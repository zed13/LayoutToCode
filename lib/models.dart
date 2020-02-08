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
}
