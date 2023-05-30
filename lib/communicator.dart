import 'message.dart';

abstract class ConnectionPoint{

}

abstract class ReceiveData<T> {
  T get connection;
  Message get message;
}

abstract class Communicator<T>{
  Future<T?> connect(String to);                // connection then return connection object.
  Future close();                               // close connection.
  Future<int> send(T connection, Message data); // send message to the connection.
  Stream<ReceiveData> listen(ConnectionPoint bind); // listen connect and receive messages.
}
