import 'package:flutter/material.dart';

class ResultSectionScreen extends StatelessWidget {
  final List<Map<String, String>> authors = [
    {
      'name': 'Mark Manson',
      'books': '7 Books',
      'image': 'assets/images/u1.png'
    },
    {
      'name': 'Ariana Bandle',
      'books': '7 Books',
      'image':  'assets/images/u2.png'
    },
    {
      'name': 'Ariana Bandle',
      'books': '7 Books',
      'image':  'assets/images/u1.png'
    },
  ];

  final List<Map<String, String>> books = [
    {
      'title': 'How to Unfolds',
      'author': 'Rebecca Roanhorse',
      'image': 'assets/images/b1.png'
    },
    {
      'title': '12 Rules For life',
      'author': 'Rebecca Roanhorse',
      'image': 'assets/images/b4.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Authors',
                style: TextStyle(
                
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: authors.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage(authors[index]['image']!),
                        ),
                        title: Text(
                          authors[index]['name']!,
                          style: const TextStyle(
                            
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          authors[index]['books']!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () {
                          print('Tapped on author: ${authors[index]['name']}');
                        },
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Books',
                style: TextStyle(
                
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 50,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: AssetImage(books[index]['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          books[index]['title']!,
                          style: const TextStyle(
                          
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          books[index]['author']!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () {
                          print('Tapped on book: ${books[index]['title']}');
                        },
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ],
          ),
        
      
    );
  }
}