enum Environment { production, development }

final class Config {
  static late Environment currentEnvironment;

  static String get apiBaseUrl {
    switch (currentEnvironment) {
      case Environment.production:
        return 'https://collectionapi.metmuseum.org/public/collection/v1/';
      case Environment.development:
        return 'https://collectionapi.metmuseum.org/public/collection/v1/';
    }
  }

  static String get environmentName {
    switch (currentEnvironment) {
      case Environment.production:
        return 'Production';
      case Environment.development:
        return 'Development';
    }
  }
}
