import 'package:faso_vote_client/app/data/models/candidat.dart';
import 'package:faso_vote_client/app/data/models/vote.dart';

class VoteCandidats {
  final VoteModel vote;
  final List<Candidat> candidats;

  VoteCandidats({
    required this.vote,
    required this.candidats,
  });

  factory VoteCandidats.fromJson(Map<String, dynamic> json) {
    return VoteCandidats(
      vote: VoteModel.fromJson(json),
      candidats: (json['candidates'] as List)
          .map((e) => Candidat.fromJson(e))
          .toList(),
    );
  }

 
}
