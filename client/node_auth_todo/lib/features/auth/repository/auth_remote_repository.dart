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

  Future<Either<AppFailure, UserModel>> getCurrentUserData(String token) async {
    try {
      print("in repository of getCu");
      final response = await http.get(
        Uri.parse("${ServerConstants.serverUrl}auth"),
        headers: {'Content-Type': 'application/json', "x-auth-token": token},
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return Right(UserModel.fromMap(resBodyMap));
      } else if (response.statusCode == 401) {
        return Left(AppFailure(resBodyMap["msg"]));
      } else if (response.statusCode == 500) {
        return Left(AppFailure(resBodyMap["error"]));
      } else {
        print("ddddddddddddd");
        return Left(AppFailure("Unexpected error occured"));
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
