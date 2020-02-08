import 'app_state.dart';
import 'models.dart';

typedef Selector<R> = R Function(AppState state);

Language languageSelector(AppState state) => state.language;

JavaAccessModifier javaAccessModifierSelector(AppState state) =>
    state.javaParams.fieldModifier;

KotlinAccessModifier kotlinAccessModifierSelector(AppState state) =>
    state.kotlinParams.fieldModifier;

VariableStyle fieldStyleSelector(AppState state) =>
    state.language == Language.kotlin
        ? state.kotlinParams.fieldStyle
        : state.javaParams.fieldStyle;
