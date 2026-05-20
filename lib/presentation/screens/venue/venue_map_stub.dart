import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Widget getVenueMap() {
  return const _MobileMap();
}

class _MobileMap extends StatefulWidget {
  const _MobileMap();

  @override
  State<_MobileMap> createState() => _MobileMapState();
}

class _MobileMapState extends State<_MobileMap> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final String mapUrl = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3682.737588083576!2d79.9695512!3d14.4354708!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a4cf3607d9137db%3A0xfa5f2ac32a13791c!2sHotel%20Minerva%20Grand%20Nellore%20%23Bluefox%20Restaurent%20%23%20ON%20The%20Rocks%20Bar%23!5e1!3m2!1sen!2sin!4v1776079792819!5m2!1sen!2sin';
    
    final String htmlString = '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body { margin: 0; padding: 0; }
          iframe { border: none; width: 100vw; height: 100vh; }
        </style>
      </head>
      <body>
        <iframe src="$mapUrl" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
      </body>
      </html>
    ''';
    
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.startsWith('intent://') || !request.url.startsWith('http')) {
              final fallbackUrl = Uri.parse('https://maps.app.goo.gl/Hx5Razwr67F7du3N9');
              try {
                await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
              } catch (e) {
                debugPrint('Could not launch $fallbackUrl');
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadHtmlString(htmlString, baseUrl: "https://www.google.com");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
