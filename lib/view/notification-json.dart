import 'package:flutter/material.dart';

class NotificationList{
  static List notification = [
    {
      "title": "About to write somethings about your date?",
      "highlight_text" : "Hey! How was your date?",
      "time": "20 minutes ago",
      "read" : false,
      "icon" : "assets/icons/questions.png"
    },
    {
      "title": "Good morning! ",
      "highlight_text" : "Today you have date with Taylor.",
      "time": "1 hours ago",
      "read" : true,
      "icon" : "assets/icons/goals.png"
    },
    {
      "title": "Define your relationship goal with",
      "highlight_text" : "Taylor",
      "time": "2 hours ago" ,
      "read" : false,
      "icon" : "assets/icons/baloon.png"
    },

    {
      "title": "Do you want to ask him",
      "highlight_text" : '"What are his thought about you?"',
      "time": "2 hours ago" ,
      "read" : false,
      "icon" : "assets/icons/love-not.png"
    },

  ];
}