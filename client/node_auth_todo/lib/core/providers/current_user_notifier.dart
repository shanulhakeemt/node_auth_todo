import 'package:node_auth_todo/features/auth/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  void addUser(UserModel userModel) {
    state = userModel;
  }

  void removeUser() {
    state = null;
  }

  @override
  UserModel? build() {
    return null;
  }
}
