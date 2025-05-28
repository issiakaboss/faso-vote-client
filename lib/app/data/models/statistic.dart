class StatisticModel {
  final int total;
  final int voted;
  final int invalid;
  final int pending;

  StatisticModel({
    required this.total,
    required this.voted,
    required this.invalid,
    required this.pending,
  });

  // Factory method pour créer une instance depuis un Map (ex : JSON)
  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      total: json['total'] ?? 0,
      voted: json['voted'] ?? 0,
      invalid: json['invalid'] ?? 0,
      pending: json['pending'] ?? 0,
    );
  }

 StatisticModel copyWith({
  int? total,
  int? voted,
  int? invalid,
  int? pending,

}) {
  return StatisticModel(
    total: total ?? this.total,
   voted: voted ?? this.voted,
   invalid: invalid ?? this.invalid,
   pending: pending ?? this.pending,

  );
}
}
