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

class RadioButton<T> extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(
          groupValue: groupValue,
          value: option.value,
          onChanged: (value) => onChanged(value),
        ),
        Text(option.name),
      ],
    );
  }
}

class Option<T> {
  final T value;
  final String name;

  Option({this.value, this.name});
}
