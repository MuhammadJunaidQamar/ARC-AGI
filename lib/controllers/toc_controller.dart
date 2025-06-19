import 'package:flutter/material.dart';

class TocController extends ChangeNotifier {
  final scrollController = ScrollController();
  final List<GlobalKey> sectionKeys = List.generate(20, (_) => GlobalKey());
  int currentIndex = 0;

  TocController() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    for (int i = 0; i < sectionKeys.length; i++) {
      final context = sectionKeys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero).dy;

        if (offset >= 0 && offset < 200) {
          // Adjust this threshold to your preference
          if (currentIndex != i) {
            currentIndex = i;
            notifyListeners();
          }
          break;
        }
      }
    }
  }

  Future<void> scrollToIndex(int index) async {
    final context = sectionKeys[index].currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
