class Votant {
  final int id;
  final int voteId;
  final String identity;
  bool isVerified;

  Votant({
    required this.id,
    required this.voteId,
    required this.identity,
    this.isVerified=false,
  });

  // Factory method pour convertir depuis JSON
  factory Votant.fromJson(Map<String, dynamic> json) {
    return Votant(
      id: json['id'] as int,
      voteId: json['vote_id'] as int,
      identity: json['identity'] as String,
      isVerified: json['is_verified']??false,
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
    return 'Votant(id: $id, voteId: $voteId, identity: $identity, isVerified: $isVerified)';
  }
}
