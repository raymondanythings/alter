class DiffusionModel {
  final String prompt;

  DiffusionModel({
    required this.prompt,
  });

  Map<String, dynamic> toJson() {
    return {
      "prompt": prompt,
    };
  }
}
