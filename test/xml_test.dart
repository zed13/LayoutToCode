import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart' as xml;
import 'package:layout_convert/extractor.dart';

void main() {
  test("XmlNode name is?", () {
    var layout = '''<?xml version="1.0"?>
    <bookshelf>
      <book>
        <title android:id="android_id" lang="english">Growing a Language</title>
        <price>29.99</price>
      </book>
      <book>
        <title lang="english">Learning XML</title>
        <price>39.95</price>
      </book>
      <price>132.00</price>
    </bookshelf>''';
    xml.XmlDocument document = xml.parse(layout);
    document
        .tags()
        .where((tag) => tag.hasAttribute("android:id"))
        .forEach((tag) {
      print(
          "tag=${tag.name} attrValue=${tag.findAttribute("android:id")?.value}");
    });
  });
}
