import 'package:layout_convert/actions.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/models.dart';

AppState convertReducer(AppState state, action) => AppState(
      language: languageReducer(state.language, action),
      javaParams: javaParamsReducer(state.javaParams, action),
      kotlinParams: kotlinParamsReducer(state.kotlinParams, action),
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
