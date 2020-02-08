import 'package:flutter/material.dart';

class VariantChooser<T> extends StatelessWidget {
  final String title;
  final T groupValue;
  final List<Option<T>> options;
  final ValueChanged<T> onChanged;

  VariantChooser({
    this.title,
    this.groupValue,
    this.options,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 16)),
        ..._buildVariants()
      ],
    );
  }

  List<Widget> _buildVariants() {
    return options
        .map((variant) => RadioButton(
              option: variant,
              groupValue: groupValue,
              onChanged: onChanged,
            ))
        .toList();
  }
}

class RadioButton<T> extends StatefulWidget {
  final Option<T> option;
  final T groupValue;
  final ValueChanged<T> onChanged;

  RadioButton({
    this.option,
    this.groupValue,
    this.onChanged,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RadioButtonState(
      option.name,
      option.value,
      groupValue,
      onChanged,
    );
  }
}

class _RadioButtonState<T> extends State<RadioButton> {
  final String _title;
  final T _value;
  final T _groupValue;
  final ValueChanged<T> _onChanged;

  _RadioButtonState(
    this._title,
    this._value,
    this._groupValue,
    this._onChanged,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(
          groupValue: _groupValue,
          value: _value,
          onChanged: _onChanged,
        ),
        Text(_title),
      ],
    );
  }
}

class Option<T> {
  final T value;
  final String name;

  Option({this.value, this.name});
}
