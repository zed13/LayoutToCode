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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: RaisedButton(
            padding: EdgeInsets.only(
              left: 48,
              top: 12,
              right: 48,
              bottom: 12,
            ),
            onPressed: () {
              viewModel.convert();
            },
            child: Text("CONVERT", style: Theme.of(context).textTheme.button),
          ),
        ),
      ],
    );
  }
}
