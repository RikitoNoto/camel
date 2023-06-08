import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:camel/command.dart';
import 'package:camel/communicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'tcp_test.mocks.dart';

import 'package:camel/tcp.dart';
import 'package:camel/message.dart';
import 'command_test.dart';

typedef ConnectFunc = Function(dynamic address, int port, {dynamic sourceAddress, int sourcePort, Duration? timeout});
typedef BindFunc = Function(dynamic address, int port, {int backlog, bool v6Only, bool shared,});

@GenerateMocks([Socket])
@GenerateMocks([ServerSocket])
@GenerateMocks([Message])
@GenerateMocks([CommandFactory])
@GenerateMocks([Command])
void main() {
  useLibraryTest();
}

class ConnectSpy {
  ConnectSpy({required this.tcp, this.socket});
  String? connectAddress;
  int? connectPort;
  final Tcp tcp;
  final MockSocket? socket;
}

class ListenSpy {
  ListenSpy({required this.tcp, this.socket, this.serverSocket});
  String? bindAddress;
  int? bindPort;
  final Tcp tcp;
  final MockSocket? socket;
  final MockServerSocket? serverSocket;
}

Future<ConnectSpy> connectWithMock({
  String address = "127.0.0.1",
  int port = 0,
  MockSocket? mockSocket,
}) async {
  Tcp tcp = Tcp();
  ConnectSpy spy = ConnectSpy(tcp: tcp, socket: mockSocket ?? MockSocket());

  ConnectFunc connectMock = (dynamic address, int port, {dynamic sourceAddress, int sourcePort=0, Duration? timeout}){
    spy.connectAddress = address;
    spy.connectPort = port;
    return spy.socket;
  };

  tcp.setConnectMock(connectMock);
  await tcp.connect(SocketConnectionPoint(address: address, port: port));

  return spy;
}

Future<ListenSpy> bindMock({
  MockSocket? mockSocket,
  MockServerSocket? mockServerSocket,
}) async {
  Tcp tcp = Tcp();
  ListenSpy spy = ListenSpy(tcp: tcp, socket: mockSocket ?? MockSocket(), serverSocket: mockServerSocket ?? MockServerSocket());

  BindFunc bindMock = (dynamic address, int port, {int backlog=0, bool v6Only=false, bool shared=false,}){
    spy.bindAddress = address;
    spy.bindPort = port;
    return spy.serverSocket;
  };

  tcp.setBindMock(bindMock);

  return spy;
}

void useLibraryTest() {
  group("connect", () {
    test("should be hand over the IP address and the port number", () async {
      ConnectSpy spy = await connectWithMock(address: "127.0.0.1", port: 1000);

      expect(spy.connectAddress, "127.0.0.1");
      expect(spy.connectPort, 1000);
    });
  });

  group("send", () {
    test("should be write the empty message to the address handed over", () async {
      ConnectSpy spy = await connectWithMock(address: "127.0.0.1", port: 1000);
      MockMessage mockMessage = MockMessage();
      when(mockMessage.message).thenReturn("");
      int sentByte = await spy.tcp.send(CommunicateData(connection: spy.socket!, message: mockMessage));

      verify(spy.socket?.write("0\n"));
      expect(sentByte, 0);
    });

    test("should be write the message to the address handed over", () async {
      ConnectSpy spy = await connectWithMock(address: "127.0.0.1", port: 1000);
      MockMessage mockMessage = MockMessage();
      when(mockMessage.message).thenReturn("message");
      int sentByte = await spy.tcp.send(CommunicateData(connection: spy.socket!, message: mockMessage));

      verify(spy.socket?.write("7\nmessage"));
      expect(sentByte, 7);
    });
  });

  group("send", () {
    test("should be write the empty message to the address handed over", () async{
      ConnectSpy spy = await connectWithMock(address: "127.0.0.1", port: 1000);
      MockMessage mockMessage = MockMessage();
      when(mockMessage.message).thenReturn("");
      int sentByte = await spy.tcp.send(CommunicateData(connection: spy.socket!, message: mockMessage));

      verify(spy.socket?.write("0\n"));
      expect(sentByte, 0);
    });

    test("should be write the message to the address handed over", () async{
      ConnectSpy spy = await connectWithMock(address: "127.0.0.1", port: 1000);
      MockMessage mockMessage = MockMessage();
      when(mockMessage.message).thenReturn("message");
      int sentByte = await spy.tcp.send(CommunicateData(connection: spy.socket!, message: mockMessage));

      verify(spy.socket?.write("7\nmessage"));
      expect(sentByte, 7);
    });
  });

  group("listen", () {
    test("should be execute received message command", () async{
      ListenSpy spy = await bindMock();

      when(spy.serverSocket?.listen(any)).thenAnswer((Invocation invocation) {
        final void Function(Socket) connectCallback = invocation.positionalArguments[0];

        // when connection
        when(spy.socket?.listen(any)).thenAnswer((Invocation invocation) {
          final void Function(Uint8List) receiveCallback = invocation.positionalArguments[0];
          receiveCallback(convertUint8data("32\nCOMMAND=someCommand\nBODY_SIZE=4\nbody"));
          return StreamSubscriptionStub<Uint8List>();
        });
        connectCallback(spy.socket!);  // connection
        verify(spy.socket?.listen(any));
        return StreamSubscriptionStub<Socket>();
      });

      await for(CommunicateData<Socket> data in await spy.tcp.listen(SocketConnectionPoint(address: "127.0.0.1", port: 1000))){
        expect(data.message.body, Uint8List.fromList(utf8.encode("body")));
        expect(data.connection, spy.socket);
        break;
      }

      verify(spy.serverSocket?.listen(any));
      expect(spy.bindAddress, "127.0.0.1");
      expect(spy.bindPort, 1000);
    });
  });
}

class StreamSubscriptionStub<T> implements StreamSubscription<T>{
  @override
  Future<void> cancel() async{
    return ;
  }

  @override void onData(void handleData(T data)?){}
  @override void onError(Function? handleError) {}
  @override void onDone(void handleDone()?){}
  @override void pause([Future<void>? resumeSignal]) {}
  @override void resume(){}
  @override bool get isPaused{ return true; }
  @override Future<E> asFuture<E>([E? futureValue])async{
    E resultValue;
    if (futureValue == null) {
      resultValue = futureValue as dynamic;
    } else {
      resultValue = futureValue;
    }
    return Future.value(resultValue);
  }
}
