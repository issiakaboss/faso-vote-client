import 'package:get/get.dart';
import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart' as pusher;
import 'package:faso_vote_client/app/core/websocket/echo_service.dart';
import 'package:faso_vote_client/app/utils/helpers/dialog_helper.dart';

class SocketController extends GetxController {
  Echo<pusher.PusherClient, PusherChannel>? echo;

  void listenToCandidatVoiceUpdated({required int voteId}) async {
    ecouter(
        channel: 'newVoice.$voteId',
        event: 'newVoice-event',
        action: (e) {
          print("new vote did $e");
        });
  }

  Future<void> connectToSocket({required int voteId}) async {
    try {
      echo ??= await EchoService.initEcho();
      echo!.connector.onConnect((data) {
        print("it%%%%%%%%%%%");
        initialSoketSubcription(voteId: voteId);
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "socket error: $e");
    }
  }

  Future<void> initialSoketSubcription({required int voteId}) async {
    listenToCandidatVoiceUpdated(voteId: voteId);
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
