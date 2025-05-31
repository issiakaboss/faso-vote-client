enum ApiRoutes {
  // auth
  login('auth/login'),
  register('auth/register'),
  googleAuth('auth/google/redirect'),
  googleAuthCalback('auth/google/callback'),
  voteGoogle('vote/votant/email'),
  votePhone('vote/votant/phone'),
  logout('auth/logout'),
  verifyOtp('vote/votant/verify-phone'),

// vote route
  votes('votes'),
  editVote('votes/{vote}/edit'),
  deleteVote('votes/{vote}'),
  toggleVoteStatus('votes/{vote}/toggle'),
  validateCandidatVote('vote/{candidat_id}'),
  voteCandidats('votes/{vote}'),
  gestVoteCandidats('vote/{vote}'),
  updateVote('votes/{vote}'),
  candidats('candidates'),
  updateCandidat('candidates/{candidat}'),
  deleteCandidat('candidates/{candidat}'),
  editCandidat('candidates/{candidat}/edit');

  final String path;
  const ApiRoutes(this.path);

  /// Remplace les valeurs dynamiques dans l'URL
  String format(Map<String, String> params) {
    String formattedPath = path;
    params.forEach((key, value) {
      formattedPath = formattedPath.replaceAll('{$key}', value);
    });
    return formattedPath;
  }
}
