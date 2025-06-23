import 'package:flutter/material.dart';

class TocController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  final List<GlobalKey> sectionKeys;
  final List<int> sectionLevels;
  int currentIndex = 0;

  TocController({required this.sectionKeys, required this.sectionLevels})
    : assert(sectionKeys.length == sectionLevels.length),
      super() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    for (var i = 0; i < sectionKeys.length; i++) {
      final ctx = sectionKeys[i].currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero).dy;
        if (offset >= 0 && offset < 200) {
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
    final ctx = sectionKeys[index].currentContext;
    if (ctx != null) {
      await Scrollable.ensureVisible(
        ctx,
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
