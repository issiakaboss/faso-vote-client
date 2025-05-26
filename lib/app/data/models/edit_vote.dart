class EditVote {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String? logo;
  final DateTime startDate;
  final DateTime endDate;

  EditVote({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.logo,
    required this.startDate,
    required this.endDate,
  });

  factory EditVote.fromJson(Map<String, dynamic> json) {
    return EditVote(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      logo: json['logo'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'logo': logo,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }
}
