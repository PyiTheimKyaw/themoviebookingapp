class EnvironmentConfig {
  static const String CONFIG_THEME_COLOR = String.fromEnvironment(
      "CONFIG_THEME_COLOR",
      defaultValue: "DEFAULT_THEME_COLOR");
  static const String CONFIG_WELCOME_TITLE = String.fromEnvironment(
      "CONFIG_WELCOME_TITLE",
      defaultValue: "DEFAULT_CONFIG_WELCOME_TITLE");
  static const String CONFIG_WELCOME_IMAGE = String.fromEnvironment(
      "CONFIG_WELCOME_IMAGE",
      defaultValue: "DEFAULT_WELCOME_IMAGE");
  static const String CONFIG_MOVIES_VIEW = String.fromEnvironment(
      "CONFIG_MOVIES_VIEW",
      defaultValue: "DEFAULT_MOVIES_VIEW");
  static const String CONFIG_CAST_VIEW=String.fromEnvironment("CONFIG_CAST_VIEW",defaultValue: "DEFAULT_CAST_VIEW");

}

///flavors
///Config movie booking app
///flutter run --dart-define=CONFIG_THEME_COLOR=CONFIG_COLOR --dart-define=CONFIG_WELCOME_TITLE=CONFIG_WELCOME_SCREEN_TITLE --dart-define=CONFIG_WELCOME_IMAGE=CONFIG_WELCOME_SCREEN_IMAGE --dart-define=CONFIG_MOVIES_VIEW=CONFIG_MOVIES_VIEW_BY_TAB --dart-define=CONFIG_CAST_VIEW=CONFIG_CAST_BY_WRAP
