import 'package:layout_convert/actions.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/models.dart';
import 'package:redux/redux.dart';

void handleTypesMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is SelectFieldStyleAction) {
    if (store.state.language == Language.kotlin) {
      next(SelectKotlinStyleAction(action.style));
    } else {
      next(SelectJavaStyleAction(action.style));
    }
  } else {
    next(action);
  }
}