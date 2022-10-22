import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/handle_pictures_bloc.dart';
import '../shared/components/components.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return  BlocBuilder<HandlePicturesBloc,HandlePicturesState>(
      builder:(context, state) {
        var dwonloaded=HandlePicturesBloc.get(context).download;
        return ImageBuilder(
            images: dwonloaded,
          download: false,
        );
      },
    );
  }
}
