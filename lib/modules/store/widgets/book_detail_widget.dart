import 'package:elkitap/modules/genre/view/books_grid_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget sectionTitle(String title) {
  return GestureDetector(
    onTap: () {
      Get.to(() => BooksGridScreen(
            title: title,
          ));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                fontFamily: 'NewYork',
                fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black45),
        ],
      ),
    ),
  );
}

Widget horizontalBookList(List<String> covers) {
  return SizedBox(
    height: 140,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: covers.length,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (_, i) => Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(covers[i]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
