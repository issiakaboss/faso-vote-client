class Candidat {
  final int id;
  final String fullName;
  final String etablissement;
  final String? theme;
  final String? photoUrl;

  Candidat({
    required this.id,
    required this.fullName,
    required this.etablissement,
    this.theme,
    this.photoUrl,
  });

  // Optionnel: méthode fromJson si vous utilisez une API
  factory Candidat.fromJson(Map<String, dynamic> json) {
    return Candidat(
      id: json['id'],
      fullName: json['fullName'],
      etablissement: json['etablissement'],
      theme: json['theme'],
      photoUrl: json['photoUrl'],
    );
  }

  // Optionnel: méthode toJson si vous utilisez une API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'etablissement': etablissement,
      'theme':theme,
      'photoUrl': photoUrl,
    };
  }
}