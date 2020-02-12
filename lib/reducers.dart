import 'package:layout_convert/actions.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/models.dart';

AppState convertReducer(AppState state, action) => AppState(
      language: languageReducer(state.language, action),
      javaParams: javaParamsReducer(state.javaParams, action),
      kotlinParams: kotlinParamsReducer(state.kotlinParams, action),
      layoutXml: layoutXmlReducer(state.layoutXml, action),
      generatedFields: generatedFieldsReducer(state.generatedFields, action),
      generatedBindings:
          generatedBindingsReducer(state.generatedBindings, action),
    );

Language languageReducer(Language language, action) {
  if (action is ChangeLanguageAction) {
    return action.language;
  } else {
    return language;
  }
}

JavaParams javaParamsReducer(JavaParams params, action) {
  if (action is SelectJavaModifierAction) {
    return params.clone(fieldModifier: action.modifier);
  } else if (action is SelectJavaStyleAction) {
    return params.clone(fieldStyle: action.style);
  } else if (action is UpdateJavaPrefixAction) {
    return params.clone(prefix: action.prefix);
  } else if (action is UpdateJavaPostfixAction) {
    return params.clone(postfix: action.postfix);
  }
  return params;
}

KotlinParams kotlinParamsReducer(KotlinParams params, action) {
  if (action is SelectKotlinModifierAction) {
    return params.clone(fieldModifier: action.modifier);
  } else if (action is SelectKotlinStyleAction) {
    return params.clone(fieldStyle: action.style);
  } else if (action is UpdateKotlinPrefixAction) {
    return params.clone(prefix: action.prefix);
  } else if (action is UpdateKotlinPostfixAction) {
    return params.clone(postfix: action.postfix);
  }
  return params;
}

String layoutXmlReducer(String layoutXml, action) {
  if (action is UpdateLayoutXmlAction) {
    return action.layoutXml;
  }
  return layoutXml;
}

String generatedFieldsReducer(String generatedFields, action) {
  if (action is UpdateGeneratedFieldsAction) {
    return action.fields;
  }
  return generatedFields;
}

String generatedBindingsReducer(String generatedBindings, action) {
  if (action is UpdateGeneratedBindingsAction) {
    return action.bindings;
  }
  return generatedBindings;
}
