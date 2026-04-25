import 'package:flutter/material.dart';

class LocalGuestSession {
  static final ValueNotifier<bool> isGuestMode = ValueNotifier<bool>(false);

  static void enable() => isGuestMode.value = true;

  static void disable() => isGuestMode.value = false;
}
