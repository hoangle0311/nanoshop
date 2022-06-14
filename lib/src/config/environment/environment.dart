import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:nanoshop/src/core/constant/default_string_constant.dart';

part 'environment_keys.dart';

class Environment {
  static String get getEnvironmentFile {
    if (kReleaseMode) {
      return '.env.production';
    }

    if (kDebugMode) {
      return '.env.development';
    }

    return '';
  }

  static String get domain {
    return dotenv.env[EnvironmentKeys.apiUrl] ?? DefaultStringConstant.notFound;
  }

  static get token {
    return dotenv.env[EnvironmentKeys.apiToken] ??
        DefaultStringConstant.notFound;
  }
}
