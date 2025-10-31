import 'package:elkitap/modules/audio_player/model/chapter.dart';
import 'package:flutter/material.dart';

class ChapterTile extends StatelessWidget {
  final Chapter chapter;

  const ChapterTile({Key? key, required this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chapter.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${chapter.duration} • ${chapter.size}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.download_rounded,
            color: chapter.isDownloaded ? Colors.white : const Color(0xFFFF5722),
            size: 28,
          ),
        ],
      ),
    );
  }
}