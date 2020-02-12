import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:layout_convert/actions.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/presentation/kotlin_panel.dart';
import 'package:redux/redux.dart';

class KotlinPanelContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.from(store),
      builder: (context, vm) => KotlinPanel(
        currentModifier: vm.currentModifier,
        onModifierChanged: vm.onModifierChanged,
        fieldStyle: vm.fieldStyle,
        onFieldStyleChanged: vm.onFieldStyleChanged,
        prefix: vm.prefix,
        onPrefixChanged: vm.onPrefixChanged,
        postfix: vm.postfix,
        onPostfixChanged: vm.onPostfixChanged,
      ),
    );
  }
}

class _ViewModel {
  final KotlinAccessModifier currentModifier;
  final ValueChanged<KotlinAccessModifier> onModifierChanged;
  final VariableStyle fieldStyle;
  final ValueChanged<VariableStyle> onFieldStyleChanged;
  final String prefix;
  final ValueChanged<String> onPrefixChanged;
  final String postfix;
  final ValueChanged<String> onPostfixChanged;

  _ViewModel({
    Key key,
    this.currentModifier,
    this.onModifierChanged,
    this.fieldStyle,
    this.onFieldStyleChanged,
    this.prefix,
    this.onPrefixChanged,
    this.postfix,
    this.onPostfixChanged,
  });

  static _ViewModel from(Store<AppState> store) => _ViewModel(
      currentModifier: store.state.kotlinParams.fieldModifier,
      onModifierChanged: (value) {
        store.dispatch(SelectKotlinModifierAction(value));
      },
      fieldStyle: store.state.kotlinParams.fieldStyle,
      onFieldStyleChanged: (value) {
        store.dispatch(SelectKotlinStyleAction(value));
      },
      prefix: store.state.kotlinParams.prefix,
      onPrefixChanged: (value) {
        store.dispatch(UpdateKotlinPrefixAction(value));
      },
      postfix: store.state.kotlinParams.postfix,
      onPostfixChanged: (value) {
        store.dispatch(UpdateKotlinPostfixAction(value));
      });
}
