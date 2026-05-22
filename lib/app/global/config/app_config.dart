class EnvConfig {
  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const String cdnDomain = String.fromEnvironment('CDN_DOMAIN');
  static const String cdnKey = String.fromEnvironment('CDN_KEY');

  static const String flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'prod');

  static bool get isProduction => flavor == 'prod';
}

printFile() {
  print("API URL: ${EnvConfig.apiBaseUrl}");
  print("App Flavor: ${EnvConfig.flavor}");
}

/*
flavorDimensions "flavor-type"

productFlavors {
    dev {
        dimension "flavor-type"
        applicationIdSuffix ".dev"
        versionNameSuffix "-dev"
    }
    staging {
        dimension "flavor-type"
        applicationIdSuffix ".staging"
        versionNameSuffix "-staging"
    }
    prod {
        dimension "flavor-type"
    }
}


Step 4: Create .xcconfig Files for iOS
For iOS, create separate configuration files:

📂 ios/Runner/Configs/

dev.xcconfig
staging.xcconfig
prod.xcconfig
Inside each file, define:

xcconfig
Copy
Edit
// Example: dev.xcconfig
APP_NAME = "MyApp Dev"
BUNDLE_ID = "com.myapp.dev"
Then, link them in ios/Runner.xcworkspace.


 flutter run --flavor dev --dart-define=FLAVOR=dev \
  --dart-define=API_BASE_URL=https://api.dev.com \
  --dart-define=AUTH_TOKEN=123456 \
  --dart-define=FIREBASE_KEY=dev_firebase_key \
  --dart-define=FEATURE_FLAG=true
* */
