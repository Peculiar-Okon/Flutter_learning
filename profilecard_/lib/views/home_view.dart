import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'details_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: FirstSection(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        IconSection(),
                        SizedBox(height: 30),
                        SecondSection(),
                        SizedBox(height: 50),
                        FirstPgLinkButton(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150.0),
                    child: FirstSection(),
                  ),
                  SecondSection(),
                  SizedBox(height: 35),
                  FirstPgLinkButton(),
                  SizedBox(height: 60),
                  IconSection(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class FirstSection extends StatelessWidget {
  const FirstSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(10, 15),
                ),
              ],
              image: DecorationImage(
                image: AssetImage("assets/a_photo.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 18),
          Text(
            'Peculiar Okon',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            'Software Engineer',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class SecondSection extends StatelessWidget {
  const SecondSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'An engineer passionate about building personalized systems and apps that solve user problems.',
              textAlign: TextAlign
                  .center, // This is the correct way to center the text
              style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class FirstPgLinkButton extends StatelessWidget {
  const FirstPgLinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      
      child: ElevatedButton(
        
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailsView()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
            Theme.of(context).colorScheme.primary, 
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        child: const Text(
          'Learn More',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class IconSection extends StatelessWidget {
  const IconSection({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // Centers the row horizontally
      children: [
        // Twitter Icon
        InkWell(
          onTap: () {
            _launchUrl('https://x.com/ThatghurlPearl');
          },
          child: Container(
            width: 70, // Increased size
            height: 70, // Increased size
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary, // First icon background color
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.alternate_email, color: Colors.white),
          ),
        ),

        const SizedBox(width: 35), // Increased spacing
        // LinkedIn Icon
        InkWell(
          onTap: () {
            _launchUrl(
              'https://www.linkedin.com/in/pearl-🌐✨-b94903329?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
            );
          },
          child: Container(
            width: 70, // Increased size
            height: 70, // Increased size
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary, // Greenish-blue color
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.badge, color: Colors.white),
          ),
        ),

        const SizedBox(width: 35), // Increased spacing
        // Instagram Icon
        InkWell(
          onTap: () {
            _launchUrl('https://instagram.com/pearly_ghurl__');
          },
          child: Container(
            width: 70, // Increased size
            height: 70, // Increased size
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary, // Plain blue color
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.camera_alt, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
