import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_pictures/blocs/bloc/handle_pictures_bloc.dart';
import 'package:show_pictures/screens/search_screen.dart';
import 'package:show_pictures/shared/components/components.dart';

import '../shared/style/color.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HandlePicturesBloc, HandlePicturesState>(
      builder: (context, state) {
        var bloc = HandlePicturesBloc.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Show Pictures App',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          body: bloc.bottomScreens[bloc.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: bloc.currentIndex,
            onTap: (int index) {
              bloc.add(ChangeBottomNavBarEvent(index: index));
            },
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.photo_album), label: 'Picture'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourites'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.download_done), label: 'Download'),
            ],
          ),
        );
      },
    );
  }
}
