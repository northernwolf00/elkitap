import 'package:elkitap/modules/store/widgets/book_detail_widget.dart';
import 'package:flutter/material.dart';

class BookDetailView extends StatefulWidget {
  const BookDetailView({super.key});

  @override
  State<BookDetailView> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends State<BookDetailView> {
  bool isAudio = false;

  @override
  Widget build(BuildContext context) {
    final Color accent = const Color(0xFFFF5A3C);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(""),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.add_circle_outline, color: Colors.grey),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Toggle Buttons (Text / Audio)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text("Text"),
                  selected: !isAudio,
                  onSelected: (_) => setState(() => isAudio = false),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text("Audio"),
                  selected: isAudio,
                  onSelected: (_) => setState(() => isAudio = true),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- Book Cover
            Container(
              width: 180,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(
                    isAudio
                        ? 'assets/audio_cover.png'
                        : 'assets/book_cover.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Chip(
              label: Text("🌐 English"),
              backgroundColor: Color(0xFFF4F4F4),
            ),
            const SizedBox(height: 10),

            // --- Title & Author
            const Text(
              "The Subtle Art of Not Giving a F*ck",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 6),
            const Text("Mark Manson", style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 10),
            const Text(
              "Health, Mind & Body • 18+",
              style: TextStyle(color: Colors.black45),
            ),
            const SizedBox(height: 20),

            // --- Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {},
                    child: const Text("Read"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {},
                    child: const Text("Listen"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // --- AI mazmuny Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [Color(0xFFAA5AFF), Color(0xFFFB6B78)],
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                "✨ AI mazmuny",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- About Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Сегодня в рубрике «Профессии» наш гость — региональный директор Üйрекçi. "
              "Он расскажет о трёх книгах, которые научат договариваться, продавать и понимать...",
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // --- Similar Books Section
            sectionTitle("Similar books"),
            horizontalBookList([
              'assets/images/b1.png',
              'assets/images/b2.png',
              'assets/images/b3.png',
            ]),

            // --- More Section
            sectionTitle("More in Health, Mind & Body"),
            horizontalBookList([
              'assets/images/b4.png',
              'assets/images/b5.png',
              'assets/images/b6.png',
            ]),
          ],
        ),
      ),
    );
  }
}
