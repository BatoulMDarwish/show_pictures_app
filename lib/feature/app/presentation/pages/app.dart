import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:show_pictures/common/constants/constants.dart';
import 'package:show_pictures/core/config/theme/app_theme.dart';
import 'package:show_pictures/services/service_provider.dart';
import '../../../../core/config/routing/router.dart';
import '../bloc/app_manager_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: designSize,
      builder: (context, child) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: ServiceProvider(
          child: BlocBuilder<AppManagerCubit, AppManagerState>(
            builder: (context, state) {
              return MaterialApp.router(
                title: "Show Picture App",
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light(context),
                darkTheme: AppTheme.dark(context),
                routerConfig: GRouter.router,
                locale: context.locale,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
              );
            },
          ),
        ),
      ),
    );
  }
}
