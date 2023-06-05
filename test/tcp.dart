import 'dart:convert';
import 'dart:io';

import 'package:camel/communicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'tcp.mocks.dart';

import 'package:camel/tcp.dart';
import 'package:camel/message.dart';

typedef Connect_t = Function(dynamic address, int port, {dynamic sourceAddress, int sourcePort, Duration? timeout});

@GenerateMocks([Socket])
@GenerateMocks([Message])
void main() {
  useLibraryTest();
}

class ConnectSpy {
  ConnectSpy({required this.tcp, this.socket});
  String? receiveAddress;
  int? receivePort;
  final Tcp tcp;
  final MockSocket? socket;
}

ConnectSpy connectWithMock({
  String address = "127.0.0.1",
  int port = 0,
  MockSocket? mockSocket,
}) {
  Tcp tcp = Tcp();
  ConnectSpy spy = ConnectSpy(tcp: tcp, socket: mockSocket ?? MockSocket());

  Connect_t connectMock = (dynamic address, int port, {dynamic sourceAddress, int sourcePort=0, Duration? timeout}){
    spy.receiveAddress = address;
    spy.receivePort = port;
    return spy.socket;
  };

  tcp.setConnectMock(connectMock);
  tcp.connect(SocketConnectionPoint(address: address, port: port));

  return spy;
}

void useLibraryTest() {
  group("connect", () {
    test("should be hand over the IP address and the port number", (){
      ConnectSpy spy = connectWithMock(address: "127.0.0.1", port: 1000);

      expect(spy.receiveAddress, "127.0.0.1");
      expect(spy.receivePort, 1000);
    });
  });

  group("send", () {
    test("should be write the empty message to the address handed over", () async{
      ConnectSpy spy = connectWithMock(address: "127.0.0.1", port: 1000);
      MockMessage mockMessage = MockMessage();
      when(mockMessage.message).thenReturn("");
      int sentByte = await spy.tcp.send(CommunicateData(connection: spy.socket!, message: mockMessage));

      verify(spy.socket?.write("0\n"));
      expect(sentByte, 0);
    });

    test("should be write the message to the address handed over", () async{
      ConnectSpy spy = connectWithMock(address: "127.0.0.1", port: 1000);
      MockMessage mockMessage = MockMessage();
      when(mockMessage.message).thenReturn("message");
      int sentByte = await spy.tcp.send(CommunicateData(connection: spy.socket!, message: mockMessage));

      verify(spy.socket?.write("7\nmessage"));
      expect(sentByte, 7);
    });
  });

  group("send", () {
    test("should be write the empty message to the address handed over", () async{
      ConnectSpy spy = connectWithMock(address: "127.0.0.1", port: 1000);
      MockMessage mockMessage = MockMessage();
      when(mockMessage.message).thenReturn("");
      int sentByte = await spy.tcp.send(CommunicateData(connection: spy.socket!, message: mockMessage));

      verify(spy.socket?.write("0\n"));
      expect(sentByte, 0);
    });

    test("should be write the message to the address handed over", () async{
      ConnectSpy spy = connectWithMock(address: "127.0.0.1", port: 1000);
      MockMessage mockMessage = MockMessage();
      when(mockMessage.message).thenReturn("message");
      int sentByte = await spy.tcp.send(CommunicateData(connection: spy.socket!, message: mockMessage));

      verify(spy.socket?.write("7\nmessage"));
      expect(sentByte, 7);
    });
  });
}
