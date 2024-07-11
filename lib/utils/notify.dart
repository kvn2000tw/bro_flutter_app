import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

void showNotification(String title,String body)
{
  showSimpleNotification(
    Text(title,textAlign: TextAlign.center,
      style: const TextStyle(
      color: Colors.black,
    ),),
    subtitle: Text(body,textAlign: TextAlign.center,
      style: const TextStyle(
      color: Colors.black,
    ),),
    background: Colors.cyan.shade700,
    foreground:Colors.cyan.shade700,
    duration: const Duration(seconds: 2),
  );     
}
