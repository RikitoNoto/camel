import 'dart:convert';
import 'dart:typed_data';

enum Sections{
  command,
  bodySize,
}

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

class MessageHeader {
  static const String delimiter = "\n";

  late final String command;
  late final int bodySize;
  late final int headerSize;
  late final String rawData;

  MessageHeader(Uint8List data) {
    String? header = parseHeaderSize(utf8.decode(data));

    if (header == null) {
      rawData = "";
      return;
    } else {
      rawData = header;
    }

    command = parseHeaderSection(header, Sections.command.name) ?? "";
    bodySize = int.parse(parseHeaderSection(header, Sections.bodySize.name) ?? "0");
  }

  MessageHeader.fromParam({
    required this.command,
    required this.bodySize,
  }){
    headerSize = "${Sections.command.name}=${command}\n${Sections.bodySize.name}=${bodySize}\n".length;
  }

  String? parseHeaderSection(String header, String section) {
    RegExpMatch? valueMatch =
        RegExp('^$section=(.*?)\$', dotAll: true, multiLine: true)
            .firstMatch(header);
    return valueMatch?.group(1);
  }

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
  late final Uint8List body;
  String get message => "";

  Message(Uint8List data) {
    header = MessageHeader(data);
    // body start position is the header size + the header size char count + LF
    final int headerEndPosition =
        header.headerSize + header.headerSize.toString().length + 1;
    int bodyEndPosition = headerEndPosition + header.bodySize;
    if (bodyEndPosition > data.length) {
      bodyEndPosition = data.length;
    }
    body = Uint8List.fromList(data.sublist(headerEndPosition, bodyEndPosition));
  }

  Message.fromBody({
    required String command,
    required this.body,
  }){
    header = MessageHeader.fromParam(command: command, bodySize: body.length);
  }
}

class MessageFormatException implements Exception {
  const MessageFormatException(this.message);
  final String message;

  @override
  String toString() => message;
}
