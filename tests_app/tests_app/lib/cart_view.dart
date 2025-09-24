
import 'core.dart';
import 'main.dart';
import 'dart:async'; // for Future.delayed

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isPaying = false;
  bool paymentSuccess = false;

  void _showCheckoutModal(double totalPrice) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Summary",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Show items
                  ...cartItems.map((item) {
                    return ListTile(
                      title: Text(item['name']),
                      trailing: Text(
                        "\$${(item['price'] as double).toStringAsFixed(2)}",
                      ),
                    );
                  }),

                  const Divider(),

                  // Total row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Pay Now button
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        if (!isPaying) {
                          setModalState(() {
                            isPaying = true;
                          });

                          // fake payment delay
                          await Future.delayed(const Duration(seconds: 2));

                          setModalState(() {
                            paymentSuccess = true;
                          });

                          // wait a bit then go back
                          await Future.delayed(const Duration(seconds: 1));

                          
                          if (mounted) {
                            // clear the cart before navigating away
                            setState(() {
                              cartItems.clear();
                            });

                            Navigator.pop(context); // close modal
                            Navigator.pushReplacementNamed(context, '/menu'); // back to menu
                          }
                        }
                      },
                      child: isPaying
                          ? (paymentSuccess
                              ? const Icon(Icons.check, color: Colors.white)
                              : const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ))
                          : const Text("Pay Now"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(
      0,
      (sum, item) => sum + (item['price'] as double),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add some delicious items from our menu!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                            return ListTile(
  leading: const Icon(Icons.fastfood, color: Colors.orange),
  //  Correction: Show "x2", "x3", etc.
  title: Text("${item['name']}  (x${item['quantity']})"),
  subtitle: Text(
    '\$${(item['price'] as double).toStringAsFixed(2)}',
  ),
  trailing: IconButton(
    icon: const Icon(Icons.delete, color: Colors.red),
    onPressed: () {
      setState(() {
        //  Correction: decrease quantity if >1, else remove item
        if (item['quantity'] > 1) {
          item['quantity'] -= 1;
        } else {
          cartItems.removeAt(index);
        }
      });
    },
  ),
);

                    },
                  ),
                ),
                Container(
  padding: const EdgeInsets.all(16),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Total
      Text(
        'Total: \$${totalPrice.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Clear All button
      ElevatedButton(
        onPressed: () {
          setState(() {
            cartItems.clear();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cart cleared!')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
        child: const Text('Clear All'),
      ),

      // Checkout button
      ElevatedButton(
        onPressed: () => _showCheckoutModal(totalPrice),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
        child: const Text('Checkout'),
      ),
    ],
  ),
),

              ],
            ),
    );
  }
}

