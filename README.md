<img height="200px" src="doc/assets/rogo.png">

# Camel
[日本語](doc/README.jp.md)<br/>

Flutter package that allows communicating in a local network.

## Features
This library allows you to communicate in a local network without "dart:io" package.
Also, you can switch callback communication or stream communication.

## Getting started
Add this package to your pubspec.yaml
```yaml
# pubspec.yaml

dependencies:
  camel: ^<latest version>
```

## Usage

### Sender
If the receiver doesn't use a command callback, you call the send method as below.
```dart
  // if you use socket communication and TCP.
  final Communicator communicator = Tcp();
  final Camel<Socket, SocketConnectionPoint> sender = Camel(communicator);

  // call send method with a connection point a send message.
  sender.send(
    SocketConnectionPoint(address: "127.0.0.1", port: 50000),
    Message.fromBody(command: "dummy", body: "Hello, Camel."),
  );
```

When using a command callback, you define a custom command class as below.
```dart
  class MyCommand implements Command {
    @override String get command => "MY_COMMAND";

    @override
    void execute(Uint8List data){
      // This method is called when data is received by the Camel.listen method.
      print("received: ${utf8.decode(data)}"); // received: Hello, Camel.
    }
  }

  // if you use socket communication and TCP.
  final Communicator communicator = Tcp();
  final Camel<Socket, SocketConnectionPoint> sender = Camel(communicator);
  CommandFactory.registerCommand(MyCommand());  // register command.

  // call send method with a connection point a send message.
  sender.send(
    SocketConnectionPoint(address: "127.0.0.1", port: 50000),
    Message.fromBody(command: "MY_COMMAND", body: "Hello, Camel."),
  );
```

### Receiver
If the receiver doesn't use callback, you can call the listen method as below.
```dart
  // if you use socket communication and TCP.
  final Communicator communicator = Tcp();
  final Camel<Socket, SocketConnectionPoint> receiver = Camel(communicator);

  // call listen method with a bind connection point.
  await for(
    CommunicateData<Socket> data in receiver.listen(
      SocketConnectionPoint(address: "127.0.0.1", port: 50000)
    )
  ){
    print(data.message.body); // display received data.
  }
```

When the receiver receives the custom command, then call the execute method of the command as below.
```dart
  class MyCommand implements Command {
    @override String get command => "MY_COMMAND";

    @override
    void execute(Uint8List data){
      // This method is called when data is received by the Camel.listen method.
      print("received: ${utf8.decode(data)}"); // display "received: " + received data
    }
  }

  // if you use socket communication and TCP.
  final Communicator communicator = Tcp();
  final Camel<Socket, SocketConnectionPoint> receiver = Camel(communicator);
  CommandFactory.registerCommand(MyCommand());  // register command.

  // call listen method with a bind connection point.
  await for(
    CommunicateData<Socket> _ in receiver.listen(
      SocketConnectionPoint(address: "127.0.0.1", port: 50000)
    )
  ){}
```

