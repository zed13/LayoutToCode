import 'dart:async';

import 'package:flutter/material.dart';
import 'package:layout_convert/models.dart';
import 'package:rxdart/rxdart.dart';

class ViewModel {
  // Language observables

  final BehaviorSubject<Language> _language =
      BehaviorSubject.seeded(Language.java);

  // Java observables

  final BehaviorSubject<JavaAccessModifier> _javaAccessModifierController =
      BehaviorSubject.seeded(JavaAccessModifier.public);
  final BehaviorSubject<VariableStyle> _javaFieldStyleController =
      BehaviorSubject.seeded(VariableStyle.lowerCamelCase);
  final _javaPrefixController = TextEditingController(text: "");
  final _javaPostfixController = TextEditingController(text: "View");

  // Kotlin observables

  final BehaviorSubject<KotlinAccessModifier> _kotlinAccessModifier =
      BehaviorSubject.seeded(KotlinAccessModifier.public);
  final BehaviorSubject<VariableStyle> _kotlinFieldStyleController =
      BehaviorSubject.seeded(VariableStyle.lowerCamelCase);
  final _kotlinPrefixController = TextEditingController(text: "");
  final _kotlinPostfixController = TextEditingController(text: "");

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

  void dispose() {
    _language.close();

    _javaAccessModifierController.close();
    _javaFieldStyleController.close();
    _javaPrefixController.dispose();
    _javaPostfixController.dispose();

    _kotlinAccessModifier.close();
    _kotlinFieldStyleController.close();
    _kotlinPrefixController.dispose();
    _kotlinPostfixController.dispose();
  }

  void convert() {}
}
