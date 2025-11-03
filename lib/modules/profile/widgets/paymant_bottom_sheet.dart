import 'package:elkitap/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PaymentHistoryBottomSheet extends StatelessWidget {
  const PaymentHistoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double sheetHeight = screenHeight * 0.95;
    return Container(
      height: sheetHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor, // Use theme background color
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        children: [
       
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Go back (close bottom sheet)
                  },
                  child: Icon(
                    Icons.arrow_back_ios, // Back icon
                    color: Theme.of(context).iconTheme.color, // Theme-adaptive icon color
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                   'profile'.tr, // Text for 'Profile'
                  style: TextStyle(
                    fontSize: 18,
                     fontFamily: StringConstants.SFPro,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Payment History", // Title of the bottom sheet
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                       fontFamily: StringConstants.SFPro,
                      fontWeight: FontWeight.bold, // Make it bold as in the image
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                ),
                // An empty SizedBox to balance the row if there's no trailing widget
                const SizedBox(width: 46), // Adjust to match combined width of back icon and "Profile" text
              ],
            ),
          ),
         
          Expanded( // Use Expanded to allow the ListView to take available height
            child: ListView(
              padding: EdgeInsets.zero, // Remove default ListView padding
              children: [
                _buildPaymentItem(
                  context,
                  status: "Successfully paid",
                  bankService: "Rysgal Bank",
                  date: "20 Apr 2025 17:34",
                  amount: "50 man",
                  duration: "6 months",
                  isPaid: true,
                ),
                _buildPaymentItem(
                  context,
                  status: "Unpaid",
                  bankService: "Rysgal Bank",
                  date: "20 Apr 2025 17:34",
                  amount: "10 man",
                  duration: "1 months",
                  isPaid: false,
                ),
                _buildPaymentItem(
                  context,
                  status: "Unpaid",
                  bankService: "Reedem",
                  date: "20 Apr 2025 17:34",
                  amount: "10 man",
                  duration: "1 months",
                  isPaid: false,
                ),
                _buildPaymentItem(
                  context,
                  status: "Successfully paid",
                  bankService: "Altyn Asyr",
                  date: "20 Apr 2025 17:34",
                  amount: "10 man",
                  duration: "1 months",
                  isPaid: true,
                ),
                _buildPaymentItem(
                  context,
                  status: "Successfully paid",
                  bankService: "Altyn Asyr",
                  date: "30 Apr 2025 17:34",
                  amount: "10 man",
                  duration: "1 months",
                  isPaid: true,
                ),
                 _buildPaymentItem(
                  context,
                  status: "Successfully paid",
                  bankService: "Altyn Asyr",
                  date: "20 Apr 2025 17:34",
                  amount: "10 man",
                  duration: "1 months",
                  isPaid: true,
                ),
                 _buildPaymentItem(
                  context,
                  status: "Successfully paid",
                  bankService: "Altyn Asyr",
                  date: "20 Apr 2025 17:34",
                  amount: "10 man",
                  duration: "1 months",
                  isPaid: true,
                ),
                 _buildPaymentItem(
                  context,
                  status: "Successfully paid",
                  bankService: "Altyn Asyr",
                  date: "20 Apr 2025 17:34",
                  amount: "10 man",
                  duration: "1 months",
                  isPaid: true,
                  showDivider: false, // No divider for the last item
                ),
                // Add more _buildPaymentItem widgets for more history entries
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(
    BuildContext context, {
    required String status,
    required String bankService,
    required String date,
    required String amount,
    required String duration,
    required bool isPaid,
    bool showDivider = true,
  }) {
    // Define colors based on theme and status
    final Color statusColor = isPaid
        ? Colors.green // Green for 'Successfully paid'
        : Colors.red;   // Red for 'Unpaid'

    final Color primaryTextColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color secondaryTextColor = Theme.of(context).textTheme.bodySmall!.color!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Status, Bank/Service, Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 16,
                         fontFamily: StringConstants.SFPro,
                        fontWeight: FontWeight.w500, // Medium bold
                        color: statusColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      bankService,
                      style: TextStyle(
                        fontSize: 14,
                         fontFamily: StringConstants.SFPro,
                        color: primaryTextColor.withOpacity(0.8), // Slightly less opaque
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                         fontFamily: StringConstants.SFPro,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Right side: Amount, Duration
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 16,
                       fontFamily: StringConstants.SFPro,
                      fontWeight: FontWeight.w500, // Medium bold
                      color: primaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 12,
                       fontFamily: StringConstants.SFPro,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // Indent divider
            child: Divider(
              height: 1,
              color: Theme.of(context).dividerColor.withOpacity(0.5),
              thickness: 0.5,
            ),
          ),
      ],
    );
  }
}

