class Candidat {
  final int id;
  final int voteId;
  final String fullName;
  final String etablissement;
  final String? theme;
  final String? photoUrl;
  final int voix;

  Candidat({
    required this.id,
    required this.voteId,
    required this.fullName,
    required this.etablissement,
    this.theme,
    this.photoUrl,
    required this.voix,
  });

  // Optionnel: méthode fromJson si vous utilisez une API
  factory Candidat.fromJson(Map<String, dynamic> json) {
    return Candidat(
      id: json['id'],
      voteId: json['vote_id'],
      fullName: json['full_name'],
      etablissement: json['university'],
      theme: json['theme'],
      photoUrl: json['photo'],
      voix: json['votes_count'],
    );
  }

  // Optionnel: méthode toJson si vous utilisez une API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'university': etablissement,
      'theme': theme,
      'photo': photoUrl,
    };
  }
}
