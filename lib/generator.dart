import 'models.dart';
import 'extractor.dart';
import 'utils.dart';

abstract class Generator {
  String generateVariables(List<IdEntry> ids);
  String generateBindings(List<IdEntry> ids);

  factory Generator.forKotlin(KotlinParams params) =>
      KotlinGenerator.from(params);
  factory Generator.forJava(JavaParams params) => JavaGenerator.from(params);
}

class JavaGenerator implements Generator {
  final JavaAccessModifier accessLevel;
  final VariableStyle generatedVariableStyle;
  final String variablePrefix;
  final String variablePostfix;
  final String rootView;

  JavaGenerator(
    this.accessLevel,
    this.generatedVariableStyle,
    this.variablePrefix,
    this.variablePostfix,
    this.rootView,
  );

  JavaGenerator.from(JavaParams params)
      : accessLevel = params.fieldModifier,
        generatedVariableStyle = params.fieldStyle,
        variablePrefix = params.prefix,
        variablePostfix = params.postfix,
        rootView = params.parentView;

  @override
  String generateVariables(List<IdEntry> ids) {
    var builder = StringBuffer();

    for (var id in ids) {
      builder.writeln(
          "var ${javaAccessName(accessLevel)} ${id.widgetName} ${_generateVariableName(id)};");
    }

    return builder.toString();
  }

  String _generateVariableName(IdEntry entry) {
    return idToName(
        entry.id, generatedVariableStyle, variablePrefix, variablePostfix);
  }

  @override
  String generateBindings(List<IdEntry> ids) {
    var builder = StringBuffer();
    var findView = rootView == null || rootView.isEmpty
        ? "findViewById"
        : "$rootView.findViewById";
    for (var id in ids) {
      builder
          .writeln("${_generateVariableName(id)} = $findView(R.id.${id.id});");
    }
    return builder.toString();
  }
}

class KotlinGenerator implements Generator {
  final KotlinAccessModifier accessLevel;
  final VariableStyle generatedVariableStyle;
  final String variablePrefix;
  final String variablePostfix;
  final String rootView;

  KotlinGenerator(
    this.accessLevel,
    this.generatedVariableStyle,
    this.variablePrefix,
    this.variablePostfix,
    this.rootView,
  );

  KotlinGenerator.from(KotlinParams params)
      : accessLevel = params.fieldModifier,
        generatedVariableStyle = params.fieldStyle,
        variablePrefix = params.prefix,
        variablePostfix = params.postfix,
        rootView = params.parentView;

  @override
  String generateVariables(List<IdEntry> ids) {
    var builder = StringBuffer();

    for (var id in ids) {
      builder.writeln(
          "${kotlinAccessName(accessLevel)} ${_generateVariableName(id)}: ${id.widgetName}?=null");
    }

    return builder.toString();
  }

  String _generateVariableName(IdEntry entry) {
    return idToName(
        entry.id, generatedVariableStyle, variablePrefix, variablePostfix);
  }

  @override
  String generateBindings(List<IdEntry> ids) {
    var builder = StringBuffer();
    var findView = rootView == null || rootView.isEmpty
        ? "findViewById"
        : "$rootView.findViewById";
    for (var id in ids) {
      builder
          .writeln("${_generateVariableName(id)} = $findView(R.id.${id.id})");
    }
    return builder.toString();
  }
}

String javaAccessName(JavaAccessModifier accessLevel) {
  switch (accessLevel) {
    case JavaAccessModifier.public:
      return "public";
    case JavaAccessModifier.protected:
      return "protected";
    case JavaAccessModifier.private:
      return "private";
    default:
      return "";
  }
}

String kotlinAccessName(KotlinAccessModifier accessLevel) {
  switch (accessLevel) {
    case KotlinAccessModifier.public:
      return "";
    case KotlinAccessModifier.protected:
      return "protected";
    case KotlinAccessModifier.private:
      return "private";
    case KotlinAccessModifier.internal:
      return "internal";
    default:
      return "";
  }
}

String idToName(
  String widgetId,
  VariableStyle style,
  String prefix,
  String postfix,
) {
  String nameWithoutPrefix =
      generateName(style, nameToParts(widgetId)) + postfix;
  return prefix.isEmpty
      ? nameWithoutPrefix
      : prefix + nameWithoutPrefix.capitalize();
}

String generateName(
  VariableStyle style,
  List<String> parts,
) {
  if (parts.isEmpty) {
    return "";
  }
  List<String> name = parts.map((part) => part.toLowerCase()).toList();
  if (style == VariableStyle.lowerCamelCase) {
    var builder = StringBuffer(name.first);
    for (var part in name.skip(1)) {
      builder.write(part.capitalize());
    }
    return builder.toString();
  } else if (style == VariableStyle.upperCamelCase) {
    var builder = StringBuffer();
    for (var part in name) {
      builder.write(part.capitalize());
    }
    return builder.toString();
  } else {
    return name.join("_");
  }
}

List<String> nameToParts(String name) {
  return name
      .split("_")
      .expand((part) => part.splitByCaps())
      .map((part) => part.toLowerCase())
      .toList();
}
