import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Link extends StatelessWidget {
  final String url;
  final String text;
  final bool openInNewTab;

  const Link({
    required this.url,
    required this.text,
    this.openInNewTab = false,
    super.key,
  });

  Future<void> _launch() async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        webOnlyWindowName: openInNewTab ? '_blank' : '_self',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16),
        child: RichText(
          text: TextSpan(
            text: text,
            style: TextStyle(
              color: const Color.fromARGB(255, 32, 148, 243),
              fontSize: 15.4,
            ),
            recognizer: TapGestureRecognizer()..onTap = _launch,
          ),
        ),
      ),
    );
  }
}
