import 'package:flutter/material.dart';

class FeatureItem {
  const FeatureItem(this.title, this.icon, this.color, {this.subtitle});

  final String title;
  final IconData icon;
  final Color color;
  final String? subtitle;
}
