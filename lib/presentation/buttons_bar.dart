import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:layout_convert/actions.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/models.dart';

class ButtonsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Language>(
      converter: (store) => store.state.language,
      builder: (context, language) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildButton(
            image: Image.asset('assets/ic_java_48.png'),
            value: Language.java,
            groupValue: language,
          ),
          VerticalDivider(
            width: 32,
          ),
          _buildButton(
            image: Image.asset(
              'assets/ic_kotlin_48.png',
              height: 152,
              width: 152,
            ),
            value: Language.kotlin,
            groupValue: language,
          )
        ],
      ),
    );
  }

  Widget _buildButton({image: Image, value: Language, groupValue: Language}) {
    return StoreBuilder<AppState>(
      builder: (context, store) => Container(
        height: 152,
        width: 152,
        color: groupValue == value ? Colors.white12 : Colors.transparent,
        child: GestureDetector(
          child: image,
          onTap: () => store.dispatch(ChangeLanguageAction(value)),
        ),
      ),
    );
  }
}
