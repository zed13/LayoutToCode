import 'package:flutter/material.dart';

class Additions extends StatelessWidget {
  final String initialPrefix;
  final String initialPostfix;
  final ValueChanged<String> onPrefixChanged;
  final ValueChanged<String> onPostfixChanged;

  Additions({
    Key key,
    this.initialPrefix = "",
    this.initialPostfix = "",
    @required this.onPrefixChanged,
    @required this.onPostfixChanged,
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Additions", style: TextStyle(fontSize: 16)),
        _inputField(
          value: initialPrefix,
          onChanged: onPrefixChanged,
          labelText: "Prefix",
        ),
        _inputField(
          value: initialPostfix,
          onChanged: onPostfixChanged,
          labelText: "Postfix",
        )
      ],
    );
  }
}

Widget _inputField({
  @required String labelText,
  @required String value,
  @required ValueChanged<String> onChanged,
}) {
  return Container(
    padding: EdgeInsets.only(top: 16),
    child: SizedBox(
      width: 200,
      height: 42,
      child: TextFormField(
        initialValue: value,
        onChanged: onChanged,
        maxLines: 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    ),
  );
}
