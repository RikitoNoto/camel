import 'dart:convert';
import 'dart:typed_data';

/// header sections
///
/// these sections represent meanings each of data in header.
enum Sections {
  /// represent the command of the message.
  command,

  /// represent the body size of the message.
  bodySize,
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
/// **\<headerSize\>\n\[\<sectionName\>=\<sectionData\>\n...\]**
///
/// **headerSize**: the size exclude the header size string itself and a char of LF after that strings of the header.
///
/// **sectionName**: a name that describes represent the meaning of data written after the section name itself.
///
/// **sectionData**: data of a section.
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
  /// a delimiter string in a header.
  static const String delimiter = "\n";

  late final String command;
  late final int bodySize;

  /// a header size exclude the header size section.
  late final int headerSize;

  /// raw data of the header exclude the header size section.
  late final String rawData;

  /// a content of the header exclude the header size section.
  String get headContent =>
      "${Sections.command.name}=$command\n${Sections.bodySize.name}=$bodySize\n";

  /// a content of the header all.
  String get message => "$headerSize\n$headContent";

  /// constructor from Uint8List(receive data).
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

  /// constructor from params(send data).
  MessageHeader.fromParam({
    required this.command,
    required this.bodySize,
  }) {
    headerSize =
        "${Sections.command.name}=$command\n${Sections.bodySize.name}=$bodySize\n"
            .length;
  }

  /// parse a section from all of header.
  ///
  /// parse and get section data in [header].
  /// [header] is all of the header string.
  /// this function searches a section of [section] in [header], then parses and returns the found data.
  /// section's format is <Section name>=<content>.
  String? parseHeaderSection(String header, String section) {
    RegExpMatch? valueMatch =
        RegExp('^$section=(.*?)\$', dotAll: true, multiLine: true)
            .firstMatch(header);
    return valueMatch?.group(1);
  }

  /// parse header size of the received message.
  ///
  /// parse and set a header size from received message string [message].
  /// after that return a header string exclude the header size.
  String? parseHeaderSize(String message) {
    RegExpMatch? headerSizeMatch =
        RegExp('^([0-9]+)(?:$delimiter(.*))?', dotAll: true)
            .firstMatch(message);
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

/// a message class
///
/// ## format
/// **\<header\>\[\<body\>\]**
///
/// **header**: the header include info of size etc in message.(reference [MessageHeader])
/// **body**: a body data of message.
///       if the char count is more than [MessageHeader.bodySize], doesn't recognize more strings.
///
/// ### example
/// this message has a body size section.
/// it define that a body size is 10byte, but body data has 27byte data.
/// then this class recognize only 10byte data.
/// ```dart
/// const data = "15\nBODY_SIZE=10\n hello, i have 27byte data.";
/// Message message = Message(Uint8List.fromList(utf8.encode(data)));
/// print(message.body); // " hello, i "
/// ```
///
class Message {
  late final MessageHeader header;
  late final String body;
  String get message => "${header.message}$body";

  /// constructor from Uint8List(receive data).
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

  /// constructor from params(send data).
  Message.fromBody({
    String? command,
    required this.body,
  }) {
    header = MessageHeader.fromParam(command: command ?? "", bodySize: body.length);
  }
}

/// exception of format error.
class MessageFormatException implements Exception {
  const MessageFormatException(this.message);
  final String message;

  @override
  String toString() => message;
}
