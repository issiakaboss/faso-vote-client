import 'package:faso_vote_client/app/data/models/candidat.dart';
import 'package:faso_vote_client/app/data/models/statistic.dart';
import 'package:faso_vote_client/app/data/models/vote.dart';

class VoteCandidats {
  final VoteModel vote;
  final StatisticModel statistic;
  final List<Candidat> candidats;

  VoteCandidats({
    required this.vote,
    required this.statistic,
    required this.candidats,
  });

  factory VoteCandidats.fromJson(Map<String, dynamic> json) {
    return VoteCandidats(
      vote: VoteModel.fromJson(json),
      statistic: StatisticModel.fromJson(json['statistics']),
      candidats: (json['candidates'] as List)
          .map((e) => Candidat.fromJson(e))
          .toList(),
    );
  }

 VoteCandidats copyWith({
    VoteModel? vote,
    StatisticModel? statistic,
    List<Candidat>? candidats,
  }) {
    return VoteCandidats(
      vote: vote ?? this.vote,
      statistic: statistic ?? this.statistic,
      candidats: candidats ?? this.candidats,
    );
  }
}
