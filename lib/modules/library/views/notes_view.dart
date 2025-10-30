import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/library/controllers/note_controller.dart';
import 'package:elkitap/modules/library/widgets/note_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotesController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            NotesAppBar(),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.notes.length,
                  itemBuilder: (context, index) {
                    final note = controller.notes[index];
                    return NoteCard(note: note);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotesAppBar extends StatelessWidget {
  const NotesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotesController>();

    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Get.back(),
              child: Row(
                children: [
                  Icon(Icons.chevron_left, color: Colors.blue),
                  Text('Back', style: TextStyle(color: Colors.blue,
                   fontFamily: StringConstants.SFPro,)),
                ],
              ),
            ),
            Text(
              'Notes',
              style: TextStyle(
                fontSize: 34,
                 fontFamily: StringConstants.SFPro,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: controller.isSelectionMode.value
                  ? () => controller.clearSelection()
                  : null,
              child: Text(
                'Select',
                
                style: TextStyle(
                   fontFamily: StringConstants.SFPro,
                  color: controller.isSelectionMode.value
                      ? Colors.blue
                      : Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
