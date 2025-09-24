import 'view.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _ageController = TextEditingController();

  bool _termsAccepted = false;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Enter password";
    if (value.length < 8) return "Min 8 characters";
    if (!RegExp(r'[A-Z]').hasMatch(value)) return "Add uppercase letter";
    if (!RegExp(r'[a-z]').hasMatch(value)) return "Add lowercase letter";
    if (!RegExp(r'[0-9]').hasMatch(value)) return "Add number";
    if (!RegExp(r'[!@#\$&*~.?>,]').hasMatch(value)) return "Add special char";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Validation")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: "Username"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter username";
                  if (!RegExp(r'^[a-zA-Z0-9]{3,20}$').hasMatch(value)) {
                    return "3–20 alphanumeric only";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter email";
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator: _validatePassword,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Confirm Password"),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return "Passwords don’t match";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Age"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter age";
                  final age = int.tryParse(value);
                  if (age == null || age < 18) {
                    return "Must be 18+";
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text("Accept Terms & Conditions"),
                value: _termsAccepted,
                onChanged: (val) {
                  setState(() => _termsAccepted = val!);
                },
                controlAffinity: ListTileControlAffinity.leading,
                subtitle: !_termsAccepted ? Text("Required", style: TextStyle(color: Colors.red)) : null,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _termsAccepted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Form is valid ✅")),
                    );
                  }
                },
                child: Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
