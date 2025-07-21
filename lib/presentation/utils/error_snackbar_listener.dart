// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/21
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/base/state_with_error_key.dart';
import '../../l10n/app_localizations.dart';
import '../utils/error_translator.dart';

void showErrorOnStateChange<T extends StateNotifier<StateWithErrorKey>>({
  required WidgetRef ref,
  required BuildContext context,
  required StateNotifierProvider<T, StateWithErrorKey> provider,
  void Function()? clearError,
}) {
  ref.listen<StateWithErrorKey>(provider, (prev, next) {
    if (next.errorKey != null && next.errorKey != prev?.errorKey) {
      final loc = AppLocalizations.of(context)!;
      final msg = ErrorTranslator.getMessage(next.errorKey!, loc);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));

      clearError?.call();
    }
  });
}
