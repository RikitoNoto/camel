import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'command_test.mocks.dart';
import 'package:camel/camel.dart';

@GenerateMocks([Message])
@GenerateMocks([MessageHeader])
void main() {
  setUp(() async {
    CommandFactory.clearCommands();
  });
  commandFactoryTest();
}

class CommandStub implements Command {
  CommandStub({
    required this.command,
  });

  @override
  final String command;
  @override
  void execute(Uint8List data) {}
}

MockMessage constructMessageMock({
  MessageHeader? header,
  String? body,
  String? command,
  int? bodySize,
}) {
  // if header does not set.
  if (header == null) {
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
    return body ?? "";
  });

  return mockMessage;
}

bool isInCommandList(Command command, List<Command> commandList) {
  bool result = false;
  for (Command c in commandList) {
    if (command == c) {
      result = true;
      break;
    }
  }
  return result;
}

Uint8List convertUint8data(String message) {
  return Uint8List.fromList(utf8.encode(message));
}

void expectUint8List(Uint8List exp, Uint8List actual) {
  try {
    expect(exp.length, actual.length);
    for (int i = 0; i < exp.length; i++) {
      expect(exp[i], actual[i]);
    }
  } catch (e) {
    fail("two lists are difference.\n expect: $exp\n actual: $actual");
  }
}

void commandFactoryTest() {
  group('register command', () {
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

    test(
        'should be return the Command registered after if commands register two times',
        () {
      CommandStub commandStubFirst = CommandStub(command: "A");
      CommandFactory.registerCommand(
          commandStubFirst); // register command first.
      CommandStub commandStubSecond = CommandStub(command: "A");
      CommandFactory.registerCommand(
          commandStubSecond); // register same command second.

      MockMessage mockMessage = constructMessageMock(command: "A");
      Command? command = CommandFactory.getCommand(mockMessage);
      expect(command, commandStubSecond);
    });
  });

  group('get command list', () {
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
