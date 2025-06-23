import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/endpoint_constants.dart';
import '../../../../core/helper/dio_helper.dart';
import '../../../../core/network/status_code.dart';
import '../../../../core/utils/app_shared_preferences.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  final formKeyRegister = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController profession = TextEditingController();
  
  bool showPass = false;

  

  
  void user(
      String name, String phone, String email, String password) {
    this.name.text = name;
    this.phone.text = phone;
    this.email.text = email;
    this.password.text = password;
  }

  Future<void> register(BuildContext context) async {
    emit(RegisterLoading());
    DioHelper.postData(url: EndpointConstants.register, data: {
      "name": name.text.trim(),
      "phone": phone.text.trim(),
      "email": email.text.trim(),
      "password": password.text.trim(),
      
    }).then((value) {
      if (kDebugMode) {
        print("${{
          "name": name.text.trim(),
          "phone": phone.text.trim(),
          "email": email.text.trim(),
          "password": password.text.trim(),
        }}");
      }
      if (value == null) {
        emit(RegisterError(error: "value is null"));
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
        emit(RegisterError(error: value.data["message"].toString()));
        return;
      }
      if (value.statusCode == StatusCode.ok) {
        if (kDebugMode) {
          print(value.data);
        }
        
        emit(RegisterSuccess(name: value.data['name'],));
      }
    }).catchError((error, stacktrace) {
      if (kDebugMode) {
        print("error: $error\nstacktrace: $stacktrace,\n");
      }
      emit(RegisterError(error: error.toString()));
    }).catchError((error, stacktrace) {
      if (error is DioError) {
        if (error.type == DioErrorType.connectionTimeout) {
          emit(RegisterError(error: "Connection timeout"));
        } else if (error.type == DioErrorType.receiveTimeout) {
          emit(RegisterError(error: "Receive timeout"));
        } else if (error.type == DioErrorType.badResponse) {
          emit(RegisterError(
              error:
                  "Received invalid status code: ${error.response?.statusCode}"));
        } else {
          emit(RegisterError(error: error.message.toString()));
        }
      } else {
        emit(RegisterError(error: error.toString()));
      }
    });
  }

  onShowPass(bool val) {
    showPass = !showPass;
    emit(RegisterUpdate());
  }
}
