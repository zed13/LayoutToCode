enum Language { java, kotlin }

enum JavaAccessModifier { public, private, protected, packagePrivate }

enum KotlinAccessModifier { public, protected, private, internal }

enum VariableStyle { snakeCase, lowerCamelCase, upperCamelCase }

class JavaParams {
  final JavaAccessModifier fieldModifier;
  final VariableStyle fieldStyle;
  final String prefix;
  final String postfix;

  JavaParams({
    this.fieldModifier = JavaAccessModifier.public,
    this.fieldStyle = VariableStyle.lowerCamelCase,
    this.prefix = "",
    this.postfix = "View",
  });

  bool operator ==(o) =>
      o is JavaParams &&
      fieldModifier == o.fieldModifier &&
      fieldStyle == o.fieldStyle &&
      prefix == o.prefix &&
      postfix == o.postfix;

  int get hashCode {
    var hashCode = 1;
    hashCode = 31 * hashCode + fieldModifier.hashCode;
    hashCode = 31 * hashCode + fieldStyle.hashCode;
    hashCode = 31 * hashCode + prefix.hashCode;
    hashCode = 31 * hashCode + postfix.hashCode;
    return hashCode;
  }
}

class KotlinParams {
  final KotlinAccessModifier fieldModifier;
  final VariableStyle fieldStyle;
  final String prefix;
  final String postfix;

  KotlinParams({
    this.fieldModifier = KotlinAccessModifier.public,
    this.fieldStyle = VariableStyle.lowerCamelCase,
    this.prefix = "",
    this.postfix = "View",
  });

  bool operator ==(o) =>
      o is KotlinParams &&
      fieldModifier == o.fieldModifier &&
      fieldStyle == o.fieldStyle &&
      prefix == o.prefix &&
      postfix == o.postfix;

  int get hashCode {
    var hashCode = 1;
    hashCode = 31 * hashCode + fieldModifier.hashCode;
    hashCode = 31 * hashCode + fieldStyle.hashCode;
    hashCode = 31 * hashCode + prefix.hashCode;
    hashCode = 31 * hashCode + postfix.hashCode;
    return hashCode;
  }
}
