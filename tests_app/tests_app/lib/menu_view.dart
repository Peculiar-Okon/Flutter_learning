

// import 'core.dart';
// import 'main.dart';

// class MenuScreen extends StatefulWidget {
//   const MenuScreen({super.key});

//   @override
//   State<MenuScreen> createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> {
//   final List<Map<String, dynamic>> menuItems = [
//     {
//       'name': 'Margherita Pizza',
//       'description': 'Fresh mozzarella, tomato sauce, basil',
//       'price': 15.99,
//       'image': 'assets/pizza.jpg',
//       'category': 'Pizza',
//       'rating': 4.5,
//       'prepTime': '20 mins',
//       'isSpicy': false,
//       'isFavorite': false,
//     },
//     {
//       'name': 'Caesar Salad',
//       'description': 'Romaine lettuce, parmesan, croutons',
//       'price': 12.99,
//       'image': 'assets/salad.jpg',
//       'category': 'Salad',
//       'rating': 4.5,
//       'prepTime': '13 mins',
//       'isSpicy': false,
//       'isFavorite': false,
//     },
//     {
//       'name': 'Pasta Carbonara',
//       'description': 'Spaghetti, eggs, bacon, parmesan',
//       'price': 18.99,
//       'image': 'assets/pasta.jpg',
//       'category': 'Pasta',
//       'rating': 4.2,
//       'prepTime': '20 mins',
//       'isSpicy': true,
//       'isFavorite': false,
//     },
//     {
//       'name': 'Chicken Wings',
//       'description': 'Crispy wings with your choice of sauce',
//       'price': 14.99,
//       'image': 'assets/chickenwings.jpg',
//       'category': 'Appetizer',
//       'rating': 4.2,
//       'prepTime': '15 mins',
//       'isSpicy': true,
//       'isFavorite': false,
//     },
//   ];

//   String selectedCategory = 'All';
//   final List<String> categories = [
//     'All',
//     'Pizza',
//     'Salad',
//     'Pasta',
//     'Appetizer',
//   ];

//   //  Search feature variables
//   bool isSearching = false;
//   TextEditingController searchController = TextEditingController();
//   List<Map<String, dynamic>> displayedItems = [];

//   @override
//   void initState() {
//     super.initState();
//     displayedItems = List.from(menuItems); // start with all items
//   }

//   //  Filter by category + search
//   void _filterItems() {
//     setState(() {
//       List<Map<String, dynamic>> results = selectedCategory == 'All'
//           ? List.from(menuItems)
//           : menuItems
//               .where((item) => item['category'] == selectedCategory)
//               .toList();

//       if (searchController.text.isNotEmpty) {
//         results = results
//             .where(
//               (item) => item['name'].toLowerCase().contains(
//                     searchController.text.toLowerCase(),
//                   ),
//             )
//             .toList();
//       }

