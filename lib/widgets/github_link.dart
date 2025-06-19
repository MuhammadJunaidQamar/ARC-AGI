import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubLink extends StatelessWidget {
  final String repoUrl;
  const GitHubLink({required this.repoUrl, super.key});

  Future<void> _launch() async {
    if (await canLaunchUrl(Uri.parse(repoUrl))) {
      await launchUrl(Uri.parse(repoUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16),
        child: RichText(
          text: TextSpan(
            text: 'Source code',
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
