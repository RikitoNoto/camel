import 'dart:convert';
import 'dart:typed_data';

/// command class is the interface communication class and application.
abstract class Command{
  /// command is the identified what is the receive data.
  String get command;
  /// this method is called with received data from the communication class.
  void execute(Uint8List data);
}


/// construct Command instance from the received Message data.
/// this class has message dictionary.
/// it could register and read from other class.
/// in default, that dictionary registered default command.
abstract class CommandFactory{
  static final Map<String, Command> _commands = {};

  static List<Command> get commandList{
    return _commands.values.toList();
  }

  static Command? getCommand(Message receivedData){
    for(Command command in _commands.values){
      // if match the command, return that command.
      if(command.command == receivedData.header.command){
        return command;
      }
    }
    return null;
  }

  static void registerCommand(Command command){
    _commands[command.command] = command;
  }

  static void clearCommands(){
    _commands.clear();
  }
}

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
    int headerStartPosition = header.headerSize + header.headerSize.toString().length + 1;
    body = Uint8List.fromList(data.sublist(headerStartPosition, headerStartPosition + header.bodySize));
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
