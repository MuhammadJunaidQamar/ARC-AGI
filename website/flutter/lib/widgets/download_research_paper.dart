import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class DownloadResearchPaper extends StatelessWidget {
  final String assetPath = 'assets/pdf/research_paper.pdf';
  final String downloadName = 'LLMs are more Memory than Mystery.pdf';

  const DownloadResearchPaper({super.key});

  Future<void> _downloadAssetPdf() async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();

    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', downloadName)
      ..style.display = 'none';
    html.document.body!.append(anchor);
    anchor.click();
    anchor.remove();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text('Download Paper'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          foregroundColor: const Color.fromARGB(255, 32, 148, 243),
          textStyle: Theme.of(context).textTheme.bodySmall,
        ),
        onPressed: _downloadAssetPdf,
      ),
    );
  }
}
