import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:layout_convert/actions.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/presentation/java_panel.dart';
import 'package:layout_convert/view_model.dart';
import 'package:redux/redux.dart';

class JavaPanelContainer extends StatelessWidget {
  final ViewModel viewModel;

  JavaPanelContainer({@required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.from(store),
      builder: (context, vm) => JavaPanel(
        viewModel: viewModel,
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
  final JavaAccessModifier currentModifier;
  final ValueChanged<JavaAccessModifier> onModifierChanged;
  final VariableStyle fieldStyle;
  final ValueChanged<VariableStyle> onFieldStyleChanged;
  final String prefix;
  final ValueChanged<String> onPrefixChanged;
  final String postfix;
  final ValueChanged<String> onPostfixChanged;

  _ViewModel({
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
      currentModifier: store.state.javaParams.fieldModifier,
      onModifierChanged: (value) {
        store.dispatch(SelectJavaModifierAction(value));
      },
      fieldStyle: store.state.javaParams.fieldStyle,
      onFieldStyleChanged: (value) {
        store.dispatch(SelectJavaStyleAction(value));
      },
      prefix: store.state.javaParams.prefix,
      onPrefixChanged: (value) {
        store.dispatch(UpdateJavaPrefixAction(value));
      },
      postfix: store.state.javaParams.postfix,
      onPostfixChanged: (value) {
        store.dispatch(UpdateJavaPostfixAction(value));
      });
}
