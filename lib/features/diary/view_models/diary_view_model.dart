import 'dart:async';

import 'package:alter/features/diary/models/diary_model.dart';
import 'package:alter/features/diary/repository/diary_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryViewModel extends AsyncNotifier<List<DiaryModel>> {
  late final DiaryRepository _repository;
  int? lastItemCreatedAt;
  List<DiaryModel> _list = [];

  Future<List<DiaryModel>> _fetchDiaries({int? lastItemCreatedAt}) async {
    final result = await _repository.fetchDiaries(
      lastItemCreatedAt: lastItemCreatedAt ?? this.lastItemCreatedAt,
    );
    this.lastItemCreatedAt = lastItemCreatedAt;
    final diaries = result.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return DiaryModel.fromJson(
        data,
      );
    });
    return diaries.toList();
  }

  Future<void> refetch() async {
    final diaries = await _fetchDiaries();
    state = AsyncValue.data(diaries);
  }

  Future<void> removeDiary(String docId) async {
    await _repository.removeDiary(docId);
    await refetch();
  }

  @override
  FutureOr<List<DiaryModel>> build() async {
    _repository = ref.read(diaryRepository);
    _list = await _fetchDiaries();
    return _list;
  }
}

final diaryProvider = AsyncNotifierProvider<DiaryViewModel, List<DiaryModel>>(
  () => DiaryViewModel(),
);
