import 'package:flutter/material.dart';

class Additions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdditionsState();
  }
}

class AdditionsState extends State<Additions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Additions", style: TextStyle(fontSize: 16)),
        inputField(
          labelText: "Prefix",
          onChanged: (value) {},
        ),
        inputField(
          labelText: "Postfix",
          onChanged: (value) {},
        )
      ],
    );
  }
}

Widget inputField({
  @required String labelText,
  @required ValueChanged<String> onChanged,
}) {
  return Container(
    padding: EdgeInsets.only(top: 16),
    child: SizedBox(
      width: 200,
      height: 42,
      child: TextFormField(
        maxLines: 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
        onChanged: onChanged,
      ),
    ),
  );
}