//       displayedItems = results;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: !isSearching
//             ? const Text('Menu')
//             : TextField(
//                 controller: searchController,
//                 autofocus: true,
//                 decoration: const InputDecoration(
//                   hintText: "Search food...",
//                   border: InputBorder.none,
//                 ),
//                 onChanged: (value) => _filterItems(),
//               ),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(isSearching ? Icons.close : Icons.search),
//             onPressed: () {
//               setState(() {
//                 isSearching = !isSearching;
//                 searchController.clear();
//                 _filterItems();
//               });
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.shopping_cart),
//             onPressed: () {
//               Navigator.pushNamed(context, '/cart');
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Category Filter
//           Container(
//             height: 60,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 final category = categories[index];
//                 final isSelected = category == selectedCategory;

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 4,
//                     vertical: 8,
//                   ),
//                   child: FilterChip(
//                     label: Text(category),
//                     selected: isSelected,
//                     onSelected: (selected) {
//                       setState(() {
//                         selectedCategory = category;
//                         _filterItems();
//                       });
//                     },
//                     selectedColor: Colors.orange.shade200,
//                     checkmarkColor: Colors.orange,
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Menu Items
//           Expanded(
//             child: displayedItems.isEmpty
//                 ? const Center(
//                     child: Text(
//                       "No match found",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   )
//                 : ListView.builder(
//                     padding: const EdgeInsets.all(16),
//                     itemCount: displayedItems.length,
//                     itemBuilder: (context, index) {
//                       final item = displayedItems[index];
//                       return _buildMenuItem(context, item);
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: InkWell(
//         onTap: () {
//           _showItemDetails(context, item);
//         },
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               // Item Image
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.asset(
//                   item['image'],
//                   width: 80,
//                   height: 80,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 16),

//               // Item Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       item['name'],
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       item['description'],
//                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                             color: Colors.grey.shade600,
//                           ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '\$${item['price'].toStringAsFixed(2)}',
//                           style: Theme.of(context).textTheme.titleMedium
//                               ?.copyWith(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             _addToCart(context, item);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange,
//                             foregroundColor: Colors.white,
//                             minimumSize: const Size(80, 36),
//                           ),
//                           child: const Text('Add'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showItemDetails(BuildContext context, Map<String, dynamic> item) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Handle
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Item Image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.asset(
//                 item['image'],
//                 width: 120,
//                 height: 120,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Item Details
//             Text(
//               item['name'],
//               style: Theme.of(
//                 context,
//               ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),

//             Text(
//               item['description'],
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),

//             Text(
//               '\$${item['price'].toStringAsFixed(2)}',
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.orange,
//                   ),
//             ),
//             const SizedBox(height: 24),

//             // Add to Cart Button
//             SizedBox(
//               width: double.infinity,
//               height: 56,
//               child: ElevatedButton(
//                 onPressed: () {
//                   _addToCart(context, item);
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 child: const Text(
//                   'Add to Cart',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   void _addToCart(BuildContext context, Map<String, dynamic> item) {
//     setState(() {
//       final existingItemIndex = cartItems.indexWhere(
//         (cartItem) => cartItem['name'] == item['name'],
//       );

//       if (existingItemIndex != -1) {
//         // If item already in cart → increase quantity
//         cartItems[existingItemIndex]['quantity'] += 1;
//       } else {
//         // If not in cart → add with quantity = 1
//         cartItems.add({...item, 'quantity': 1});
//       }
//     });

//     //  Updated snackbar to also show quantity
//     final cartItem = cartItems.firstWhere(
//       (cartItem) => cartItem['name'] == item['name'],
//     );
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('${cartItem['name']} added! (x${cartItem['quantity']})'),
//         duration: const Duration(seconds: 2),
//         action: SnackBarAction(
//           label: 'View Cart',
//           onPressed: () {
//             Navigator.pushNamed(context, '/cart');
//           },
//         ),
//       ),
//     );
//   }
// }


import 'core.dart';
import 'main.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Margherita Pizza',
      'description': 'Fresh mozzarella, tomato sauce, basil',
      'price': 15.99,
      'image': 'assets/pizza.jpg',
      'category': 'Pizza',
      'rating': 4.5,
      'prepTime': '20 mins',
      'isSpicy': false,
      'isFavorite': false,
    },
    {
      'name': 'Caesar Salad',
      'description': 'Romaine lettuce, parmesan, croutons',
      'price': 12.99,
      'image': 'assets/salad.jpg',
      'category': 'Salad',
      'rating': 4.5,
      'prepTime': '13 mins',
      'isSpicy': false,
      'isFavorite': false,
    },
    {
      'name': 'Pasta Carbonara',
      'description': 'Spaghetti, eggs, bacon, parmesan',
      'price': 18.99,
      'image': 'assets/pasta.jpg',
      'category': 'Pasta',
      'rating': 4.2,
      'prepTime': '20 mins',
      'isSpicy': true,
      'isFavorite': false,
    },
    {
      'name': 'Chicken Wings',
      'description': 'Crispy wings with your choice of sauce',
      'price': 14.99,
      'image': 'assets/chickenwings.jpg',
      'category': 'Appetizer',
      'rating': 4.2,
      'prepTime': '15 mins',
      'isSpicy': true,
      'isFavorite': false,
    },
  ];

  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Pizza',
    'Salad',
    'Pasta',
    'Appetizer',
  ];

  //  Search feature variables
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> displayedItems = [];

  @override
  void initState() {
    super.initState();
    displayedItems = List.from(menuItems); // start with all items
  }

  //  Filter by category + search
  void _filterItems() {
    setState(() {
      List<Map<String, dynamic>> results = selectedCategory == 'All'
          ? List.from(menuItems)
          : menuItems
              .where((item) => item['category'] == selectedCategory)
              .toList();

      if (searchController.text.isNotEmpty) {
        results = results
            .where(
              (item) => item['name'].toLowerCase().contains(
                    searchController.text.toLowerCase(),
                  ),
            )
            .toList();
      }

      displayedItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? const Text('Menu')
            : TextField(
                controller: searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search food...",
                  border: InputBorder.none,
                ),
                onChanged: (value) => _filterItems(),
              ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                searchController.clear();
                _filterItems();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                        _filterItems();
                      });
                    },
                    selectedColor: Colors.orange.shade200,
                    checkmarkColor: Colors.orange,
                  ),
                );
              },
            ),
          ),

          // Menu Items
          Expanded(
            child: displayedItems.isEmpty
                ? const Center(
                    child: Text(
                      "No match found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: displayedItems.length,
                    itemBuilder: (context, index) {
                      final item = displayedItems[index];
                      return _buildMenuItem(context, item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              _showItemDetails(context, item);
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Item Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item['image'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Item Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),

                        // Rating + Prep time + Spicy
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            Text(item['rating'].toString()),

                            const SizedBox(width: 12),
                            Icon(Icons.access_time,
                                size: 16, color: Colors.grey),
                            Text(item['prepTime']),

                            if (item['isSpicy']) ...[
                              const SizedBox(width: 12),
                              Icon(Icons.whatshot,
                                  size: 18, color: Colors.red),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),

                        Text(
                          item['description'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${item['price'].toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _addToCart(context, item);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(80, 36),
                              ),
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Favorite button (top-right)
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                item['isFavorite']
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  item['isFavorite'] = !item['isFavorite'];
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showItemDetails(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Item Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item['image'],
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Item Details
            Text(
              item['name'],
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              item['description'],
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            Text(
              '\$${item['price'].toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
            ),
            const SizedBox(height: 24),

            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  _addToCart(context, item);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _addToCart(BuildContext context, Map<String, dynamic> item) {
    setState(() {
      final existingItemIndex = cartItems.indexWhere(
        (cartItem) => cartItem['name'] == item['name'],
      );

      if (existingItemIndex != -1) {
        // If item already in cart → increase quantity
        cartItems[existingItemIndex]['quantity'] += 1;
      } else {
        // If not in cart → add with quantity = 1
        cartItems.add({...item, 'quantity': 1});
      }
    });

    //  Updated snackbar to also show quantity
    final cartItem = cartItems.firstWhere(
      (cartItem) => cartItem['name'] == item['name'],
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${cartItem['name']} added! (x${cartItem['quantity']})'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
  }
}


