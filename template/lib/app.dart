import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'core/constants/app_constants.dart';
import 'core/cubit/theme/theme_cubit.dart';
import 'features/customer/provider_details/cubit/provider_cubit.dart';


class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) =>
            MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppConstants.appName,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeState.themeMode,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              onGenerateRoute: appRouter.generateRoute,
              initialRoute: '/',
            ),
      ),
    );
  }
}
