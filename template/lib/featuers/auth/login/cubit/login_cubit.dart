import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/endpoint_constants.dart';
import '../../../../core/helper/dio_helper.dart';
import '../../../../core/network/status_code.dart';
import '../../../../core/utils/app_shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();

  Future<void> login(BuildContext context) async {
    emit(LoginLoading());
    DioHelper.postData(url: EndpointConstants.login, data: {
      "email": email.text.trim(),
      "password": password.text.trim(),
    }).then((value) {
      if (value == null) {
        emit(LoginError(error: "value is null"));
        return;
      }
      if (kDebugMode) {
        print(value.statusCode);
      }
      if (value.statusCode != StatusCode.ok) {
        if (kDebugMode) {
          print(value.data.runtimeType);
          print(value.data);
          print(value.statusCode);
        }

        emit(LoginError(error: value.data["message"].toString()));
        return;
      }
      if (value.statusCode == StatusCode.ok) {
        if (kDebugMode) {
          print(value.data);
        }
        AppPreferences().setData("token", value.data['token']);
        emit(LoginSuccess(name: value.data['name']));
      }
    }).catchError((error, stacktrace) {
      if (kDebugMode) {
        print("error: $error\nstacktrace: $stacktrace,\n");
      }
      emit(LoginError(error: error.toString()));
    }).catchError((error, stacktrace) {
      if (error is DioError) {
        if (error.type == DioErrorType.connectionTimeout) {
          emit(LoginError(error: "Connection timeout"));
        } else if (error.type == DioErrorType.receiveTimeout) {
          emit(LoginError(error: "Receive timeout"));
        } else if (error.type == DioErrorType.badResponse) {
          emit(LoginError(
              error:
                  "Received invalid status code: ${error.response?.statusCode}"));
        } else {
          emit(LoginError(error: error.message.toString()));
        }
      } else {
        emit(LoginError(error: error.toString()));
      }
    });
  }
}
