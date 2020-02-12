import 'package:layout_convert/generator.dart' as gen;
import 'package:flutter_test/flutter_test.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/extractor.dart';

void main() {
  group("Generator test", () {
    test("generate fields", () {
      var generator = gen.JavaGenerator(
        JavaAccessModifier.protected,
        VariableStyle.snakeCase,
        VariableStyle.upperCamelCase,
        "m",
        "View",
        "rootView",
      );
      var ids = [
        IdEntry("android.widget.TextView", "user_first_name"),
        IdEntry("TextView", "user_last_name"),
        IdEntry("TextView", "user_age"),
        IdEntry("ImageView", "avatar"),
      ];
      print("Variables:");
      print(generator.generateVariables(ids));
      print("Bindings:");
      print(generator.generateBindings(ids));
    });
  });
  group("Field generation", () {
    test("Convet to lower camel case", () {
      var splitedName = ["trunk", "volume", "in", "liters"];
      expect(gen.generateName(VariableStyle.lowerCamelCase, splitedName),
          equals("trunkVolumeInLiters"));
    });
    test("Convert to upper camel case", () {
      var splittedName = ["who", "are", "you"];
      expect(gen.generateName(VariableStyle.upperCamelCase, splittedName),
          equals("WhoAreYou"));
    });

    test("Convert name to snake case", () {
      var splittedName = ["chamber", "of", "secrets"];
      expect(gen.generateName(VariableStyle.snakeCase, splittedName),
          equals("chamber_of_secrets"));
    });

    test("Initial parts case do not affects result style", () {
      var splittedName = ["Blue", "oRange", "Trunk"];
      expect(gen.generateName(VariableStyle.snakeCase, splittedName),
          equals("blue_orange_trunk"));
    });
  });
}
