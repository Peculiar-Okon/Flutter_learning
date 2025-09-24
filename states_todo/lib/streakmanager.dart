import 'package:shared_preferences/shared_preferences.dart';

class StreakManager {
  static const _currentStreakKey = "current_streak";
  static const _lastCompletionDateKey = "last_completion_date";
  static const _bestStreakKey = "best_streak";

  static Future<void> updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();

    final lastDateStr = prefs.getString(_lastCompletionDateKey);
    final lastDate = lastDateStr != null ? DateTime.parse(lastDateStr) : null;
    int currentStreak = prefs.getInt(_currentStreakKey) ?? 0;
    int bestStreak = prefs.getInt(_bestStreakKey) ?? 0;

    if (lastDate == null) {
      // First ever completion
      currentStreak = 1;
    } else {
      final difference = today.difference(lastDate).inDays;

      if (difference == 1) {
        // Continued streak
        currentStreak++;
      } else if (difference > 1) {
        // Missed a day → reset streak
        currentStreak = 1;
      } 
      // if difference == 0, same day → don’t increase streak
    }

    // Update best streak
    if (currentStreak > bestStreak) {
      bestStreak = currentStreak;
    }

    // Save values
    await prefs.setInt(_currentStreakKey, currentStreak);
    await prefs.setInt(_bestStreakKey, bestStreak);
    await prefs.setString(_lastCompletionDateKey, today.toIso8601String());
  }

  static Future<int> getCurrentStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_currentStreakKey) ?? 0;
  }

  static Future<int> getBestStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_bestStreakKey) ?? 0;
  }
}
