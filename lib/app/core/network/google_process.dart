import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';


class GoogleProcess {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: 'TON_CLIENT_ID.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  void renderGoogleButton() {
    if (kIsWeb) {
      final plugin = GoogleSignInPlatform.instance;
      if (plugin is GoogleSignInPlugin) {
        plugin.renderButton(
          configuration: GSIButtonConfiguration(
            type:  GSIButtonType.standard,
            theme:  GSIButtonTheme.filledBlue,
          
          ),
        );
      } else {
        print("Le plugin Web GoogleSignIn n'est pas disponible.");
      }
    }
  }

  Future<void> signInSilently() async {
    try {
      final user = await _googleSignIn.signInSilently();
      if (user != null) {
        final auth = await user.authentication;
        print("ID Token: ${auth.idToken}");
        // Envoie ce token à Laravel ici
      } else {
        print("Utilisateur non connecté.");
      }
    } catch (e) {
      print("Erreur d'authentification: $e");
    }
  }
}
