import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/presentation/header.dart';
import 'package:layout_convert/presentation/text.dart';
import 'package:layout_convert/reducers.dart';
import 'package:redux/redux.dart';
import 'models.dart';

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
          Header(),
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
}