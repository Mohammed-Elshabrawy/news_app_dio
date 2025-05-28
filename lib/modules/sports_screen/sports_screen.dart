import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (BuildContext context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.sports;
        return articleBuilder(list, context);
      },
      listener: (BuildContext context, state) {},
    );
  }
}