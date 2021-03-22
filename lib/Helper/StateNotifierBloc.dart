import 'dart:async';
import 'package:rxdart/rxdart.dart';

enum StreamType { Publish, Behavior }

class StateNotifierBloc<T> {
  StreamController<T> _controller;
  Stream<T> get stream => _controller.stream;

  StateNotifierBloc(
      {StreamType type, void onListen(), void onCancel(), bool sync = false}) {
    if (StreamType.Behavior == type) {
      _controller = BehaviorSubject<T>(
        onListen: onListen,
        onCancel: onCancel,
        sync: sync,
      );
    } else{
      _controller = PublishSubject<T>(
        onListen: onListen,
        onCancel: onCancel,
        sync: sync,
      );
    }
  }


  void push(T data) {
    print(data);
    _controller.sink.add(data);
  }

  void pushError(data) {
    print(data);
    _controller.sink.addError(data);
  }

  void error(error) => _controller.sink.addError(error);

  void dispose() => _controller.close();
}
