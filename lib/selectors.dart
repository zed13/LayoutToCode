import 'app_state.dart';
import 'models.dart';

typedef Selector<R> = R Function(AppState state);

Language languageSelector(AppState state) => state.language;

// Java selectors ////////

JavaAccessModifier javaAccessModifierSelector(AppState state) =>
    state.javaParams.fieldModifier;

VariableStyle javaFieldStyleSelector(AppState state) =>
    state.javaParams.fieldStyle;

// Kotlin selectors //////

KotlinAccessModifier kotlinAccessModifierSelector(AppState state) =>
    state.kotlinParams.fieldModifier;
