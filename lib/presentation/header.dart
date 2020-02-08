import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout_convert/actions.dart';
import 'package:layout_convert/containers/language_container.dart';
import 'package:layout_convert/containers/modifier_containers.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/presentation/additions.dart';
import 'package:layout_convert/presentation/buttons_bar.dart';
import 'package:layout_convert/presentation/chooser.dart';
import 'package:layout_convert/presentation/text.dart';
import 'package:layout_convert/selectors.dart';

class Header extends StatelessWidget {
  static List<Option<JavaAccessModifier>> accessModifiersOptions = [
    Option(value: JavaAccessModifier.public, name: "public"),
    Option(value: JavaAccessModifier.protected, name: "protected"),
    Option(value: JavaAccessModifier.private, name: "private"),
    Option(value: JavaAccessModifier.packagePrivate, name: "package-private")
  ];

  static List<Option<VariableStyle>> variableStyleOptions = [
    Option(value: VariableStyle.snakeCase, name: "snake case"),
    Option(value: VariableStyle.lowerCamelCase, name: "lower camel case"),
    Option(value: VariableStyle.upperCamelCase, name: "upper camel case")
  ];

  static List<Option<KotlinAccessModifier>> kotlinAccessModifiersOptions = [
    Option(value: KotlinAccessModifier.public, name: "public"),
    Option(value: KotlinAccessModifier.protected, name: "protected"),
    Option(value: KotlinAccessModifier.private, name: "private"),
    Option(value: KotlinAccessModifier.internal, name: "internal"),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Display1Text("Layout Convert"),
            ButtonsBar(),
          ],
        ),
        LanguageAwareContainer(
          targetLanguage: Language.java,
          child: VariantChooserContainer<JavaAccessModifier>(
            variantSelector: javaAccessModifierSelector,
            eventFactory: (value) => SelectJavaModifierAction(value),
            builder: (builder, modifier, callback) => VariantChooser(
              title: "Access modifier",
              groupValue: modifier,
              options: accessModifiersOptions,
              onChanged: callback,
            ),
          ),
        ),
        LanguageAwareContainer(
          targetLanguage: Language.kotlin,
          child: VariantChooserContainer<KotlinAccessModifier>(
            variantSelector: kotlinAccessModifierSelector,
            eventFactory: (value) => SelectKotlinModifierAction(value),
            builder: (context, modifier, callback) => VariantChooser(
              title: "Acess modifier",
              groupValue: modifier,
              options: kotlinAccessModifiersOptions,
              onChanged: callback,
            ),
          ),
        ),
        VariantChooserContainer<VariableStyle>(
          variantSelector: fieldStyleSelector,
          eventFactory: (value) => SelectFieldStyleAction(value),
          builder: (context, value, callback) => VariantChooser(
            title: "Code field name style",
            groupValue: value,
            options: variableStyleOptions,
            onChanged: callback,
          ),
        ),
        Additions(),
        RaisedButton(
          onPressed: () {},
          child: Text("CONVERT"),
        )
      ],
    );
  }
}
