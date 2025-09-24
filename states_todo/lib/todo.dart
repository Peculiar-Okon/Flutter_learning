

// import 'view.dart';
// import 'package:intl/intl.dart';

// class TodoListScreen extends StatefulWidget {
//   final VoidCallback onThemeChanged; // ✅ fixed type
//   final bool isDarkMode;

//   const TodoListScreen({
//     super.key,
//     required this.onThemeChanged,
//     required this.isDarkMode,
//   });

//   @override
//   _TodoListScreenState createState() => _TodoListScreenState();
// }

// class _TodoListScreenState extends State<TodoListScreen> {
//   List<TodoItem> _todos = [];
//   String _filter = 'all';
//   String _categoryFilter = 'All';
//   bool _isSearching = false;
//   String _searchQuery = '';

//   final TextEditingController _searchController = TextEditingController();

//   // Added quotes list
//   final List<String> dailyQuotes = [
//     "Small progress each day adds up to big results.",
//     "Focus on being productive, not busy.",
//     "Your future is created by what you do today, not tomorrow.",
//     "Discipline is the bridge between goals and accomplishment.",
//     "Start where you are. Use what you have. Do what you can.",
//   ];

//   // Function to pick quote of the day
//   String getDailyQuote() {
//     final today = DateTime.now();
//     final index = today.day % dailyQuotes.length;
//     return dailyQuotes[index];
//   }

//   @override
//   void initState() {
//     super.initState();
//     _addSampleTodos();
//   }

//   void _addSampleTodos() {
//     setState(() {
//       _todos = [
//         TodoItem(
//           id: '1',
//           title: 'Learn Flutter Basics',
//           description: 'Complete the Flutter fundamentals course',
//           createdAt: DateTime.now().subtract(const Duration(days: 1)),
//           priority: Priority.high,
//         ),
//         TodoItem(
//           id: '2',
//           title: 'Build Todo App',
//           description: 'Create a functional todo application',
//           createdAt: DateTime.now(),
//           priority: Priority.medium,
//         ),
//         TodoItem(
//           id: '3',
//           title: 'Review Code',
//           description: 'Go through the completed exercises',
//           createdAt: DateTime.now(),
//           isCompleted: true,
//           completedAt: DateTime.now().subtract(const Duration(hours: 2)),
//           priority: Priority.low,
//         ),
//       ];
//     });
//   }

//   List<TodoItem> get _filteredTodos {
//     List<TodoItem> todos;
//     switch (_filter) {
//       case 'active':
//         todos = _todos.where((todo) => !todo.isCompleted).toList();
//         todos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//         break;
//       case 'completed':
//         todos = _todos.where((todo) => todo.isCompleted).toList();
//         todos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//         break;
//       case 'sort_priority':
//         todos = [..._todos];
//         const order = {'High': 3, 'Medium': 2, 'Low': 1};
//         todos.sort((a, b) {
//           return (order[b.getPriorityText()] ?? 0)
//               .compareTo(order[a.getPriorityText()] ?? 0);
//         });
//         break;
//       case 'sort_date':
//         todos = [..._todos];
//         todos.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // newest first
//         break;
//       default:
//         todos = [..._todos];
//         todos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//     }

//     if (_categoryFilter != 'All') {
//       todos = todos.where((todo) => todo.category == _categoryFilter).toList();
//     }

//     if (_searchQuery.isNotEmpty) {
//       todos = todos
//           .where(
//             (todo) =>
//                 todo.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
//                 (todo.description?.toLowerCase().contains(
//                           _searchQuery.toLowerCase(),
//                         ) ??
//                     false),
//           )
//           .toList();
//     }

//     return todos;
//   }

//   void _addTodo(TodoItem todo) {
//     setState(() {
//       _todos.add(todo);
//     });
//   }

//   void _toggleTodo(String id) {
//     setState(() {
//       final todo = _todos.firstWhere((todo) => todo.id == id);
//       todo.toggleCompletion();
//     });
//   }

//   void _deleteTodo(String id) {
//     setState(() {
//       _todos.removeWhere((todo) => todo.id == id);
//     });
//   }

//   void _updateFilter(String filter) {
//     setState(() {
//       _filter = filter;
//     });
//   }

//   void _updateTodo(TodoItem updatedTodo) {
//     setState(() {
//       final index = _todos.indexWhere((t) => t.id == updatedTodo.id);
//       if (index != -1) {
//         _todos[index] = updatedTodo;
//       }
//     });
//   }

