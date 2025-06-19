import 'package:arc_agi/models/section_info.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../controllers/toc_controller.dart';
import '../data/sections_data.dart';
import '../models/section_content.dart';

class ContentPanel extends StatelessWidget {
  final TocController controller;
  const ContentPanel({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        controller: controller.scrollController,
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 756,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < sections.length; i++) ...[
                _buildSection(context, sections[i], controller.sectionKeys[i]),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, SectionInfo sec, GlobalKey key) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sec.title, style: theme.headlineSmall),
          const SizedBox(height: 12),

          for (final block in sec.contentBlocks) ...[
            if (block is HeadingContent) ...[
              Text(block.text, style: theme.titleMedium),
              const SizedBox(height: 8),
            ] else if (block is ParagraphContent) ...[
              Text(
                block.text,
                style: theme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12),
            ] else if (block is ImageContent) ...[
              block.imagePath.startsWith('http')
                  ? Image.network(block.imagePath, height: block.height)
                  : Image.asset(block.imagePath, height: block.height),
              const SizedBox(height: 12),
            ] else if (block is LinkContent) ...[
              RichText(
                text: TextSpan(
                  text: block.text,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: launch(block.url);
                        },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ],
      ),
    );
  }
}
