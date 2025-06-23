import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_shared_preferences.dart';
import '../../../customer/app/screen.dart';
import '../../cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SplashCubit()..checkUserLoggedIn(),
        child: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is SplashNavigateToHome) {
             
            } else if (state is SplashNavigateToLogin) {
              context.pushNamedAndRemoveUntil("/registerScreen");
            }
          },
          builder: (context, state) {
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('', height: 300.h),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
