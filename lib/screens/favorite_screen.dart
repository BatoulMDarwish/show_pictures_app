import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_pictures/blocs/bloc/handle_pictures_bloc.dart';
import 'package:show_pictures/shared/components/components.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HandlePicturesBloc,HandlePicturesState>(
        builder:(context, state) {
          var favorites=HandlePicturesBloc.get(context).favorites;
          return ImageBuilder(
              images: favorites
          );
        },
        );

  }
}
