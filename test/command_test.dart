import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'command_test.mocks.dart';
import 'package:camel/command.dart';


@GenerateMocks([Message])
@GenerateMocks([MessageHeader])
void main() {
  setUp(() async{
    CommandFactory.clearCommands();
  });
  commandFactoryTest();
  messageHeaderTest();
  messageTest();
}

class CommandStub implements Command{
  CommandStub({
    required this.command,
  });

  @override final String command;
  @override
  void execute(Uint8List data){

  }
}

MockMessage constructMessageMock({
  MessageHeader? header,
  Uint8List? body,
  String? command,
  int? bodySize,
}){
  // if header does not set.
  if(header == null){
    // construct header mock.
    header = MockMessageHeader();
    when(header.command).thenAnswer((realInvocation) {
      return command ??= "";
    });
    when(header.bodySize).thenAnswer((realInvocation) {
      return bodySize ??= 0;
    });
  }

  // construct message mock.
  MockMessage mockMessage = MockMessage();
  when(mockMessage.header).thenAnswer((realInvocation) {
    return header!;
  });

  when(mockMessage.body).thenAnswer((realInvocation) {
    return body ?? Uint8List(0);
  });

  return mockMessage;
}

bool isInCommandList(Command command, List<Command> commandList){
  bool result = false;
  for(Command c in commandList){
    if(command == c){
      result = true;
      break;
    }
  }
  return result;
}

Uint8List convertUint8data(String message){
  return Uint8List.fromList(utf8.encode(message));
}

void commandFactoryTest(){
  group('register command', (){
    test('should be return null if command no register', () {
      MockMessage mockMessage = constructMessageMock(command: "");
      Command? command = CommandFactory.getCommand(mockMessage);
      expect(command, null);
    });

    test('should be return Command Stub if command registered', () {
      CommandStub commandStub = CommandStub(command: "A");
      CommandFactory.registerCommand(commandStub); // register command.

      MockMessage mockMessage = constructMessageMock(command: "A");
      Command? command = CommandFactory.getCommand(mockMessage);
      expect(command, commandStub);
    });

    test('should be return null if no match command in registered', () {
      CommandStub commandStub = CommandStub(command: "A");
      CommandFactory.registerCommand(commandStub); // register command.

      MockMessage mockMessage = constructMessageMock(command: "B");
      Command? command = CommandFactory.getCommand(mockMessage);
      expect(command, null);
    });

    test('should be return the Command registered after if commands register two times', () {
      CommandStub commandStubFirst = CommandStub(command: "A");
      CommandFactory.registerCommand(commandStubFirst); // register command first.
      CommandStub commandStubSecond = CommandStub(command: "A");
      CommandFactory.registerCommand(commandStubSecond); // register same command second.

      MockMessage mockMessage = constructMessageMock(command: "A");
      Command? command = CommandFactory.getCommand(mockMessage);
      expect(command, commandStubSecond);
    });
  });

  group('get command list', (){
    test('should be get empty list when register no command', () {
      expect(CommandFactory.commandList.length, 0);
    });

    test('should be get one content list when register one command', () {
      CommandStub commandStub = CommandStub(command: "A");
      CommandFactory.registerCommand(commandStub);
      expect(CommandFactory.commandList.length, 1);
      expect(CommandFactory.commandList[0], commandStub);
    });

    test('should be get two content list when register two command', () {
      CommandStub commandStub1 = CommandStub(command: "A");
      CommandFactory.registerCommand(commandStub1);
      CommandStub commandStub2 = CommandStub(command: "B");
      CommandFactory.registerCommand(commandStub2);

      List<Command> commandList = CommandFactory.commandList;
      expect(commandList.length, 2);
      expect(isInCommandList(commandStub1, commandList), isTrue);
      expect(isInCommandList(commandStub2, commandList), isTrue);
    });
  });
}

