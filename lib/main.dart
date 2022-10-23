import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_pictures/layout/home_layout.dart';
import 'package:show_pictures/screens/splash_screen.dart';
import 'package:show_pictures/shared/style/theme_app.dart';
import 'blocs/bloc/handle_pictures_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HandlePicturesBloc>(
      create: (BuildContext context) => HandlePicturesBloc()
        ..add(GetPhotoEvent(numberPage: 1))
        ..add(CreatDatabaseEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Show Pictures',
        theme: lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
