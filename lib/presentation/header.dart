import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout_convert/containers/java_panel_container.dart';
import 'package:layout_convert/containers/kotlin_panel_container.dart';
import 'package:layout_convert/containers/language_container.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/presentation/buttons_bar.dart';
import 'package:layout_convert/presentation/text.dart';

class Header extends StatelessWidget {
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
          child: JavaPanelContainer(),
        ),
        LanguageAwareContainer(
          targetLanguage: Language.kotlin,
          child: KotlinPanelContainer(),
        ),
        RaisedButton(
          onPressed: () {},
          child: Text("CONVERT"),
        )
      ],
    );
  }
}
