import 'package:fpdart/fpdart.dart';
import 'package:node_auth_todo/core/providers/current_user_notifier.dart';
import 'package:node_auth_todo/features/auth/model/user_model.dart';
import 'package:node_auth_todo/features/auth/repository/auth_local_repository.dart';
import 'package:node_auth_todo/features/auth/repository/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;

  Future<void> initSharedPreferences() async {
    print("ssssssssssssss");
    await _authLocalRepository.init();
  }

  Future<void> signUpUser(UserModel userModel) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.signup(userModel);
    final val = switch (res) {
      Left(value: final l) => state = AsyncError(l, StackTrace.current),
      Right(value: final r) => state = AsyncData(r),
    };
    print("val= $val");
  }

  Future<void> loginUser(UserModel userModel) async {
    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.login(userModel);
    final val = switch (res) {
      Left(value: final l) => state = AsyncError(l, StackTrace.current),
      Right(value: final r) => state = _loginSuccess(r),
    };
    print("val= $val");
  }

  AsyncValue<UserModel>? _loginSuccess(UserModel user) {
    _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  void clearSharedPreference() {
    _authLocalRepository.clearSharedPreference();
  }

  Future<UserModel?> getData() async {
    state = const AsyncValue.loading();
    final token = _authLocalRepository.getToken();
    print("yeah token");
    print(token);
    print("yeah token");
    if (token != null) {
      final res = await _authRemoteRepository.getCurrentUserData(token);
      final val = switch (res) {
        Left(value: final l) => state =
            AsyncValue.error(l.message, StackTrace.current),
        Right(value: final r) => _getCurrentUser(r),
      };

      print("user entered");
      print(val.value?.toMap());
      print("user entered");

      return val.value;
    }

    return null;
  }

  AsyncValue<UserModel> _getCurrentUser(UserModel user) {
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }
}
