import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/search_screen/search_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [
                IconButton(onPressed: () {
                  navigateTo(context, Search());
                }, icon: Icon(Icons.search)),
                IconButton(
                  onPressed: () {
                    cubit.changeThemeMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.buttonItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        },
    );
  }
}
