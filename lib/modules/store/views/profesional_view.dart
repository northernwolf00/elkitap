import 'package:flutter/material.dart';

class ProfessionalsReadView extends StatelessWidget {
  const ProfessionalsReadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Professionals read',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        children: const [
          ProfessionalCard(
            name: 'Merdan Durnayew',
            role: 'DIRECTOR',
            imageUrl: 'assets/merdan.jpg',
          ),
          ProfessionalCard(
            name: 'Azat Sary',
            role: 'ARCHITECS',
            imageUrl: 'assets/azat.jpg',
          ),
          ProfessionalCard(
            name: 'Azat Sary',
            role: 'ARCHITECS',
            imageUrl: 'assets/azat.jpg',
          ),
        ],
      ),
    );
  }
}

class ProfessionalCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;

  const ProfessionalCard({
    Key? key,
    required this.name,
    required this.role,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(imageUrl),
          ),
          const SizedBox(height: 12),
          Text(
            role,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const BookRow(),
        ],
      ),
    );
  }
}

class BookRow extends StatelessWidget {
  const BookRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: BookCover(
              color: Colors.orange[700]!,
              title: 'THE SUBTLE ART OF NOT GIVING A F*CK',
              author: 'MARK MANSON',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: BookCover(
              color: Colors.white,
              title: 'Atomic Habits',
              author: 'James Clear',
              hasBorder: true,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: BookCover(
              color: Colors.white,
              title: '12 RULES FOR LIFE',
              author: 'JORDAN B. PETERSON',
              hasBorder: true,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: BookCover(
              color: Colors.black,
              title: 'FALLING BONES',
              author: 'REBECCA ROANHORST',
              hasAudibleBadge: true,
            ),
          ),
        ],
      ),
    );
  }
}

class BookCover extends StatelessWidget {
  final Color color;
  final String title;
  final String author;
  final bool hasBorder;
  final bool hasAudibleBadge;

  const BookCover({
    Key? key,
    required this.color,
    required this.title,
    required this.author,
    this.hasBorder = false,
    this.hasAudibleBadge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        border: hasBorder ? Border.all(color: Colors.grey[300]!) : null,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color == Colors.black || color == Colors.orange[700]
                          ? Colors.white
                          : Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    author,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color == Colors.black || color == Colors.orange[700]
                          ? Colors.white70
                          : Colors.grey[600],
                      fontSize: 6,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          if (hasAudibleBadge)
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange[700],
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Text(
                  'Audible',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}