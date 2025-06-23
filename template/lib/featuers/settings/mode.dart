import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cubit/theme/theme_cubit.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('settings'.tr())),
      body: Center(
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return SwitchListTile(
              title: const Text('Dark Mode'),
              value: state.themeMode == ThemeMode.dark,
              onChanged: (value) {
                final newTheme = value ? ThemeMode.dark : ThemeMode.light;
                context.read<ThemeCubit>().changeTheme(newTheme);
              },
            );
          },
        ),
      ),
    );
  }
}
