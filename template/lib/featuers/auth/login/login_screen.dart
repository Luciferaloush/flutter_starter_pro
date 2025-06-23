import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/extensions/sizedbox_extensions.dart';
import '../../../core/utils/app_shared_preferences.dart';
i
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoginSuccess) {
            print("Login Success");
            
          }
          if (state is LoginError) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text(state.error),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); 
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
          return Scaffold(
            //backgroundColor: Theme.of(context).colorScheme.background,
              
    );
  }
}
