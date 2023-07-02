import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camel/camel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camel Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NoCommandPage(title: 'Camel Demo Page(no use command)'),
      // home: const CommandPage(title: 'Camel Demo Page(use command)'),
    );
  }
}

class NoCommandPage extends StatefulWidget {
  const NoCommandPage({super.key, required this.title});

  final String title;

  @override
  State<NoCommandPage> createState() => _NoCommandPage();
}

class _NoCommandPage extends State<NoCommandPage> {
  late final Camel<Socket, SocketConnectionPoint> _receiver;

  static const String myAddress =
      "127.0.0.1"; // if you use android emulator, change to emulator's ip address (etc."10.0.2.16").
  static const int port = 50000;

  String _sendText = "";
  String _receiveText = "";

  @override
  void initState() {
    _receiver = Camel(Tcp());
    listen();
    super.initState();
  }

  Future listen() async {
    // call listen method for receive message.
    await for (CommunicateData<Socket> data in _receiver
        .listen(SocketConnectionPoint(address: myAddress, port: port))) {
      setState(() {
        _receiveText = data.message.body;
      });
    }
  }

  void _send() async {
    final Camel<Socket, SocketConnectionPoint> sender =
        Camel<Socket, SocketConnectionPoint>(Tcp());
    // call send method for send message.
    await sender.send(
      SocketConnectionPoint(address: myAddress, port: port),
      Message.fromBody(
          command: "dummy",
          body:
              _sendText), // if you don't use command, a command arg is anything.
    );
    sender.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Received message:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              _receiveText,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              child: TextField(
                onChanged: (String value) {
                  _sendText = value;
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _send,
        tooltip: 'Send',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CommandPage extends StatefulWidget {
  const CommandPage({super.key, required this.title});

  final String title;

  @override
  State<CommandPage> createState() => _CommandPage();
}

class _CommandPage extends State<CommandPage> implements Command {
  late final Camel<Socket, SocketConnectionPoint> _receiver;

  static const String myAddress =
      "127.0.0.1"; // if you use android emulator, change to emulator's ip address (etc."10.0.2.16").
  static const int port = 50000;

  String _sendText = "";
  String _receiveText = "";

  @override
  String get command => "MY_COMMAND";

  @override
  void execute(Uint8List data) {
    setState(() {
      _receiveText = utf8.decode(data);
    });
  }

  @override
  void initState() {
    CommandFactory.registerCommand(this); // register command.
    _receiver = Camel(Tcp());
    listen();
    super.initState();
  }

  Future listen() async {
    // call listen method for receive message.
    await for (CommunicateData<Socket> _ in _receiver
        .listen(SocketConnectionPoint(address: myAddress, port: port))) {}
  }

  void _send() async{
    final Camel<Socket, SocketConnectionPoint> sender =
        Camel<Socket, SocketConnectionPoint>(Tcp());
    // call send method for send message.
    await sender.send(
      SocketConnectionPoint(address: myAddress, port: port),
      Message.fromBody(
          command: "MY_COMMAND",
          body:
              _sendText), // if you don't use command, a command arg is anything.
    );

    sender.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Received message:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              _receiveText,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              child: TextField(
                onChanged: (String value) {
                  _sendText = value;
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _send,
        tooltip: 'Send',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
