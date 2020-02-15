import 'package:flutter/material.dart';
import 'package:layout_convert/base.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/view_model.dart';


class LanguageAwareContainer extends StatefulWidget {
  final ViewModel viewModel;
  final WidgetBuilder builder;
  final Language targetLanguage;

  LanguageAwareContainer({
    Key key,
    @required this.viewModel,
    @required this.builder,
    @required this.targetLanguage,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LanguageAwareContainer(
        viewModel,
        targetLanguage,
        builder,
      );
  }
}

class _LanguageAwareContainer extends RxState<LanguageAwareContainer> {
  final ViewModel vm;
  final Language targetLanguage;
  final WidgetBuilder builder;

  _LanguageAwareContainer(
    this.vm,
    this.targetLanguage,
    this.builder,
  );

  Language get language => vm.language;

  @override
  void initState() {
    bind(vm.languageStream);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Visibility(
        visible: language == targetLanguage,
        child: builder(context),
      );
}