void messageHeaderTest(){
  group("parse test", (){

    group('get header size', (){
      test('should be throw MessageFormatException if arg is empty header', () {
        expect(() => MessageHeader(convertUint8data("")), throwsA(const TypeMatcher<MessageFormatException>()));
      });

      test('should be throw MessageFormatException if arg is that is not number.', () {
        expect(() => MessageHeader(convertUint8data("a")), throwsA(const TypeMatcher<MessageFormatException>()));
      });

      test('should be throw MessageFormatException if get arg is start from LF.', () {
        expect(() => MessageHeader(convertUint8data("\n100")), throwsA(const TypeMatcher<MessageFormatException>()));
      });

      test('should be get 0 as the header size if get arg is 0.', () {
        expect(MessageHeader(convertUint8data("0")).headerSize, 0);
      });

      test('should be get 100 as the header size if get arg is 100.', () {
        expect(MessageHeader(convertUint8data("100")).headerSize, 100);
      });

      test('should be get 100 as the header size if get arg is 100+LF.', () {
        expect(MessageHeader(convertUint8data("100\n")).headerSize, 100);
      });
    });

    group('get commands', (){
      test('should be get no command if there is not COMMAND header.', () {
        MessageHeader header = MessageHeader(convertUint8data("100\n"));
        expect(header.command, "");
      });

      test('should be get a command if there is COMMAND header.', () {
        MessageHeader header = MessageHeader(convertUint8data("15\nCOMMAND=command"));
        expect(header.command, "command");
      });

      test('should be get a command in the middle if the header size is less.', () {
        MessageHeader header = MessageHeader(convertUint8data("14\nCOMMAND=command"));
        expect(header.command, "comman");
      });

      test('should be get no command if the header size is less.', () {
        MessageHeader header = MessageHeader(convertUint8data("0\nCOMMAND=command"));
        expect(header.command, "");
      });

      test('should be get an before command if the COMMAND section is twice.', () {
        MessageHeader header = MessageHeader(convertUint8data("34\nCOMMAND=command1\nCOMMAND=command2"));
        expect(header.command, "command1");
      });
    });

    group('get body size', (){
      test('should be get 0 as body size if there is not BODY_SIZE header.', () {
        MessageHeader header = MessageHeader(convertUint8data("100\n"));
        expect(header.bodySize, 0);
      });

      test('should be get 10 as body size if there is BODY_SIZE header.', () {
        MessageHeader header = MessageHeader(convertUint8data("12\nBODY_SIZE=10"));
        expect(header.bodySize, 10);
      });

      test('should be get 1 as body size(in the middle) if the header size is less.', () {
        MessageHeader header = MessageHeader(convertUint8data("11\nBODY_SIZE=10"));
        expect(header.bodySize, 1);
      });

      test('should be get 0 as body size if the header size is less.', () {
        MessageHeader header = MessageHeader(convertUint8data("0\nBODY_SIZE=10"));
        expect(header.bodySize, 0);
      });

      test('should be get an before body size if the BODY_SIZE section is twice.', () {
        MessageHeader header = MessageHeader(convertUint8data("24\nBODY_SIZE=1\nBODY_SIZE=2"));
        expect(header.bodySize, 1);
      });
    });


    group('get raw data', (){
      test('should be not get raw data if the header size is 0.', () {
        MessageHeader header = MessageHeader(convertUint8data("0\n"));
        expect(header.rawData, "");
      });

      test('should be not get raw data if the header size is 0 and exist header data.', () {
        MessageHeader header = MessageHeader(convertUint8data("0\ndata"));
        expect(header.rawData, "");
      });

      test('should be get raw data if exist header data.', () {
        MessageHeader header = MessageHeader(convertUint8data("4\ndata"));
        expect(header.rawData, "data");
      });

      test('should be get raw data in the middle if header size is less.', () {
        MessageHeader header = MessageHeader(convertUint8data("3\ndata"));
        expect(header.rawData, "dat");
      });
    });
  });
}

void messageTest(){
  group('get header', (){
    // test('should be get header command,bodySize,headerSize', () {
    //   Message message = Message(convertUint8data("A\n10\nbodydata"));
    //   expect(message.header.command, "A");
    //   expect(message.header.headerSize, 5);
    //   expect(message.header.bodySize, 10);
    // });
    //
    // test('should be get 0 size body from empty data', () {
    //   Message message = Message(convertUint8data(""));
    //   expect(message.body.length, 0);
    // });
    //
    // test('should be get 0 size body from empty body', () {
    //   Message message = Message(convertUint8data("A\n10\n"));
    //   expect(message.body.length, 0);
    // });
    //
    // test('should be get 1 size body from exist body', () {
    //   Message message = Message(convertUint8data("A\n10\na"));
    //   expect(message.body.length, 1);
    // });
  });
}
