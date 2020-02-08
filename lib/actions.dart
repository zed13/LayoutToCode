import 'models.dart';


class ChangeLanguageAction {
  final Language language;
  ChangeLanguageAction(this.language);
}



class SelectJavaModifierAction {
  final JavaAccessModifier modifier;
  SelectJavaModifierAction(this.modifier);
}

class SelectKotlinModifierAction {
  final KotlinAccessModifier modifier;
  SelectKotlinModifierAction(this.modifier);
}

class SelectFieldStyleAction {
  final VariableStyle style;
  SelectFieldStyleAction(this.style);
}

class SelectJavaStyleAction {
  final VariableStyle style;
  SelectJavaStyleAction(this.style);
}

class SelectKotlinStyleAction {
  final VariableStyle style;
  SelectKotlinStyleAction(this.style);
}

class UpdatePrefixAction {
  final String prefix;
  UpdatePrefixAction(this.prefix);
}

class UpdatePostfixAction {
  final String postfix;
  UpdatePostfixAction(this.postfix);
}