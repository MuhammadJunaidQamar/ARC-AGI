import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/toc_controller.dart';
import '../data/sections_data.dart';
import '../models/section_content.dart';

class ContentPanel extends StatelessWidget {
  final TocController controller;
  const ContentPanel({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    int entryIdx = 0;

    return Center(
      child: SingleChildScrollView(
        controller: controller.scrollController,
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 756,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var sec in sections) ...[
                Padding(
                  key: controller.sectionKeys[entryIdx++],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    sec.title,
                    style: theme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                for (var block in sec.contentBlocks) ...[
                  if (block is HeadingContent) ...[
                    Padding(
                      key: controller.sectionKeys[entryIdx++],
                      padding: EdgeInsets.only(left: (block.level - 1) * 16.0),
                      child: Text(
                        block.text,
                        style: _headingStyle(theme, block.level),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ] else if (block is ListContent) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          block.items.map((segments) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    block.solid ? '• ' : '– ',
                                    style: theme.bodyLarge,
                                  ),
                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        children:
                                            segments.map((seg) {
                                              if (seg is TextSegment) {
                                                return TextSpan(
                                                  text: seg.text,
                                                  style: theme.bodyLarge,
                                                );
                                              }
                                              if (seg is BoldSegment) {
                                                return TextSpan(
                                                  text: seg.text,
                                                  style: theme.bodyLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                );
                                              }
                                              if (seg is LinkSegment) {
                                                return TextSpan(
                                                  text: seg.text,
                                                  style: theme.bodyLarge
                                                      ?.copyWith(
                                                        color: Colors.blue,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap =
                                                            () => launchUrl(
                                                              Uri.parse(
                                                                seg.url,
                                                              ),
                                                            ),
                                                );
                                              }
                                              if (seg is ImageSegment) {
                                                final img = Image.network(
                                                  seg.src,
                                                  width: seg.width,
                                                  height: seg.height,
                                                );
                                                return WidgetSpan(
                                                  alignment:
                                                      PlaceholderAlignment
                                                          .middle,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 4,
                                                        ),
                                                    child: Align(
                                                      alignment: seg.alignment,
                                                      child: img,
                                                    ),
                                                  ),
                                                );
                                              }
                                              if (seg is CodeSegment) {
                                                return WidgetSpan(
                                                  alignment:
                                                      PlaceholderAlignment
                                                          .middle,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 6,
                                                          vertical: 2,
                                                        ),
                                                    margin:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 2,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            4,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      seg.code,
                                                      style: theme.bodyLarge
                                                          ?.copyWith(
                                                            fontFamily:
                                                                'monospace',
                                                            fontSize:
                                                                theme
                                                                    .bodyLarge!
                                                                    .fontSize! *
                                                                0.9,
                                                          ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return const TextSpan();
                                            }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 12),
                  ] else if (block is CodeBlockContent) ...[
                    Center(
                      child: Container(
                        width: 500,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3C3C3C),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(6),
                                ),
                              ),
                              child: Row(
                                children: [
                                  _circle(Colors.red),
                                  const SizedBox(width: 6),
                                  _circle(Colors.yellow),
                                  const SizedBox(width: 6),
                                  _circle(Colors.green),
                                  const Spacer(),
                                  Text(
                                    block.language ?? 'Plain Text',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontFamily: 'Source Code Pro',
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.copy,
                                      size: 20,
                                      color: Colors.white70,
                                    ),
                                    tooltip: 'Copy code',
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(text: block.code),
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Code copied to clipboard',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var line in block.code.trimRight().split(
                                    '\n',
                                  ))
                                    Builder(
                                      builder: (_) {
                                        final symbol =
                                            line.isNotEmpty ? line[0] : '';
                                        Color symbolColor;
                                        switch (symbol) {
                                          case '+':
                                            symbolColor = Colors.greenAccent;
                                            break;
                                          case '*':
                                            symbolColor = Colors.cyanAccent;
                                            break;
                                          case '&':
                                            symbolColor = Colors.orangeAccent;
                                            break;
                                          default:
                                            symbolColor = Colors.white;
                                        }
                                        return RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              fontFamily: 'Source Code Pro',
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                            children: [
                                              if (symbolColor != Colors.white)
                                                TextSpan(
                                                  text: symbol,
                                                  style: TextStyle(
                                                    color: symbolColor,
                                                  ),
                                                ),
                                              TextSpan(
                                                text:
                                                    symbolColor != Colors.white
                                                        ? line.substring(1)
                                                        : line,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else if (block is ParagraphContent) ...[
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        children:
                            block.segments.map((seg) {
                              if (seg is TextSegment) {
                                return TextSpan(
                                  text: seg.text,
                                  style: theme.bodyLarge,
                                );
                              }
                              if (seg is BoldSegment) {
                                return TextSpan(
                                  text: seg.text,
                                  style: theme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              if (seg is LinkSegment) {
                                return TextSpan(
                                  text: seg.text,
                                  style: theme.bodyLarge?.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap =
                                            () => launchUrl(Uri.parse(seg.url)),
                                );
                              }
                              if (seg is ImageSegment) {
                                final img = Image.network(
                                  seg.src,
                                  width: seg.width,
                                  height: seg.height,
                                );
                                return WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: Align(
                                      alignment: seg.alignment,
                                      child: img,
                                    ),
                                  ),
                                );
                              }
                              if (seg is CodeSegment) {
                                return WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      seg.code,
                                      style: theme.bodyLarge?.copyWith(
                                        fontFamily: 'monospace',
                                        fontSize:
                                            theme.bodyLarge!.fontSize! * 0.9,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const TextSpan();
                            }).toList(),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _circle(Color color) => Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );

  TextStyle _headingStyle(TextTheme t, int level) {
    switch (level) {
      case 1:
        return t.headlineMedium!;
      case 2:
        return t.headlineSmall!;
      case 3:
        return t.titleLarge!;
      default:
        return t.bodyLarge!.copyWith(fontWeight: FontWeight.w600);
    }
  }
}
