import 'package:flutter/widgets.dart';

class VoteModel {
  final int id;
  final String? title;
  final String? location;
  final String? date;
  final String? duration;
  final String? description;
  final String? status;
  final String? statusColor;
  final String? logo;
  final String uuid;
  final String url;

  VoteModel({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.duration,
    required this.description,
    required this.status,
    this.statusColor,
    this.logo,
    required this.uuid,
    required this.url,
  });

  factory VoteModel.fromJson(Map<String, dynamic> json) {
    return VoteModel(
      id: json['id'] as int,
      title: json['title'],
      location: json['location'],
      date: json['date'],
      duration: json['duration'],
      description: json['description'],
      status: json['status'],
      statusColor: json['status_color'],
      logo: json['logo'],
      uuid: json['uuid'],
      url: json['url'],
    );
  }
  Color get statusDisplayColor => Color(int.parse(statusColor ?? "0xffffff"));
}
