class CryptoCoinDescription {
  String en;

  CryptoCoinDescription({
    required this.en,
  });

  factory CryptoCoinDescription.fromJson(Map<String, dynamic> json) {
    return CryptoCoinDescription(
      en: json["en"],
    );
  }
}
