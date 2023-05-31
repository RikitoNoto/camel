import 'message.dart';

abstract class ConnectionPoint{

}

class CommunicateData<T> {
  CommunicateData({
    required this.connection,
    required this.message
  });

  final T connection;
  final Message message;
}

abstract class Communicator<T>{
  Future<T> connect(ConnectionPoint to);                // connection then return connection object.
  Future close();                               // close connection.
  Future<int> send(CommunicateData data); // send message to the connection.
  Stream<CommunicateData<T>> listen(ConnectionPoint bind); // listen connect and receive messages.
}
