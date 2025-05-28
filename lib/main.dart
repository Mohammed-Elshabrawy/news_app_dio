import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/network/remote/dio_helper.dart';
import 'package:news_app_dio/shared/cubit/bloc_observer.dart';
import 'package:news_app_dio/shared/cubit/cubit.dart';
import 'package:news_app_dio/shared/cubit/states.dart';
import 'layout/home_layout/home_layout.dart';
import 'network/local/cache_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   DioHelper.init();
  Bloc.observer = MyBlocObserver();
 await CacheHelper.init();
  bool? isDark = CacheHelper.getBool(key: 'isDark');
  runApp( MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..changeThemeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              textTheme: TextTheme(
                titleSmall: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                ),
                color: Colors.white,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                elevation: 18.0,
                type: BottomNavigationBarType.fixed,
              ),
              useMaterial3: true
            ),
            darkTheme: ThemeData.dark(),
            themeMode: NewsCubit.get(context).isDark? ThemeMode.dark:ThemeMode.light,
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),
    );
  }
}
