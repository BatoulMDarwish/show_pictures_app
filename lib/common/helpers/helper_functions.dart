import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:show_pictures/feature/app/presentation/widgets/loading_indicator.dart';
import '../../core/config/theme/colors_app.dart';

class HelperFunctions {
  HelperFunctions._singleton();

  static HelperFunctions? _instance;

  factory HelperFunctions() {
    return instance;
  }

  static HelperFunctions get instance => _instance ??= HelperFunctions._singleton();





  static buildShowLoadingIndicator(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: LoadingIndicator(),
          );
        });
  }

}
