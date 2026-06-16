import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class DashboardUser extends StatefulWidget {
  const DashboardUser({super.key});

  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  final List<String> _avatarOptions = [
    'assets/pixel_avatar_1.png',
    'assets/pixel_avatar_2.png',
    'assets/pixel_avatar_3.png',
  ];

  @override
  void initState() {
    super.initState();
    // Cek apakah userModel terinisialisasi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final userModel = Provider.of<UserModel>(context, listen: false);
        if (userModel.username.isEmpty) {
          // Jika username kosong, set default
          userModel.initializeUser();
        }
      } catch (e) {
        print('Error initializing user: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Gunakan Consumer untuk menghindari error
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
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
                          _buildProfileCard(context, userModel),
                          const SizedBox(height: 20),
                          _buildScoreCard(context, userModel),
                          const SizedBox(height: 20),
                          _buildAchievementCard(context, userModel),
                          const SizedBox(height: 20),
                          _buildActionButtons(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============ HEADER ============
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
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade900.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.cyan.shade300,
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.games,
                  color: Colors.cyan,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.cyan, Colors.purple.shade300],
                    ).createShader(bounds),
                    child: const Text(
                      'STUDY GAME',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    'Thesis Management',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.cyan.shade300,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan.shade900.withOpacity(0.3),
                      Colors.purple.shade900.withOpacity(0.3),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${userModel.points}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'pts',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.red.shade300,
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 22,
                  ),
                  onPressed: () {
                    _showLogoutConfirmation(context);
                  },
                  tooltip: 'Logout',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============ PROFILE CARD ============
  Widget _buildProfileCard(BuildContext context, UserModel userModel) {
    return Card(
      elevation: 15,
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.cyan.shade300,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.cyan.shade300,
                        Colors.purple.shade300,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      image: DecorationImage(
                        image: AssetImage(userModel.avatarPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.cyan.shade900,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.cyan.shade300,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.emoji_events,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Lv.${(userModel.points / 20).ceil()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              userModel.username,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.cyan.shade900.withOpacity(0.3),
                    Colors.purple.shade900.withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.cyan.shade300,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.5),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '🎯 Thesis Candidate',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Graduation Progress',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '${(userModel.points / 100 * 100).toInt()}%',
                            style: const TextStyle(
                              color: Colors.cyan,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: userModel.points / 100,
                          backgroundColor: Colors.grey.shade800,
                          color: Colors.cyan,
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============ SCORE CARD ============
  Widget _buildScoreCard(BuildContext context, UserModel userModel) {
    return Card(
      elevation: 15,
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.purple.shade300,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade900.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.scoreboard,
                    color: Colors.purple,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'SCOREBOARD',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade900.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Max: 100 pts',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildScoreItem(
              context,
              icon: '📄',
              title: 'Journal Publication',
              current: userModel.journalScore,
              max: 10,
              color: Colors.blue,
              description: 'Publish in national journal',
            ),
            const SizedBox(height: 12),
            _buildScoreItem(
              context,
              icon: '🌍',
              title: 'Sinta International',
              current: userModel.sintaScore,
              max: 20,
              color: Colors.green,
              description: 'Publish in Sinta accredited journal',
            ),
            const SizedBox(height: 12),
            _buildScoreItem(
              context,
              icon: '🎓',
              title: 'Thesis Exam',
              current: userModel.thesisScore,
              max: 50,
              color: Colors.amber,
              description: 'Complete thesis defense',
            ),
            const SizedBox(height: 16),
            Divider(
              color: Colors.grey.shade800,
              thickness: 1,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TOTAL SCORE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.cyan.shade900.withOpacity(0.3),
                        Colors.purple.shade900.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.cyan.shade300,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${userModel.points}',
                        style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' / 100',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreItem(
    BuildContext context, {
    required String icon,
    required String title,
    required int current,
    required int max,
    required Color color,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade800,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    icon,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '$current',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    ' / $max',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: current / max,
              backgroundColor: Colors.grey.shade800,
              color: color,
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  // ============ ACHIEVEMENT CARD ============
  Widget _buildAchievementCard(BuildContext context, UserModel userModel) {
    final achievements = [
      {
        'icon': '📄',
        'label': 'Journal',
        'unlocked': userModel.journalScore >= 10,
        'description': 'Publish journal article',
      },
      {
        'icon': '🌍',
        'label': 'Sinta',
        'unlocked': userModel.sintaScore >= 20,
        'description': 'Sinta international publication',
      },
      {
        'icon': '🎓',
        'label': 'Thesis',
        'unlocked': userModel.thesisScore >= 50,
        'description': 'Complete thesis exam',
      },
      {
        'icon': '⭐',
        'label': 'Graduate',
        'unlocked': userModel.points >= 100,
        'description': 'Complete all requirements',
      },
      {
        'icon': '🏆',
        'label': 'Perfect',
        'unlocked': userModel.points >= 80,
        'description': 'High achievement',
      },
    ];

    return Card(
      elevation: 15,
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.green.shade300,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade900.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'ACHIEVEMENTS',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade900.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${achievements.where((a) => a['unlocked'] == true).length}/${achievements.length}',
                    style: TextStyle(
                      color: Colors.green.shade300,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: achievements.map((achievement) {
                final isUnlocked = achievement['unlocked'] as bool;
                return _buildAchievementBadge(
                  icon: achievement['icon'] as String,
                  label: achievement['label'] as String,
                  unlocked: isUnlocked,
                  description: achievement['description'] as String,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementBadge({
    required String icon,
    required String label,
    required bool unlocked,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: unlocked ? Colors.green.shade300 : Colors.grey.shade700,
          width: unlocked ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(14),
        gradient: unlocked
            ? LinearGradient(
                colors: [
                  Colors.green.shade900.withOpacity(0.3),
                  Colors.green.shade700.withOpacity(0.1),
                ],
              )
            : null,
        color: unlocked ? null : Colors.grey.shade900.withOpacity(0.3),
        boxShadow: unlocked
            ? [
                BoxShadow(
                  color: Colors.green.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Text(
            icon,
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: unlocked ? Colors.green.shade300 : Colors.grey.shade500,
              fontWeight: unlocked ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
          if (unlocked)
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 14,
            ),
          if (!unlocked)
            Text(
              '🔒',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
        ],
      ),
    );
  }

  // ============ ACTION BUTTONS ============
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/game');
            },
            icon: const Icon(Icons.play_arrow, size: 20),
            label: const Text(
              'PLAY GAME',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
              shadowColor: Colors.cyan.withOpacity(0.3),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _showEditProfileDialog,
            icon: const Icon(Icons.edit, size: 20),
            label: const Text(
              'EDIT PROFILE',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
              shadowColor: Colors.purple.withOpacity(0.3),
            ),
          ),
        ),
      ],
    );
  }

  // ============ EDIT PROFILE DIALOG ============
  void _showEditProfileDialog() {
    final userModel = Provider.of<UserModel>(context, listen: false);
    final usernameController = TextEditingController(text: userModel.username);
    String selectedAvatar = userModel.avatarPath;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.cyan.shade300,
                  width: 2,
                ),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.cyan.shade900.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.cyan,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: 320,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.cyan.shade300,
                            Colors.purple.shade300,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyan.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                          image: DecorationImage(
                            image: AssetImage(selectedAvatar),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.cyan.shade300),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.cyan.shade300,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyan.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyan.shade100,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade900.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Select Avatar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: _avatarOptions.map((avatarPath) {
                        final isSelected = selectedAvatar == avatarPath;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAvatar = avatarPath;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected 
                                    ? Colors.cyan 
                                    : Colors.grey.shade700,
                                width: isSelected ? 3 : 2,
                              ),
                              boxShadow: isSelected ? [
                                BoxShadow(
                                  color: Colors.cyan.withOpacity(0.5),
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                ),
                              ] : null,
                              image: DecorationImage(
                                image: AssetImage(avatarPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: isSelected
                                ? Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Colors.cyan,
                                      size: 24,
                                    ),
                                  )
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (usernameController.text.isNotEmpty) {
                      userModel.updateProfile(
                        usernameController.text,
                        selectedAvatar,
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 8),
                              Text('✅ Profile updated successfully!'),
                            ],
                          ),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.warning, color: Colors.white),
                              SizedBox(width: 8),
                              Text('⚠️ Username cannot be empty'),
                            ],
                          ),
                          backgroundColor: Colors.orange,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ============ LOGOUT CONFIRMATION ============
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.red.shade300,
              width: 2,
            ),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.logout,
                color: Colors.red,
                size: 28,
              ),
              const SizedBox(width: 12),
              const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}