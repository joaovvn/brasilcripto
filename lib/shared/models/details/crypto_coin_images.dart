class CryptoCoinImages {
  String thumb;
  String small;
  String large;

  CryptoCoinImages({
    required this.thumb,
    required this.small,
    required this.large,
  });

  factory CryptoCoinImages.fromJson(Map<String, dynamic> json) {
    return CryptoCoinImages(
      thumb: json["thumb"],
      small: json["small"],
      large: json["large"],
    );
  }
}
