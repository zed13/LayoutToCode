import 'dart:convert';
import 'dart:html';

import 'package:layout_convert/models.dart';

class SettingsRepository {
  final Storage _storage;
  Settings _settings;

  SettingsRepository() : _storage = window.localStorage {
    final savedSettings = _storage['settings'];
    _settings = savedSettings != null
        ? Settings.fromJson(jsonDecode(savedSettings))
        : Settings(
            language: Language.kotlin,
            javaParams: JavaParams(
              postfix: "View",
              parentView: "view",
            ),
            kotlinParams: KotlinParams(
              postfix: "View",
              parentView: "view",
            ),
          );
  }

  void _updateSettings() {
    Future(() => {_storage['settings'] = jsonEncode(_settings.toJson())})
        .whenComplete(() => print(_storage['settings']));
  }

  Language get language {
    return _settings.language;
  }

  set language(Language language) {
    _settings = _settings.clone(language: language);
    _updateSettings();
  }

  JavaParams get javaParams {
    return _settings.javaParams;
  }

  set javaParams(JavaParams params) {
    _settings = _settings.clone(javaParams: params);
    _updateSettings();
  }

  void setJavaParams({
    JavaAccessModifier fieldModifier,
    VariableStyle fieldStyle,
    String prefix,
    String postfix,
    String parentView,
  }) {
    final _javaParams = _settings.javaParams;

    _settings = _settings.clone(
        javaParams: _javaParams.clone(
      fieldModifier: fieldModifier ?? _javaParams.fieldModifier,
      fieldStyle: fieldStyle ?? _javaParams.fieldStyle,
      prefix: prefix ?? _javaParams.prefix,
      postfix: postfix ?? _javaParams.postfix,
      parentView: parentView ?? _javaParams.parentView,
    ));
    _updateSettings();
  }

  KotlinParams get kotlinParams {
    return _settings.kotlinParams;
  }

  set kotlinParams(KotlinParams params) {
    _settings = _settings.clone(kotlinParams: params);
    _updateSettings();
  }

  void setKotlinParams({
    KotlinAccessModifier fieldModifier,
    VariableStyle fieldStyle,
    String prefix,
    String postfix,
    String parentView,
  }) {
    final _kotlinParams = _settings.kotlinParams;
    _settings = _settings.clone(
        kotlinParams: _kotlinParams.clone(
      fieldModifier: fieldModifier ?? _kotlinParams.fieldModifier,
      fieldStyle: fieldStyle ?? _kotlinParams.fieldStyle,
      prefix: prefix ?? _kotlinParams.prefix,
      postfix: postfix ?? _kotlinParams.postfix,
      parentView: parentView ?? _kotlinParams.parentView,
    ));
    _updateSettings();
  }
}
