import 'dart:convert';
import 'dart:typed_data';

/// header sections
///
/// these sections represent meanings each of data in header.
enum Sections {
  command,  /// represent the command of the message.
  bodySize, /// represent the body size of the message.
}

/// section strings in a message.
extension SectionsChars on Sections {
  String get name {
    switch (this) {
      case Sections.command:
        return 'COMMAND';
      case Sections.bodySize:
        return 'BODY_SIZE';
    }
  }
}

/// a header class in message
///
/// ## format
/// **<headerSize>\n[<sectionName>=<sectionData>\n...]**
///
/// headerSize: the size exclude the header size string itself and a char of LF after that strings of the header.
/// sectionName: a name that describes represent the meaning of data written after the section name itself.
/// sectionData: data of a section.
///
/// ### example
/// this message header has a command section and a body size section.
/// it represent SEND command and has 1000byte body data.
/// (Body data is omitted)
/// ```dart
/// "28\nCOMMAND=SEND\nBODY_SIZE=1000\n..."
/// ```
///
class MessageHeader {
  static const String delimiter = "\n"; /// a delimiter string in a header.

  late final String command;
  late final int bodySize;
  late final int headerSize;  /// a header size exclude the header size section.
  late final String rawData;  /// raw data

  String get headContent =>
      "${Sections.command.name}=$command\n${Sections.bodySize.name}=$bodySize\n";
  String get message => "$headerSize\n$headContent";

  MessageHeader(Uint8List data) {
    String? header = parseHeaderSize(utf8.decode(data));

    if (header == null) {
      rawData = "";
      return;
    } else {
      rawData = header;
    }

    command = parseHeaderSection(header, Sections.command.name) ?? "";
    bodySize =
        int.parse(parseHeaderSection(header, Sections.bodySize.name) ?? "0");
  }

  MessageHeader.fromParam({
    required this.command,
    required this.bodySize,
  }) {
    headerSize =
        "${Sections.command.name}=$command\n${Sections.bodySize.name}=$bodySize\n"
            .length;
  }

  /// parse a section in header from all of header.
  /// section's format is <Section name>=<content>.
  ///
  String? parseHeaderSection(String header, String section) {
    RegExpMatch? valueMatch =
        RegExp('^$section=(.*?)\$', dotAll: true, multiLine: true)
            .firstMatch(header);
    return valueMatch?.group(1);
  }

  /// parse header size of the received message.
  /// return: header content exclude the header size.
  String? parseHeaderSize(String src) {
    RegExpMatch? headerSizeMatch =
        RegExp('^([0-9]+)(?:$delimiter(.*))?', dotAll: true).firstMatch(src);
    final String? headerSizeStr = headerSizeMatch?.group(1);

    // check it was not match.
    // check it is a number.
    if ((headerSizeStr == null)) {
      throw const MessageFormatException('Could not find body size.');
    } else {
      headerSize = int.parse(headerSizeStr);
    }

    try {
      return headerSizeMatch?.group(2)?.substring(0, headerSize);
    } on RangeError {
      return headerSizeMatch?.group(2)?.substring(0);
    }
  }
}

class Message {
  late final MessageHeader header;
  late final String body;
  String get message => "${header.message}$body";

  Message(Uint8List data) {
    header = MessageHeader(data);
    // body start position is the header size + the header size char count + LF
    final int headerEndPosition =
        header.headerSize + header.headerSize.toString().length + 1;
    int bodyEndPosition = headerEndPosition + header.bodySize;
    if (bodyEndPosition > data.length) {
      bodyEndPosition = data.length;
    }
    body = utf8.decode(data.sublist(headerEndPosition, bodyEndPosition));
  }

  Message.fromBody({
    required String command,
    required this.body,
  }) {
    header = MessageHeader.fromParam(command: command, bodySize: body.length);
  }
}

class MessageFormatException implements Exception {
  const MessageFormatException(this.message);
  final String message;

  @override
  String toString() => message;
}
