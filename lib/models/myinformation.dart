
import 'package:flutter/material.dart';

class Information{
  const Information({
    required this.id,
    required this.topic,
    this.color= Colors.grey,
    required this.image,
    required this.icon,
    });

final String id;
final String topic;
final Color color;
final String image;
final IconData icon;


}