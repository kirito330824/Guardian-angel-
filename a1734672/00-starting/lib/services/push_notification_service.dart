import 'dart:ffi';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/constants/route_names.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'package:compound/locator.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final DialogService _dialogService = locator<DialogService>();

  Future initialise() async {
    if (Platform.isIOS) {
      //request permissions if we're on android
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.getToken().then((token) {
      print("-------------");
      print(token);
      print("-------------");
    });
    _fcm.configure(
      //Called when the app is in the foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        if ('$message'.contains("Patient Fall")) {
          _dialogService.showDialog(
            title: 'Warning',
            description: 'Patient falls to the ground!',
          );
        } else if ('$message'.contains("Patient leave")) {
          _dialogService.showDialog(
            title: 'Warning',
            description: 'The patient has left the room!',
          );
        } else {
          _dialogService.showDialog(
            title: 'Alart',
            description: '$message',
          );
        }

        print("------------message foreground----------");
      },
      //Called When the app is completely closed (not in the background) and opened directly from the push notification
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        print("------------message background----------");
      },
      //When the app is in the background and opened directly from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];

    if (view != null) {
      // Navigate to the create post view
      // if (view == 'create_logbook') {
      //   _navigationService.navigateTo(CreateLogbookViewRoute);
      // }
      // If there's no view it'll just open the app on the first view
    }
  }
}
