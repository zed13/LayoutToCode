import 'package:flutter/material.dart';
import 'package:layout_convert/presentation/header.dart';
import 'package:layout_convert/presentation/text.dart';
import 'package:layout_convert/repositories.dart';
import 'package:layout_convert/view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.lightGreen;
    return MaterialApp(
      title: 'Layout Convert',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: primaryColor,
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
        primaryColor: primaryColor,
        accentColor: primaryColor,
        toggleableActiveColor: primaryColor,
        cursorColor: primaryColor,
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
  final ViewModel vm = ViewModel(SettingsRepository());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      height: size.height,
      width: size.width,
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Header(viewModel: vm),
            Divider(thickness: 2),
            divider(),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: CodeField(
                      title: "Layout XML",
                      fieldController: vm.layoutXmlController,
                    ),
                  ),
                  verticalDivider(),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TitleText("Field initialization"),
                        divider(height: 8),
                        Expanded(
                          flex: 1,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: <Widget>[
                              TextFormField(
                                controller: vm.fieldsController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                minLines: 100,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.content_copy),
                                onPressed: () => vm.copyFields(),
                              )
                            ],
                          ),
                        ),
                        divider(),
                        TitleText("View bindings"),
                        divider(height: 8),
                        Expanded(
                          flex: 1,
                          child: Stack(
                              alignment: Alignment.topRight,
                              children: <Widget>[
                                TextFormField(
                                  controller: vm.bindingsController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  minLines: 100,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                IconButton(
                                  icon: Icon(Icons.content_copy),
                                  onPressed: () => vm.copyBindings(),
                                ),
                              ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class CodeField extends StatelessWidget {
  final String title;
  final TextEditingController fieldController;
  final VoidCallback copyCallback;
  final bool isCopyEnabled;

  const CodeField({
    Key key,
    @required this.title,
    @required this.fieldController,
    this.copyCallback,
  })  : isCopyEnabled = copyCallback != null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TitleText(title),
        divider(height: 8),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: fieldController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 100,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

VerticalDivider verticalDivider({double width = 24}) {
  return VerticalDivider(
    color: Colors.transparent,
    width: width,
  );
}

Divider divider({double height = 24}) {
  return Divider(
    color: Colors.transparent,
    height: height,
  );
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
