// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/21
// Description:
// -------------------------------------------------------------------

import '../../core/network/dio_helper.dart';
import '../../l10n/app_localizations.dart';

class ErrorTranslator {
  static String getMessage(String key, AppLocalizations loc) {
    switch (key) {
      case ErrorKeys.timeout:
        return loc.errorTimeout;
      case ErrorKeys.server:
        return loc.errorServer;
      case ErrorKeys.notFound:
        return loc.cityNotFound;
      case ErrorKeys.unknown:
      default:
        return loc.errorUnknown;
    }
  }
}
