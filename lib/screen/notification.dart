import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/screen/notification_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // PUSH notification

  void firebaseMesseging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Token print
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    // 🔵 FOREGROUND Notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? "N/A";
      final body = message.notification?.body ?? "N/A";

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(
            body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NotificationDetailScreen(body: body, title: title),
                  ),
                );
              },
              child: Text("Next"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
          ],
        ),
      );
    });

    // 🔵 BACKGROUND (app minimized) Notification click
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final title = message.notification?.title ?? "N/A";
      final body = message.notification?.body ?? "N/A";


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              NotificationDetailScreen(body: body, title: title),
        ),
      );
    });

    // 🔵 TERMINATED: App fully closed → User taps notification
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final title = message.notification?.title ?? "N/A";
        final body = message.notification?.body ?? "N/A";

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NotificationDetailScreen(body: body, title: title),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    firebaseMesseging();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          "Push Notification",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
    );
  }
}
