// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/l10n/app_localizations.dart';
import 'package:poyopoyo_weather/presentation/viewmodels/settings_view_model.dart';

import '../providers/locale_provider.dart';
import '../providers/theme_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(settingsViewModelProvider);
    final local = AppLocalizations.of(context)!;
    final currentThemeMode = ref.watch(themeModeProvider);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(local.settings)),
      body: ListView(
        children: [
          ListTile(title: Text(local.theme_setting)),
          RadioListTile<ThemeMode>(
            title: Text(local.light),
            value: ThemeMode.light,
            groupValue: currentThemeMode,
            onChanged: (value) =>
                value != null ? viewModel.changeTheme(value) : null,
          ),
          RadioListTile<ThemeMode>(
            title: Text(local.dark),
            value: ThemeMode.dark,
            groupValue: currentThemeMode,
            onChanged: (value) =>
                value != null ? viewModel.changeTheme(value) : null,
          ),
          const Divider(),
          ListTile(title: Text(local.language_setting)),
          RadioListTile<Locale>(
            title: Text(local.japanese),
            value: const Locale('ja'),
            groupValue: currentLocale,
            onChanged: (value) =>
                value != null ? viewModel.changeLocale(value) : null,
          ),
          RadioListTile<Locale>(
            title: Text(local.english),
            value: const Locale('en'),
            groupValue:currentLocale,
            onChanged: (value) =>
                value != null ? viewModel.changeLocale(value) : null,
          ),
        ],
      ),
    );
  }
}
