import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:node_auth_todo/core/constants/server_constants.dart';
import 'package:node_auth_todo/core/failure/failure.dart';
import 'package:node_auth_todo/features/auth/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup(UserModel userModel) async {
    try {
      print("tapped");
      final res =
          await http.post(Uri.parse("${ServerConstants.serverUrl}auth/signup"),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode(userModel.toMap()));

      final resBodyMap = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return right(UserModel.fromMap(resBodyMap));
      } else if (res.statusCode == 400) {
        return left(AppFailure(resBodyMap['msg']));
      } else if (res.statusCode == 500) {
        return left(AppFailure(resBodyMap['error']));
      } else {
        return left(AppFailure('An Unexpected error occured'));
      }
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> login(UserModel userModel) async {
    try {
      final res = await http.post(
          Uri.parse("${ServerConstants.serverUrl}auth/login"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
              {"email": userModel.email, "password": userModel.password}));

      final resBodyMap = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return right(UserModel.fromMap(resBodyMap));
      } else if (res.statusCode == 400) {
        return left(AppFailure(resBodyMap['msg']));
      } else if (res.statusCode == 500) {
        return left(AppFailure(resBodyMap['error']));
      } else {
        return left(AppFailure('An Unexpected error occured'));
      }
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
