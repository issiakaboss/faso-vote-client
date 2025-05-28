import 'package:faso_vote_client/app/data/models/statistic.dart';
import 'package:get/get.dart';
import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart' as pusher;
import 'package:faso_vote_client/app/core/websocket/echo_service.dart';
import 'package:faso_vote_client/app/utils/helpers/dialog_helper.dart';

class SocketController extends GetxController {
  Echo<pusher.PusherClient, PusherChannel>? echo;

  void listenToCandidatVoiceUpdated({
    required String voteId,
    required void Function(int candidatId, int voix,StatisticModel newNtatistic) onVoteUpdated,
  }) async {
    ecouter(
      channel: 'newVoice.$voteId',
      event: 'newVoice-event',
      action: (e) {
        try {
          StatisticModel newNtatistic=StatisticModel.fromJson(e['statistics']);
          final candidatData = e['candidat'];
          final candidatId = candidatData['candidat_id'];
          final voix = candidatData['voix'];

          if (candidatId is int && voix is int) {
            onVoteUpdated(candidatId, voix,newNtatistic);
          }
        } catch (e) {
          print("Erreur lors du traitement du vote: $e");
        }
      },
    );
  }

  Future<void> connectToSocket({
    required String voteId,
    required void Function(int candidatId, int voix,StatisticModel newNtatistic) onVoteUpdated,
  }) async {
    try {
      echo ??= await EchoService.initEcho();
      echo!.connector.onConnect((data) {
        listenToCandidatVoiceUpdated(
            voteId: voteId, onVoteUpdated: onVoteUpdated);
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "socket error: $e");
    }
  }

  void ecouter(
      {required String channel,
      required String event,
      required Function action}) {
    EchoService.listen(
      echo: echo!,
      channel: channel,
      event: event,
      action: action,
    );
  }
}
