import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Master',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        fontFamily: 'Segoe UI',
      ),
      home: const QuizHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==================== MODELS ====================

class Question {
  final int id;
  final String question;
  final List<String> options;
  final int correctAnswer; // index of correct option
  final String category;
  final String difficulty;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.category,
    required this.difficulty,
  });
}

class Quiz {
  final int id;
  final String title;
  final String description;
  final String category;
  final int totalQuestions;
  final int duration; // in minutes
  final String difficulty;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.totalQuestions,
    required this.duration,
    required this.difficulty,
    required this.questions,
  });
}

// ==================== HOME SCREEN ====================
class QuizHomeScreen extends StatelessWidget {
  const QuizHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizzes = _getQuizzes();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with gradient
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF030642),
                      Color(0xFF352FC6),
                      Color(0xFFF8E1E1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Quiz Master',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Test your knowledge',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Quiz List
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) {
                final quiz = quizzes[index];
                return _buildQuizCard(context, quiz);
              }, childCount: quizzes.length),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCard(BuildContext context,
      Quiz quiz) {
    Color difficultyColor;
    switch (quiz.difficulty) {
      case 'Easy':
        difficultyColor = Colors.green;
        break;
      case 'Medium':
        difficultyColor = Colors.orange;
        break;
      case 'Hard':
        difficultyColor = Colors.red;
        break;
      default:
        difficultyColor = Colors.blue;
    }
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      QuizScreen(quiz: quiz)),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            quiz.description,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.quiz,
                        color: Color(0xFF6366F1),
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildInfoChip(
                      Icons.help_outline,
                      '${quiz.totalQuestions} Questions',
                    ),
                    const SizedBox(width: 12),
                    _buildInfoChip(
                      Icons.timer_outlined,
                      '${quiz.duration} mins',
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: difficultyColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        quiz.difficulty,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: difficultyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }

  List<Quiz> _getQuizzes() {
    return [
      Quiz(
        id: 1,
        title: 'Flutter Basics',
        description:
            'Test your knowledge of '
            'Flutter fundamentals',
        category: 'Programming',
        totalQuestions: 10,
        duration: 5,
        difficulty: 'Easy',
        questions: _getFlutterQuestions(),
      ),
      Quiz(
        id: 2,
        title: 'Dart Programming',
        description: 'Master Dart language concepts',
        category: 'Programming',
        totalQuestions: 10,
        duration: 8,
        difficulty: 'Medium',
        questions: _getDartQuestions(),
      ),
      Quiz(
        id: 3,
        title: 'General Knowledge',
        description: 'Expand your general knowledge',
        category: 'General',
        totalQuestions: 10,
        duration: 10,
        difficulty: 'Hard',
        questions: _getGeneralQuestions(),
      ),
    ];
  }

  List<Question> _getFlutterQuestions() {
    return [
      Question(
        id: 1,
        question: 'What is Flutter?',
        options: [
          'A web framework',
          'A mobile app framework',
          'A programming language',
          'A database',
        ],
        correctAnswer: 1,
        category: 'Flutter',
        difficulty: 'Easy',
      ),
      Question(
        id: 2,
        question: 'Which widget is the root of a Flutter app?',
        options: [
          'Container',
          'MaterialApp',
          'Scaffold',
          'Center'],
        correctAnswer: 1,
        category: 'Flutter',
        difficulty: 'Easy',
      ),
      Question(
        id: 3,
        question: 'What does setState do?',
        options: [
          'Updates the UI',
          'Creates a new state',
          'Deletes the widget',
          'None of above',
        ],
        correctAnswer: 0,
        category: 'Flutter',
        difficulty: 'Easy',
      ),
      Question(
        id: 4,
        question: 'Hot reload is a feature of Flutter?',
        options: ['True', 'False',
          'Sometimes', 'Not sure'],
        correctAnswer: 0,
        category: 'Flutter',
        difficulty: 'Easy',
      ),
      Question(
        id: 5,
        question: 'Which layout widget is '
            'used for rows?',
        options: ['Column', 'Row', 'Stack', 'Grid'],
        correctAnswer: 1,
        category: 'Flutter',
        difficulty: 'Easy',
      ),
      Question(
        id: 6,
        question: 'What is a StatelessWidget?',
        options: [
          'A widget that changes',
          'A widget that does not change',
          'A widget with state',
          'A deprecated widget',
        ],
        correctAnswer: 1,
        category: 'Flutter',
        difficulty: 'Easy',
      ),
      Question(
        id: 7,
        question: 'Flutter uses which programming'
            ' language?',
        options: ['Java', 'Kotlin', 'Dart', 'Swift'],
        correctAnswer: 2,
        category: 'Flutter',
        difficulty: 'Easy',
      ),
      Question(
        id: 8,
        question: 'What is the purpose of Scaffold?',
        options: [
          'Provides Material design layout',
          'Creates a new screen',
          'Manages state',
          'All of above',
        ],
        correctAnswer: 0,
        category: 'Flutter',
        difficulty: 'Easy',
      ),
      Question(
        id: 9,
        question: 'Which widget is used for scrolling?',
        options: ['Column', 'ListView', 'Row', 'Container'],
        correctAnswer: 1,
        category: 'Flutter',
        difficulty: 'Easy',
      ),
      Question(
        id: 10,
        question: 'PageView is used for?',
        options: [
          'Horizontal scrolling',
          'Vertical scrolling',
          'Both',
          'Neither',
        ],
        correctAnswer: 2,
        category: 'Flutter',
        difficulty: 'Easy',
      ),
    ];
  }

  List<Question> _getDartQuestions() {
    return [
      Question(
        id: 1,
        question: 'Dart is a statically typed language?',
        options: ['True', 'False',
          'Partially', 'Not sure'],
        correctAnswer: 0,
        category: 'Dart',
        difficulty: 'Medium',
      ),
      Question(
        id: 2,
        question: 'What is a Future in Dart?',
        options: ['A variable','Represents async value',
          'A class', 'A function',
        ],
        correctAnswer: 1,
        category: 'Dart',
        difficulty: 'Medium',
      ),
      Question(
        id: 3,
        question: 'Dart supports null safety?',
        options: ['Yes', 'No', 'Only in 2.12+', 'Only in 3.0'],
        correctAnswer: 0,
        category: 'Dart',
        difficulty: 'Medium',
      ),
      Question(
        id: 4,
        question: 'What is async/await?',
        options: [
          'Synchronous operations',
          'Asynchronous operations',
          'Widget building',
          'State management',
        ],
        correctAnswer: 1,
        category: 'Dart',
        difficulty: 'Medium',
      ),
      Question(
        id: 5,
        question: 'Dart supports inheritance?',
        options: ['Yes', 'No', 'Only single', 'Only multiple'],
        correctAnswer: 2,
        category: 'Dart',
        difficulty: 'Medium',
      ),
      Question(
        id: 6,
        question: 'What is a Stream in Dart?',
        options: [
          'A sequence of async events',
          'A list',
          'A function',
          'A class',
        ],
        correctAnswer: 0,
        category: 'Dart',
        difficulty: 'Medium',
      ),
      Question(
        id: 7,
        question: 'Dart uses garbage collection?',
        options: ['Yes', 'No', 'Optional', 'Manual only'],
        correctAnswer: 0,
        category: 'Dart',
        difficulty: 'Medium',
      ),
      Question(
        id: 8,
        question: 'What is const in Dart?',
        options: [
          'Compile-time constant',
          'Runtime constant',
          'Variable',
          'Keyword',
        ],
        correctAnswer: 0,
        category: 'Dart',
        difficulty: 'Medium',
      ),
      Question(
        id: 9,
        question: 'Dart supports mixins?',
        options: ['Yes', 'No', 'Partially', 'Not in 3.0'],
        correctAnswer: 0,
        category: 'Dart',
        difficulty: 'Medium',
      ),
      Question(
        id: 10,
        question: 'What is null coalescing operator?',
        options: ['??', '?.', '!=', '=='],
        correctAnswer: 0,
        category: 'Dart',
        difficulty: 'Medium',
      ),
    ];
  }

  List<Question> _getGeneralQuestions() {
    return [
      Question(
        id: 1,
        question: 'What is the capital of France?',
        options: ['London', 'Berlin', 'Paris', 'Madrid'],
        correctAnswer: 2,
        category: 'Geography',
        difficulty: 'Hard',
      ),
      Question(
        id: 2,
        question: 'Which planet is closest to the sun?',
        options: ['Venus', 'Mercury', 'Earth', 'Mars'],
        correctAnswer: 1,
        category: 'Science',
        difficulty: 'Hard',
      ),
      Question(
        id: 3,
        question: 'Who wrote Romeo and Juliet?',
        options: [
          'Mark Twain',
          'Shakespeare',
          'Jane Austen',
          'Charles Dickens',
        ],
        correctAnswer: 1,
        category: 'Literature',
        difficulty: 'Hard',
      ),
      Question(
        id: 4,
        question: 'What is the largest ocean?',
        options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
        correctAnswer: 3,
        category: 'Geography',
        difficulty: 'Hard',
      ),
      Question(
        id: 5,
        question: 'How many continents are there?',
        options: ['5', '6', '7', '8'],
        correctAnswer: 2,
        category: 'Geography',
        difficulty: 'Hard',
      ),
      Question(
        id: 6,
        question: 'What is the chemical symbol for Gold?',
        options: ['Go', 'Gd', 'Au', 'Ag'],
        correctAnswer: 2,
        category: 'Science',
        difficulty: 'Hard',
      ),
      Question(
        id: 7,
        question: 'Who painted the Mona Lisa?',
        options: ['Michelangelo', 'Leonardo da Vinci', 'Raphael', 'Donatello'],
        correctAnswer: 1,
        category: 'Art',
        difficulty: 'Hard',
      ),
      Question(
        id: 8,
        question: 'What is the smallest country in the world?',
        options: ['Monaco', 'Vatican City', 'San Marino', 'Liechtenstein'],
        correctAnswer: 1,
        category: 'Geography',
        difficulty: 'Hard',
      ),
      Question(
        id: 9,
        question: 'How many sides does a hexagon have?',
        options: ['4', '5', '6', '7'],
        correctAnswer: 2,
        category: 'Math',
        difficulty: 'Hard',
      ),
      Question(
        id: 10,
        question: 'What is the speed of light?',
        options: [
          '300,000 km/s',
          '150,000 km/s',
          '450,000 km/s',
          '600,000 km/s',
        ],
        correctAnswer: 0,
        category: 'Science',
        difficulty: 'Hard',
      ),
    ];
  }
}

