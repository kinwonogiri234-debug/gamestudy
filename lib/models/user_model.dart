import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String? _username;
  String? _avatarPath;
  int _points = 0;
  int _journalScore = 0;
  int _sintaScore = 0;
  int _thesisScore = 0;
  bool _isAdmin = false;
  bool _isActive = true;
  List<Map<String, dynamic>> _users = [];

  // Getters dengan default values dan error handling
  String get username => _username ?? 'Player';
  
  String get avatarPath {
    // Jika avatarPath null atau kosong, return default
    if (_avatarPath == null || _avatarPath!.isEmpty) {
      return 'assets/pixel_avatar_1.png';
    }
    return _avatarPath!;
  }
  
  int get points => _points;
  int get journalScore => _journalScore;
  int get sintaScore => _sintaScore;
  int get thesisScore => _thesisScore;
  bool get isAdmin => _isAdmin;
  bool get isActive => _isActive;
  List<Map<String, dynamic>> get users => _users;

  // Initialize user with default values
  void initializeUser() {
    _username = 'Player';
    _avatarPath = 'assets/pixel_avatar_1.png';
    _points = 0;
    _journalScore = 0;
    _sintaScore = 0;
    _thesisScore = 0;
    _isAdmin = false;
    _isActive = true;
    notifyListeners();
  }

  void setUser(String username, String avatar, bool admin) {
    _username = username;
    _avatarPath = avatar.isNotEmpty ? avatar : 'assets/pixel_avatar_1.png';
    _isAdmin = admin;
    _points = 0;
    _journalScore = 0;
    _sintaScore = 0;
    _thesisScore = 0;
    _isActive = true;
    notifyListeners();
  }

  void updateProfile(String newUsername, String newAvatar) {
    if (newUsername.isNotEmpty) {
      _username = newUsername;
    }
    if (newAvatar.isNotEmpty) {
      _avatarPath = newAvatar;
    }
    notifyListeners();
  }

  void addJournalScore(int value) {
    _journalScore += value;
    _points += value;
    if (_points > 100) _points = 100;
    notifyListeners();
  }

  void addSintaScore(int value) {
    _sintaScore += value;
    _points += value;
    if (_points > 100) _points = 100;
    notifyListeners();
  }

  void addThesisScore(int value) {
    _thesisScore += value;
    _points += value;
    if (_points > 100) _points = 100;
    notifyListeners();
  }

  void resetScores() {
    _points = 0;
    _journalScore = 0;
    _sintaScore = 0;
    _thesisScore = 0;
    notifyListeners();
  }

  void toggleActive() {
    _isActive = !_isActive;
    notifyListeners();
  }

  void setUsers(List<Map<String, dynamic>> users) {
    _users = users;
    notifyListeners();
  }

  void addUser(Map<String, dynamic> user) {
    _users.add(user);
    notifyListeners();
  }

  void removeUser(int index) {
    if (index >= 0 && index < _users.length) {
      _users.removeAt(index);
      notifyListeners();
    }
  }
}