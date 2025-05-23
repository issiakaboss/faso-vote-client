
class VoteModel {
  final String title;
  final String location;
  final String date;
  final String duration;
  final String status;

  VoteModel({
    required this.title,
    required this.location,
    required this.date,
    required this.duration,
    required this.status,
  });

  factory VoteModel.fromJson(Map<String, dynamic> json) {
  return VoteModel(
    title: json['title'],
    location: json['location'],
    date: json['date'],
    duration: json['duration'],
    status: json['status'],
  );
}
}
