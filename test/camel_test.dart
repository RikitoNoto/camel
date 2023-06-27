import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camel/command.dart';
import 'package:camel/communicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'tcp_test.mocks.dart';

import 'package:camel/tcp.dart';
import 'package:camel/message.dart';
import 'package:camel/camel.dart';
import 'command_test.dart';

void main() {
  useTcpTest();
}

class CommandStub implements Command{
  String get command => "STUB";
  static Uint8List? receiveSpy;
  static bool isCalledExecute = false;

  void execute(Uint8List data){
    isCalledExecute = true;
    receiveSpy = data;
  }
}

void useTcpTest() {
  group("TCP", () {
    test("should be communicate", () async {
      Tcp tcpSend = Tcp();
      Camel<Socket, SocketConnectionPoint> camelSend = Camel(tcpSend);

      Tcp tcpReceive = Tcp();
      Camel<Socket, SocketConnectionPoint> camelReceive = Camel(tcpReceive);

      CommandFactory.registerCommand(CommandStub());

      Stream<CommunicateData<Socket>> stream = camelReceive.listen(SocketConnectionPoint(address:"127.0.0.1", port:15000));

      camelSend.send(
        SocketConnectionPoint(address:"127.0.0.1", port:15000),
        Message.fromBody(command: CommandStub().command, body: "Hello, camel")
      );

      await for(CommunicateData<Socket> data in stream){
        break;
      }

      expect(CommandStub.isCalledExecute, isTrue);
      expect(utf8.decode(CommandStub.receiveSpy!), "Hello, camel");
    });
  });
}
