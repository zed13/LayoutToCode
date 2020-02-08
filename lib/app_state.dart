import 'package:layout_convert/models.dart';

class AppState {
  final Language language;

  final JavaParams javaParams;

  final KotlinParams kotlinParams;

  AppState({this.language, this.javaParams, this.kotlinParams});

  AppState clone(
      {Language language, JavaParams javaParams, KotlinParams kotlinParams}) {
    return AppState(
      language: language ?? this.language,
      javaParams: javaParams ?? this.javaParams,
      kotlinParams: kotlinParams ?? this.kotlinParams,
    );
  }
}
