import 'package:elkitap/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchingHeader extends StatelessWidget {
  const SearchingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 26),
       
   
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width:MediaQuery.of(context).size.width - 100 ,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
    ? Colors.grey[800] 
    : Colors.grey[100],
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
                  Spacer(),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Icon(Icons.close,
                        size: 14,),
                      ),
                    ),
                  )
                  , 
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
           
           GestureDetector(
            onTap: (){
              Get.back();
            },
             child: Text('Cancel',
              style: TextStyle(
              fontFamily: StringConstants.SFPro,
                fontSize: 16
              ),),
           ),
             
          ],
        ),
      ],
    );
  }
}
