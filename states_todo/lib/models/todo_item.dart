// import '../view.dart';
// // lib/models/todo_item.dart
// enum Priority { low, medium, high }

// extension PriorityExtention on Priority{
//     String getPriorityText() {
//     switch (this) {
//       case Priority.low:
//         return 'Low';
//       case Priority.medium:
//         return 'Medium';
//       case Priority.high:
//         return 'High';
//     }
//   }

//     Color getPriorityColor() {
//     switch (this) {
//       case Priority.low:
//         return Colors.green;
//       case Priority.medium:
//         return Colors.orange;
//       case Priority.high:
//         return Colors.red;
//     }
//   }
// }

// class TodoItem {
//   String id;
//   String title;
//   String? description;
//   bool isCompleted;
//   Priority priority;
//   DateTime createdAt;
//   DateTime? completedAt;
//   DateTime? dueDate;
//   String category;

  
//   TodoItem({
//     required this.id,
//     required this.title,
//     this.description,
//     this.isCompleted = false,
//     this.priority = Priority.medium,
//     required this.createdAt,
//     this.completedAt,
//     this.dueDate,
//     this.category = 'All', 
//   });
  
//   // Convert to JSON for storage
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'isCompleted': isCompleted,
//       'priority': priority.index,
//       'createdAt': createdAt.toIso8601String(),
//       'completedAt': completedAt?.toIso8601String(),
//       'category': category
//     };
//   }
  
//   // Create from JSON
//   factory TodoItem.fromJson(Map<String, dynamic> json) {
//     return TodoItem(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       isCompleted: json['isCompleted'] ?? false,
//       priority: Priority.values[json['priority'] ?? 1],
//       createdAt: DateTime.parse(json['createdAt']),
//       completedAt: json['completedAt'] != null 
//           ? DateTime.parse(json['completedAt']) 
//           : null,
//       category: json['category'] ?? 'General',
//     );
//   }
  
//   // Toggle completion status
//   void toggleCompletion() {
//     isCompleted = !isCompleted;
//     completedAt = isCompleted ? DateTime.now() : null;
//   }
  
//   // Get priority color
//   Color getPriorityColor() {
//     switch (priority) {
//       case Priority.low:
//         return Colors.green;
//       case Priority.medium:
//         return Colors.orange;
//       case Priority.high:
//         return Colors.red;
//     }
//   }
  
//   // Get priority text
//   String getPriorityText() {
//     switch (priority) {
//       case Priority.low:
//         return 'Low';
//       case Priority.medium:
//         return 'Medium';
//       case Priority.high:
//         return 'High';
//     }
//   }
// }

import 'dart:convert';
import '../view.dart';

// lib/models/todo_item.dart
enum Priority { low, medium, high }

extension PriorityExtension on Priority {
  String getPriorityText() {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
    }
  }

  Color getPriorityColor() {
    switch (this) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.orange;
      case Priority.high:
        return Colors.red;
    }
  }
}

class TodoItem {
  String id;
  String title;
  String? description;
  bool isCompleted;
  Priority priority;
  DateTime createdAt;
  DateTime? completedAt;
  DateTime? dueDate;
  String category;

  TodoItem({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    this.priority = Priority.medium,
    required this.createdAt,
    this.completedAt,
    this.dueDate,
    this.category = 'All',
  });

  // Convert to Map for JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'priority': priority.index, // store as int
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'category': category,
    };
  }

  // Create from JSON
  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'] ?? false,
      priority: Priority.values[json['priority'] ?? 1],
      createdAt: DateTime.parse(json['createdAt']),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      dueDate:
          json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      category: json['category'] ?? 'General',
    );
  }

  // Convert TodoItem to JSON string (for SharedPreferences)
  String encode() => jsonEncode(toJson());

  // Decode JSON string back into TodoItem
  static TodoItem decode(String todoString) =>
      TodoItem.fromJson(jsonDecode(todoString));

  // Toggle completion status
  void toggleCompletion() {
    isCompleted = !isCompleted;
    completedAt = isCompleted ? DateTime.now() : null;
  }

  // Get priority color
  Color getPriorityColor() {
    switch (priority) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.orange;
      case Priority.high:
        return Colors.red;
    }
  }

  // Get priority text
  String getPriorityText() {
    switch (priority) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
    }
  }
}
