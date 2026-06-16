import 'package:flutter/material.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  final List<Map<String, dynamic>> _students = [
    {
      'name': 'Budi Santoso',
      'nim': 'S2-2024-001',
      'points': 45,
      'active': true,
      'avatar': 'assets/pixel_avatar_1.png',
    },
    {
      'name': 'Siti Rahayu',
      'nim': 'S2-2024-002',
      'points': 78,
      'active': true,
      'avatar': 'assets/pixel_avatar_2.png',
    },
    {
      'name': 'Agus Wijaya',
      'nim': 'S2-2024-003',
      'points': 92,
      'active': false,
      'avatar': 'assets/pixel_avatar_3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.purple.shade900.withOpacity(0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildStatsCard(context),
                      const SizedBox(height: 20),
                      _buildStudentList(context),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.purple.shade300,
            width: 2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.admin_panel_settings,
                color: Colors.purple,
                size: 30,
              ),
              const SizedBox(width: 8),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.purple, Colors.cyan],
                ).createShader(bounds),
                child: const Text(
                  'ADMIN DASHBOARD',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    final activeStudents = _students.where((s) => s['active'] == true).length;
    final totalPoints = _students.fold<int>(
      0,
      (sum, student) => sum + (student['points'] as int),
    );
    final avgPoints = _students.isEmpty ? 0 : totalPoints ~/ _students.length;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('👥', 'Total', _students.length.toString()),
            _buildStatItem('✅', 'Active', activeStudents.toString()),
            _buildStatItem('📊', 'Avg Points', avgPoints.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String icon, String label, String value) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildStudentList(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '📋 STUDENT MANAGEMENT',
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showAddStudentDialog,
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add Student'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return _buildStudentTile(context, student, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentTile(BuildContext context, Map<String, dynamic> student, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade800,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: student['active'] == true
            ? Colors.green.shade900.withOpacity(0.1)
            : Colors.red.shade900.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.cyan.shade300),
              image: DecorationImage(
                image: AssetImage(student['avatar']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  student['nim'],
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.cyan.shade900.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${student['points']} pts',
              style: const TextStyle(color: Colors.cyan, fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              student['active'] == true
                  ? Icons.check_circle
                  : Icons.cancel,
              color: student['active'] == true ? Colors.green : Colors.red,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                student['active'] = !student['active'];
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${student['name']} ${student['active'] == true ? 'activated' : 'deactivated'}',
                  ),
                  backgroundColor: student['active'] == true ? Colors.green : Colors.red,
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red, size: 20),
            onPressed: () {
              _showDeleteConfirmation(context, index);
            },
          ),
        ],
      ),
    );
  }

  void _showAddStudentDialog() {
    final nameController = TextEditingController();
    final nimController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          'Add New Student',
          style: TextStyle(color: Colors.cyan),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(color: Colors.cyan.shade300),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan.shade300),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: nimController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'NIM',
                labelStyle: TextStyle(color: Colors.cyan.shade300),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan.shade300),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && nimController.text.isNotEmpty) {
                setState(() {
                  _students.add({
                    'name': nameController.text,
                    'nim': nimController.text,
                    'points': 0,
                    'active': true,
                    'avatar': 'assets/pixel_avatar_1.png',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Student added successfully!')),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Add', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          'Delete Student',
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
          'Are you sure you want to delete ${_students[index]['name']}?',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _students.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Student deleted!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}