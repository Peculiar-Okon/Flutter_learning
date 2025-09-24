import 'core.dart';
import 'view.dart';

List<Map<String, dynamic>> cartItems = [];

void main() {
  runApp(const RestaurantMenuApp());
}

class RestaurantMenuApp extends StatelessWidget {
  const RestaurantMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant Menu',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const HomeScreen(),
      routes: {
        '/menu': (context) => const MenuScreen(),
        '/cart': (context) => const CartScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}


