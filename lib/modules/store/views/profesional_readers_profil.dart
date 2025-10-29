import 'package:elkitap/global_widgets/custom_appbar.dart';
import 'package:elkitap/modules/store/widgets/book_cart_profil.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProfesionalReadersProfil extends StatefulWidget {
  const ProfesionalReadersProfil({super.key});

  @override
  State<ProfesionalReadersProfil> createState() =>
      _ProfesionalReadersProfilState();
}

class _ProfesionalReadersProfilState extends State<ProfesionalReadersProfil> {
  bool isExpanded = false;

  final String shortBio =
      "Сегодня в рубрике «Профессии» у нас в гостях региональный директор Yüpekçi. Он поделится с вами тремя...";

  final String fullBio =
      "Сегодня в рубрике «Профессии» у нас в гостях региональный директор Yüpekçi. Он поделится с вами тремя замечательными книгами, которые помогут вам научиться договариваться, продавать и глубже понимать потребности клиентов. Эти произведения не только развивают навыки общения, но и значительно повышают вашу эффективность в бизнесе. Обязательно присоединяйтесь к нам!";
  final List<Map<String, dynamic>> books = [
    {
      'title': 'The Subtle Art of Not Giving a F*ck',
      'author': 'Mark Manson',
      'description':
          'Mark Manson\'s "The Subtle Art of Not Giving a F*ck" is a blunt, humorous guide to living by choosing your battles wisely.',
      'imageUrl': 'assets/images/b1.png',
      'buttonText': 'Continue',
      'buttonColor': const Color(0xFFFF5722),
      'buttonTextColor': Colors.white,
    },
    {
      'title': 'Falling bodies',
      'author': 'Rebecca Roanhorse',
      'description':
          'Book by Rebecca Roanhorse is a gripping sci-fi tale exploring identity and colonialism\'s impact in a universe under alien rule.',
      'imageUrl': 'assets/images/b2.png',
      'buttonText': 'Read',
      'buttonColor': Colors.grey[200],
      'buttonTextColor': Colors.black,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '', leadingText: 'Back'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile Image with Glass Effect Gradient
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Image.asset(
                            'assets/images/u2.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.grey[300],
                                ),
                              );
                            },
                          ),
                        ),
                        // Glass effect gradient overlay at bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? [
                                        Colors.black.withOpacity(0.0),
                                        Colors.black.withOpacity(0.3),
                                        Colors.black.withOpacity(0.7),
                                        Colors.black.withOpacity(0.95),
                                        Colors.black,
                                      ]
                                    : [
                                        Colors.white.withOpacity(0.0),
                                        Colors.white.withOpacity(0.3),
                                        Colors.white.withOpacity(0.7),
                                        Colors.white.withOpacity(0.95),
                                        Colors.white,
                                      ],
                                stops: const [0.0, 0.3, 0.6, 0.85, 1.0],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Profile Info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Merdan Durnayew',
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'NewYork',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Director',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                              children: [
                                TextSpan(text: isExpanded ? fullBio : shortBio),
                                TextSpan(
                                  text:
                                      isExpanded ? ' Show Less' : ' Show More',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return Column(
                          children: [
                            BookCardProfRedares(
                              title: book['title'],
                              author: book['author'],
                              description: book['description'],
                              imageUrl: book['imageUrl'],
                              buttonText: book['buttonText'],
                              buttonColor: book['buttonColor'],
                              buttonTextColor: book['buttonTextColor'],
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
