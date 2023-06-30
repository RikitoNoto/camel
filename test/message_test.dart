import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'message_test.mocks.dart';
import 'package:camel/camel.dart';

@GenerateMocks([Message])
@GenerateMocks([MessageHeader])
void main() {
  setUp(() async {});
  messageHeaderTest();
  messageFormatTest();
  messageConstructFromSendTest();
  convertBinDataTest();
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

void messageHeaderTest() {
  group("parse test", () {
    group('get header size', () {
      test('should be throw MessageFormatException if arg is empty header', () {
        expect(() => MessageHeader(convertUint8data("")),
            throwsA(const TypeMatcher<MessageFormatException>()));
      });

      test(
          'should be throw MessageFormatException if arg is that is not number.',
          () {
        expect(() => MessageHeader(convertUint8data("a")),
            throwsA(const TypeMatcher<MessageFormatException>()));
      });

      test(
          'should be throw MessageFormatException if get arg is start from LF.',
          () {
        expect(() => MessageHeader(convertUint8data("\n100")),
            throwsA(const TypeMatcher<MessageFormatException>()));
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

    group('get commands', () {
      test('should be get no command if there is not COMMAND header.', () {
        MessageHeader header = MessageHeader(convertUint8data("100\n"));
        expect(header.command, "");
      });

      test('should be get a command if there is COMMAND header.', () {
        MessageHeader header =
            MessageHeader(convertUint8data("15\nCOMMAND=command"));
        expect(header.command, "command");
      });

      test('should be get a command in the middle if the header size is less.',
          () {
        MessageHeader header =
            MessageHeader(convertUint8data("14\nCOMMAND=command"));
        expect(header.command, "comman");
      });

      test('should be get no command if the header size is less.', () {
        MessageHeader header =
            MessageHeader(convertUint8data("0\nCOMMAND=command"));
        expect(header.command, "");
      });

      test('should be get an before command if the COMMAND section is twice.',
          () {
        MessageHeader header = MessageHeader(
            convertUint8data("34\nCOMMAND=command1\nCOMMAND=command2"));
        expect(header.command, "command1");
      });
    });

    group('get body size', () {
      test('should be get 0 as body size if there is not BODY_SIZE header.',
          () {
        MessageHeader header = MessageHeader(convertUint8data("100\n"));
        expect(header.bodySize, 0);
      });

      test('should be get 10 as body size if there is BODY_SIZE header.', () {
        MessageHeader header =
            MessageHeader(convertUint8data("12\nBODY_SIZE=10"));
        expect(header.bodySize, 10);
      });

      test(
          'should be get 1 as body size(in the middle) if the header size is less.',
          () {
        MessageHeader header =
            MessageHeader(convertUint8data("11\nBODY_SIZE=10"));
        expect(header.bodySize, 1);
      });

      test('should be get 0 as body size if the header size is less.', () {
        MessageHeader header =
            MessageHeader(convertUint8data("0\nBODY_SIZE=10"));
        expect(header.bodySize, 0);
      });

      test(
          'should be get an before body size if the BODY_SIZE section is twice.',
          () {
        MessageHeader header =
            MessageHeader(convertUint8data("24\nBODY_SIZE=1\nBODY_SIZE=2"));
        expect(header.bodySize, 1);
      });
    });

    group('get raw data', () {
      test('should be not get raw data if the header size is 0.', () {
        MessageHeader header = MessageHeader(convertUint8data("0\n"));
        expect(header.rawData, "");
      });

      test(
          'should be not get raw data if the header size is 0 and exist header data.',
          () {
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

    group('get header some pattern', () {
      test('should be get variable data.', () {
        MessageHeader header = MessageHeader(convertUint8data(
            "33\nCOMMAND=someCommand\nBODY_SIZE=10\nAAAAAAAAAA"));
        expect(header.headerSize, 33);
        expect(header.rawData, "COMMAND=someCommand\nBODY_SIZE=10\n");
        expect(header.bodySize, 10);
        expect(header.command, "someCommand");
      });
    });
  });
}

void messageFormatTest() {
  group('header', () {
    test('should be get header data.', () {
      Message message = Message(convertUint8data(
          "33\nCOMMAND=someCommand\nBODY_SIZE=10\nAAAAAAAAAA"));
      expect(message.header.headerSize, 33);
      expect(message.header.rawData, "COMMAND=someCommand\nBODY_SIZE=10\n");
      expect(message.header.bodySize, 10);
      expect(message.header.command, "someCommand");
    });
  });

  group('body', () {
    test('should be get body data.', () {
      Message message = Message(convertUint8data(
          "33\nCOMMAND=someCommand\nBODY_SIZE=10\nAAAAAAAAAA"));
      expect("AAAAAAAAAA", message.body);
    });

    test('should be get body data in the middle if the body size is less.', () {
      Message message = Message(
          convertUint8data("33\nCOMMAND=someCommand\nBODY_SIZE=8\nAAAAAAAAAA"));
      expect("AAAAAAAA", message.body);
    });

    test('should be get body data all if the body size is more.', () {
      Message message = Message(convertUint8data(
          "33\nCOMMAND=someCommand\nBODY_SIZE=15\nAAAAAAAAAA"));
      expect("AAAAAAAAAA", message.body);
    });
  });
}

Message constructMessageFromBody(
    {String? command, required String body}) {
  return Message.fromBody(
      command: command, body: body); //Uint8List.fromList(utf8.encode(body)));
}

void checkMessageCommandAndBody(
    {required Message message, required String command, required String body}) {
  expect(message.header.command, command);
  expect(message.body, body);
}

void messageConstructFromSendTest() {
  group("constructor from sender", () {
    test("should be construct message command and body", () {
      Message message = constructMessageFromBody(body: "");
      checkMessageCommandAndBody(message: message, command: "", body: "");
    });

    test(
        "should be return command and body when construct message command and body",
        () {
      Message message = constructMessageFromBody(command: "AAA", body: "data");
      checkMessageCommandAndBody(
          message: message, command: "AAA", body: "data");
    });

    test("should be return 4byte as body size when construct message with aaaa",
        () {
      Message message = constructMessageFromBody(command: "", body: "aaaa");
      expect(message.header.bodySize, 4);
    });

    test("should be get the header size", () {
      Message message =
          constructMessageFromBody(command: "AAAAA", body: "aaaa");
      // COMMAND=AAAAA\n
      // BODY_SIZE=4\n
      // -> 26byte
      expect(message.header.headerSize, 26);
    });
  });
}

void convertBinDataTest() {
  group("convert bin data", () {
    test("should be convert to uint8list", () {
      Message message =
          constructMessageFromBody(command: "AAAAA", body: "aaaa");
      Message receive =
          Message(Uint8List.fromList(utf8.encode(message.message)));
      expect(receive.header.command, "AAAAA");
      expect(receive.body, "aaaa");
    });
  });
}
