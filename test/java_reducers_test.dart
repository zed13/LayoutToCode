import 'package:flutter_test/flutter_test.dart';
import 'package:layout_convert/actions.dart';
import 'package:layout_convert/models.dart';
import 'package:layout_convert/reducers.dart';

main() {
  group("Java params reducers tests", () {
    test("Modifier changed", () {
      final params = JavaParams(
        fieldModifier: JavaAccessModifier.packagePrivate,
      );
      final action = SelectJavaModifierAction(JavaAccessModifier.protected);

      expect(
          javaParamsReducer(params, action),
          equals(JavaParams(
            fieldModifier: JavaAccessModifier.protected,
            fieldStyle: VariableStyle.lowerCamelCase,
            prefix: "",
            postfix: "View",
          )));
    });
  });
}
