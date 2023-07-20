import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dante/main.dart';
import 'package:dante/utility/app_colors.dart';

class NotificationServices{

  static Future<void> initNotification()async{
    await AwesomeNotifications().initialize(
    null,
       [
         NotificationChannel(
             channelKey: "channelKey",
             channelName: "channelKey",
             channelDescription: "Notification for test",
            playSound: true,
            importance: NotificationImportance.Max,
           channelShowBadge: true,
           onlyAlertOnce: true,
           criticalAlerts: true,
           defaultColor: AppColors.mainColor,
         ),

       ],
        channelGroups: [
            NotificationChannelGroup(
                channelGroupkey: "channelGroupkey",
                channelGroupName: "channelGroupkey 1"
            )
        ],
      debug: true,

    );
    //if is not permisson for notfication
    await AwesomeNotifications().isNotificationAllowed().then(
            (isAllow)async{
          if(!isAllow){
            await AwesomeNotifications().requestPermissionToSendNotifications();
          }
        }
    );
  }


  static Future showNotification({
  required int id,
    required String title,
    required String body,
    required dynamic interval,
  })async{
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
        id: id,
        channelKey: "channelKey",
        title: title,
        body: body,
        locked: true,
        criticalAlert: true,
        category: NotificationCategory.Alarm,

    ),
    schedule: NotificationCalendar.fromDate(
        date: DateTime.parse("$interval"),
    preciseAlarm: true,
    allowWhileIdle: true,
      repeats:  true
    ));
  }

}