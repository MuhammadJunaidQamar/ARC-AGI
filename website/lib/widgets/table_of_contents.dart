import 'package:flutter/material.dart';
import '../controllers/toc_controller.dart';
import '../data/sections_data.dart';
import '../models/section_content.dart';

class TableOfContents extends StatelessWidget {
  final TocController controller;
  const TableOfContents({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final entries = <_TocEntry>[];
    int keyIndex = 0;

    for (var sec in sections) {
      entries.add(_TocEntry(text: sec.title, keyIndex: keyIndex++, level: 1));

      for (var block in sec.contentBlocks) {
        if (block is HeadingContent) {
          final lvl = block.level.clamp(2, 10);
          entries.add(
            _TocEntry(text: block.text, keyIndex: keyIndex++, level: lvl),
          );
        }
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Table of Contents',
                  style: TextStyle(
                    color: Color.fromARGB(137, 0, 0, 0),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, idx) {
                      final entry = entries[idx];
                      final isSelected = idx == controller.currentIndex;
                      return InkWell(
                        onTap: () => controller.scrollToIndex(entry.keyIndex),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: (entry.level - 1) * 12.0 + 4.0,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Text(
                            entry.text,
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? const Color.fromARGB(255, 32, 148, 243)
                                      : Colors.black,
                              fontSize: 14,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TocEntry {
  final String text;
  final int keyIndex;
  final int level;

  _TocEntry({required this.text, required this.keyIndex, required this.level});
}
