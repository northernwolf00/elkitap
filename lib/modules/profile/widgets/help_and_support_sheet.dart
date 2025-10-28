import 'package:elkitap/global_widgets/custom_icon.dart';
import 'package:flutter/material.dart';

class HelpAndSupportBottomSheet extends StatelessWidget {
  const HelpAndSupportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor, 
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
     
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).iconTheme.color, 
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Profile", 
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyLarge!.color, // Theme-adaptive text color
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Help and Support", // Title of the bottom sheet
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold, // Make it bold as in the image
                      color: Theme.of(context).textTheme.bodyLarge!.color, // Theme-adaptive text color
                    ),
                  ),
                ),
                // An empty SizedBox to balance the row if there's no trailing widget
                const SizedBox(width: 46), // Adjust to match combined width of back icon and "Profile" text
              ],
            ),
          ),
          
         
         
          Flexible( // Use Flexible to prevent bottom sheet from taking infinite height
            child: ListView(
              shrinkWrap: true, // Make ListView only take the space it needs
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling for this short list
              children: [
                _buildOptionTile(
                  context,
                  icon: 'assets/icons/p8.svg', // Phone icon
                  title: "Call",
                  hasTrailingIcon: false, // No trailing icon for Call
                  onTap: () {
                    // Handle Call tap
                    print("Call tapped");
                  },
                ),
                _buildOptionTile(
                  context,
                  icon: 'assets/icons/p9.svg', // Email icon
                  title: "Email",
                  hasTrailingIcon: false, // No trailing icon for Email
                  onTap: () {
                    // Handle Email tap
                    print("Email tapped");
                  },
                ),
                _buildOptionTile(
                  context,
                  icon: 'assets/icons/p10.svg', // Send icon (for Telegram)
                  title: "Start", // Assuming 'Start' is some chat or quick action
                  hasTrailingIcon: true, // Has trailing icon
                  onTap: () {
                    // Handle Start tap
                    print("Start tapped");
                  },
                ),
                _buildOptionTile(
                  context,
                  icon: 'assets/icons/p10.svg', // Send icon (for Telegram)
                  title: "Telegram",
                  hasTrailingIcon: true, // Has trailing icon
                  showDivider: false, // Last item, no divider below it
                  onTap: () {
                    // Handle Telegram tap
                    print("Telegram tapped");
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), 
          Spacer()
        ],
      ),
    );
  }

  // Helper method to build each ListTile with a divider
  Widget _buildOptionTile(
    BuildContext context, {
    required String icon,
    required String title,
    bool hasTrailingIcon = false,
    bool showDivider = true, // Control divider visibility
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: CustomIcon(title: icon, height: 24, width: 24, 
          color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
          )
         ,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge!.color, // Theme-adaptive text color
            ),
          ),
          trailing: hasTrailingIcon
              ?  CustomIcon(title: 'assets/icons/p11.svg', height: 24, width: 24, 
          color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
          )
              : null,
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        if (showDivider) // Only show divider if true
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // Indent divider
            child: Divider(
              height: 1,
              color: Theme.of(context).dividerColor.withOpacity(0.5), // Theme-adaptive divider color with opacity
              thickness: 0.5,
            ),
          ),
      ],
    );
  }
}

