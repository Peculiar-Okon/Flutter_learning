import 'view.dart';

class DynamicForm extends StatefulWidget {
  const DynamicForm({super.key});
  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  List<TextEditingController> phoneControllers = [];
  List<TextEditingController> addressControllers = [];

  @override
  void initState() {
    super.initState();
    phoneControllers.add(TextEditingController());
    addressControllers.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dynamic Fields")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("Phone Numbers", style: TextStyle(fontWeight: FontWeight.bold)),
          ...phoneControllers.asMap().entries.map((entry) {
            int index = entry.key;
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: entry.value,
                    decoration: InputDecoration(labelText: "Phone ${index + 1}"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    setState(() => phoneControllers.removeAt(index));
                  },
                )
              ],
            );
          }),
          ElevatedButton(
            onPressed: () {
              setState(() => phoneControllers.add(TextEditingController()));
            },
            child: Text("Add Phone"),
          ),
          SizedBox(height: 20),
          Text("Addresses", style: TextStyle(fontWeight: FontWeight.bold)),
          ...addressControllers.asMap().entries.map((entry) {
            int index = entry.key;
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: entry.value,
                    decoration: InputDecoration(labelText: "Address ${index + 1}"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    setState(() => addressControllers.removeAt(index));
                  },
                )
              ],
            );
          }),
          ElevatedButton(
            onPressed: () {
              setState(() => addressControllers.add(TextEditingController()));
            },
            child: Text("Add Address"),
          ),
        ],
      ),
    );
  }
}
