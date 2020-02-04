import 'package:flutter/material.dart';
import 'models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout Convert',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
        primaryColor: Colors.cyan,
      ),
      home: MainPage(title: 'Layout Convert'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildHeader(context),
          Divider(),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Title("XML Layout"),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 100,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Title("Field initialization"),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 100,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            )),
                      ),
                      Title("View bindings"),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 100,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Display1("Layout Convert"),
            ButtonsBar(),
          ],
        ),
        VariantChooser(
          "Access modifier",
          AccessLevel.public,
          accessModifiersOptions,
        ),
        VariantChooser(
          "Code field name style",
          VariableStyle.lowerCamelCase,
          variableStyleOptions,
        ),
        Additions(),
        RaisedButton(
          onPressed: () {},
          child: Text("CONVERT"),
        )
      ],
    );
  }
}

class Title extends StatelessWidget {
  final String title;

  Title(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.title);
  }
}

class Display1 extends StatelessWidget {
  final String title;

  Display1(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.display1);
  }
}

class VariantChooser<T> extends StatefulWidget {
  final String title;
  final T initialValue;
  final List<Option<T>> options;

  VariantChooser(this.title, this.initialValue, this.options);

  @override
  State<StatefulWidget> createState() {
    return VariantChooserState(title, initialValue, options);
  }
}

class VariantChooserState<T> extends State<VariantChooser> {
  VariantChooserState(String title, T initialOption, List<Option<T>> options) {
    this._selectedVariant = initialOption;
    this._options = options;
    this._title = title;
  }

  T _selectedVariant;

  List<Option<T>> _options;

  String _title;

  void onSelectionChanged(T value) {
    setState(() {
      _selectedVariant = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(_title, style: TextStyle(fontSize: 16)),
        ..._buildVariants()
      ],
    );
  }

  List<Widget> _buildVariants() {
    return _options
        .map((variant) => radioButton(
              title: variant.name,
              currentGroupValue: _selectedVariant,
              value: variant.value,
              onChanged: (value) => onSelectionChanged(value),
            ))
        .toList();
  }
}

Widget radioButton<T>({
  @required String title,
  @required T currentGroupValue,
  @required T value,
  @required ValueChanged<T> onChanged,
}) {
  return Row(
    children: <Widget>[
      Radio(
        groupValue: currentGroupValue,
        value: value,
        onChanged: onChanged,
      ),
      Text(title),
    ],
  );
}

class Option<T> {
  final T value;
  final String name;

  Option({this.value, this.name});
}

List<Option<AccessLevel>> accessModifiersOptions = [
  Option(value: AccessLevel.public, name: "public"),
  Option(value: AccessLevel.protected, name: "protected"),
  Option(value: AccessLevel.private, name: "private"),
  Option(value: AccessLevel.packagePrivate, name: "package-private")
];

List<Option<VariableStyle>> variableStyleOptions = [
  Option(value: VariableStyle.snakeCase, name: "snake case"),
  Option(value: VariableStyle.lowerCamelCase, name: "lower camel case"),
  Option(value: VariableStyle.upperCamelCase, name: "upper camel case")
];

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

Widget inputField(
    {@required String labelText, @required ValueChanged<String> onChanged}) {
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

class ButtonsBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ButtonsBarState();
  }
}

class ButtonsBarState extends State<ButtonsBar> {
  Language _selectedLanguage = Language.java;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildButton(
          image: Image.asset('assets/ic_java_48.png'),
          value: Language.java,
          groupValue: _selectedLanguage,
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
          groupValue: _selectedLanguage,
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
        onTap: () => _onSelectionChanged(value),
      ),
    );
  }

  void _onSelectionChanged(Language value) {
    setState(() {
      _selectedLanguage = value;
    });
  }
}
