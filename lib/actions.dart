import 'models.dart';

class ChangeLanguageAction {
  final Language language;
  ChangeLanguageAction(this.language);
}

class SelectJavaModifierAction {
  final JavaAccessModifier modifier;
  SelectJavaModifierAction(this.modifier);
}

class UpdateJavaPrefixAction {
  final String prefix;
  UpdateJavaPrefixAction(this.prefix);
}

class UpdateJavaPostfixAction {
  final String postfix;
  UpdateJavaPostfixAction(this.postfix);
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

class UpdateKotlinPrefixAction {
  final String prefix;
  UpdateKotlinPrefixAction(this.prefix);
}

class UpdateKotlinPostfixAction {
  final String postfix;
  UpdateKotlinPostfixAction(this.postfix);
}


// Editor actions
class UpdateLayoutXmlAction {
  final String layoutXml;
  UpdateLayoutXmlAction(this.layoutXml);
}

class UpdateGeneratedFieldsAction {
  final String fields;
  UpdateGeneratedFieldsAction(this.fields);
}

class UpdateGeneratedBindingsAction {
  final String bindings;
  UpdateGeneratedBindingsAction(this.bindings);
}

// Convert action

class Convert {}
