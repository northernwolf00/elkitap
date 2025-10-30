import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/modules/library/controllers/note_controller.dart';
import 'package:elkitap/modules/library/model/note_moc.dart';
import 'package:elkitap/modules/library/views/note_datail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => NoteDetailScreen(note: note)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NoteCardHeader(note: note),
            const SizedBox(height: 12),
            NoteCardContent(note: note),
            const SizedBox(height: 12),
            NoteCardFooter(note: note),
          ],
        ),
      ),
    );
  }
}

class NoteCardHeader extends StatelessWidget {
  final Note note;

  const NoteCardHeader({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.book, color: Colors.red[800], size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: TextStyle(fontSize: 16, 
                 fontFamily: StringConstants.SFPro,
                fontWeight: FontWeight.w600),
              ),
              Text(
                note.author,
                style: TextStyle(fontSize: 14, 
                 fontFamily: StringConstants.SFPro,
                color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        NoteMenuButton(note: note),
      ],
    );
  }
}

class NoteMenuButton extends StatelessWidget {
  final Note note;

  const NoteMenuButton({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_horiz),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 'open',
              child: Row(
                children: [
                  Icon(Icons.book_outlined),
                  SizedBox(width: 12),
                  Text('Open book',
                  style: TextStyle(
                     fontFamily: StringConstants.SFPro,
                  ),),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share_outlined),
                  SizedBox(width: 12),
                  Text('Share',
                  style: TextStyle(
                     fontFamily: StringConstants.SFPro,
                  ),),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_outlined),
                  SizedBox(width: 12),
                  Text('Edit',
                  style: TextStyle(
                     fontFamily: StringConstants.SFPro,
                  ),),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Delete', style: TextStyle(color: Colors.red,
                   fontFamily: StringConstants.SFPro,)),
                ],
              ),
            ),
          ],
      onSelected: (value) {
        final controller = Get.find<NotesController>();
        if (value == 'delete') {
          controller.deleteNote(note.id);
        } else if (value == 'edit') {
          Get.to(() => NoteDetailScreen(note: note));
        }
      },
    );
  }
}

class NoteCardContent extends StatelessWidget {
  final Note note;
  const NoteCardContent({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: note.accentColor, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.content,
            style: TextStyle(fontSize: 15,
             fontFamily: StringConstants.NewYork,
             height: 1.5, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Text(
            note.comment,
            style: TextStyle(fontSize: 15,
             fontFamily: StringConstants.SFPro,
             fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class NoteCardFooter extends StatelessWidget {
  final Note note;

  const NoteCardFooter({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${note.timestamp.hour}:${note.timestamp.minute.toString().padLeft(2, '0')} ${_getMonthName(note.timestamp.month)} ${note.timestamp.day}, ${note.timestamp.year}',
      style: TextStyle(fontSize: 13, color: Colors.grey[500],
       fontFamily: StringConstants.SFPro,),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}

class ColorPicker extends StatelessWidget {
  final List<Color> colors = [
    Colors.grey,
    Colors.red,
    Colors.yellow,
    Colors.brown,
    Colors.purple,
    Colors.green,
    Colors.blue,
  ];

 ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NoteDetailController>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            colors.map((color) {
              return Obx(
                () => GestureDetector(
                  onTap: () => controller.updateColor(color),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            controller.selectedColor.value == color
                                ? Colors.black
                                : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
