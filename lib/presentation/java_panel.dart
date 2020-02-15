import 'package:flutter/material.dart';
import 'package:layout_convert/base.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/presentation/additions.dart';
import 'package:layout_convert/presentation/chooser.dart';
import 'package:layout_convert/view_model.dart';

class JavaPanel extends StatefulWidget {
  final ViewModel viewModel;

  JavaPanel({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _JpanelState(viewModel);
}

class _JpanelState extends RxState<JavaPanel> {
  final ViewModel vm;

  _JpanelState(this.vm);

  static List<Option<JavaAccessModifier>> _accessModifiersOptions = [
    Option(value: JavaAccessModifier.public, name: "public"),
    Option(value: JavaAccessModifier.protected, name: "protected"),
    Option(value: JavaAccessModifier.private, name: "private"),
    Option(value: JavaAccessModifier.packagePrivate, name: "package-private")
  ];

  static List<Option<VariableStyle>> _variableStyleOptions = [
    Option(value: VariableStyle.snakeCase, name: "snake case"),
    Option(value: VariableStyle.lowerCamelCase, name: "lower camel case"),
    Option(value: VariableStyle.upperCamelCase, name: "upper camel case")
  ];

  @override
  void initState() {
    bind(vm.javaFieldStyleStream);
    bind(vm.javaAccessModifierStream);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        VariantChooser<JavaAccessModifier>(
          title: "Field modifier",
          groupValue: vm.javaAccessModifier,
          options: _accessModifiersOptions,
          onChanged: (value) {
            vm.javaAccessModifier = value;
          },
        ),
        VariantChooser<VariableStyle>(
          title: "Field style",
          groupValue: vm.javaFieldStyle,
          options: _variableStyleOptions,
          onChanged: (value) {
            vm.javaFieldStyle = value;
          },
        ),
        Additions(viewModel: vm),
      ],
    );
  }
}
