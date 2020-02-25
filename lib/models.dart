import 'dart:convert';

import 'package:layout_convert/extractor.dart';

enum Language { java, kotlin }

enum JavaAccessModifier { public, private, protected, packagePrivate }

enum KotlinAccessModifier { public, protected, private, internal }

enum VariableStyle { snakeCase, lowerCamelCase, upperCamelCase }

class EnumConverter {
  static String toJson(enumMember) {
    return jsonEncode(enumMember.toString().split(".")[1]);
  }

  static Language languageFromJson(String enumMember) {
    print("languageFromJson($enumMember)");
    return enumMember == '"kotlin"' ? Language.kotlin : Language.java;
  }

  static JavaAccessModifier javaAccessModifierFromJson(String enumMember) {
    enumMember = jsonDecode(enumMember);
    print("javaAccessModifierFromJson($enumMember)");
    for (JavaAccessModifier member in JavaAccessModifier.values) {
      if (member.toString() == "JavaAccessModifier.$enumMember") {
        return member;
      }
    }
    throw ParseError(
        "Unknown member '$enumMember' for enum JavaAccessModifier");
  }

  static KotlinAccessModifier kotlinAccessModifierFromJson(String enumMember) {
    enumMember = jsonDecode(enumMember);
    print("kotlinAccessModifierFromJson($enumMember)");
    for (KotlinAccessModifier member in KotlinAccessModifier.values) {
      if (member.toString() == "KotlinAccessModifier.$enumMember") {
        return member;
      }
    }
    throw ParseError(
        "Unknown member '$enumMember' for enum KotlinAccessModifier");
  }

  static VariableStyle variableStyleFromJson(String enumMember) {
    enumMember = jsonDecode(enumMember);
    print("variableStyleFromJson($enumMember)");
    for (VariableStyle member in VariableStyle.values) {
      if (member.toString() == "VariableStyle.$enumMember") {
        return member;
      }
    }
    throw ParseError("Unknown member '$enumMember' for enum VariableStyle");
  }
}

class JavaParams {
  final JavaAccessModifier fieldModifier;
  final VariableStyle fieldStyle;
  final String prefix;
  final String postfix;
  final String parentView;

  const JavaParams({
    this.fieldModifier = JavaAccessModifier.public,
    this.fieldStyle = VariableStyle.lowerCamelCase,
    this.prefix = "",
    this.postfix = "View",
    this.parentView = "",
  });

  JavaParams clone({
    JavaAccessModifier fieldModifier,
    VariableStyle fieldStyle,
    String prefix,
    String postfix,
    String parentView,
  }) =>
      JavaParams(
        fieldModifier: fieldModifier ?? this.fieldModifier,
        fieldStyle: fieldStyle ?? this.fieldStyle,
        prefix: prefix ?? this.prefix,
        postfix: postfix ?? this.postfix,
        parentView: parentView ?? this.parentView,
      );

  bool operator ==(o) =>
      o is JavaParams &&
      fieldModifier == o.fieldModifier &&
      fieldStyle == o.fieldStyle &&
      prefix == o.prefix &&
      postfix == o.postfix &&
      parentView == o.parentView;

  int get hashCode {
    var hashCode = 1;
    hashCode = 31 * hashCode + fieldModifier.hashCode;
    hashCode = 31 * hashCode + fieldStyle.hashCode;
    hashCode = 31 * hashCode + prefix.hashCode;
    hashCode = 31 * hashCode + postfix.hashCode;
    hashCode = 31 * hashCode + parentView.hashCode;
    return hashCode;
  }

  JavaParams.fromJson(Map<String, dynamic> json)
      : fieldModifier =
            EnumConverter.javaAccessModifierFromJson(json['modifier']),
        fieldStyle = EnumConverter.variableStyleFromJson(json['style']),
        prefix = json['prefix'],
        postfix = json['postfix'],
        parentView = json['parentView'];

  Map<String, dynamic> toJson() => {
        'modifier': EnumConverter.toJson(fieldModifier),
        'style': EnumConverter.toJson(fieldStyle),
        'prefix': prefix,
        'postfix': postfix,
        'parentView': parentView
      };
}

class KotlinParams {
  final KotlinAccessModifier fieldModifier;
  final VariableStyle fieldStyle;
  final String prefix;
  final String postfix;
  final String parentView;

  const KotlinParams({
    this.fieldModifier = KotlinAccessModifier.public,
    this.fieldStyle = VariableStyle.lowerCamelCase,
    this.prefix = "",
    this.postfix = "View",
    this.parentView = "",
  });

  bool operator ==(o) =>
      o is KotlinParams &&
      fieldModifier == o.fieldModifier &&
      fieldStyle == o.fieldStyle &&
      prefix == o.prefix &&
      postfix == o.postfix &&
      parentView == o.parentView;

  int get hashCode {
    var hashCode = 1;
    hashCode = 31 * hashCode + fieldModifier.hashCode;
    hashCode = 31 * hashCode + fieldStyle.hashCode;
    hashCode = 31 * hashCode + prefix.hashCode;
    hashCode = 31 * hashCode + postfix.hashCode;
    hashCode = 31 * hashCode + parentView.hashCode;
    return hashCode;
  }

  KotlinParams clone({
    KotlinAccessModifier fieldModifier,
    VariableStyle fieldStyle,
    String prefix,
    String postfix,
    String parentView,
  }) =>
      KotlinParams(
        fieldModifier: fieldModifier ?? this.fieldModifier,
        fieldStyle: fieldStyle ?? this.fieldStyle,
        prefix: prefix ?? this.prefix,
        postfix: postfix ?? this.postfix,
        parentView: parentView ?? this.parentView,
      );

  KotlinParams.fromJson(Map<String, dynamic> json)
      : fieldModifier =
            EnumConverter.kotlinAccessModifierFromJson(json['kotlinModifier']),
        fieldStyle = EnumConverter.variableStyleFromJson(json['kotlinStyle']),
        prefix = json['kotlinPrefix'],
        postfix = json['kotlinPostfix'],
        parentView = json['kotlinParentView'];

  Map<String, dynamic> toJson() => {
        'kotlinModifier': EnumConverter.toJson(fieldModifier),
        'kotlinStyle': EnumConverter.toJson(fieldStyle),
        'kotlinPrefix': prefix,
        'kotlinPostfix': postfix,
        'kotlinParentView': parentView
      };
}

class Settings {
  final Language language;
  final JavaParams javaParams;
  final KotlinParams kotlinParams;

  Settings({
    this.language = Language.java,
    this.javaParams = const JavaParams(),
    this.kotlinParams = const KotlinParams(),
  });

  Settings.fromJson(Map<String, dynamic> json)
      : language = EnumConverter.languageFromJson(json['language']),
        javaParams = JavaParams.fromJson(json['javaParams']),
        kotlinParams = KotlinParams.fromJson(json['kotlinParams']);

  Map<String, dynamic> toJson() => {
        'language': EnumConverter.toJson(language),
        'javaParams': javaParams.toJson(),
        'kotlinParams': kotlinParams.toJson(),
      };

  Settings clone({
    Language language,
    JavaParams javaParams,
    KotlinParams kotlinParams,
  }) {
    return Settings(
        language: language ?? this.language,
        javaParams: javaParams ?? this.javaParams,
        kotlinParams: kotlinParams ?? this.kotlinParams);
  }
}
