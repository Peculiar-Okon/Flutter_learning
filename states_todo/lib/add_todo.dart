import 'view.dart';

class AddTodoScreen extends StatefulWidget {
  final TodoItem? todo;

  const AddTodoScreen({super.key, this.todo});
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDueDate;
  Priority _selectedPriority = Priority.medium; // 👈 Default priority

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description ?? '';
      _selectedDueDate = widget.todo!.dueDate;
      _selectedPriority = widget.todo!.priority; // 👈 load existing
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      final updatedTodo = TodoItem(
        id: widget.todo?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        createdAt: widget.todo?.createdAt ?? DateTime.now(),
        isCompleted: widget.todo?.isCompleted ?? false,
        dueDate: _selectedDueDate,
        priority: _selectedPriority, // 👈 save selected priority
      );

      Navigator.pop(context, updatedTodo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Add New Todo' : 'Edit Todo'),
        actions: [
          TextButton(
            onPressed: _saveTodo,
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Todo Title *',
                  hintText: 'Enter todo title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'Enter todo description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // 👇 Priority Dropdown
              DropdownButtonFormField<Priority>(
                value: _selectedPriority,
                decoration: const InputDecoration(
                  labelText: "Priority",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag),
                ),
                items: Priority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority.getPriorityText()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedPriority = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),
              const Text(
                'Due Date:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDueDate == null
                          ? 'No due date selected'
                          : '${_selectedDueDate!.day}/${_selectedDueDate!.month}/${_selectedDueDate!.year}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white70
                            : Colors.black87,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _selectedDueDate = pickedDate;
                        });
                      }
                    },
                    child: const Text('Pick Date'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

