import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _currentLevel = 1;
  final List<Map<String, dynamic>> _challenges = [
    {
      'title': '📚 Literature Review',
      'description': 'Complete comprehensive literature review',
      'points': 5,
      'completed': false,
    },
    {
      'title': '📄 Research Proposal',
      'description': 'Submit research proposal to supervisor',
      'points': 10,
      'completed': false,
    },
    {
      'title': '📊 Data Collection',
      'description': 'Collect and analyze research data',
      'points': 15,
      'completed': false,
    },
    {
      'title': '📑 Journal Publication',
      'description': 'Publish in Sinta accredited journal',
      'points': 20,
      'completed': false,
    },
    {
      'title': '🌍 International Journal',
      'description': 'Publish in international journal',
      'points': 25,
      'completed': false,
    },
    {
      'title': '🎓 Thesis Defense',
      'description': 'Complete thesis examination',
      'points': 25,
      'completed': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.cyan.shade900.withOpacity(0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, userModel),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildGameMap(context, userModel),
                      const SizedBox(height: 20),
                      _buildChallengesList(context, userModel),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserModel userModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.cyan.shade300,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.gamepad, color: Colors.cyan, size: 30),
              const SizedBox(width: 8),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.cyan, Colors.purple.shade300],
                ).createShader(bounds),
                child: const Text(
                  'GAME MODE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.cyan.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.withOpacity(0.3),
                          blurRadius: 10 * _animationController.value,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${userModel.points} pts',
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGameMap(BuildContext context, UserModel userModel) {
    return Card(
      elevation: 10,
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.cyan.shade300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🗺️ JOURNEY MAP',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  final isCompleted = index < _currentLevel;
                  final isCurrent = index == _currentLevel;
                  return _buildMapNode(index, isCompleted, isCurrent);
                },
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: _currentLevel / 6,
              backgroundColor: Colors.grey.shade800,
              color: Colors.cyan,
              minHeight: 8,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Level ${_currentLevel + 1} of 6',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  '${(_currentLevel / 6 * 100).toInt()}%',
                  style: const TextStyle(color: Colors.cyan, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapNode(int index, bool isCompleted, bool isCurrent) {
    final icons = ['🌱', '📝', '🔬', '📄', '🌍', '🎓'];
    final labels = ['Start', 'Proposal', 'Data', 'Journal', 'International', 'Thesis'];

    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 8),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isCompleted
                    ? Colors.green
                    : isCurrent
                        ? Colors.cyan
                        : Colors.grey.shade700,
                width: isCurrent ? 3 : 2,
              ),
              color: isCompleted
                  ? Colors.green.shade900
                  : isCurrent
                      ? Colors.cyan.shade900
                      : Colors.grey.shade900,
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: Colors.cyan.withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                icons[index],
                style: TextStyle(
                  fontSize: isCurrent ? 24 : 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            labels[index],
            style: TextStyle(
              color: isCompleted
                  ? Colors.green
                  : isCurrent
                      ? Colors.cyan
                      : Colors.grey,
              fontSize: 10,
            ),
          ),
          if (isCompleted)
            const Icon(Icons.check_circle, color: Colors.green, size: 14),
        ],
      ),
    );
  }

  Widget _buildChallengesList(BuildContext context, UserModel userModel) {
    return Card(
      elevation: 10,
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.purple.shade300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🎯 CHALLENGES',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),
            ..._challenges.map((challenge) => _buildChallengeItem(
                  context,
                  challenge,
                  userModel,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeItem(
    BuildContext context,
    Map<String, dynamic> challenge,
    UserModel userModel,
  ) {
    final isCompleted = challenge['completed'];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: isCompleted ? Colors.green.shade700 : Colors.grey.shade800,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isCompleted
            ? Colors.green.shade900.withOpacity(0.1)
            : Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge['title'],
                  style: TextStyle(
                    color: isCompleted ? Colors.green : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  challenge['description'],
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (!isCompleted)
            ElevatedButton(
              onPressed: () {
                _completeChallenge(context, challenge, userModel);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: Text(
                '+${challenge['points']} pts',
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          if (isCompleted)
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
        ],
      ),
    );
  }

  void _completeChallenge(
    BuildContext context,
    Map<String, dynamic> challenge,
    UserModel userModel,
  ) {
    setState(() {
      challenge['completed'] = true;
      _currentLevel = _challenges.where((c) => c['completed']).length;

      // Add points based on challenge type
      final title = challenge['title'];
      final points = challenge['points'] as int;

      if (title.contains('Journal')) {
        userModel.addJournalScore(points);
      } else if (title.contains('International')) {
        userModel.addSintaScore(points);
      } else if (title.contains('Thesis')) {
        userModel.addThesisScore(points);
      } else {
        userModel.addJournalScore(points);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '🎉 ${challenge['title']} completed! +${challenge['points']} points',
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }
}