// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onPressed;

  const SettingsButton({
    super.key,
    required this.isVisible,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isVisible
          ? IconButton(
              key: const ValueKey('setting'),
              icon: const Icon(Icons.more_horiz),
              onPressed: onPressed,
            )
          : const SizedBox.shrink(),
    );
  }
}
