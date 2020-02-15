import 'package:flutter/material.dart';
import 'package:layout_convert/base.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/view_model.dart';

class ButtonsBar extends StatefulWidget {
  final ViewModel viewModel;

  ButtonsBar({Key key, @required this.viewModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonsBarState(viewModel);
}

class _ButtonsBarState extends RxState<ButtonsBar> {
  final ViewModel vm;

  _ButtonsBarState(this.vm);

  Language get language => vm.language;

  @override
  void initState() {
    bind(vm.languageStream);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }

  Widget _buildButton({image: Image, value: Language, groupValue: Language}) {
    return Container(
      height: 152,
      width: 152,
      color: groupValue == value ? Colors.white12 : Colors.transparent,
      child: GestureDetector(
        child: image,
        onTap: () => vm.language = value,
      ),
    );
  }
}
