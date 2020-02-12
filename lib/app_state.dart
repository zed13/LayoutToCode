import 'package:layout_convert/models.dart';

class AppState {
  final Language language;

  final JavaParams javaParams;

  final KotlinParams kotlinParams;

  final String layoutXml;

  final String generatedFields;

  final String generatedBindings;

  AppState({
    this.language,
    this.javaParams,
    this.kotlinParams,
    this.layoutXml = "",
    this.generatedBindings = "",
    this.generatedFields = "",
  });

  AppState clone({
    Language language,
    JavaParams javaParams,
    KotlinParams kotlinParams,
    String layoutXml,
    String generatedFields,
    String generatedBindings,
  }) {
    return AppState(
      language: language ?? this.language,
      javaParams: javaParams ?? this.javaParams,
      kotlinParams: kotlinParams ?? this.kotlinParams,
      layoutXml: layoutXml ?? this.layoutXml,
      generatedFields: generatedFields ?? this.generatedFields,
      generatedBindings: generatedBindings ?? this.generatedBindings,
    );
  }
}
