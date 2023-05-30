import 'dart:convert';
import 'dart:typed_data';

class MessageHeader{
  static const String delimiter = "\n";

  late final String command;
  late final int bodySize;
  late final int headerSize;
  late final String rawData;

  MessageHeader(Uint8List data){
    String? header = parseHeaderSize(utf8.decode(data));

    if(header == null) {
      rawData = "";
      return;
    }
    else{
      rawData = header;
    }

    command = parseHeaderSection(header, "COMMAND") ?? "";
    bodySize = int.parse(parseHeaderSection(header, "BODY_SIZE") ?? "0");

  }

  String? parseHeaderSection(String header, String section){
    RegExpMatch? valueMatch = RegExp('^$section=(.*?)\$', dotAll: true, multiLine: true).firstMatch(header);
    return valueMatch?.group(1);
  }

  String? parseHeaderSize(String src){
    RegExpMatch? headerSizeMatch = RegExp('^([0-9]+)(?:$delimiter(.*))?', dotAll: true).firstMatch(src);
    final String? headerSizeStr = headerSizeMatch?.group(1);

    // check it was not match.
    // check it is a number.
    if((headerSizeStr == null)){
      throw const MessageFormatException('Could not find body size.');
    }
    else{
      headerSize = int.parse(headerSizeStr);
    }

    try{
      return headerSizeMatch?.group(2)?.substring(0, headerSize);
    }
    on RangeError {
      return headerSizeMatch?.group(2)?.substring(0);
    }
  }
}

class Message{
  Message(Uint8List data) {
    header = MessageHeader(data);
    // body start position is the header size + the header size char count + LF
    final int headerEndPosition = header.headerSize + header.headerSize.toString().length + 1;
    int bodyEndPosition = headerEndPosition + header.bodySize;
    if(bodyEndPosition > data.length){
      bodyEndPosition = data.length;
    }
    body = Uint8List.fromList(data.sublist(headerEndPosition, bodyEndPosition));
  }

  late final MessageHeader header;
  late final Uint8List body;
}

class MessageFormatException implements Exception{
  const MessageFormatException(this.message);
  final String message;

  @override
  String toString() => message;
}
