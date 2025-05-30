// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:google_sign_in/google_sign_in.dart';
// import '../../data/providers/api_provider.dart';
// import '../../utils/enums/api_routes.dart';

// class AuthService {
//   static final GoogleSignIn _googleSignIn = GoogleSignIn(
//     clientId: kIsWeb
//         ? '1037977832184-6sravmv32k7bfedce0lkhki1uh3qko0m.apps.googleusercontent.com'
//         : null,
//     scopes: ['email', 'profile'],
//     signInOption: SignInOption.standard,
//   );

//   static Future<String?> signInWithGoogle() async {
//     try {
//       if (kIsWeb) {
//         // Initialisation spécifique pour le web
//         await _initializeForWeb();
//       }

//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;

//       return await _handleGoogleSignIn(googleUser);
//     } catch (e) {
//       print('Google sign in error: $e');
//       return null;
//     }
//   }

//   static Future<void> _initializeForWeb() async {
//     try {
//       await _googleSignIn.signInSilently();
//     } catch (e) {
//       print('Initialization error: $e');
//     }
//   }

//   static Future<String?> _handleGoogleSignIn(
//       GoogleSignInAccount googleUser) async {
//     try {
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final response = await ApiProvider.post(
//         auth: false,
//         data: {
//           'token': googleAuth.idToken,
//           'access_token': googleAuth.accessToken,
//         },
//         apiURL: ApiRoutes.googleAuthCalback.path,
//       );

//       if (response != null && response['token'] != null) {
//         return response['token'];
//       }
//       print('Invalid response: ${response ?? "NULL"}');
//       return null;
//     } catch (e) {
//       print('Authentication error: $e');
//       return null;
//     }
//   }

//   static Future<void> signOut() async {
//     try {
//       await _googleSignIn.signOut();
//       if (kIsWeb) {
//         await _googleSignIn.disconnect();
//       }
//       // Ajouter ici la suppression du token JWT local
//     } catch (e) {
//       print('Sign out error: $e');
//     }
//   }
// }

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/providers/api_provider.dart';
import '../../utils/enums/api_routes.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb
        ? '1037977832184-6sravmv32k7bfedce0lkhki1uh3qko0m.apps.googleusercontent.com'
        : null,
    scopes: ['email', 'profile'],
    signInOption: SignInOption.standard,
  );

  static Future<dynamic> signInWithGoogle({required String voteUuid}) async {
    try {
      if (kIsWeb) {
        // Approche recommandée pour le web
        return await _webSignIn(voteUuid: voteUuid);
      } else {
        // Approche mobile/native
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) return null;
        return await _handleAuth(googleUser, voteUuid: voteUuid);
      }
    } catch (e) {
      print('Google sign in error: $e');
      return null;
    }
  }

  static Future<dynamic> _webSignIn({required String voteUuid}) async {
    try {
      // 1. Essayer d'abord une connexion silencieuse
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signInSilently();
      if (googleUser != null) {
        return await _handleAuth(googleUser, voteUuid: voteUuid);
      }

      // 2. Si échec, faire une connexion interactive
      final interactiveUser = await _googleSignIn.signIn();
      if (interactiveUser == null) return null;

      return await _handleAuth(interactiveUser, voteUuid: voteUuid);
    } catch (e) {
      print('Web sign in error: $e');
      return null;
    }
  }

  static Future<dynamic> _handleAuth(GoogleSignInAccount googleUser,
      {required String voteUuid}) async {
    try {
      final String? userMail = await googleUser.email;

      if (userMail == null) {
        return null;
      }

      final response = await ApiProvider.post(
        auth: false,
        data: {
          'email': userMail,
          'vote_uuid': voteUuid,
        },
        apiURL: ApiRoutes.voteGoogle.path,
      ).catchError((error){
      });
      return response;
    } catch (e) {
      print('Authentication error: $e');
      return null;
    }
  }

  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      if (kIsWeb) {
        await _googleSignIn.disconnect();
      }
    } catch (e) {
      print('Sign out error: $e');
    }
  }
}
