// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/07/18
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';

class SearchCityScreen extends StatelessWidget {
  const SearchCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('都市検索')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: '都市名を入力',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Text('候補都市... (API連携予定)'),
        ],
      ),
    );
  }
}
