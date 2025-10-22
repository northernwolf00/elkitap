import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 26),
        const Text(
          "Search",
          style: TextStyle(
            fontSize: 34,
            fontFamily: 'New York',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 6,
                      bottom: 6,
                    ),
                    child: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: TextFormField(
                    maxLines: 1,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),

                    onChanged: (_) {},
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
