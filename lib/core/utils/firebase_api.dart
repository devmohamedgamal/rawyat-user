import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log("Title : ${message.notification?.title}");
  log("Body : ${message.notification?.body}");
  log("payload : ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    log("Token : $fCMToken");
  }

  Future<void> requestAndGetToken() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    FirebaseMessaging.instance.subscribeToTopic('notify');
    log("Token : $fCMToken");
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  sendMessageToTopic(
      String title, String body, String topic, String imageUrl) async {
    const String serverKey =
        "AAAAeUNoI-o:APA91bFsVKPXiY_wRf2FJZYFhuEB7IqPKH3ivmsJDk4Z2p5eT-uVsVpWS37va5zgpipMyaQBBi022icFm3h7HK7JLZE3GgXBSUTmOdnCuqN7Cx8MPNpnogaS-jzWoGPRsv4zVPzdHNii";
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey'
    };
    var data = json.encode({
      "to": "/topics/$topic",
      "notification": {"title": title, "body": body, "sound": "Tri-tone"},
      "data": {
        "url": imageUrl,
      }
    });
    var dio = Dio();
    var response = await dio.request(
      'https://fcm.googleapis.com/fcm/send',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      log(json.encode(response.data));
    } else {
      log(response.statusMessage.toString());
    }
  }
}
