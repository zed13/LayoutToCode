  int _capsStart = "A".codeUnitAt(0);
  int _capsEnd = "Z".codeUnitAt(0);

extension StringExt on String {
  String capitalize() {
    if (this.isEmpty) {
      return "";
    }
    return this[0].toUpperCase() + substring(1);
  }

  bool isUpper(int position) {
    var code = codeUnitAt(position);
    return code.isUpper();
  }

  List<String> splitByCaps() {
    if (isEmpty) {
      return [];
    }
    Iterable<int> symbols = codeUnits.skip(1);
    List<int> buffer = [];
    List<String> parts = [];
    buffer.add(codeUnitAt(0));
    for (int char in symbols) {
      if (char.isUpper()) {
        parts.add(String.fromCharCodes(buffer));
        buffer.clear();
      }
      buffer.add(char);
    }
    if (buffer.isNotEmpty) {
      parts.add(String.fromCharCodes(buffer));
    }
    return parts;
  }
}

extension IntExt on int {
  bool isUpper() {
    return this >= _capsStart && this <= _capsEnd;
  }
}

