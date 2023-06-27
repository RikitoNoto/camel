import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camel/command.dart';
import 'package:camel/communicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:camel/tcp.dart';
import 'package:camel/message.dart';
import 'package:camel/camel.dart';

void main() {
  useTcpTest();
}

class CommandStub implements Command{
  @override String get command => "STUB";
  static Uint8List? receiveSpy;
  static bool isCalledExecute = false;

  @override
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

      await for(CommunicateData<Socket> _ in stream){
        break;
      }

      expect(CommandStub.isCalledExecute, isTrue);
      expect(utf8.decode(CommandStub.receiveSpy!), "Hello, camel");
    });
  });
}
