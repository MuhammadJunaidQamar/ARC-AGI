abstract class SectionContent {}

class ParagraphContent extends SectionContent {
  final String text;
  ParagraphContent(this.text);
}

class HeadingContent extends SectionContent {
  final String text;
  HeadingContent(this.text);
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
