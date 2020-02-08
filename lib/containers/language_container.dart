import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/models.dart';

import '../selectors.dart';

class LanguageAwareContainer extends StatelessWidget {
  final WidgetBuilder builder;
  final Language targetLanguage;

  LanguageAwareContainer({
    Key key,
    @required this.builder,
    @required this.targetLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Language>(
      converter: languageSelector,
      builder: (context, lang) => Visibility(
        child: builder(context),
        visible: targetLanguage == lang,
      ),
    );
  }
}