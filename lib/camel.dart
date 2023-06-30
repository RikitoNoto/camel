library camel;

import "dart:async";
import "dart:convert";
import "dart:typed_data";

import "communicator.dart";
import "command.dart";
import "message.dart";

export "communicator.dart";
export "command.dart";
export "message.dart";

class Camel<T, C> {
  Camel(this.communicator);
  final Communicator<T, C> communicator;

  Future<int> send(C to, Message message) async {
    T connection = await communicator.connect(to);
    return await communicator
        .send(CommunicateData<T>(connection: connection, message: message));
  }

  Stream<CommunicateData<T>> listen(C bind) async* {
    await for (CommunicateData<T> data in await communicator.listen(bind)) {
      Command? command = CommandFactory.getCommand(data.message);
      if (command != null) {
        command.execute(Uint8List.fromList(utf8.encode(data.message.body)));
      }
      yield data;
    }
  }
}
