import 'dart:async';
import 'dart:convert';
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

class CommunicateDataTcp {
  CommunicateDataTcp({required this.connection, required this.dataSize});

  void receive(Uint8List data) {
    final newBuffer = Uint8List(_receiveBuffer.length + data.length);
    newBuffer.setAll(0, _receiveBuffer);
    newBuffer.setAll(_receiveBuffer.length, data);
    _receiveBuffer = newBuffer;
  }

  bool isReceivedAll() {
    return _receiveBuffer.length >= dataSize;
  }

  CommunicateData<Socket>? get receiveData {
    if (!isReceivedAll()) return null;

    return CommunicateData<Socket>(
        connection: connection, message: Message(_receiveBuffer));
  }

  Uint8List _receiveBuffer = Uint8List(0);
  final Socket connection;
  final int dataSize;
}

class Tcp implements Communicator<Socket, SocketConnectionPoint> {
  final Map<Socket, CommunicateDataTcp> _receiveBuffers = {};

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
    // connection
    serverSocket.listen((Socket socket) {
      // receive data
      socket.listen((Uint8List data) {
        // if have not received data yet.
        if (_receiveBuffers[socket] == null) {
          int bodyPosition = 0;
          int dataSize = 0;
          // search first LF sign.
          // chars until first LF represent the size of this message.
          for (int i = 0; i < data.length; i++) {
            if (data[i] == utf8.encode("\n").first) {
              bodyPosition = i + 1; // the message after first LF.
              dataSize = int.parse(utf8.decode(data.sublist(0, i)));
              break;
            }
          }

          data = data.sublist(bodyPosition); // change [data] to only the body.

          _receiveBuffers[socket] =
              CommunicateDataTcp(connection: socket, dataSize: dataSize);
        }

        final receiveBuffer = _receiveBuffers[socket];
        if (receiveBuffer == null) return;

        receiveBuffer.receive(data);

        // if received all of messages.
        if (receiveBuffer.isReceivedAll()) {
          controller.sink.add(receiveBuffer.receiveData!); // stream data.
          _receiveBuffers.remove(receiveBuffer.connection); // remove buffer.
        }
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
