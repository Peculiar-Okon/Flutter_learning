import 'package:flutter/material.dart';

class UserExperienceRatingPage extends StatefulWidget {
  const UserExperienceRatingPage({super.key});

  @override
  State<UserExperienceRatingPage> createState() => _UserExperienceRatingPageState();
}

class _UserExperienceRatingPageState extends State<UserExperienceRatingPage> {
  int _likeCount = 0;
  bool _isLiked = false;

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _likeCount--;
        _isLiked = false;
      } else {
        _likeCount++;
        _isLiked = true;
      }
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('You have clicked the like button.'),
          duration: Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, 
        title: const Text(
          'User Rating',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Liked your experience? Leave a like',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ? Colors.red : Colors.grey,
                    size: 40,
                  ),
                  onPressed: _toggleLike,
                ),
                Text(
                  '$_likeCount',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

