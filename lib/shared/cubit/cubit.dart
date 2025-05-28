import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_dio/shared/cubit/states.dart';
import '../../modules/business_screen/business_screen.dart';
import '../../modules/science_screen/science_screen.dart';
import '../../modules/sports_screen/sports_screen.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> buttonItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    //BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    //const SettingsScreen(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsChangeBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
          url: "v2/top-headlines",
          query: {
            "country": "us",
            'category': 'business',
            'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
          },
        )
        .then((onValue) {
          business = onValue.data['articles'];
          emit(NewsGetBusinessSuccessState());
        })
        .catchError((onError) {
          emit(NewsGetBusinessErrorState(onError.toString()));
        });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
          url: "v2/top-headlines",
          query: {
            "country": "us",
            'category': 'sports',
            'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
          },
        )
        .then((onValue) {
          sports = onValue.data['articles'];
          emit(NewsGetSportsSuccessState());
        })
        .catchError((onError) {
          emit(NewsGetSportsErrorState(onError.toString()));
        });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
          url: "v2/top-headlines",
          query: {
            "country": "us",
            'category': 'science',
            'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
          },
        )
        .then((onValue) {
          science = onValue.data['articles'];
          emit(NewsGetScienceSuccessState());
        })
        .catchError((onError) {
          emit(NewsGetScienceErrorState(onError.toString()));
        });
  }

  bool isDark = false;
  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeAppModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((onValue) {
        emit(NewsChangeAppModeState());
      });
    }
  }
}
