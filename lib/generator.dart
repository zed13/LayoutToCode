import 'models.dart';
import 'extractor.dart';
import 'utils.dart';

class Generator {
  final JavaAccessModifier accessLevel;
  final VariableStyle layoutIdStyle;
  final VariableStyle generatedVariableStyle;
  final String variablePrefix;
  final String variablePostfix;
  final String rootView;

  Generator(this.accessLevel, this.layoutIdStyle, this.generatedVariableStyle,
      this.variablePrefix, this.variablePostfix, this.rootView);

  String generateVariables(List<IdEntry> ids) {
    var builder = StringBuffer();

    for (var id in ids) {
      builder.writeln(
          "${javaAccessName(accessLevel)} ${id.widgetName} ${_generateVariableName(id)}");
    }

    return builder.toString();
  }

  String _generateVariableName(IdEntry entry) {
    return idToName(
        entry.id, generatedVariableStyle, variablePrefix, variablePostfix);
  }

  String generateBindings(List<IdEntry> ids) {
    var builder = StringBuffer();
    var findView = rootView == null ? "findViewById" : "$rootView.findViewById";
    for (var id in ids) {
      builder.writeln("${_generateVariableName(id)} = $findView(R.id.${id.id});");
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

String idToName(
    String widgetId, VariableStyle style, String prefix, String postfix) {
  return prefix + generateName(style, nameToParts(widgetId)) + postfix;
}

String generateName(VariableStyle style, List<String> parts) {
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
