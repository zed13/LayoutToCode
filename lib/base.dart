import 'dart:async';

import 'package:flutter/material.dart';

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
