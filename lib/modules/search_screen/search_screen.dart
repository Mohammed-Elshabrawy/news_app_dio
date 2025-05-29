import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class Search extends StatelessWidget {
  const Search({super.key});
  static var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context,  state) {  },

      builder: (BuildContext context,  state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: Text('Search'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormFiled(
                  onChange: (value) {
                    if (value !=null) {
                      NewsCubit.get(context).getSearch(value);

                    }else{
                    }
                  },
                  labelStyle: TextStyle(color: NewsCubit.get(context).isDark?Colors.white:Colors.black),
                  textStyle: TextStyle(color: NewsCubit.get(context).isDark?Colors.white:Colors.black),
                  controller: searchController,
                  type: TextInputType.text,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'search_screen must not be empty';
                    } else {
                      return null;
                    }
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list, context))
            ],
          ),
        );
      },
    );
  }
}
