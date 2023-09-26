import 'dart:async';
import 'package:alter/features/authenticate/repository/auth_repository.dart';
import 'package:alter/features/users/models/user_model.dart';
import 'package:alter/features/users/repository/users_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersViewModel extends AsyncNotifier<UserModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserModel> build() async {
    _usersRepository = ref.read(userRepository);
    _authenticationRepository = ref.read(authRepository);
    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserModel.fromJson(profile);
      }
    }
    return UserModel.enpty();
  }

  Future<void> createAccount(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    } else {
      state = const AsyncValue.loading();
      final newUser = UserModel(
        hasAvatar: false,
        uid: credential.user!.uid,
        name: credential.user!.displayName ?? "Anon",
        email: credential.user!.email ?? "anon@anon.com",
        description: "",
        username: "",
      );
      await _usersRepository.createProfile(newUser);
      state = AsyncValue.data(newUser);
    }
  }

  Future<void> onAvatarUpload() async {
    if (state.value != null) {
      state = AsyncValue.data(
        state.value!.copyWith(hasAvatar: true),
      );
      await _usersRepository.updateUser(state.value!.uid, {"hasAvatar": true});
    }
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserModel>(
  () => UsersViewModel(),
);
