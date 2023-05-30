import 'message.dart';
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
