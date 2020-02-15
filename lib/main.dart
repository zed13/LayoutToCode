import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:layout_convert/actions.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/middleware.dart';
import 'package:layout_convert/presentation/header.dart';
import 'package:layout_convert/presentation/text.dart';
import 'package:layout_convert/reducers.dart';
import 'package:layout_convert/view_model.dart';
import 'package:redux/redux.dart';
import 'models.dart';

void main() {
  final store = Store<AppState>(
    convertReducer,
    initialState: AppState(
      language: Language.java,
      javaParams: JavaParams(),
      kotlinParams: KotlinParams(),
      layoutXml: xml,
    ),
    middleware: [convertMiddleware],
  );

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

  final ViewModel vm = ViewModel();

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
          Header(viewModel: vm),
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
                        child: StoreConnector<AppState, _LayoutViewModel>(
                          converter: (store) => _LayoutViewModel.from(store),
                          builder: (context, vm) => TextFormField(
                            initialValue: vm.text,
                            onChanged: vm.onLayoutChanged,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 100,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          ),
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
                        child: StoreConnector<AppState, String>(
                          converter: (store) => store.state.generatedFields,
                          builder: (context, text) => TextFormField(
                              initialValue: text,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 100,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              )),
                        ),
                      ),
                      TitleText("View bindings"),
                      Expanded(
                        flex: 1,
                        child: StoreConnector<AppState, String>(
                          converter: (store) => store.state.generatedBindings,
                          builder: (context, text) => TextFormField(
                            initialValue: text,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 100,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          ),
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

class _LayoutViewModel {
  final String text;
  final ValueChanged<String> onLayoutChanged;

  _LayoutViewModel({this.text, this.onLayoutChanged});

  static _LayoutViewModel from(Store<AppState> store) {
    return _LayoutViewModel(
      text: store.state.layoutXml,
      onLayoutChanged: (value) {
        store.dispatch(UpdateLayoutXmlAction(value));
      },
    );
  }
}

const xml = '''
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@drawable/bg_screen"
    android:orientation="vertical"
    android:descendantFocusability="beforeDescendants"
    android:focusableInTouchMode="true">

    <include
        android:id="@+id/toolbar"
        layout="@layout/layout_toolbar_base" />

    <androidx.swiperefreshlayout.widget.SwipeRefreshLayout
        android:id="@+id/swipe_refresh"
        android:layout_width="match_parent"
        android:layout_height="match_parent">

        <androidx.core.widget.NestedScrollView
            android:id="@+id/scrollable_container"
            android:layout_width="match_parent"
            android:layout_height="match_parent">

            <LinearLayout
                android:layout_width="match_parent"
                android:layout_height="match_parent"
                android:orientation="vertical">

                <ImageView
                    android:id="@+id/barcode_image"
                    android:layout_width="match_parent"
                    android:layout_height="wrap_content"
                    android:background="@color/bg_ui"
                    tools:background="#0a0"
                    tools:layout_height="200dp" />

                <include
                    android:id="@+id/bonus_card_points_container"
                    layout="@layout/layout_bonus_card_detail" />

                <View
                    android:id="@+id/points_divider"
                    style="@style/Vanilla.Markup.DividerView"
                    android:layout_marginStart="@dimen/offset_16" />

                <include
                    android:id="@+id/bonus_card_number_container"
                    layout="@layout/layout_bonus_card_detail" />

                <View style="@style/Vanilla.Markup.DividerView" />

                <FrameLayout
                    android:layout_width="match_parent"
                    android:layout_height="0dp"
                    android:layout_weight="1">

                    <include
                        android:id="@+id/empty_bonus_card_history_container"
                        layout="@layout/layout_empty_bonus_card_history"
                        android:visibility="gone" />

                    <include
                        android:id="@+id/disable_bonus_card_history_container"
                        layout="@layout/layout_card_operations_disabled"
                        android:visibility="gone" />

                    <include
                        android:id="@+id/card_history_loading_progress"
                        layout="@layout/view_progress"
                        android:layout_width="match_parent"
                        android:layout_height="wrap_content"
                        android:layout_marginTop="@dimen/offset_112"
                        android:visibility="visible" />

                    <androidx.recyclerview.widget.RecyclerView
                        android:id="@+id/list"
                        android:layout_width="match_parent"
                        android:layout_height="match_parent"
                        tools:itemCount="6"
                        tools:listitem="@layout/item_bonus_card_history_entry" />
                </FrameLayout>
            </LinearLayout>
        </androidx.core.widget.NestedScrollView>


    </androidx.swiperefreshlayout.widget.SwipeRefreshLayout>


</LinearLayout>
''';
