// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import '../controllers/toc_controller.dart';
import '../utils/responsive_layout.dart';
import '../widgets/content_panel.dart';
import '../widgets/table_of_contents.dart';
import '../widgets/github_link.dart';
import '../data/sections_data.dart';
import '../models/section_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TocController _tocController;

  @override
  void initState() {
    super.initState();

    // Build flat key & level lists
    final keys = <GlobalKey>[];
    final levels = <int>[];
    for (var sec in sections) {
      keys.add(GlobalKey());
      levels.add(1);
      for (var block in sec.contentBlocks) {
        if (block is HeadingContent) {
          keys.add(GlobalKey());
          levels.add(block.level.clamp(2, 10));
        }
      }
    }

    _tocController = TocController(sectionKeys: keys, sectionLevels: levels);
  }

  @override
  void dispose() {
    _tocController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const repoUrl = 'https://github.com/MuhammadJunaidQamar/ARC-AGI';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ARC-AGI'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 32, 148, 243),
      ),
      body: ResponsiveLayout(
        mobile: _buildMobile(repoUrl),
        tablet: _buildTablet(repoUrl),
        desktop: _buildDesktop(repoUrl),
      ),
    );
  }

  Widget _buildMobile(String repoUrl) => Column(
    children: [
      Expanded(child: ContentPanel(controller: _tocController)),
      FloatingActionButton(
        onPressed: () {},
        child: GitHubLink(repoUrl: repoUrl),
      ),
    ],
  );

  Widget _buildTablet(String repoUrl) {
    final w = MediaQuery.of(context).size.width;
    final tocWidth = w < 900 ? 180.0 : 250.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GitHubLink(repoUrl: repoUrl),
        const SizedBox(height: 16),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 756),
                    child: ContentPanel(controller: _tocController),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: tocWidth,
                child: TableOfContents(controller: _tocController),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktop(String repoUrl) {
    final w = MediaQuery.of(context).size.width;
    final tocWidth = w < 1200 ? 200.0 : 250.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GitHubLink(repoUrl: repoUrl),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 756),
                child: ContentPanel(controller: _tocController),
              ),
            ),
          ),
          const SizedBox(width: 32),
          SizedBox(
            width: tocWidth,
            child: TableOfContents(controller: _tocController),
          ),
        ],
      ),
    );
  }
}
