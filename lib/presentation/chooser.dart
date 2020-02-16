import 'package:flutter/material.dart';

class VariantChooser<T> extends StatelessWidget {
  final String title;
  final T groupValue;
  final List<Option<T>> options;
  final ValueChanged<T> onChanged;

  VariantChooser({
    @required this.title,
    @required this.groupValue,
    @required this.options,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(title, style: TextStyle(fontSize: 16)),
          ),
          ..._buildVariants()
        ],
      ),
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
