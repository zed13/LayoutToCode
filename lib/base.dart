import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

typedef VoidCallback = Function();

typedef ViewBuilder = Widget Function(BuildContext context);

abstract class RxState<T extends StatefulWidget> extends State<T> {
  List<StreamSubscription> _subscribtions = [];

  void addDisposable<F>(StreamSubscription<F> subscription) {
    _subscribtions.add(subscription);
  }

  void bind<F>(
    Stream<F> stream, {
    ValueChanged<F> onChanged,
    Function onError,
    VoidCallback onDone,
    bool cancelOnError = false,
  }) {
    addDisposable(stream.listen(
      (event) {
        if (onChanged == null) {
          setState(() {});
        } else {
          setState(() => onChanged(event));
        }
      },
      onError: ([error, trace]) {
        if (onError != null) {
          setState(() => onError());
        }
      },
      onDone: () {
        if (onDone != null) {
          setState(() => onDone());
        }
      },
      cancelOnError: cancelOnError,
    ));
  }

  @override
  void dispose() {
    _subscribtions.forEach((element) => element.cancel());
    super.dispose();
  }
}

class Subjects {
  static BehaviorSubject<T> behaviorSubject<T>(
    T initialValue, {
    Function(T) onChange,
  }) =>
      BehaviorSubject.seeded(initialValue)
        ..listen((value) {
          if (onChange != null) onChange(value);
        });
}

class Controllers {
  static TextEditingController textController({
    @required String text,
    Function(String) onChanged,
  }) {
    final controller = TextEditingController(text: text);
    controller.addListener(() {
      if (onChanged != null) onChanged(controller.text);
    });
    return controller;
  }
}
