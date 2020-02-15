import 'package:flutter/material.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/presentation/additions.dart';
import 'package:layout_convert/presentation/chooser.dart';
import 'package:layout_convert/view_model.dart';

class JavaPanel extends StatelessWidget {
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

  final ViewModel viewModel;
  final JavaAccessModifier currentModifier;
  final ValueChanged<JavaAccessModifier> onModifierChanged;
  final VariableStyle fieldStyle;
  final ValueChanged<VariableStyle> onFieldStyleChanged;
  final String prefix;
  final ValueChanged<String> onPrefixChanged;
  final String postfix;
  final ValueChanged<String> onPostfixChanged;

  JavaPanel({
    Key key,
    @required this.viewModel,
    @required this.currentModifier,
    @required this.onModifierChanged,
    @required this.fieldStyle,
    @required this.onFieldStyleChanged,
    @required this.prefix,
    @required this.onPrefixChanged,
    @required this.postfix,
    @required this.onPostfixChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        VariantChooser<JavaAccessModifier>(
          title: "Field modifier",
          groupValue: currentModifier,
          options: _accessModifiersOptions,
          onChanged: onModifierChanged,
        ),
        VariantChooser<VariableStyle>(
          title: "Field style",
          groupValue: fieldStyle,
          options: _variableStyleOptions,
          onChanged: onFieldStyleChanged,
        ),
        Additions(viewModel: viewModel),
      ],
    );
  }
}
