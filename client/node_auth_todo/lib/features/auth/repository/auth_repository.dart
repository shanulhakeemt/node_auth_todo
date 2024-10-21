import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:node_auth_todo/core/constants/server_constants.dart';
import 'package:node_auth_todo/core/failure/failure.dart';
import 'package:node_auth_todo/features/auth/model/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<Either<AppFailure, UserModel>> signup(
      {required String name,
      required String email,
      required String password}) async {
    try {
          final res =await http.post(
          Uri.parse("${ServerConstants.serverUrl}auth/signup"),
          headers: {
            'Content-Type': 'application/json',
          },
          body:
              jsonEncode({"name": name, "email": email, "password": password}));




    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
