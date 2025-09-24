import 'core.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
            body: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange.shade200,
              child: const Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 16),

            // Name & Email
            Text(
              'Pearl',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'peculiargirl4real@gmail.com',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),

            // Account options
            ListTile(
              leading: const Icon(Icons.history, color: Colors.orange),
              title: const Text("Order History"),
              onTap: () {
                // Later: navigate to order history page
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order history tapped")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.orange),
              title: const Text("Settings"),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Settings tapped")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logged out")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
