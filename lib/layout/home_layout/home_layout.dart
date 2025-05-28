import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/network/remote/dio_helper.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness()..getSports()..getScience(),

      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(

            appBar: AppBar(
              title: Text("News App"),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                IconButton(
                  onPressed: () {
                    NewsCubit.get(context).changeThemeMode();
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
      ),
    );
  }
}
