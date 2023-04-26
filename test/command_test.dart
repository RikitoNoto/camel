import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'command_test.mocks.dart';
import 'package:camel/command.dart';


@GenerateMocks([Message])
@GenerateMocks([MessageHeader])
void main() {
  commandFactoryTest();
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

/// check get default commands.
///
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
}
