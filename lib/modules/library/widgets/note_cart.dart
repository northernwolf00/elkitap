import 'package:elkitap/core/constants/string_constants.dart';
import 'package:elkitap/core/theme/app_colors.dart';
import 'package:elkitap/modules/library/model/note_moc.dart';
import 'package:elkitap/utils/dialog_utils.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final NoteItem note;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const NoteCard({
    Key? key,
    required this.note,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Opacity(
        opacity: isSelectionMode && !isSelected ? 0.4 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1F1F1F)
                : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          'assets/images/b4.png',
                          fit: BoxFit.fill,
                        )),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: StringConstants.SFPro,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            note.author,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: StringConstants.SFPro,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelectionMode)
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isSelected ? Colors.grey : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? AppColors.mainColor
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.mainColor
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : null,
                          ),
                        ),
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        onPressed: () => DialogUtils.showIOSStylePopup(
                          context,
                          onDelete,
                          () {},
                          onEdit,
                          () {},
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: note.color, width: 4),
                    ),
                  ),
                  child: Text(
                    note.quote,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: StringConstants.NewYork,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  note.comment,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: StringConstants.SFPro,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  note.date,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: StringConstants.SFPro,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
