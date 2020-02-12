import 'package:layout_convert/actions.dart';
import 'package:layout_convert/app_state.dart';
import 'package:layout_convert/extractor.dart';
import 'package:layout_convert/generator.dart';
import 'package:layout_convert/models.dart';
import 'package:redux/redux.dart';

void convertMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is Convert) {
    final ids = extractIds(store.state.layoutXml).whereType<IdEntry>().toList();
    if (store.state.language == Language.kotlin) {
      final generator = KotlinGenerator.from(store.state.kotlinParams);
      next(UpdateGeneratedFieldsAction(generator.generateVariables(ids)));
      next(UpdateGeneratedBindingsAction(generator.generateVariables(ids)));
    } else {
      final generator = JavaGenerator.from(store.state.javaParams);
      next(UpdateGeneratedFieldsAction(generator.generateVariables(ids)));
      next(UpdateGeneratedBindingsAction(generator.generateVariables(ids)));
    }
  } else {
    next(action);
  }
}
