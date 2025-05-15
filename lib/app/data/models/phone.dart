import 'dart:convert';
import 'package:faso_vote_client/app/utils/helpers/storage_helper.dart';

class Phone {
  final int? id;
  final String number;

  Phone({required this.id, required this.number});
  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(id: json['phone_id'], number: json['number']);
  }
  Map<String, dynamic> toJson() {
    return {'phone_id': id, 'number': number};
  }

  static void savePhone(Phone phone) {
    String phoneJson = jsonEncode(phone.toJson());
    StorageHelper.set('phone', phoneJson);
  }

  static Phone? getPhone() {
    String? phoneJson = StorageHelper.get('phone');
    if (phoneJson != null && phoneJson.isNotEmpty) {
      return Phone.fromJson(jsonDecode(phoneJson));
    }
    return null;
  }

  static void clearPhone() {
    StorageHelper.delete('phone');
  }
}
