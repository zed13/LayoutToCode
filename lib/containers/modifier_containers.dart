import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:layout_convert/app_state.dart';

import '../selectors.dart';

typedef ValueCallback<T> = void Function(T value);

typedef VariantViewModelBuilder<T> = Widget Function(
  BuildContext context,
  T currentValue,
  ValueCallback<T> onChanged,
);

typedef EventFactory<T> = dynamic Function(T value);

class VariantChooserContainer<T> extends StatelessWidget {
  final VariantViewModelBuilder<T> builder;
  final Selector<T> variantSelector;
  final EventFactory<T> eventFactory;

  VariantChooserContainer({
    Key key,
    @required this.builder,
    @required this.variantSelector,
    @required this.eventFactory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, T>(
      distinct: true,
      converter: (store) => variantSelector(store.state),
      builder: (context, modifier) =>
          StoreConnector<AppState, ValueCallback<T>>(
        converter: (store) =>
            (value) => store.dispatch(eventFactory(value)),
        builder: (context, callback) => builder(context, modifier, callback),
      ),
    );
  }
}

