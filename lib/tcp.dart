import 'dart:io';
import 'package:flutter/foundation.dart';

import 'communicator.dart';
import 'message.dart';

class SocketConnectionPoint{
  SocketConnectionPoint({
    required this.address,
    required this.port,
  });

  final String address;
  final int port;
}

class Tcp implements Communicator<Socket, SocketConnectionPoint>{
  @override
  Future<Socket> connect(SocketConnectionPoint connectionPoint) async{
    return await _connect(connectionPoint.address, connectionPoint.port);
  }

  @override
  Future close() async{

  }

  @override
  Future<int> send(CommunicateData<Socket> data) async{
    data.connection.write("${data.message.message.length}\n${data.message.message}");
    return Future(() => data.message.message.length);
  }

  @override
  Stream<CommunicateData<Socket>> listen(SocketConnectionPoint bind) async* {
    Socket socket = await _connect("", 0);
    yield CommunicateData<Socket>(connection: socket, message: Message(Uint8List(0)));
  }

  // ↓↓↓↓↓↓↓↓↓↓↓↓↓↓ for test ↓↓↓↓↓↓↓↓↓↓↓↓↓↓
  Function(dynamic address, int port, {dynamic sourceAddress, int sourcePort, Duration? timeout}) _connect = Socket.connect;
  Function(dynamic address, int port, {int backlog, bool v6Only, bool shared, }) _bind = ServerSocket.bind;

  void setConnectMock(Function(dynamic, int, {dynamic sourceAddress, int sourcePort, Duration? timeout}) connect) {
    if(kDebugMode){
      _connect = connect;
    }
  }

  void setBindMock(Function(dynamic address, int port, {int backlog, bool v6Only, bool shared, }) bind) {
    if(kDebugMode){
      _bind = bind;
    }
  }

}
