import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/models.dart';

import '../selectors.dart';

class LanguageAwareContainer extends StatelessWidget {
  final Widget child;
  final Language targetLanguage;

  LanguageAwareContainer({
    Key key,
    @required this.child,
    @required this.targetLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Language>(
      converter: (store) => languageSelector(store.state),
      builder: (context, lang) => Visibility(
        child: child,
        visible: targetLanguage == lang,
      ),
    );
  }
}