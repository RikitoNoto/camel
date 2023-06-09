import 'message.dart';

class CommunicateData<T> {
  CommunicateData({required this.connection, required this.message});

  final T connection;
  final Message message;
}

abstract class Communicator<T, C> {
  Future<T> connect(
      C connectionPoint); // connection then return connection object.
  Future close(); // close connection.
  Future<int> send(CommunicateData<T> data); // send message to the connection.
  Future<Stream<CommunicateData<T>>> listen(
      C bind); // listen connect and receive messages.
}
