import 'package:elkitap/modules/audio_player/model/chapter.dart';
import 'package:elkitap/modules/audio_player/widgets/chapter_tile.dart';
import 'package:flutter/material.dart';

class AudiobookBottomSheet extends StatelessWidget {
  const AudiobookBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chapters = List.generate(
      10,
      (index) => Chapter(
        number: index + 1,
        title: 'Chapter ${index + 1}',
        duration: '18:45',
        size: '46 Mb',
        isDownloaded: index != 2 && index != 3,
      ),
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 77, 78, 80),
                Color.fromARGB(255, 88, 88, 89)
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book cover
                    Container(
                        width: 56,
                        height: 80,
                        decoration: BoxDecoration(),
                        child: Image.asset('assets/images/b4.png')),
                    const SizedBox(width: 16),

                    // Title
                    const Expanded(
                      child: Text(
                        'The Subtle art of not giving',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // Close button
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.white),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ],
                ),
              ),

              // Chapters list
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: chapters.length,
                  itemBuilder: (context, index) {
                    return ChapterTile(chapter: chapters[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
