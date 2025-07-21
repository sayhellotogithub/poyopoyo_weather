// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchHeaderViewModelProvider = ChangeNotifierProvider.autoDispose(
  (ref) => SearchHeaderViewModel(),
);

class SearchHeaderViewModel extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isSearching = false;

  void startSearch() {
    isSearching = true;
    notifyListeners();
    Future.delayed(Duration(milliseconds: 100), () {
      focusNode.requestFocus();
    });
  }

  void cancelSearch() {
    isSearching = false;
    controller.clear();
    focusNode.unfocus();
    notifyListeners();
  }

  bool get isEmpty => controller.text.isEmpty;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
