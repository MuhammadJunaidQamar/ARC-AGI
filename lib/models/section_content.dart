import 'package:flutter/material.dart';

abstract class SectionContent {}

class HeadingContent extends SectionContent {
  final String text;
  final int level;
  HeadingContent(this.text, {this.level = 1});
}

class CodeBlockContent extends SectionContent {
  final String code;
  final String? language;
  CodeBlockContent(this.code, {this.language});
}

class ImageContent extends SectionContent {
  final String imagePath;
  final double? height;
  ImageContent(this.imagePath, {this.height});
}

class LinkContent extends SectionContent {
  final String text;
  final String url;
  LinkContent(this.text, this.url);
}

class ListContent extends SectionContent {
  final List<List<ParagraphSegment>> items;
  final bool solid;
  ListContent(this.items, {this.solid = true});
}

abstract class ParagraphSegment {}

class TextSegment extends ParagraphSegment {
  final String text;
  TextSegment(this.text);
}

class BoldSegment extends ParagraphSegment {
  final String text;
  BoldSegment(this.text);
}

class LinkSegment extends ParagraphSegment {
  final String text;
  final String url;
  LinkSegment(this.text, this.url);
}

class ImageSegment extends ParagraphSegment {
  final String src;
  final double? width;
  final double? height;
  final Alignment alignment;
  ImageSegment(
    this.src, {
    this.width,
    this.height,
    this.alignment = Alignment.centerRight,
  });
}

class ParagraphContent extends SectionContent {
  final List<ParagraphSegment> segments;
  ParagraphContent(this.segments);
}

class CodeSegment extends ParagraphSegment {
  final String code;
  CodeSegment(this.code);
}
