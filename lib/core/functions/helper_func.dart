// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'appodeal.dart';
// import 'dart:ui' as ui;

getFormatedDate(date) {
  var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
  var inputDate = inputFormat.parse(date);
  var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
  return outputFormat.format(inputDate);
}

String selectPhrase(String input,
    {required int startWord, required int endWord}) {
  List<String> words = input.split(' ');

  // Ensure startWord and endWord are within the valid range
  startWord = startWord.clamp(0, words.length);
  endWord = endWord.clamp(0, words.length);

  // Take the desired words
  List<String> selectedWords = words.sublist(startWord, endWord);

  // Join the selected words to form the final phrase
  String selectedPhrase = selectedWords.join(' ');

  return selectedPhrase;
}

int countWords(String input) {
  List<String> words = input.split(' ');

  // Remove empty strings caused by consecutive spaces
  words.removeWhere((word) => word.isEmpty);

  return words.length;
}

bool containsMap(List<dynamic> list, Map<String, dynamic> map) {
  return list.any((element) =>
      element is Map &&
      const MapEquality().equals(element.cast<String, dynamic>(), map));
}

void removeMap(List<dynamic> list, Map<String, dynamic> map) {
  list.removeWhere((element) =>
      element is Map &&
      const MapEquality().equals(element.cast<String, dynamic>(), map));
}

List<String> splitTextIntoWords(String text, int wordsPerItem) {
  List<String> words = text.split(' ');
  List<String> result = [];

  for (int i = 0; i < words.length; i += wordsPerItem) {
    int end = i + wordsPerItem < words.length ? i + wordsPerItem : words.length;
    result.add(words.sublist(i, end).join(' '));
  }

  return result;
}

Future<bool> checkNotificationPermission() async {
  NotificationSettings settings =
      await FirebaseMessaging.instance.getNotificationSettings();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log('Notifications are allowed');
    return true;
  } else {
    log('Notifications are not allowed');
    return false;
  }
}

Future<bool> requestTONotification(BuildContext context) async {
  try {
    if (await Permission.notification.isDenied) {
      var status = await Permission.notification.status;
      if (status.isDenied) {
        showAlertDialog(context);
      }
      log('Permission denied');
      return true;
    } else {
      await Permission.notification.request();
      log('perem notifications');
      return false;
    }
  } catch (e) {
    log(e.toString());
    return false;
  }
}

showAlertDialog(context) => showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('الاشعارات مغلقة'),
          content: const Text('يرجي تفعيل الاشعارات'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () {
                context.pop();
              },
              child: const Text('الغاء'),
            ),
            CupertinoDialogAction(
              onPressed: () => openAppSettings(),
              child: const Text('الاعدادات'),
            ),
          ],
        ));

void adsCounter({
  required BuildContext context,
  required int adsCounter,
  required int counter,
  required Function closeAd,
  required Function incresCounter,
}) {
  if (counter < adsCounter) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      title: 'يجب مشاهدة الاعلان',
      desc: 'لقد شاهدت $counter/$adsCounter',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        AppodealFunc.loadRewardedAd(onClosed: incresCounter);
        log(" ok btn => $counter");
      },
    ).show();
  } else {
    AppodealFunc.loadRewardedAd(onClosed: closeAd);
  }
}
