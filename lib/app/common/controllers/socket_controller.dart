import 'package:faso_vote_client/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart' as pusher;
import 'package:faso_vote_client/app/core/websocket/echo_service.dart';
import 'package:faso_vote_client/app/data/models/user.dart';
import 'package:faso_vote_client/app/utils/helpers/dialog_helper.dart';

class SocketController extends GetxController {
  Echo<pusher.PusherClient, PusherChannel>? echo;

  void listenToCardUpdated({required int walletId}) async {
    HomeController homeController = Get.find<HomeController>();
    ecouter(
        channel: 'private-card.$walletId.updated',
        event: 'card-event',
        action: (e) {
      
     
        });
  }

  void listenToUserProfileUpdated({required int userId}) async {
  
    ecouter(
        channel: 'private-profile.$userId.updated',
        event: 'profile-event',
        action: (e) {
          User updatedUserData = User.fromJson(e['user']);
       
        });
  }

  Future<void> connectToSocket(
      {required int walletId, required int userId}) async {
    try {
      echo ??= await EchoService.initEcho();
      echo!.connector.onConnect((data) {
        initialSoketSubcription(walletId: walletId, userId: userId);
      });
    } catch (e) {
      DialogHelper.showErrorSnackbar(message: "socket error: $e");
    }
  }

  Future<void> initialSoketSubcription(
      {required int walletId, required int userId}) async {
    listenToUserProfileUpdated(userId: userId);
    listenToCardUpdated(walletId: walletId);
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
