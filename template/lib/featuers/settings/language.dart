import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../core/cubit/locale/locale_cubit.dart';
import '../../core/services/locale_service.dart';

class LanguageChangeScreen extends StatelessWidget {
  const LanguageChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeLanguage').tr(),
      ),
      body: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return Center(
            child: DropdownButton<Locale>(
              value: state.locale,
              items: const [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale('ar'),
                  child: Text('العربية'),
                ),
              ],
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  context.read<LocaleCubit>().changeLocale(newLocale);
                  LocaleService().setLocale(context, newLocale.languageCode);

                }
              },
            ),
          );
        },
      ),
    );
  }
}
