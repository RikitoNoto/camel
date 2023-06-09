import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'communicator.dart';
import 'message.dart';

class SocketConnectionPoint {
  SocketConnectionPoint({
    required this.address,
    required this.port,
  });

  final String address;
  final int port;
}

class Tcp implements Communicator<Socket, SocketConnectionPoint> {
  @override
  Future<Socket> connect(SocketConnectionPoint connectionPoint) async {
    return await _connect(connectionPoint.address, connectionPoint.port);
  }

  @override
  Future close() async {}

  @override
  Future<int> send(CommunicateData<Socket> data) async {
    data.connection
        .write("${data.message.message.length}\n${data.message.message}");
    return Future(() => data.message.message.length);
  }

  @override
  Future<Stream<CommunicateData<Socket>>> listen(
      SocketConnectionPoint bind) async {
    final StreamController<CommunicateData<Socket>> controller =
        StreamController();
    ServerSocket serverSocket = await _bind(bind.address, bind.port);
    serverSocket.listen((Socket socket) {
      socket.listen((Uint8List data) {
        controller.sink
            .add(CommunicateData(connection: socket, message: Message(data)));
      });
    });
    return controller.stream;
  }

  // ↓↓↓↓↓↓↓↓↓↓↓↓↓↓ for test ↓↓↓↓↓↓↓↓↓↓↓↓↓↓
  Function(dynamic address, int port,
      {dynamic sourceAddress,
      int sourcePort,
      Duration? timeout}) _connect = Socket.connect;
  Function(
    dynamic address,
    int port, {
    int backlog,
    bool v6Only,
    bool shared,
  }) _bind = ServerSocket.bind;

  void setConnectMock(
      Function(dynamic, int,
              {dynamic sourceAddress, int sourcePort, Duration? timeout})
          connect) {
    if (kDebugMode) {
      _connect = connect;
    }
  }

  void setBindMock(
      Function(
        dynamic address,
        int port, {
        int backlog,
        bool v6Only,
        bool shared,
      }) bind) {
    if (kDebugMode) {
      _bind = bind;
    }
  }
}
