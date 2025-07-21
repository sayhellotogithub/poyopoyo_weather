// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poyopoyo_weather/l10n/app_localizations.dart';
import 'package:poyopoyo_weather/presentation/components/search/search_header_view_model.dart';
import 'package:poyopoyo_weather/presentation/widgets/settings_button.dart';

final searchHeaderViewModelProvider = ChangeNotifierProvider(
  (ref) => SearchHeaderViewModel(),
);

class HeaderBarWithSearch extends StatelessWidget {
  final bool isSearching;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onTapSearch;
  final VoidCallback onCancelSearch;
  final VoidCallback onSettingsTap;
  final void Function(String)? onChanged;

  const HeaderBarWithSearch({
    super.key,
    required this.isSearching,
    required this.controller,
    required this.focusNode,
    required this.onTapSearch,
    required this.onCancelSearch,
    required this.onSettingsTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isSearching
                  ? const SizedBox.shrink()
                  : Padding(
                      key: const ValueKey('title'),
                      padding: const EdgeInsets.fromLTRB(16, 50, 16, 4),
                      child: Text(
                        loc.appTitle,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
            AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.fromLTRB(16, isSearching ? 8 : 0, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onTap: onTapSearch,
                      onChanged: onChanged,
                      decoration: InputDecoration(
                        hintText: '都市を検索',
                        hintStyle: const TextStyle(color: Colors.white30),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white30,
                        ),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (isSearching)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: TextButton(
                        key: const ValueKey('cancel'),
                        onPressed: onCancelSearch,
                        child: const Text('キャンセル'),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 16,
          child: SettingsButton(
            isVisible: !isSearching,
            onPressed: onSettingsTap,
          ),
        ),
      ],
    );
  }
}
