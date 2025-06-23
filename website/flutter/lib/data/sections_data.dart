import 'package:flutter/material.dart';

import '../models/section_info.dart';
import '../models/section_content.dart';

final List<SectionInfo> sections = [
  SectionInfo(
    title: 'Abstract',
    contentBlocks: [
      ParagraphContent([
        TextSegment('We present a structuredt'),
        BoldSegment(' Domain-Specific Language (DSL) '),
        TextSegment('and a simple'),
        BoldSegment(' Genetic Algorithm (GA) '),
        TextSegment(
          'o solve visual reasoning tasks in the ARC (Abstraction and Reasoning Corpus) benchmark. Our approach codifies common image transformations (e.g. color grouping, cropping, rotation) as DSL primitives and searches the program space for solutions. Metaphorically, we note that a computer is a “dumb machine” that cannot guess the solution without guidance; random search through programs would be akin to the infinite monkey theorem (monkeys randomly typing code until a solution emerges) and is practically infeasible. Instead, our DSL+GA provides structured guidance through the search space. We describe the DSL primitives and GA design in detail, and analyze the code structure. We then compare our approach to state-of-art systems: prior DSL/GA solvers and modern AI models. Fischer et al. used a similar DSL+evolution strategy to solve only ~3% of test tasks, illustrating the difficulty. Recent neural methods (DreamCoder) also solve few tasks. By contrast, large language models (LLMs) have achieved limited ARC performance (e.g. GPT-4 solved 26% of simple tasks). The new OpenAI o3 model achieves ~75% on ARC-AGI (semi-private), far exceeding earlier results. We include these comparisons to highlight the challenge. Our DSL+GA approach does not reach these levels, but offers a transparent programmatic solution method. Results on example tasks show that even simple DSL programs can solve nontrivial ARC transformations, and our performance aligns with prior DSL-based efforts. This suggests that while the ARC remains largely unsolved (no system exceeds ~50% on “easy” tasks), symbolic methods like our DSL+GA are a viable part of the solution space.',
        ),
      ]),
    ],
  ),
  SectionInfo(
    title: 'Introduction',
    contentBlocks: [
      ParagraphContent([
        TextSegment('The'),
        BoldSegment(' Abstraction and Reasoning Corpus (ARC) '),
        TextSegment(
          'is a benchmark of abstract visual reasoning tasks, proposed by Chollet as a test of general intelligence. Each ARC task consists of a few example input/output grid pairs and a test grid; the goal is to infer the transformation rule and apply it. Critically, tasks require human-like abstraction from very few examples, a capability that remains elusive for machines. ARC was introduced to codify a kind of “IQ test for AI”, and after multiple competitions and years of research, no AI system has solved a majority of tasks. For example, Bober-Irizar and Banerjee report that the best ARC-Easy solvers reach only ~50% accuracy, and only 20% on more difficult tasks. Even with recent advances, the majority of ARC tasks remain unsolved by any single method. In this context, we explore',
        ),
        BoldSegment(' discrete program synthesis '),
        TextSegment('using a custom DSL as an approach to reasoning.'),
      ]),
      ParagraphContent([
        TextSegment(
          'We motivate our approach with a metaphor: a computer is fundamentally a deterministic engine that only follows instructions; it cannot infer an abstract rule without being explicitly programmed. If we let a computer search randomly (like “monkeys at typewriters” producing endless random code), it might eventually stumble on a correct program by pure chance (the infinite monkey theorem). However, this naive method is impractical given the immense program space. Instead, we design a DSL to capture common visual patterns, and use a Genetic Algorithm to guide the search for programs in this language. This structured search is akin to giving the computer better intuition, compared to unguided random search.',
        ),
      ]),
      ParagraphContent([
        TextSegment('Our contributions are: (1) A detailed specification of a'),
        BoldSegment(' minimalistic DSL '),
        TextSegment(
          'for ARC image tasks, including core primitives (color grouping, cropping, transforms). (2) A description of a simple',
        ),
        BoldSegment(' GA-based program search '),
        TextSegment(
          'using this DSL, with code analysis. (3) Comparative discussion placing our results in context: we compare performance of DSL+GA to prior DSL solutions, large-scale neural methods, and frontier LLMs.',
        ),
      ]),
      ParagraphContent([
        TextSegment(
          'The rest of this paper is organized as follows. Section II reviews related work on ARC solvers, including both symbolic and neural approaches. Section III describes our DSL and GA methodology in detail, with code structure and examples. Section IV presents results on exemplar tasks and compares to other reported ARC performance. Section V discusses implications and future directions, and Section VI concludes.',
        ),
        ImageSegment('assets/images/arc-example.jpg'),
      ]),
    ],
  ),
  SectionInfo(
    title: 'Related Work',
    contentBlocks: <SectionContent>[
      ParagraphContent([
        TextSegment(
          ' Solving ARC tasks has attracted interest from both symbolic and neural perspectives. Early ARC competition entries often used hand-crafted program search. Fischer et al. introduced a',
        ),
        BoldSegment(' DSL + Genetic Programming '),
        TextSegment(
          'approach: they defined image transformation primitives and used Grammatical Evolution to evolve programs. Despite a sophisticated GA, they solved only 7.7% of training tasks and ~3% of test tasks, ranking in the top 4% of entrants. This highlights the difficulty and the reliance on DSL expressivity. More recently, DreamCoder-based systems have been applied: Bober-Irizar and Banerjee adapted DreamCoder to ARC, achieving 16.5% accuracy on easy tasks and 4.5% on hard tasks, behind older hand-designed solutions. These neural-symbolic systems leverage DSLs too, but still solve a small fraction of tasks, and even combining DreamCoder with GPT-4 and other methods only solved ~57% on ARC-Easy.',
        ),
        LinkSegment(
          'nature.com',
          'https://www.nature.com/articles/s41598-024-73582-7',
        ),
      ]),
      ParagraphContent([
        TextSegment('On the other hand, researchers have tested'),
        BoldSegment(' large neural models (LLMs) '),
        TextSegment(
          'on ARC. Xu et al. find that a state-of-art LLM (GPT-4) solves only 13 out of 50 of the simplest tasks when given textual descriptions (26%). Chollet’s ARC-AGI benchmarks (an ongoing challenge) report similar struggles: a plain GPT-4-based solution scored essentially 0–5%.',
        ),
        LinkSegment('arcprize.org', 'https://arcprize.org/guide'),
        TextSegment(
          'Likewise, recent model analysis shows leading LLMs like Google Gemini and Anthropic Claude achieve low single-digit performance on the hardest ARC-AGI tasks.',
        ),
        LinkSegment(
          'arize.com',
          'https://arize.com/blog/ai-benchmark-deep-dive-gemini-humanitys-last-exam/#:~:text=solving%20based%20on%20visual%20cues,intriguing%20debate%20about%20which%20types',
        ),
        TextSegment(
          'For example, ARC Prize blog results report Claude 3.5 (Sonnet) solved ~40% of ARC-AGI-1 tasks and Gemini 2.5 ~33%, while GPT-4 variants were essentially at chance. The newly announced OpenAI o3 model made a dramatic leap to 75.7% on ARC-AGI (semi-private), but only with massive compute and likely heavy fine-tuning.',
        ),
      ]),
      ParagraphContent([
        TextSegment(
          'Importantly, nearly all ARC solvers combine symbolic search with learning. Chollet himself emphasizes that LLMs “basically freeze at inference time” and must be augmented with program search.',
        ),
        LinkSegment('arcprize.org', 'https://arcprize.org/guide'),
        TextSegment(
          'Hybrid approaches using DSLs, neural nets, or ensembles are an active research area. Our work follows the symbolic tradition, using a DSL+GA to capture structured reasoning. We build on the idea that a carefully chosen language can make search tractable, similar in spirit to Fischer et al.. However, our DSL is simpler, and our GA is a basic elitist search (without sophisticated grammar learning). We thus expect low raw accuracy, but aim for clarity and extensibility. We compare our performance to these prior systems and the frontier LLM results.',
        ),
      ]),
    ],
  ),

  SectionInfo(
    title: 'Methodology',
    contentBlocks: [
      HeadingContent('DSL Design'),
      ParagraphContent([
        TextSegment('We define a minimalistic'),
        BoldSegment(' DSL for grid manipulation'),
        TextSegment(
          '. Each primitive is a function that takes one or more input images (2D color grids) and returns a list of output images. By chaining primitives, we construct a pipeline that maps input grids to output grid(s). Our goal is to capture common ARC patterns (color segmentation, shape extraction, filling, etc.) in these atoms. Key primitives include:',
        ),
      ]),
      ListContent([
        [
          BoldSegment('groupByColor: '),
          TextSegment(
            'splits an image into subimages, each containing one color (masking other colors to 0).',
          ),
        ],
        [
          BoldSegment('cropToContent: '),
          TextSegment(
            'rops an image to the bounding box of its non-zero pixels.',
          ),
        ],
        [
          BoldSegment('splitH / splitV: '),
          TextSegment(
            'splits an image horizontally or vertically into two halves.',
          ),
        ],
        [
          BoldSegment('rotate90, reflectH/V: '),
          TextSegment('geometric transformations.'),
        ],
        [
          BoldSegment('fillBackground(color): '),
          TextSegment('replaces any non-zero background with a color.'),
        ],
        [
          BoldSegment('mergeImages: '),
          TextSegment('overlays or concatenates images.'),
        ],
        [
          BoldSegment('count, pickLargest '),
          TextSegment('(for some tasks): computes sizes.'),
        ],
      ]),
      ParagraphContent([
        TextSegment(
          'By composing these primitives, one can express many ARC solutions. For instance, a task requiring “find the largest blue shape and fill its bounding box” could be done by',
        ),
        CodeSegment(
          'groupByColor -> pickLargest -> cropToContent -> fillBackground(color=blue)',
        ),
        TextSegment(
          '. In our implementation, each primitive is a Python function (e.g.,',
        ),
        CodeSegment(
          'def groupByColor(image): return [List of mask for color in unique_colors(image)]',
        ),
        TextSegment(
          '). The DSL syntax is simply a list of these function names applied in sequence.',
        ),
        ImageSegment(
          'assets/gif/Arc-solve.gif',
          width: 4800,
          height: 480,
          alignment: Alignment.center,
        ),
      ]),
      ParagraphContent([
        TextSegment('A program in our DSL is thus a sequence of tokens, e.g.'),
        CodeSegment(
          '[groupByColor, pickLargest, cropToContent, fillBackground]',
        ),
        TextSegment('. The'),
        BoldSegment(' search space '),
        TextSegment(
          'of programs is huge (we estimated ~4^11 possibilities under our length limit',
        ),
        LinkSegment('code', 'https://github.com/MuhammadJunaidQamar/ARC-AGI'),
        TextSegment(
          '). Hence, exhaustive search is infeasible, motivating a guided search strategy.',
        ),
      ]),
      HeadingContent('Genetic Algorithm'),
      ParagraphContent([
        TextSegment('We employ a simple'),
        BoldSegment(' elitist Genetic Algorithm '),
        TextSegment(
          'to search the space of programs. Programs are represented as fixed-length sequences of DSL tokens (with padding for shorter programs). Our GA workflow is:',
        ),
      ]),
      ListContent(solid: false, [
        [
          BoldSegment('Initialization:'),
          TextSegment(
            'Generate a random population of programs (we start with very short programs, e.g., length 1 or 2, drawn randomly from the DSL primitives).',
          ),
        ],
        [
          BoldSegment('Evaluation:'),
          TextSegment(
            'Each program is executed on the training examples of the ARC task. We define a multi-objective',
          ),
          BoldSegment(' fitness: '),
          TextSegment(
            'the program’s score measures how close its outputs match the target outputs. Concretely, we use pixel-wise equality plus structural checks. If any program exactly solves all training pairs, it is a valid solution (fitness=0 distance). Otherwise, the fitness is the sum of differences in pixels or the count of mismatches.',
          ),
        ],
        [
          BoldSegment('Selection (Elitism): '),
          TextSegment(
            'We maintain an “elite set” of the best programs (those with lowest fitness). This approximates the Pareto frontier of solutions. In each generation, we keep the elites.',
          ),
        ],
        [
          BoldSegment('Variation (Mutation): '),
          TextSegment(
            'From the elites, we generate new candidate programs by random mutations: we randomly change one token (replace one primitive), insert or delete a primitive, or replace a function argument (e.g., change a rotation angle). (In this simple GA we omit crossover.) Each new candidate is evaluated.',
          ),
        ],
        [
          BoldSegment('Iteration: '),
          TextSegment(
            'We update the elite set with any improved candidates and repeat. The process continues until a perfect solution is found (fitness=0) or a resource limit is reached.',
          ),
        ],
      ]),
      ParagraphContent([
        TextSegment(
          'Because we minimize a distance score, we actually treat fitness as distance-to-solution. This view is similar to multi-objective GA: the elite set contains programs that balance different sub-objectives. If a program perfectly solves the task, the Pareto front collapses to that solution. Practically, we found it effective to keep a small number of elites and focus on hill-climbing from them.',
        ),
      ]),
      HeadingContent('Implementation Details', level: 3),
      ParagraphContent([
        TextSegment(
          'Our reference implementation (see accompanying code) uses NumPy arrays for grids and evaluates DSL programs in a pipeline. To',
        ),
        BoldSegment(' check equality'),
        TextSegment(
          ', we compare each candidate output to the target output array; due to possible multiple output images from the DSL, we allow matching in any order. For example, if a program produces 3 images, we see if any of them exactly equals the expected output grid (within the first 3, to avoid large mismatch). A helper',
        ),
        CodeSegment('is_solution(program, task)'),
        TextSegment('returns True if all training pairs match.'),
      ]),
      ParagraphContent([
        TextSegment('The'),
        BoldSegment(' fitness function '),
        TextSegment(
          'has multiple components (hence multi-objective): it includes the number of pixels correct, differences in color counts, and penalty for extra or missing segments. We sum these to a single score to rank programs; lower is better. We keep the best few programs (elites) by this score.',
        ),
      ]),
      ParagraphContent([
        TextSegment(
          'Our GA is deliberately simple (no population pool, no crossover, no complex selection). This is in part for pedagogical clarity. Despite its simplicity, it can solve some tasks with relatively small search (for example, our example task was solved within a few dozen mutations). However, as Fischer et al. note, the search space complexity is enormous, so any non-trivial improvement (e.g. smarter mutations, grammar learning) is future work.',
        ),
      ]),
      HeadingContent('Code Analysis and Example'),
      ParagraphContent([
        TextSegment(
          'To illustrate, consider a concrete ARC task: transform the input grids by isolating the main colored object and painting its region a single color. A human might describe “find the colored shape and fill its bounding box”. In our DSL, a solution could be:',
        ),
      ]),
      CodeBlockContent(
        '''program = [groupByColor, pickLargest, cropToContent, fillBackground]''',
        language: 'Python',
      ),
      ListContent([
        [
          CodeSegment('groupByColor'),
          TextSegment('splits the grid into sub-grids for each color.'),
        ],
        [
          CodeSegment('pickLargest'),
          TextSegment(
            '(a custom primitive) selects the largest non-empty sub-grid (the main object).',
          ),
        ],
        [
          CodeSegment('cropToContent'),
          TextSegment('trims to the bounding box.'),
        ],
        [
          CodeSegment('fillBackground'),
          TextSegment('fills the area with its color.'),
        ],
      ]),
      ParagraphContent([
        TextSegment(
          'Our code would run this program on the training example: group the colors, pick the largest area, crop, fill. We then check if the output matches the target. In our implementation,',
        ),
        CodeSegment('evaluate(program, input_grid)'),
        TextSegment(
          'Our code would run this program on the training example: group the colors, pick the largest area, crop, fill. We then check if the output matches the target. In our implementation, evaluate(program, input_grid) executes each function in order, carrying a list of images through the pipeline. The snippet below (from our notebook) shows the core check:',
        ),
      ]),
      CodeBlockContent('''
        def is_solution(program, task):
          for sample in task['train']:
            input_grid = np.array(sample['input'])
            expected = np.array(sample['output'])
            outputs = evaluate(program, input_grid)   # run DSL program
            if not any(are_equal(out, expected) for out in outputs[:3]):
              return False
          return True
        ''', language: 'Python'),
      ParagraphContent([
        TextSegment('Here,'),
        CodeSegment('are_equal'),
        TextSegment(
          'checks array equality, and we only consider the first few outputs for efficiency. If',
        ),
        CodeSegment('is_solution'),
        TextSegment(
          'returns True, we found a program that perfectly matches all examples. We also print',
        ),
        CodeSegment('program_desc(program)'),
        TextSegment('to show the human-readable sequence.'),
      ]),
      ParagraphContent([
        TextSegment(
          'In this example, the program above would indeed solve a task where all examples obey the rule “fill the main object”. We verified with our code that',
        ),
        CodeSegment(
          'is_solution([groupByColor, pickLargest, cropToContent, fillBackground], task)',
        ),
        TextSegment(
          'returns True, and printed “is a solution of the task: True” for the example task.',
        ),
      ]),
    ],
  ),

  SectionInfo(
    title: 'Results',
    contentBlocks: [
      ParagraphContent([
        TextSegment(
          'Because our DSL and GA are custom, we do not present a large benchmark run. Instead, we report two things: (a) performance on one or a few illustrative tasks, and (b) comparison to reported results of other systems on ARC or ARC-AGI benchmarks.',
        ),
      ]),
      HeadingContent('Example Task Performance'),
      ParagraphContent([
        TextSegment(
          'On the example task above, our GA quickly found the correct program. Starting from random single-operation programs, elitist mutations discovered the four-step program in a few iterations. The search space was small (4^11 possibilities with our function set)',
        ),
        LinkSegment('code', 'https://github.com/MuhammadJunaidQamar/ARC-AGI'),
        TextSegment(
          ', and the GA’s simple hill-climbing sufficed. This demonstrates that our DSL has enough expressive power to encode the intended solution. In general, for tasks that align well with our primitives (color grouping, cropping, etc.), solutions are found. For tasks requiring logic not covered by our DSL (e.g. parity checks, sequential counting), the GA will fail or get stuck, reflecting the language’s limitations.',
        ),
      ]),
      HeadingContent('Comparative Performance'),
      ParagraphContent([
        TextSegment('We compare our approach to published results:'),
      ]),
      ListContent([
        [
          BoldSegment('DSL+Evolution Baseline: '),
          TextSegment(' Fischer et al., using a more complex GE setup, solved'),
          BoldSegment(' 7.7% '),
          TextSegment('of training tasks and only'),
          BoldSegment(' 3% '),
          TextSegment(
            'of secret test tasks in the ARC competition. They also noted that random search solved ~6.2% of training tasks (and 0% of test tasks). Our approach, being similar in spirit, would be expected to have similar low overall accuracy if scaled to all tasks. This confirms that even a DSL+GA with many primitives struggles across the diverse ARC set',
          ),
        ],
        [
          BoldSegment('State-of-the-Art Symbolic AI: '),
          TextSegment(
            'Bober-Irizar & Banerjee’s DreamCoder adaptation solved only',
          ),
          BoldSegment(' 16.5% of “easy” '),
          TextSegment(
            'ARC tasks, and worse on harder tasks. The best hand-crafted solver (Icecuber) remains over 50% on easy tasks. Our DSL+GA, lacking the sophisticated learning and enumerative engines of DreamCoder, would not approach these figures. Still, our example solution confirms the DSL is on the right track for at least some tasks',
          ),
        ],
        [
          BoldSegment('LLM-Based Systems: '),
          TextSegment(
            ' Early tests with generic LLMs gave near-zero accuracy. The ARC Prize guide notes that vanilla GPT-4 (with prompts) achieved <5% accuracy,',
          ),
          LinkSegment('arcprize.org', 'https://arcprize.org/guide'),
          TextSegment(
            'and even fine-tuned models only ~10%. Xu et al. report GPT-4 solved',
          ),
          BoldSegment(' 13/50 '),
          TextSegment(
            'of sample tasks (26%). Recent benchmarking by Chollet’s team shows GPT-4 variants score essentially',
          ),
          BoldSegment(' 0% '),
          TextSegment('on ARC-AGI-1. In contrast, OpenAI’s new'),
          BoldSegment(' o3 '),
          TextSegment('model (trained on ARC data) achieves'),
          BoldSegment(' 75.7% '),
          TextSegment(
            'on the semi-private set, and 87.5% with extreme compute. Anthropic’s Claude 3.5 Sonnet scored ~40% and Google Gemini Flash ~33%. These arcprize results underscore that only massive, specialized models are reaching high scores.',
          ),
        ],
        [
          BoldSegment('Summary Comparison: '),
          TextSegment(
            'Figure 1 (imagined) would summarize these: traditional DSL/GA yields single-digit success on ARC, early LLMs near zero,',
          ),
          LinkSegment('arcprize.org', 'https://arcprize.org/guide'),
          TextSegment(
            ' while the new frontier model hits ~80%. Our approach so far is in the former category.',
          ),
          ImageSegment('assets/images/arc-example-task-fig1.png'),
        ],
      ]),
      ParagraphContent([
        TextSegment(
          ' Thus, on publicly reported benchmarks, current purely symbolic methods are far behind leading AI. Our DSL+GA does not match the specialized LLM or hybrid techniques in absolute performance. However, it preserves transparency and uses no external training data. It aligns with the notion that ARC remains an open challenge: no approach dominates. In particular, Chollet’s analysis concludes “ARC-AGI-2 remains completely unsolved” and that',
        ),
        BoldSegment(' new ideas are needed. '),
        LinkSegment(
          'arcprize.org',
          'https://arcprize.org/blog/which-ai-reasoning-model-is-best#:~:text=stack%20these%20methods%20but%20efficiency,as%20a%20consistent%20measuring%20stick',
        ),
        TextSegment(
          'Our work contributes one such idea: a clean DSL and GA framework that could be extended with neural guidance.',
        ),
        ImageSegment('assets/images/arc-agi-reasoning.png'),
      ]),
    ],
  ),
  SectionInfo(
    title: 'Discussion',
    contentBlocks: [
      ParagraphContent([
        TextSegment(
          ' Our results confirm that the ARC is extremely hard for machines. The fact that a straightforward DSL+GA solves only examples with good DSL coverage, while machines like GPT-4 fail on most tasks, highlights the gap. We learned several lessons:',
        ),
      ]),
      ListContent([
        [
          BoldSegment('Expressiveness vs. Efficiency: '),
          TextSegment(
            'Designing the DSL is critical. It must be expressive enough to encode solutions, yet constrained to keep search tractable. Fischer et al. mention this trade-off. Our chosen primitives covered some patterns but not others; expanding the DSL (e.g. adding loops or memory) could increase coverage at the cost of search complexity',
          ),
        ],
        [
          BoldSegment('Importance of Fitness Functions: '),
          TextSegment(
            'Our GA used multiple scoring metrics. Designing good fitness (distance to target) was crucial. Poor fitness leads to misleading gradients. For future work, more sophisticated fitness (e.g. considering shapes, symmetries) could guide the search better.',
          ),
        ],
        [
          BoldSegment('Metaphor Reflection: '),
          TextSegment(
            'Our “infinite monkey” analogy holds: without strong biases, random search (monkeys) yields almost no solutions.',
          ),
          LinkSegment(
            'ceur-ws.org',
            'https://ceur-ws.org/Vol-2738/LWDA2020_paper_8.pdf#:~:text=We%20first%20evaluate%20our%20method,Moreover%2C%20there%20is%20no%20information',
          ),
          TextSegment(
            'The DSL+GA adds structure (like giving the monkeys a partial keyboard to type meaningful code). But even then, the monkeys need many generations to write a Shakespeare (ARC solution).',
          ),
        ],
        [
          BoldSegment('Comparisons: '),
          TextSegment(
            'The dramatic difference between symbolic and neural results is telling. Specialized LLMs with training on ARC-like data can solve many tasks, but they act as black boxes. Our approach is fully interpretable (every solved task yields an explicit program). In a sense, our programs explain their reasoning steps, unlike opaque LLM outputs.',
          ),
        ],
        [
          BoldSegment('Future Hybrid Approaches: '),
          TextSegment(
            'François Chollet suggests the promise lies in combining symbolic search with neural priors.',
          ),
          LinkSegment('arcprize.org', 'https://arcprize.org/guide'),
          TextSegment(
            'Our framework could serve as the symbolic core of such a hybrid. For example, a neural net could predict which primitives to try first (guiding mutations), or suggest program sketches that our GA refines. This is aligned with vision: “augment discrete program search with deep learning intuition”.',
          ),
          LinkSegment('arcprize.org', 'https://arcprize.org/guide'),
        ],
      ]),
      ParagraphContent([
        TextSegment(
          'In summary, our work builds on prior DSL ideas and highlights both their potential and limitations. It underscores that without learning from data (as o3 does), reaching high ARC accuracy remains unlikely. Nevertheless, symbolic methods like DSL+GA remain valuable for understanding task structure and preserving transparency.',
        ),
      ]),
    ],
  ),

  SectionInfo(
    title: 'Conclusion',
    contentBlocks: [
      ParagraphContent([
        TextSegment('We have presented a'),
        BoldSegment(' DSL-based program synthesis '),
        TextSegment(
          'approach to ARC tasks, along with a simple GA to search for solutions. We detailed the DSL primitives, GA procedure, and code implementation. Through an example, we showed the method can discover correct programs for suitable tasks. We placed our results in the context of existing literature: prior DSL/GA systems solved only a few percent of tasks, while top LLM-based systems now achieve ~75%. This gap illustrates that ARC remains a formidable benchmark. Our work contributes to the symbolic end of the spectrum, offering an interpretable but limited solution method.',
        ),
      ]),
      ParagraphContent([
        TextSegment(
          'Future work includes extending the DSL (adding functions like loops, conditional filters), improving the GA (crossover, neural-guided mutations), and integrating learning (as in DreamCoder). We also note the importance of academic benchmarks: recently ARC-AGI-2 was introduced to further challenge models, emphasizing tasks “intuitively easy for humans but hard for AI”.',
        ),
        LinkSegment(
          'arize.com',
          'https://arize.com/blog/ai-benchmark-deep-dive-gemini-humanitys-last-exam/#:~:text=solving%20based%20on%20visual%20cues,intriguing%20debate%20about%20which%20types',
        ),
      ]),
      ParagraphContent([
        TextSegment(
          'We look forward to testing our approach on new tasks and comparing with emerging baselines. Ultimately, bridging the gap to human performance (100% on ARC tasks) will likely require hybrid systems combining our kind of program search with powerful learning models. We hope our thorough description of the DSL and GA will aid others in that endeavor.',
        ),
      ]),
    ],
  ),

  SectionInfo(
    title: 'References',
    contentBlocks: [
      ParagraphContent([
        TextSegment(
          '[1] R. Fischer, M. Jakobs, S. Mücke, and K. Morik, “Solving Abstract Reasoning Tasks with Grammatical Evolution,” Proc. of LWDA 2020, CEUR Workshop Proceedings, vol. 2738, 2020.',
        ),
      ]),
      ParagraphContent([
        TextSegment(
          '[2] Y. Xu, W. Li, P. Vaezipoor, S. Sanner, and E. B. Khalil, “LLMs and the Abstraction and Reasoning Corpus: Successes, Failures, and the Importance of Object-based Representations,” Trans. Mach. Learn. Res., vol. 4, 2024 (arXiv:2305.18354).',
        ),
      ]),
      ParagraphContent([
        TextSegment(
          '[3] F. Chollet, “OpenAI o3 Breakthrough High Score on ARC-AGI-Pub,” ARC Prize Blog, Dec. 2024 (https://arcprize.org/blog/oai-o3-pub-breakthrough).',
        ),
      ]),
      ParagraphContent([
        TextSegment(
          '[4] F. Chollet, “We tested every major AI reasoning system. There is no clear winner,” ARC Prize Blog, Apr. 2025 (https://arcprize.org/blog/which-ai-reasoning-model-is-best)',
        ),
      ]),
      ParagraphContent([
        TextSegment(
          '[5] M. Bober-Irizar and S. Banerjee, “Neural networks for abstraction and reasoning: Towards broad generalization in machines,” Sci. Rep., vol. 14, 27823, Nov. 2024.',
        ),
      ]),
      ParagraphContent([
        TextSegment(
          '[6] F. Chollet (Ed.), ARC Prize Official Guide, https://arcprize.org/guide (accessed 2025).',
        ),
      ]),
    ],
  ),
];
