import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;

  TitleText(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.title);
  }
}

class Display1Text extends StatelessWidget {
  final String title;

  Display1Text(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.headline4);
  }
}


