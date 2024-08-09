import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'notification_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Basic Notification",
                    body: "This is a Basic Notification",
                  );
                },
                label: Text("Default Notification"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Basic Notification",
                    body: "This is a Basic Notification",
                    summary: "This is Basic Summary",
                    notificationLayout: NotificationLayout.Inbox,
                  );
                },
                label: Text("Notification With Summary"),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await showNotification(
                    title: "Basic Notification",
                    body: "This is a Basic Notification",
                    summary: "This is Basic Summary",
                    notificationLayout: NotificationLayout.BigPicture,
                    bigPicture:
                    "https://i0.wp.com/devhq.in/wp-content/uploads/2024/07/2.png?w=1280&ssl=1",
                  );
                },
                label: Text("BigPicture Notification"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Action noti",
                    body: "This is a Action",
                    payload: {
                      "navigate": "true",
                    },
                    actionButtons: [
                      NotificationActionButton(
                        key: 'navigate',
                        label: "PYQs",
                        actionType: ActionType.SilentAction,
                        color: Colors.deepPurple,
                      )
                    ],
                  );
                },
                label: Text("Action Button Notification"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Big Text Notification",
                    body: "This is Big Text",
                    notificationLayout: NotificationLayout.BigText,
                  );
                },
                label: Text("BigText Notification"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Song Downloading",
                    body: "Please wait",
                    notificationLayout: NotificationLayout.ProgressBar,
                  );
                },
                label: Text("ProgressBar Notification"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Nitish Kumar",
                    body: "Hello What are you doing",
                    notificationLayout: NotificationLayout.Messaging,
                  );
                },
                label: Text("Messaging Notification"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "Nitish Kumar",
                    body: "Hello What are you doing",
                    notificationLayout: NotificationLayout.MessagingGroup,
                  );
                },
                label: Text("Messaging Group Notification"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "New song playing",
                    body: "Arjit ",
                    notificationLayout: NotificationLayout.MediaPlayer,
                  );
                },
                label: Text("MediaPlayer Notification"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showNotification(
                    title: "New song playing",
                    body: "Arjit ",
                    notificationLayout: NotificationLayout.MediaPlayer,
                  );
                },
                label: Text("MediaPlayer Notification"),
              ),
            ],
          ),
        ));
  }
}
