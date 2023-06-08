library camel;

import 'package:camel/tcp.dart';
import 'package:camel/communicator.dart';
import 'dart:io';

void main() async{
  Tcp tcp = Tcp();
  await for(CommunicateData<Socket> data in await tcp.listen(SocketConnectionPoint(address: "192.168.12.104", port: 32099))){
    print(data);
  }

  // runApp(const MyApp());
}

