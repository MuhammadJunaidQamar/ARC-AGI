import 'package:flutter/material.dart';
import '../controllers/toc_controller.dart';
import '../data/sections_data.dart';

class TableOfContents extends StatelessWidget {
  final TocController controller;
  const TableOfContents({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
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
                    itemCount: sections.length,
                    itemBuilder: (context, idx) {
                      final isSelected = idx == controller.currentIndex;
                      return InkWell(
                        onTap: () => controller.scrollToIndex(idx),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          child: Text(
                            sections[idx].title,
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
