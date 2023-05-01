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
  group('get commands', (){
    test('should be construct header with no command from 0 byte data', () {
      MessageHeader header = MessageHeader(Uint8List(0));
      expect(header.command, "");
    });

    test('should be construct header of A command from A command data', () {
      MessageHeader header = MessageHeader(convertUint8data("A\n"));
      expect(header.command, "A");
    });

    test('should be construct header of B command from BBBB command data', () {
      MessageHeader header = MessageHeader(convertUint8data("BBBB\n"));
      expect(header.command, "BBBB");
    });
  });

  group('get body size', (){
    test('should be get 0 byte as body size from 0 byte data', () {
      MessageHeader header = MessageHeader(Uint8List(0));
      expect(header.bodySize, 0);
    });

    test('should be get 0 byte as body size from only command data', () {
      MessageHeader header = MessageHeader(convertUint8data("A\n"));
      expect(header.bodySize, 0);
    });

    test('should be get 1 byte as body size', () {
      MessageHeader header = MessageHeader(convertUint8data("A\n1\n"));
      expect(header.bodySize, 1);
    });

    test('should be get 255 byte as body size', () {
      MessageHeader header = MessageHeader(convertUint8data("A\n255\n"));
      expect(header.bodySize, 255);
    });
  });

  group('get header size', (){
    test('should be get header size 0 when empty header gave', () {
      MessageHeader header = MessageHeader(convertUint8data(""));
      expect(header.headerSize, 0);
    });

    test('should be get header size 1 when 1 size header gave', () {
      MessageHeader header = MessageHeader(convertUint8data("A"));
      expect(header.headerSize, 1);
    });

    test('should be get header size when exist body', () {
      MessageHeader header = MessageHeader(convertUint8data("A\n10\nbodydata"));
      expect(header.headerSize, 5);
    });
  });
}

void messageTest(){
  group('get header', (){
    test('should be get header command,bodySize,headerSize', () {
      Message message = Message(convertUint8data("A\n10\nbodydata"));
      expect(message.header.command, "A");
      expect(message.header.headerSize, 5);
      expect(message.header.bodySize, 10);
    });

    test('should be get 0 size body from empty data', () {
      Message message = Message(convertUint8data(""));
      expect(message.body.length, 0);
    });

    test('should be get 0 size body from empty body', () {
      Message message = Message(convertUint8data("A\n10\n"));
      expect(message.body.length, 0);
    });

    test('should be get 1 size body from exist body', () {
      Message message = Message(convertUint8data("A\n10\na"));
      expect(message.body.length, 1);
    });
  });
}
