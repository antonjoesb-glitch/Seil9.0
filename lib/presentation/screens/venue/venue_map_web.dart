// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

Widget getVenueMap() {
  final String viewId = 'google-map-iframe-${DateTime.now().millisecondsSinceEpoch}';
  ui_web.platformViewRegistry.registerViewFactory(
    viewId,
    (int viewId) => html.IFrameElement()
      ..src = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3682.737588083576!2d79.9695512!3d14.4354708!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a4cf3607d9137db%3A0xfa5f2ac32a13791c!2sHotel%20Minerva%20Grand%20Nellore%20%23Bluefox%20Restaurent%20%23%20ON%20The%20Rocks%20Bar%23!5e1!3m2!1sen!2sin!4v1776079792819!5m2!1sen!2sin'
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%',
  );

  return HtmlElementView(viewType: viewId);
}
