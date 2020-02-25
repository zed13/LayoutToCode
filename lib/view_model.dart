import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout_convert/extractor.dart';
import 'package:layout_convert/generator.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/repositories.dart';
import 'package:rxdart/rxdart.dart';

import 'base.dart';

class ViewModel {
  final SettingsRepository repo;

  // Language observables

  ViewModel(this.repo)
      : _language = Subjects.behaviorSubject(
          repo.language,
          onChange: (value) => repo.language = value,
        ),
        _javaAccessModifierController = Subjects.behaviorSubject(
          repo.javaParams.fieldModifier,
          onChange: (value) => repo.setJavaParams(fieldModifier: value),
        ),
        _javaFieldStyleController = Subjects.behaviorSubject(
          repo.javaParams.fieldStyle,
          onChange: (value) => repo.setJavaParams(fieldStyle: value),
        ),
        _javaPrefixController = Controllers.textController(
          text: repo.javaParams.prefix,
          onChanged: (value) => repo.setJavaParams(prefix: value),
        ),
        _javaPostfixController = Controllers.textController(
          text: repo.javaParams.prefix,
          onChanged: (value) => repo.setJavaParams(postfix: value),
        ),
        _javaParentViewController = Controllers.textController(
            text: repo.javaParams.parentView,
            onChanged: (value) => repo.setJavaParams(parentView: value)),
        _kotlinAccessModifier = Subjects.behaviorSubject(
          repo.kotlinParams.fieldModifier,
          onChange: (value) => repo.setKotlinParams(fieldModifier: value),
        ),
        _kotlinFieldStyleController = Subjects.behaviorSubject(
          repo.kotlinParams.fieldStyle,
          onChange: (value) => repo.setKotlinParams(fieldStyle: value),
        ),
        _kotlinPrefixController = Controllers.textController(
          text: repo.kotlinParams.prefix,
          onChanged: (value) => repo.setKotlinParams(prefix: value),
        ),
        _kotlinPostfixController = Controllers.textController(
          text: repo.kotlinParams.postfix,
          onChanged: (value) => repo.setKotlinParams(postfix: value),
        ),
        _kotlinParentViewController = Controllers.textController(
          text: repo.kotlinParams.parentView,
          onChanged: (value) => repo.setKotlinParams(parentView: value),
        );

  final BehaviorSubject<Language> _language;

  final layoutXmlController = TextEditingController(text: "");
  final fieldsController = TextEditingController(text: "");
  final bindingsController = TextEditingController(text: "");

  // Java observables

  final BehaviorSubject<JavaAccessModifier> _javaAccessModifierController;
  final BehaviorSubject<VariableStyle> _javaFieldStyleController;
  final TextEditingController _javaPrefixController;
  final TextEditingController _javaPostfixController;
  final TextEditingController _javaParentViewController;

  // Kotlin observables

  final BehaviorSubject<KotlinAccessModifier> _kotlinAccessModifier;
  final BehaviorSubject<VariableStyle> _kotlinFieldStyleController;
  final TextEditingController _kotlinPrefixController;
  final TextEditingController _kotlinPostfixController;
  final TextEditingController _kotlinParentViewController;

  // common setters and getters

  set language(Language language) => _language.add(language);
  Language get language => _language.value;
  Stream<Language> get languageStream => _language.stream;

  // java setters and getters

  set javaAccessModifier(JavaAccessModifier modifier) =>
      _javaAccessModifierController.add(modifier);
  JavaAccessModifier get javaAccessModifier =>
      _javaAccessModifierController.value;
  Stream<JavaAccessModifier> get javaAccessModifierStream =>
      _javaAccessModifierController.stream;

  set javaFieldStyle(VariableStyle style) =>
      _javaFieldStyleController.add(style);
  VariableStyle get javaFieldStyle => _javaFieldStyleController.value;
  Stream<VariableStyle> get javaFieldStyleStream =>
      _javaFieldStyleController.stream;

  // kotlin setters and getters

  set kotlinAccessModifier(KotlinAccessModifier modifier) =>
      _kotlinAccessModifier.add(modifier);
  KotlinAccessModifier get kotlinAccessModifier => _kotlinAccessModifier.value;
  Stream<KotlinAccessModifier> get kotlinAccessModifierStream =>
      _kotlinAccessModifier.stream;

  set kotlinFieldStyle(VariableStyle style) =>
      _kotlinFieldStyleController.add(style);
  VariableStyle get kotlinFieldStyle => _kotlinFieldStyleController.value;
  Stream<VariableStyle> get kotilnFieldStyleStream =>
      _kotlinFieldStyleController.stream;

  // language controllers getters

  TextEditingController get prefixController => language == Language.kotlin
      ? _kotlinPrefixController
      : _javaPrefixController;

  TextEditingController get postfixController => language == Language.kotlin
      ? _kotlinPostfixController
      : _javaPostfixController;

  TextEditingController get parentViewController => language == Language.kotlin
      ? _kotlinParentViewController
      : _javaParentViewController;

  void dispose() {
    _language.close();
    layoutXmlController.dispose();
    fieldsController.dispose();
    bindingsController.dispose();

    _javaAccessModifierController.close();
    _javaFieldStyleController.close();
    _javaPrefixController.dispose();
    _javaPostfixController.dispose();
    _javaParentViewController.dispose();

    _kotlinAccessModifier.close();
    _kotlinFieldStyleController.close();
    _kotlinPrefixController.dispose();
    _kotlinPostfixController.dispose();
    _kotlinParentViewController.dispose();
  }

  void convert() async {
    final ids =
        extractIds(layoutXmlController.text).whereType<IdEntry>().toList();

    Generator generator;

    if (language == Language.kotlin) {
      generator = Generator.forKotlin(KotlinParams(
        fieldModifier: kotlinAccessModifier,
        fieldStyle: kotlinFieldStyle,
        prefix: _kotlinPrefixController.text,
        postfix: _kotlinPostfixController.text,
        parentView: _kotlinParentViewController.text,
      ));
    } else {
      generator = Generator.forJava(JavaParams(
        fieldModifier: javaAccessModifier,
        fieldStyle: kotlinFieldStyle,
        prefix: _javaPrefixController.text,
        postfix: _javaPostfixController.text,
        parentView: _javaParentViewController.text,
      ));
    }
    bindingsController.text = generator.generateBindings(ids);
    fieldsController.text = generator.generateVariables(ids);
  }

  copyBindings() {
    Clipboard.setData(ClipboardData(text: bindingsController.text));
  }

  copyFields() {
    Clipboard.setData(ClipboardData(text: fieldsController.text));
  }
}
