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
  } else if (action is SelectJavaFieldStyleAction) {
    return params.clone(fieldStyle: action.style);
  }
  return params;
}

KotlinParams kotlinParamsReducer(KotlinParams params, action) {
  if (action is SelectKotlinModifierAction) {
    return KotlinParams(
      fieldModifier: action.modifier,
      fieldStyle: params.fieldStyle,
      prefix: params.prefix,
      postfix: params.postfix,
    );
  }
  return params;
}
