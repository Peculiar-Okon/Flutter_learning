import 'package:flutter/material.dart';
import 'user_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Your wide-screen layout here
            return SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: AboutMeSection(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [AboutText(), AboutMeButtons()],
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Your small-screen layout here
            return SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                child: Column(
                  children: [
                    AboutMeSection(),
                    SizedBox(height: 15),
                    AboutText(),
                    SizedBox(height: 15),
                    AboutMeButtons(),
                    SizedBox(height: 25),
                    MySkills(),
                    SizedBox(height: 15),
                    MySkillsRows(),
                    SizedBox(height: 25),
                    ContactMe(),
                    ContactMeCards(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

//reusable widget
class HeaderText extends StatelessWidget {
  const HeaderText(
    this.text, {
    super.key,
    required this.color,
    this.style,
    this.textAlign,
  });

  final String text;
  final TextStyle? style;
  final Color color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: style),
    );
  }
}

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: HeaderText(
            "ABOUT ME",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Divider(
          height: 20, // Vertical space above and below the line
          thickness: 1, // Thickness of the line
          indent: 10, // Space on the left
          endIndent: 10, // Space on the right
          color: Colors.grey,
        ),
      ],
    );
  }
}

class AboutText extends StatelessWidget {
  const AboutText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Text(
          'Pearl is a Nigerian software engineering student with a strong passion for technology and innovation. She is currently focused on fullstack development, with hands-on experience in JavaScript, React, and Flutter.',
          textAlign:
              TextAlign.justify, // Use this for a clean, block-like appearance
          style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
    );
  }
}

class AboutMeBtnReusable extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final IconData? icon;

  const AboutMeBtnReusable({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: const [
          // Added BoxShadow here
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutMeButtons extends StatelessWidget {
  const AboutMeButtons({super.key});

    Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AboutMeBtnReusable(
          text: 'Download CV',
          onPressed: () {
            
          },
          color: Theme.of(context).colorScheme.primary,
          icon: Icons.download,
        ),
        const SizedBox(width: 20),
        AboutMeBtnReusable(
          text: 'GitHub',
          onPressed: () async {
            await _launchUrl('https://github.com/Peculiar-Okon');
          }, 
          color: Theme.of(context).colorScheme.primary,
          icon: Icons.link,
        ),
      ],
    );
  }
}

class MySkills extends StatelessWidget {
  const MySkills({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: HeaderText(
            "SKILLS",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          indent: 10,
          endIndent: 10,
          color: Colors.grey,
        ),
      ],
    );
  }
}

class MySkillsRows extends StatelessWidget {
  const MySkillsRows({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // Centers the row horizontally
      children: [
        // React Tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
          ),
          child: const Text(
            'React',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(width: 18), // Adds space between the containers
        // Flutter Tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
          ),
          child: const Text(
            'Flutter',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(width: 18), // Adds space between the containers
        // JavaScript Tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
          ),
          child: const Text(
            'JavaScript',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class ContactMe extends StatelessWidget {
  const ContactMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: HeaderText(
            "CONTACT ME",
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          indent: 10,
          endIndent: 10,
          color: Colors.grey,
        ),
      ],
    );
  }
}

class ContactMeCards extends StatelessWidget {
  const ContactMeCards({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.email, color: Colors.grey),
                  title: Text(
                    'peculiargirl4real@gmail.com',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.phone, color: Colors.grey),
                  title: Text(
                    '+234 810 687 2610',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