//   double get _progress {
//     if (_todos.isEmpty) return 0.0;
//     final completed = _todos.where((t) => t.isCompleted).length;
//     return completed / _todos.length;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: isDark ? Colors.black : Colors.white,
//         iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
//         title: !_isSearching
//             ? Text(
//                 "Todos",
//                 style: TextStyle(color: isDark ? Colors.white : Colors.black),
//               )
//             : TextField(
//                 controller: _searchController,
//                 autofocus: true,
//                 decoration: const InputDecoration(
//                   hintText: "Search todos...",
//                   border: InputBorder.none,
//                 ),
//                 style: TextStyle(color: isDark ? Colors.white : Colors.black),
//                 onChanged: (query) {
//                   setState(() {
//                     _searchQuery = query;
//                   });
//                 },
//               ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               _isSearching ? Icons.close : Icons.search,
//               color: isDark ? Colors.white : Colors.black,
//             ),
//             onPressed: () {
//               setState(() {
//                 _isSearching = !_isSearching;
//                 if (!_isSearching) _searchQuery = "";
//               });
//             },
//           ),
//           IconButton(
//             icon: Icon(
//               widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
//               color: isDark ? Colors.white : Colors.black,
//             ),
//             onPressed: widget.onThemeChanged, // ✅ fixed
//           ),
//           PopupMenuButton<String>(
//             onSelected: _updateFilter,
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                 value: 'all',
//                 child: Text('All (${_todos.length})'),
//               ),
//               const PopupMenuItem(
//                   value: 'sort_date', child: Text('Sort by Date')),
//               const PopupMenuItem(
//                   value: 'sort_priority', child: Text('Sort by Priority')),
//               PopupMenuItem(
//                 value: 'active',
//                 child: Text(
//                   'Active (${_todos.where((todo) => !todo.isCompleted).length})',
//                 ),
//               ),
//               PopupMenuItem(
//                 value: 'completed',
//                 child: Text(
//                   'Completed (${_todos.where((todo) => todo.isCompleted).length})',
//                 ),
//               ),
//             ],
//             icon: Icon(Icons.filter_list,
//                 color: isDark ? Colors.white : Colors.black),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // ✅ Added daily quote here
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Text(
//               getDailyQuote(),
//               style: TextStyle(
//                 fontSize: 16,
//                 fontStyle: FontStyle.italic,
//                 color: isDark ? Colors.white70 : Colors.black87,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),

//           FutureBuilder<int>(
//   future: StreakManager.getCurrentStreak(),
//   builder: (context, snapshot) {
//     if (!snapshot.hasData) return SizedBox();
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(Icons.local_fire_department, color: Colors.orange),
//         SizedBox(width: 6),
//         Text(
//           "Streak: ${snapshot.data} 🔥",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   },
// ),


//           // Progress tracker
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text("Progress",
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     Text("${(_progress * 100).toStringAsFixed(0)}%"),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: LinearProgressIndicator(
//                     value: _progress,
//                     minHeight: 10,
//                     backgroundColor: Colors.grey[300],
//                     valueColor:
//                         AlwaysStoppedAnimation<Color>(Colors.green[500]!),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: _filteredTodos.isEmpty
//                 ? Center(
//                     child: Text("No todos found",
//                         style: TextStyle(
//                             color: isDark ? Colors.white70 : Colors.black54)))
//                 : ListView.builder(
//                     itemCount: _filteredTodos.length,
//                     itemBuilder: (context, index) {
//                       final todo = _filteredTodos[index];
//                       return _buildTodoTile(todo, isDark);
//                     },
//                   ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddTodoScreen()),
//           );
//           if (result != null && result is TodoItem) {
//             _addTodo(result);
//           }
//         },
//         backgroundColor: isDark ? Colors.grey[900] : Colors.white70,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildTodoTile(TodoItem todo, bool isDark) {
//     final priorityColor = todo.getPriorityColor(); // ✅ use enum extension

//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       child: ListTile(
// leading: Checkbox(
//   value: todo.isCompleted,
//   onChanged: (value) async {
//     _toggleTodo(todo.id);
//     if (value == true) {
//       await StreakManager.updateStreak();
//     }
//     setState(() {}); // refresh streak UI
//   },
//   activeColor: Colors.green,
// ),
         
//         title: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 todo.title,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   decoration:
//                       todo.isCompleted ? TextDecoration.lineThrough : null,
//                   color: todo.isCompleted
//                       ? Colors.grey
//                       : isDark
//                           ? Colors.white
//                           : Colors.black,
//                 ),
//               ),
//             ),
//             Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//               decoration: BoxDecoration(
//                 color: priorityColor.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 todo.getPriorityText(), // ✅ fixed
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: priorityColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (todo.description != null && todo.description!.isNotEmpty)
//               Text(
//                 todo.description!.length > 30
//                     ? '${todo.description!.substring(0, 30)}...'
//                     : todo.description!,
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: todo.isCompleted
//                       ? Colors.grey
//                       : isDark
//                           ? Colors.white70
//                           : Colors.black87,
//                 ),
//               ),
//             Text(
//               "Created: ${DateFormat.yMMMd().add_jm().format(todo.createdAt)}",
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isDark ? Colors.grey[400] : Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//         trailing: PopupMenuButton<String>(
//           onSelected: (value) async {
//             if (value == 'edit') {
//               final updatedTodo = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddTodoScreen(todo: todo),
//                 ),
//               );
//               if (updatedTodo != null && updatedTodo is TodoItem) {
//                 _updateTodo(updatedTodo);
//               }
//             } else if (value == 'delete') {
//               _deleteTodo(todo.id);
//             } else if (value == 'status') {
//               _toggleTodo(todo.id);
//             }
//           },
//           itemBuilder: (context) => [
//             const PopupMenuItem(value: 'edit', child: Text("Edit")),
//             const PopupMenuItem(value: 'delete', child: Text("Delete")),
//             const PopupMenuItem(
//                 value: 'status', child: Text("Mark as Done/Undone")),
//           ],
//         ),
//         onTap: () async {
//           final updatedTodo = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => TodoDetailsScreen(todo: todo),
//             ),
//           );
//           if (updatedTodo != null && updatedTodo is TodoItem) {
//             _updateTodo(updatedTodo);
//           }
//         },
//       ),
//     );
//   }
// }


import 'view.dart';
import 'package:intl/intl.dart';

class TodoListScreen extends StatefulWidget {
  final VoidCallback onThemeChanged; // ✅ fixed type
  final bool isDarkMode;

  const TodoListScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> _todos = [];
  String _filter = 'all';
  String _categoryFilter = 'All';
  bool _isSearching = false;
  String _searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  // ✅ Quotes list
  final List<String> dailyQuotes = [
    "Small progress each day adds up to big results.",
    "Focus on being productive, not busy.",
    "Your future is created by what you do today, not tomorrow.",
    "Discipline is the bridge between goals and accomplishment.",
    "Start where you are. Use what you have. Do what you can.",
  ];

  // ✅ Quote picker
  String getDailyQuote() {
    final today = DateTime.now();
    final index = today.day % dailyQuotes.length;
    return dailyQuotes[index];
  }

  @override
  void initState() {
    super.initState();
    _loadTodosFromPrefs(); // ✅ load saved todos
  }

  // ✅ Save todos to SharedPreferences
  Future<void> _saveTodosToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final todoListJson = _todos.map((t) => t.toJson()).toList();
    await prefs.setString('todos', jsonEncode(todoListJson));
  }

  // ✅ Load todos from SharedPreferences
  Future<void> _loadTodosFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');
    if (todosString != null) {
      final List decoded = jsonDecode(todosString);
      setState(() {
        _todos = decoded.map((item) => TodoItem.fromJson(item)).toList();
      });
    } else {
      _addSampleTodos(); // fallback sample data
    }
  }

  void _addSampleTodos() {
    setState(() {
      _todos = [
        TodoItem(
          id: '1',
          title: 'Learn Flutter Basics',
          description: 'Complete the Flutter fundamentals course',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          priority: Priority.high,
        ),
        TodoItem(
          id: '2',
          title: 'Build Todo App',
          description: 'Create a functional todo application',
          createdAt: DateTime.now(),
          priority: Priority.medium,
        ),
        TodoItem(
          id: '3',
          title: 'Review Code',
          description: 'Go through the completed exercises',
          createdAt: DateTime.now(),
          isCompleted: true,
          completedAt: DateTime.now().subtract(const Duration(hours: 2)),
          priority: Priority.low,
        ),
      ];
    });
    _saveTodosToPrefs(); // ✅ save sample todos
  }

  List<TodoItem> get _filteredTodos {
    List<TodoItem> todos;
    switch (_filter) {
      case 'active':
        todos = _todos.where((todo) => !todo.isCompleted).toList();
        todos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'completed':
        todos = _todos.where((todo) => todo.isCompleted).toList();
        todos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'sort_priority':
        todos = [..._todos];
        const order = {'High': 3, 'Medium': 2, 'Low': 1};
        todos.sort((a, b) {
          return (order[b.getPriorityText()] ?? 0)
              .compareTo(order[a.getPriorityText()] ?? 0);
        });
        break;
      case 'sort_date':
        todos = [..._todos];
        todos.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // newest first
        break;
      default:
        todos = [..._todos];
        todos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    if (_categoryFilter != 'All') {
      todos = todos.where((todo) => todo.category == _categoryFilter).toList();
    }

    if (_searchQuery.isNotEmpty) {
      todos = todos
          .where(
            (todo) =>
                todo.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                (todo.description?.toLowerCase().contains(
                          _searchQuery.toLowerCase(),
                        ) ??
                    false),
          )
          .toList();
    }

    return todos;
  }

  void _addTodo(TodoItem todo) {
    setState(() {
      _todos.add(todo);
    });
    _saveTodosToPrefs(); // ✅ persist
  }

  void _toggleTodo(String id) {
    setState(() {
      final todo = _todos.firstWhere((todo) => todo.id == id);
      todo.toggleCompletion();
    });
    _saveTodosToPrefs(); // ✅ persist
  }

  void _deleteTodo(String id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
    _saveTodosToPrefs(); // ✅ persist
  }

  void _updateFilter(String filter) {
    setState(() {
      _filter = filter;
    });
  }

  void _updateTodo(TodoItem updatedTodo) {
    setState(() {
      final index = _todos.indexWhere((t) => t.id == updatedTodo.id);
      if (index != -1) {
        _todos[index] = updatedTodo;
      }
    });
    _saveTodosToPrefs(); // ✅ persist
  }

  double get _progress {
    if (_todos.isEmpty) return 0.0;
    final completed = _todos.where((t) => t.isCompleted).length;
    return completed / _todos.length;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        title: !_isSearching
            ? Text(
                "Todos",
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
              )
            : TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search todos...",
                  border: InputBorder.none,
                ),
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) _searchQuery = "";
              });
            },
          ),
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: widget.onThemeChanged, // ✅ fixed
          ),
          PopupMenuButton<String>(
            onSelected: _updateFilter,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'all',
                child: Text('All (${_todos.length})'),
              ),
              const PopupMenuItem(
                  value: 'sort_date', child: Text('Sort by Date')),
              const PopupMenuItem(
                  value: 'sort_priority', child: Text('Sort by Priority')),
              PopupMenuItem(
                value: 'active',
                child: Text(
                  'Active (${_todos.where((todo) => !todo.isCompleted).length})',
                ),
              ),
              PopupMenuItem(
                value: 'completed',
                child: Text(
                  'Completed (${_todos.where((todo) => todo.isCompleted).length})',
                ),
              ),
            ],
            icon: Icon(Icons.filter_list,
                color: isDark ? Colors.white : Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          // ✅ daily quote
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              getDailyQuote(),
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // ✅ streak
          FutureBuilder<int>(
            future: StreakManager.getCurrentStreak(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return SizedBox();
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_fire_department, color: Colors.orange),
                  SizedBox(width: 6),
                  Text(
                    "Streak: ${snapshot.data} 🔥",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          ),

          // ✅ progress
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Progress",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("${(_progress * 100).toStringAsFixed(0)}%"),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _progress,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.green[500]!),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _filteredTodos.isEmpty
                ? Center(
                    child: Text("No todos found",
                        style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black54)))
                : ListView.builder(
                    itemCount: _filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = _filteredTodos[index];
                      return _buildTodoTile(todo, isDark);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );
          if (result != null && result is TodoItem) {
            _addTodo(result);
          }
        },
        backgroundColor: isDark ? Colors.grey[900] : Colors.white70,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoTile(TodoItem todo, bool isDark) {
    final priorityColor = todo.getPriorityColor();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (value) async {
            _toggleTodo(todo.id);
            if (value == true) {
              await StreakManager.updateStreak();
            }
            setState(() {}); // refresh streak UI
          },
          activeColor: Colors.green,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                todo.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: todo.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                  color: todo.isCompleted
                      ? Colors.grey
                      : isDark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: priorityColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                todo.getPriorityText(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: priorityColor,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todo.description != null && todo.description!.isNotEmpty)
              Text(
                todo.description!.length > 30
                    ? '${todo.description!.substring(0, 30)}...'
                    : todo.description!,
                style: TextStyle(
                  fontSize: 13,
                  color: todo.isCompleted
                      ? Colors.grey
                      : isDark
                          ? Colors.white70
                          : Colors.black87,
                ),
              ),
            Text(
              "Created: ${DateFormat.yMMMd().add_jm().format(todo.createdAt)}",
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'edit') {
              final updatedTodo = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodoScreen(todo: todo),
                ),
              );
              if (updatedTodo != null && updatedTodo is TodoItem) {
                _updateTodo(updatedTodo);
              }
            } else if (value == 'delete') {
              _deleteTodo(todo.id);
            } else if (value == 'status') {
              _toggleTodo(todo.id);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text("Edit")),
            const PopupMenuItem(value: 'delete', child: Text("Delete")),
            const PopupMenuItem(
                value: 'status', child: Text("Mark as Done/Undone")),
          ],
        ),
        onTap: () async {
          final updatedTodo = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodoDetailsScreen(todo: todo),
            ),
          );
          if (updatedTodo != null && updatedTodo is TodoItem) {
            _updateTodo(updatedTodo);
          }
        },
      ),
    );
  }
}


