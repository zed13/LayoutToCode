import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:layout_convert/actions.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/containers/language_container.dart';
import 'package:layout_convert/presentation/text.dart';
import 'package:layout_convert/reducers.dart';
import 'package:layout_convert/selectors.dart';
import 'package:redux/redux.dart';
import 'containers/modifier_containers.dart';
import 'models.dart';
import 'presentation/chooser.dart';

void main() {
  final store = Store<AppState>(convertReducer,
      initialState: AppState(
        language: Language.java,
        javaParams: JavaParams(),
        kotlinParams: KotlinParams(),
      ));

  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp(this.store, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Layout Convert',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.pink,
          backgroundColor: Color.fromARGB(255, 48, 48, 48),
          primaryColor: Colors.cyan,
        ),
        home: MainPage(title: 'Layout Convert'),
      ),
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
                      TitleText("XML Layout"),
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
                      TitleText("Field initialization"),
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
                      TitleText("View bindings"),
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
            Display1Text("Layout Convert"),
            ButtonsBar(),
          ],
        ),
        LanguageAwareContainer(
          targetLanguage: Language.java,
          child: VariantChooserContainer<JavaAccessModifier>(
            variantSelector: javaAccessModifierSelector,
            eventFactory: (value) => SelectJavaModifierAction(value),
            builder: (builder, modifier, callback) => VariantChooser(
              title: "Access modifier",
              groupValue: modifier,
              options: accessModifiersOptions,
              onChanged: callback,
            ),
          ),
        ),
        LanguageAwareContainer(
          targetLanguage: Language.kotlin,
          child: VariantChooserContainer<KotlinAccessModifier>(
            variantSelector: kotlinAccessModifierSelector,
            eventFactory: (value) => SelectKotlinModifierAction(value),
            builder: (context, modifier, callback) => VariantChooser(
              title: "Acess modifier",
              groupValue: modifier,
              options: kotlinAccessModifiersOptions,
              onChanged: callback,
            ),
          ),
        ),
        VariantChooserContainer<VariableStyle>(
          variantSelector: javaFieldStyleSelector,
          eventFactory: (value) => SelectJavaFieldStyleAction(value),
          builder: (context, value, callback) => VariantChooser(
            title: "Code field name style",
            groupValue: value,
            options: variableStyleOptions,
            onChanged: callback,
          ),
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


List<Option<JavaAccessModifier>> accessModifiersOptions = [
  Option(value: JavaAccessModifier.public, name: "public"),
  Option(value: JavaAccessModifier.protected, name: "protected"),
  Option(value: JavaAccessModifier.private, name: "private"),
  Option(value: JavaAccessModifier.packagePrivate, name: "package-private")
];

List<Option<VariableStyle>> variableStyleOptions = [
  Option(value: VariableStyle.snakeCase, name: "snake case"),
  Option(value: VariableStyle.lowerCamelCase, name: "lower camel case"),
  Option(value: VariableStyle.upperCamelCase, name: "upper camel case")
];

List<Option<KotlinAccessModifier>> kotlinAccessModifiersOptions = [
  Option(value: KotlinAccessModifier.public, name: "public"),
  Option(value: KotlinAccessModifier.protected, name: "protected"),
  Option(value: KotlinAccessModifier.private, name: "private"),
  Option(value: KotlinAccessModifier.internal, name: "internal"),
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
