import 'package:flutter/material.dart';
import '../controllers/toc_controller.dart';
import '../utils/responsive_layout.dart';
import '../widgets/content_panel.dart';
import '../widgets/table_of_contents.dart';
import '../widgets/github_link.dart';

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
    _tocController = TocController();
  }

  @override
  void dispose() {
    _tocController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const repoUrl = 'https://github.com/your-org/your-repo';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ARC-AGI'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 32, 148, 243),
      ),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(repoUrl),
        tablet: _buildTabletLayout(repoUrl),
        desktop: _buildDesktopLayout(repoUrl),
      ),
    );
  }

  Widget _buildMobileLayout(String repoUrl) {
    return Column(
      children: [
        GitHubLink(repoUrl: repoUrl),
        Expanded(child: ContentPanel(controller: _tocController)),
      ],
    );
  }

  Widget _buildTabletLayout(String repoUrl) {
    final screenWidth = MediaQuery.of(context).size.width;

    double tocWidth = 250;
    if (screenWidth < 900) {
      tocWidth = 180;
    }

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

  Widget _buildDesktopLayout(String repoUrl) {
    final screenWidth = MediaQuery.of(context).size.width;

    double tocWidth = 250;
    if (screenWidth < 1200) {
      tocWidth = 200;
    }

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
