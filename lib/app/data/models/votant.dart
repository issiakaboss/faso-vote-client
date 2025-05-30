class Votant {
  final int id;
  final int voteId;
  final String identity;

  Votant({
    required this.id,
    required this.voteId,
    required this.identity,
  });

  // Factory method pour convertir depuis JSON
  factory Votant.fromJson(Map<String, dynamic> json) {
    return Votant(
      id: json['id'] as int,
      voteId: json['vote_id'] as int,
      identity: json['identity'] as String,
    );
  }

  // Méthode pour convertir vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vote_id': voteId,
      'identity': identity,
    };
  }

  @override
  String toString() {
    return 'Votant(id: $id, voteId: $voteId, identity: $identity)';
  }
}
