import 'package:alter/features/diary/models/diary_model.dart';
import 'package:alter/features/replicate/models/diffusion_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:replicate/replicate.dart';

class DiaryRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> generateImage(String title, String diary) async {
    try {
      // Unexpected Blessings from Grandma
      await Replicate.instance.predictions.create(
        version:
            "ac732df83cea7fff18b8472768c88ad041fa750ff7682a21affe81863cbe77e4",
        input: DiffusionModel(prompt: """


Title:  $title

Content: $diary

""").toJson(),
      );
    } catch (err) {
      print(err);
    }

    await Future.delayed(
      const Duration(seconds: 7),
    );
    PaginatedPredictions predictionsPageList =
        await Replicate.instance.predictions.list();

    Prediction prediction = await Replicate.instance.predictions.get(
      id: predictionsPageList.results.elementAt(0).id,
    );
    return prediction.output[0];
  }

  Future<void> saveDiary(DiaryModel data) async {
    await _db.collection("diaries").add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchDiaries({
    int? lastItemCreatedAt,
  }) {
    final query = _db
        .collection("diaries")
        .orderBy("createdAt", descending: true)
        .limit(10);
    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  Future<void> removeDiary(String docId) async {
    _db.collection("diaries").doc(docId).delete();
  }
}

final diaryRepository = Provider((ref) => DiaryRepository());
