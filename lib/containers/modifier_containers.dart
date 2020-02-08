import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:layout_convert/actions.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/models.dart';

import '../selectors.dart';

typedef ValueCallback<T> = void Function(T value);

typedef VariantViewModelBuilder<T> = Widget Function(
  BuildContext context,
  T currentValue,
  ValueCallback<T> onChanged,
);

class JavaAccessModifierContainer extends StatelessWidget {
  final VariantViewModelBuilder<JavaAccessModifier> builder;

  JavaAccessModifierContainer({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, JavaAccessModifier>(
      distinct: true,
      converter: (store) => javaAccessModifierSelector(store.state),
      builder: (context, modifier) =>
          StoreConnector<AppState, ValueCallback<JavaAccessModifier>>(
        converter: (store) =>
            (value) => store.dispatch(SelectJavaModifierAction(value)),
        builder: (context, callback) => builder(context, modifier, callback),
      ),
    );
  }
}

class KotlinAccessModifierContainer extends StatelessWidget {
  final VariantViewModelBuilder<KotlinAccessModifier> builder;

  KotlinAccessModifierContainer({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, KotlinAccessModifier>(
      distinct: true,
      converter: (store) => kotlinAccessModifierSelector(store.state),
      builder: (context, modifier) =>
          StoreConnector<AppState, ValueCallback<KotlinAccessModifier>>(
        converter: (store) =>
            (value) => store.dispatch(SelectKotlinModifierAction(value)),
        builder: (context, callback) => builder(context, modifier, callback),
      ),
    );
  }
}

