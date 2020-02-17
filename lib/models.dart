enum Language { java, kotlin }

enum JavaAccessModifier { public, private, protected, packagePrivate }

enum KotlinAccessModifier { public, protected, private, internal }

enum VariableStyle { snakeCase, lowerCamelCase, upperCamelCase }

class JavaParams {
  final JavaAccessModifier fieldModifier;
  final VariableStyle fieldStyle;
  final String prefix;
  final String postfix;
  final String parentView;

  JavaParams({
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
}

class KotlinParams {
  final KotlinAccessModifier fieldModifier;
  final VariableStyle fieldStyle;
  final String prefix;
  final String postfix;
  final String parentView;

  KotlinParams({
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
}