// ==================== QUIZ SCREEN WITH PAGEVIEW ====================

class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  const QuizScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  late List<int?> _selectedAnswers;
  int _score = 0;
  bool _quizCompleted = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _selectedAnswers = List<int?>
        .filled(widget.quiz.questions.length,
          null);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _selectedAnswers[_currentIndex] = answerIndex;
    });
  }

  void _nextQuestion() {
    if (_currentIndex
         < widget.quiz.questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeQuiz();
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeQuiz() {
    // Calculate score
    _score = 0;
    for (int i = 0; i < widget.quiz.questions.length; i++) {
      if (_selectedAnswers[i] == widget.quiz.questions[i].correctAnswer) {
        _score++;
      }
    }
    setState(() {
      _quizCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_quizCompleted) {
      return ResultsScreen(
        quiz: widget.quiz,
        score: _score,
        totalQuestions: widget.quiz.questions.length,
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        title: Text(widget.quiz.title),
      ),
      body: Column(
        children: [
          // Progress bar
          Container(
            color: const Color(0xFF6366F1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentIndex + 1} of ${widget.quiz.questions.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${((_currentIndex + 1) / widget.quiz.questions.length * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (_currentIndex + 1) / widget.quiz.questions.length,
                    minHeight: 10,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // PageView with questions
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.quiz.questions.length,
              itemBuilder: (context, index) {
                final question = widget.quiz.questions[index];
                return QuestionCard(
                  question: question,
                  selectedAnswer: _selectedAnswers[index],
                  onSelectAnswer: _selectAnswer,
                );
              },
            ),
          ),

          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentIndex > 0
                        ? _previousQuestion : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.grey[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Previous'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                    _selectedAnswers[_currentIndex] != null
                        ? _nextQuestion
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        _currentIndex == widget.quiz.questions.length - 1
                            ? 'Submit'
                            : 'Next',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== QUESTION CARD ====================

class QuestionCard extends StatelessWidget {
  final Question question;
  final int? selectedAnswer;
  final Function(int) onSelectAnswer;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.selectedAnswer,
    required this.onSelectAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question text
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              question.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Options
          const Text(
            'Select an answer',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: question.options.length,
            itemBuilder: (context, index) {
              return _buildOptionButton(
                context,
                index,
                question.options[index],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, int index, String option) {
    final isSelected = selectedAnswer == index;

    return GestureDetector(
      onTap: () => onSelectAnswer(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6366F1) : Colors.white,
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6366F1)
                : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? [
                  BoxShadow(
                    color: const Color(0xFF00010E).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ?
                Colors.white : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? Colors.white
                      : Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16,
                  color: Color(0xFF6366F1))
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ?
                  Colors.white : const Color(0xFF1F2937),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== RESULTS SCREEN ====================

class ResultsScreen extends StatelessWidget {
  final Quiz quiz;
  final int score;
  final int totalQuestions;

  const ResultsScreen({
    Key? key,
    required this.quiz,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage =
    (score / totalQuestions * 100).toStringAsFixed(1);
    final isPassed =
        score >= totalQuestions * 0.6; // 60% is passing

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        title: const Text('Quiz Results'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // Result indicator
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPassed
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  border: Border.all(
                    color: isPassed ?
                    Colors.green : Colors.red,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Icon(
                    isPassed ?
                    Icons.check_circle : Icons.cancel,
                    size: 80,
                    color: isPassed ? Colors.green : Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Score text
              Text(
                isPassed ? 'Congratulations!' : 'Good Try!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isPassed
                    ? 'You passed the quiz!'
                    : 'You need to score 60% to pass',
                style: TextStyle(fontSize: 16,
                    color: Colors.grey[600]),
              ),
              const SizedBox(height: 48),

              // Score card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFA4A5EF),
                        const Color(0xFFFFFFFF),
                        const Color(0xFF2529AF),
                      ],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Your Score',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$score / $totalQuestions',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$percentage%',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // Performance breakdown
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Performance Summary',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPerformanceRow('Quiz Title', quiz.title, Icons.quiz),
                    const SizedBox(height: 12),
                    _buildPerformanceRow(
                      'Category',
                      quiz.category,
                      Icons.category,
                    ),
                    const SizedBox(height: 12),
                    _buildPerformanceRow(
                      'Difficulty',
                      quiz.difficulty,
                      Icons.trending_up,
                    ),
                    const SizedBox(height: 12),
                    _buildPerformanceRow(
                      'Correct Answers',
                      '$score/$totalQuestions',
                      Icons.check_circle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // Action buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  //Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: Color(0xFF6366F1), width: 2),
                ),
                child: const Text(
                  'Retake Quiz',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6366F1),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerformanceRow(
      String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF6366F1), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
