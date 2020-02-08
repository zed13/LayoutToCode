import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';
import 'models.dart';

typedef Selector<R> = R Function(Store<AppState> state);

Language languageSelector(Store<AppState> store) => store.state.language;

