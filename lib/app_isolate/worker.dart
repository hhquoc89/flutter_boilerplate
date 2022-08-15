import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

enum IsolateProcess { jsonDecoding }

class IsolateDataWrapper {
  final IsolateProcess isolateProcess;
  final dynamic message;
  final int identifier;

  IsolateDataWrapper(this.isolateProcess, this.message, this.identifier);
}

class CompleterWrapper<T> {
  late Completer<T> completer;
  late int identifier;

  CompleterWrapper() {
    completer = Completer<T>();
    identifier = DateTime.now().microsecondsSinceEpoch;
  }
}

class Worker {
  late Isolate anotherIsolate;
  late SendPort anotherSendPort;
  StreamController mainListener = StreamController.broadcast();
  Completer<void> isolateState = Completer();
  Map<String, CompleterWrapper<dynamic>> pool = {};

  Worker() {
    _init();
  }

  Future<void> dispose() async {
    await mainListener.close();
    anotherIsolate.kill(priority: 0);
  }

  Future<void> init() async {
    return await isolateState.future;
  }

  static void anotherIsolateEntry(SendPort sendPort) {
    ReceivePort receiverPort = ReceivePort();
    sendPort.send(receiverPort.sendPort);
    receiverPort.listen((dynamic data) async {
      if (data is IsolateDataWrapper) {
        data.message["sendPort"] = sendPort;
        data.message["identifier"] = data.identifier;
        if (data.isolateProcess == IsolateProcess.jsonDecoding) {}
      }
    }, onError: (error) {
      if (kDebugMode) {
        print("Error");
      }
    });
  }

  void _init() async {
    final mainReceivePort = ReceivePort();
    if (mainListener.isClosed) mainListener = StreamController.broadcast();
    anotherIsolate = await Isolate.spawn(
        anotherIsolateEntry, mainReceivePort.sendPort,
        onError: mainReceivePort.sendPort, onExit: mainReceivePort.sendPort);
    mainReceivePort.listen((onData) {
      mainListener.add(onData);
    }, onError: (error) {
      if (kDebugMode) {
        print("Error");
      }
    });

    mainListener.stream.listen((data) async {
      if (data is SendPort) {
        anotherSendPort = data;
        isolateState.complete();
      } else if (data is IsolateDataWrapper) {
        if (kDebugMode) {
          print("Data type in main isolate is ${data.isolateProcess}");
          print("Data in main isolate is ${data.message}");
        }
        complete(data);
      } else if (data == null) {
        await dispose();
        isolateState = Completer();
        _init();
      }
    });
  }

  void complete(IsolateDataWrapper data) {
    final com = pool.remove(data.identifier.toString());
    if (com != null) {
      com.completer.complete(data.message);
      pool.remove(com);
    }
  }
}
