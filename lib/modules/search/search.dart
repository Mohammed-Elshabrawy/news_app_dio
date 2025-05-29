import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class Search extends StatelessWidget {
   const Search({super.key});
  static var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          defaultFormFiled(
            controller: searchController,
            type: TextInputType.text,
            validate: (String? value) {
              if (value!.isEmpty) {
                return 'search must not be empty';
              } else {
                return null;
              }
            },
            label: 'Search',
            prefix: Icons.search,
          ),
        ],
      ),
    );
  }
}
