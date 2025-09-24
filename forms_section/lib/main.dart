import 'package:forms_section/dynamicform.dart';

import 'view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DynamicForm(),);
  }
}
