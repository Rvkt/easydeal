class Offer {
  final String title;
  final String subtitle;
  final String colorName;
  final String iconName;

  Offer({
    required this.title,
    required this.subtitle,
    required this.colorName,
    required this.iconName,
  });

  // Optional: Factory constructor to create an Offer from a JSON map
  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      title: json['title'],
      subtitle: json['subtitle'],
      colorName: json['colorName'],
      iconName: json['iconName'],
    );
  }

  // Optional: Method to convert an Offer to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'colorName': colorName,
      'iconName': iconName,
    };
  }
}
