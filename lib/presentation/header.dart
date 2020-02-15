import 'package:flutter/material.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/presentation/buttons_bar.dart';
import 'package:layout_convert/presentation/java_panel.dart';
import 'package:layout_convert/presentation/kotlin_panel.dart';
import 'package:layout_convert/presentation/language_container.dart';
import 'package:layout_convert/presentation/text.dart';
import 'package:layout_convert/view_model.dart';

class Header extends StatelessWidget {
  final ViewModel viewModel;

  Header({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Display1Text("Layout Convert"),
            ButtonsBar(viewModel: viewModel),
          ],
        ),
        LanguageAwareContainer(
          viewModel: viewModel,
          targetLanguage: Language.java,
          builder: (context) => JavaPanel(viewModel: viewModel),
        ),
        LanguageAwareContainer(
          viewModel: viewModel,
          targetLanguage: Language.kotlin,
          builder: (context) => KotlinPanel(viewModel: viewModel),
        ),
         RaisedButton(
            onPressed: () {
              viewModel.convert();
            },
            child: Text("CONVERT"),
          ),
      ],
    );
  }
}
