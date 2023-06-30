# Camel
[English](../README.md)<br/>

ローカルネットワークで通信を行うためのFlutterパッケージ。

## 特徴
このライブラリは"dart:io"ライブラリを使わず、簡単にローカルネットワーク通信を行えます。
また、受信データはコールバックかStreamを使用した形式か選択して使用することができます。

## インストール
このパッケージをpubspec.yamlに追加してください。
```yaml
# pubspec.yaml

dependencies:
  camel: ^<latest version>
```

## 使用方法

### 送信側
受信側がCommandクラスのコールバック処理を使用しない場合は、以下のように送信処理を作成できます。
```dart
  // TCPを使用したSocket通信を行う場合。
  final Communicator communicator = Tcp();
  final Camel<Socket, SocketConnectionPoint> sender = Camel(communicator);

  // コネクションポイントと送信データを渡してsendメソッドを呼び出しします。
  sender.send(
    SocketConnectionPoint(address: "127.0.0.1", port: 50000),
    Message.fromBody(command: "dummy", body: "Hello, Camel."),
  );
```

受信側がCommandクラスのコールバック処理を使用する場合は、以下のようにします。
```dart
  class MyCommand implements Command {
    @override String get command => "MY_COMMAND";

    @override
    void execute(Uint8List data){
      // このメソッドは受信側がデータを受信したときに呼び出されます。
      print("received: ${utf8.decode(data)}"); // received: Hello, Camel.
    }
  }

  // TCPを使用したSocket通信を行う場合。
  final Communicator communicator = Tcp();
  final Camel<Socket, SocketConnectionPoint> sender = Camel(communicator);
  CommandFactory.registerCommand(MyCommand());  // 作成したコマンドの登録

  // コネクションポイントと送信データを渡してsendメソッドを呼び出しします。
  // この時、作成したコマンドの名前をcommand引数に渡します。
  sender.send(
    SocketConnectionPoint(address: "127.0.0.1", port: 50000),
    Message.fromBody(command: "MY_COMMAND", body: "Hello, Camel."),
  );
```

### 受信側
受信側がCommandクラスのコールバック処理を使用しない場合は、以下のように受信処理を作成できます。
```dart
  // TCPを使用したSocket通信を行う場合。
  final Communicator communicator = Tcp();
  final Camel<Socket, SocketConnectionPoint> receiver = Camel(communicator);

  // バインドするコネクションポイントとともにlistenメソッドを呼び出します。
  await for(
    CommunicateData<Socket> data in receiver.listen(
      SocketConnectionPoint(address: "127.0.0.1", port: 50000)
    )
  ){
    print(data.message.body); // Streamとしてデータを受信します。
  }
```


受信側がCommandクラスのコールバック処理を使用する場合は、以下のようにします。

```dart
  class MyCommand implements Command {
    @override String get command => "MY_COMMAND";

    @override
    void execute(Uint8List data){
      // このメソッドは受信側がデータを受信したときに呼び出されます。
      print("received: ${utf8.decode(data)}");
    }
  }

  // TCPを使用したSocket通信を行う場合。
  final Communicator communicator = Tcp();
  final Camel<Socket, SocketConnectionPoint> receiver = Camel(communicator);

  // バインドするコネクションポイントとともにlistenメソッドを呼び出します。
  await for(
    CommunicateData<Socket> _ in receiver.listen(
      SocketConnectionPoint(address: "127.0.0.1", port: 50000)
    )
  ){}
```

