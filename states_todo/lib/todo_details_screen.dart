
// import 'view.dart';
// import 'package:intl/intl.dart';

// class TodoDetailsScreen extends StatefulWidget {
//   final TodoItem todo;

//   const TodoDetailsScreen({super.key, required this.todo});

//   @override
//   _TodoDetailsScreenState createState() => _TodoDetailsScreenState();
// }

// class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
//   late TodoItem _currentTodo;

//   @override
//   void initState() {
//     super.initState();
//     _currentTodo = widget.todo;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pop(context, _currentTodo);
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Todo Details"),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.edit),
//               onPressed: () async {
//                 final updatedTodo = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => AddTodoScreen(todo: _currentTodo),
//                   ),
//                 );
//                 if (updatedTodo != null && updatedTodo is TodoItem) {
//                   setState(() {
//                     _currentTodo = updatedTodo;
//                   });
//                 }
//               },
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 _currentTodo.title,
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   decoration: _currentTodo.isCompleted ? TextDecoration.lineThrough : null,
//                   color: _currentTodo.isCompleted
//                       ? Colors.grey
//                       : isDark
//                           ? Colors.white
//                           : Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               if (_currentTodo.description != null && _currentTodo.description!.isNotEmpty)
//                 Text(
//                   _currentTodo.description!,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: isDark ? Colors.white70 : Colors.black87,
//                   ),
//                 ),
//               const SizedBox(height: 16),
//               Text(
//                 "Created: ${DateFormat.yMMMd().add_jm().format(_currentTodo.createdAt)}",
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: isDark ? Colors.grey[400] : Colors.grey[600],
//                 ),
//               ),
//               if (_currentTodo.dueDate != null) ...[
//                 const SizedBox(height: 8),
//                 Text(
//                   "Due: ${DateFormat.yMMMd().format(_currentTodo.dueDate!)}",
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//               if (_currentTodo.completedAt != null) ...[
//                 const SizedBox(height: 8),
//                 Text(
//                   "Completed: ${DateFormat.yMMMd().add_jm().format(_currentTodo.completedAt!)}",
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.green,
//                   ),
//                 ),
//               ],
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.pop(context, _currentTodo);
//                     },
//                     icon: const Icon(Icons.arrow_back),
//                     label: const Text("Back"),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'view.dart';
import 'package:intl/intl.dart';

class TodoDetailsScreen extends StatefulWidget {
  final TodoItem todo;

  const TodoDetailsScreen({super.key, required this.todo});

  @override
  _TodoDetailsScreenState createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  late TodoItem _currentTodo;

  @override
  void initState() {
    super.initState();
    _currentTodo = widget.todo;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      onWillPop: () async {
        Navigator.pop(context, _currentTodo);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Todo Details"),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final updatedTodo = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTodoScreen(todo: _currentTodo),
                  ),
                );
                if (updatedTodo != null && updatedTodo is TodoItem) {
                  setState(() {
                    _currentTodo = updatedTodo;
                  });
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                _currentTodo.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  decoration: _currentTodo.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                  color: _currentTodo.isCompleted
                      ? Colors.grey
                      : isDark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // 👇 Show priority with color
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              //   decoration: BoxDecoration(
              //     color: _currentTodo.getPriorityColor().withOpacity(0.15),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Text(
              //     _currentTodo.getPriorityText(),
              //     style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.bold,
              //       color: _currentTodo.getPriorityColor(),
              //     ),
              //   ),
              // ),

Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    const Text(
      "Priority: ",
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black, // or Theme.of(context).textTheme.bodyMedium?.color
      ),
    ),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _currentTodo.getPriorityColor().withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _currentTodo.getPriorityText(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _currentTodo.getPriorityColor(),
        ),
      ),
    ),
  ],
),



              const SizedBox(height: 12),
              if (_currentTodo.description != null &&
                  _currentTodo.description!.isNotEmpty)
                Text(
                  _currentTodo.description!,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                "Created: ${DateFormat.yMMMd().add_jm().format(_currentTodo.createdAt)}",
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              if (_currentTodo.dueDate != null) ...[
                const SizedBox(height: 8),
                Text(
                  "Due: ${DateFormat.yMMMd().format(_currentTodo.dueDate!)}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              ],
              if (_currentTodo.completedAt != null) ...[
                const SizedBox(height: 8),
                Text(
                  "Completed: ${DateFormat.yMMMd().add_jm().format(_currentTodo.completedAt!)}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
