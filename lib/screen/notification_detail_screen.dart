import 'package:flutter/material.dart';

class NotificationDetailScreen extends StatelessWidget {
  final String body;
  final String title;

  const NotificationDetailScreen({
    super.key,
    required this.body,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Detail"),),
      body: Padding(padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10,),

        Text(body) ],
      ),
    ),);
  }
}
