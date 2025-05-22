enum ApiRoutes {
  // auth
  login('v1/app/login'),
  register('v1/app/register'),
  logout('v1/app/logout'),
  storeSecret('v1/app/store-secret'),
  storePhone('v1/app/phones'),
  removePhone('v1/app/phones/{phone}/delete'),
  resendOtp('v1/app/phones/{phone_id}/resend-otp'),
  verifyOtp('v1/app/phones/{phone_id}/verify/{code}'),

// vote route
  votes('votes'),
  updateVote('votes/{vote}');

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
