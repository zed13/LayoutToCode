import 'package:xml/xml.dart' as xml;

class IdEntry extends ParseResult {
  final String widgetName;
  final String id;
  IdEntry(this.widgetName, this.id) : super._();
}

class ParseResult {
  ParseResult._();

  factory ParseResult.success(String id, String widgetName) =>
      IdEntry(widgetName, id);

  factory ParseResult.error(String message) => ParseError(message);
}

class ParseError extends ParseResult {
  final String message;
  ParseError(this.message) : super._();
}

Iterable<ParseResult> extractIds(String layoutXml) {
  return xml
      .parse(layoutXml)
      .tags()
      .where((tag) => tag.hasAttribute("android:id"))
      .map((tag) => _extractId(tag));
}

ParseResult _extractId(xml.XmlElement tag) {
  xml.XmlAttribute attr = tag.findAttribute("android:id");
  List<String> idValue = attr.value.split("/");
  if (idValue.length == 2) {
    return ParseResult.success(idValue[1], tag.getName());
  } else {
    return ParseResult.error(
        "Malformed id=${attr.value} in widget=${tag.getName()}");
  }
}

extension XmlDocumentExt on xml.XmlDocument {
  Iterable<xml.XmlElement> tags() {
    return descendants
        .where((node) => node.nodeType == xml.XmlNodeType.ELEMENT)
        .whereType<xml.XmlElement>();
  }
}

extension XmlElementExt on xml.XmlElement {
  xml.XmlAttribute findAttribute(String name) {
    if (attributes == null || attributes.isEmpty) return null;
    return attributes.firstWhere((attr) => attr.name.toString() == name,
        orElse: () => null);
  }

  bool hasAttribute(String name) {
    return attributes.any((attr) => attr.name.toString() == name);
  }

  String getName() {
    return name.toString();
  }
}
