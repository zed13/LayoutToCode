import 'package:flutter_test/flutter_test.dart';
import 'package:layout_convert/utils.dart';

main() {
  group("utils tests", () {
    group("Strings extensions test", () {
      group("capitalize() tests", () {
        test("Capitalize first symbol of word", () {
          expect("onion".capitalize(), equals("Onion"));
        });
        test("For empty line returns empty string", () {
          var emptyString = "";
          expect(emptyString.capitalize(), equals(""));
        });
        test("One symbol still capitalized", () {
          expect("a".capitalize(), equals("A"));
        });
      });

      group("isUpper() tests", () {
        test("true if char is upper case", () {
          expect("aBc".isUpper(1), isTrue);
        });
        test("false if char is lower case", () {
          expect("Valley".isUpper(4), isFalse);
        });
        test("fails when position is out of string range", () {
          expect(() => "orange".isUpper(10), throwsA(isA<RangeError>()));
        });
      });

      group("splitByCaps() tests", () {
        test("split by caps", () {
          expect(
              "appSimpleName".splitByCaps(), equals(["app", "Simple", "Name"]));
        });
        test("preserves char's size", () {
          expect("MySwitchCaSe".splitByCaps(),
              equals(["My", "Switch", "Ca", "Se"]));
        });
        test("empty list on empty string", () {
          expect("".splitByCaps(), equals([]));
        });
        test("every upper char is word start", () {
          expect("ABCdefJ".splitByCaps(), equals(["A", "B", "Cdef", "J"]));
        });
      });
    });

    group("Int extension tests", () {
      test("on upper case char returns true", () {
        var start = "A".codeUnitAt(0);
        var end = "Z".codeUnitAt(0);
        for (int symbol = start; symbol <= end; symbol++) {
          expect(symbol.isUpper(), isTrue);
        }
      });
      test("on lower case char returns false", () {
        var start = "a".codeUnitAt(0);
        var end = "z".codeUnitAt(0);
        for (int symbol = start; symbol <= end; symbol++) {
          expect(symbol.isUpper(), isFalse);
        }
      });
    });
  });
}
