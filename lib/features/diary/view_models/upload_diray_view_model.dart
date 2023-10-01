import 'dart:async';
import 'package:alter/features/authenticate/repository/auth_repository.dart';
import 'package:alter/features/diary/models/diary_model.dart';
import 'package:alter/features/diary/repository/diary_repository.dart';
import 'package:alter/features/diary/view_models/diary_view_model.dart';
import 'package:alter/features/users/view_models/users_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UploadDiaryViewModel extends AsyncNotifier<void> {
  late final DiaryRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(diaryRepository);
  }

  Future<void> uploadDiary(
      String title, String diary, BuildContext context) async {
    final user = ref.read(authRepository).user;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(
        () async {
          final imageUrl = await _repository.generateImage(title, diary);
          await _repository.saveDiary(
            DiaryModel(
              picture: imageUrl,
              title: title,
              diary: diary,
              creatorUid: user!.uid,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              creator: userProfile.username,
            ),
          );
          await ref.read(diaryProvider.notifier).refetch();
          context.pop();
        },
      );
    }
  }
}

final uploadDiaryProvider = AsyncNotifierProvider<UploadDiaryViewModel, void>(
  () => UploadDiaryViewModel(),
);
