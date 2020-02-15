import 'package:flutter/material.dart';
import 'package:layout_convert/base.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/presentation/additions.dart';
import 'package:layout_convert/presentation/chooser.dart';
import 'package:layout_convert/view_model.dart';

class KotlinPanel extends StatefulWidget {
  final ViewModel viewModel;

  KotlinPanel({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KotlinPanelState(viewModel);
}

class _KotlinPanelState extends RxState<KotlinPanel> {
  static List<Option<VariableStyle>> _variableStyleOptions = [
    Option(value: VariableStyle.snakeCase, name: "snake case"),
    Option(value: VariableStyle.lowerCamelCase, name: "lower camel case"),
    Option(value: VariableStyle.upperCamelCase, name: "upper camel case")
  ];

  static List<Option<KotlinAccessModifier>> _kotlinAccessModifiersOptions = [
    Option(value: KotlinAccessModifier.public, name: "public"),
    Option(value: KotlinAccessModifier.protected, name: "protected"),
    Option(value: KotlinAccessModifier.private, name: "private"),
    Option(value: KotlinAccessModifier.internal, name: "internal"),
  ];

  final ViewModel vm;

  _KotlinPanelState(this.vm);

  @override
  void initState() {
    bind(vm.kotlinAccessModifierStream);
    bind(vm.kotilnFieldStyleStream);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        VariantChooser<KotlinAccessModifier>(
          title: "Field modifier",
          groupValue: vm.kotlinAccessModifier,
          options: _kotlinAccessModifiersOptions,
          onChanged: (value) {
            vm.kotlinAccessModifier = value;
          },
        ),
        VariantChooser<VariableStyle>(
          title: "Field style",
          groupValue: vm.kotlinFieldStyle,
          options: _variableStyleOptions,
          onChanged: (value) {
            vm.kotlinFieldStyle = value;
          },
        ),
        Additions(viewModel: vm),
      ],
    );
  }
}
