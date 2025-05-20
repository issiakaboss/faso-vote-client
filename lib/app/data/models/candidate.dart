class Candidate {
  final String? id;
  final String? name;
  final String? title;
  final String? image;

  Candidate({
    this.id,
    this.name,
    this.title,
    this.image,
  });

  // Convertir un JSON en Candidate
  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }

  // Convertir un Candidate en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'image': image,
    };
  }
}
