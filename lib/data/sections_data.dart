import '../models/section_info.dart';
import '../models/section_content.dart';

final List<SectionInfo> sections = [
  SectionInfo(
    title: 'Abstract',
    contentBlocks: [
      ParagraphContent(
        'This project presents the design and implementation of a neuro-symbolic reasoning system i.e., ARC-AGI that tackles the Abstraction and Reasoning Corpus (ARC), a few-shot benchmark of human-level abstract problem-solving. We propose a modular pipeline that (1) encodes colored grid tasks into a compact 64-token representation, (2) enriches training data with Re-ARC and Concept-ARC augmentations (rotations, color permutations, procedural example generators), (3) fine-tunes decoder-only language models (e.g., LLaMA-3.2B, NeMo-Minitron-8B) via Low-Rank Adaptation (LoRA) under tight compute budgets within Kaggle Environment, and (4) applies a depth-first-search sampler with log-softmax scoring to yield and rank candidate solutions across multiple augmented views. Compared to classical and prior neural approaches, ARC-AGI achieves a better output through pipeline integration of LLM & continuous Augmentation. Our open-source toolkit not only demonstrates latent abstract reasoning capabilities in large language models but also introduces a reusable domain-specific language for grid transformations and a data-centric augmentation suite. This work lays a foundation for reproducible, explainable AGI research and paves the way for future extensions in few-shot generalization, program synthesis, and cognitive-inspired AI.',
      ),
      ImageContent('assets/images/arc-example-task.jpg'),
    ],
  ),
  SectionInfo(
    title: 'Introduction',
    contentBlocks: [
      ParagraphContent(
        'Artificial General Intelligence (AGI) is the capability of machines to understand and learn any intellectual task that a human can. AGI remains one of the most ambitious goals in the field of artificial intelligence. One of the most critical steps toward AGI is enabling machines to perform abstract reasoning across a diverse range of tasks just like humans do. Large Language Models (LLMs) have demonstrated remarkable capabilities across diverse tasks, from natural language processing to code generation. However, the fundamental question of whether these systems can truly "reason" remains contentious in the artificial intelligence community.',
      ),
      ParagraphContent(
        'The Abstraction and Reasoning Corpus (ARC), introduced by François Chollet in 2019, designed specifically to evaluate genuine intelligence in AI systems, provides a stark illustration of this challenge. Although the tasks appear simple to human test takers, both classical algorithmic approaches and modern neural architectures have struggled to achieve high performance on ARC, painting a bleak picture for artificial reasoning capabilities. This project is centered on solving ARC problems using an advanced approach developed to handle a broad spectrum of ARC tasks by breaking down the problem-solving process into interpretable, human-like steps. The ultimate objective of this project is to implement a framework capable of learning to solve previously unseen ARC tasks, showcasing its strength in generalization.',
      ),
    ],
  ),
  SectionInfo(title: 'Problem Statement', contentBlocks: []),
  SectionInfo(title: 'Related Work', contentBlocks: []),
  SectionInfo(
    title: ' Datasets Overview',
    contentBlocks: [
      HeadingContent('ARC'),
      HeadingContent('2. Re-ARC'),
      HeadingContent('ARC Heavy'),
      HeadingContent('Concept ARC'),
    ],
  ),
  SectionInfo(title: 'Data Representation', contentBlocks: []),
  SectionInfo(title: 'Tokenization', contentBlocks: []),
  SectionInfo(title: 'Pipeline Overview', contentBlocks: []),
  SectionInfo(title: 'Augmentation', contentBlocks: []),
  SectionInfo(title: 'Models', contentBlocks: []),
  SectionInfo(title: 'Preliminary & Secondary Fine-Tuning', contentBlocks: []),
  SectionInfo(title: 'Candidate Generation', contentBlocks: []),
  SectionInfo(title: 'Candidate Selection', contentBlocks: []),
  SectionInfo(title: 'Inference', contentBlocks: []),
  SectionInfo(title: 'Selection Strategies', contentBlocks: []),
  SectionInfo(title: 'Discussion', contentBlocks: []),
  SectionInfo(title: 'Conclusion', contentBlocks: []),
  SectionInfo(title: 'Future Work', contentBlocks: []),
  SectionInfo(title: 'References', contentBlocks: []),
  // SectionInfo(
  //   title: 'Getting Started',
  //   contentBlocks: [
  //     ParagraphContent('First, install via Pub:'),
  //     ParagraphContent('```shell\nflutter pub add arc_agi\n```'),
  //     ParagraphContent('Then import and initialize:'),
  //     ParagraphContent(
  //       "```dart\nimport 'package:arc_agi/arc_agi.dart';\n\nARCAGI.init();\n```",
  //     ),
  //   ],
  // ),
  // SectionInfo(
  //   title: 'Introduction',
  //   contentBlocks: [
  //     HeadingContent('What is ARC-AGI?'),
  //     ParagraphContent(
  //       'ARC-AGI is a framework for building adaptive, learning-powered UIs.',
  //     ),
  //     ImageContent('assets/images/arc_overview.png', height: 200),
  //     ParagraphContent(
  //       'It supports dynamic content blocks, auto-scrolling TOCs, and more.',
  //     ),
  //     LinkContent('Learn more on our website', 'https://example.com'),
  //   ],
  // ),
];
