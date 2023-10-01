import 'package:alter/common/views/widgets/input.dart';
import 'package:alter/constants/gaps.dart';
import 'package:alter/constants/sizes.dart';
import 'package:alter/features/diary/view_models/upload_diray_view_model.dart';
import 'package:alter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WriteDiaryScreen extends ConsumerStatefulWidget {
  const WriteDiaryScreen({super.key});

  @override
  ConsumerState<WriteDiaryScreen> createState() => _WriteDiaryScreenState();
}

class _WriteDiaryScreenState extends ConsumerState<WriteDiaryScreen> {
  late ScrollController _scrollContoller;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};
  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        ref.read(uploadDiaryProvider.notifier).uploadDiary(
              formData['title']!,
              formData['diary']!,
              context,
            );
      }
    }
  }

  void _onSaveFormData(String key, String? value) {
    if (value != null) {
      formData[key] = value;
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollContoller = ScrollController();
  }

  @override
  void dispose() {
    _scrollContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            Sizes.size10,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Today's diary",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.size20,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: _onSubmitTap,
              child: ref.watch(uploadDiaryProvider).isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size10,
                      ),
                      child: Text(
                        "POST",
                        style: TextStyle(
                          color: isDarkMode(context) ? Colors.white : null,
                        ),
                      ),
                    ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Scrollbar(
            controller: _scrollContoller,
            child: SingleChildScrollView(
              controller: _scrollContoller,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Title",
                      style: TextStyle(
                        fontSize: Sizes.size18,
                      ),
                    ),
                    Gaps.v4,
                    Input(
                      onSaved: (newValue) => _onSaveFormData("title", newValue),
                    ),
                    Gaps.v20,
                    const Text(
                      "Write your diary here",
                      style: TextStyle(
                        fontSize: Sizes.size18,
                      ),
                    ),
                    Gaps.v4,
                    Input(
                      multiline: true,
                      onSaved: (newValue) => _onSaveFormData("diary", newValue),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
