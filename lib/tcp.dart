import 'dart:io';
import 'package:flutter/foundation.dart';

import 'communicator.dart';
import 'message.dart';


class Tcp implements Communicator<Socket>{
  @override
  Future<Socket> connect(ConnectionPoint to) async{
    return await _connect("", 0);
  }

  @override
  Future close() async{

  }

  @override
  Future<int> send(CommunicateData data) async{
    return 0;
  }

  @override
  Stream<CommunicateData<Socket>> listen(ConnectionPoint bind) async* {
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
