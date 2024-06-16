import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/my_assets.dart';
import '../../../../core/utils/my_colors.dart';
import '../../../../domain/entities/CategoryOrBrandResponseEntity.dart';
import '../../../../domain/entities/ProductResponseEntity.dart';
import '../../cart/cart_screen.dart';
import '../../product_details/product_details_view.dart';
import '../home_tab/widgets/custom_text_field.dart';
import '../product_list_tab/widgets/grid_view_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailScreen extends StatelessWidget {
  final CategoryOrBrandEntity categoryOrBrandEntity;

  DetailScreen({super.key, required this.categoryOrBrandEntity});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(categoryOrBrandEntity.id);
    List<String> images = [];
    List<int>? ratings = [];
    List<String> titles = [];
    if (categoryOrBrandEntity.name == "dell") {
      images = [
        "assets/mens/tshirt/B24MBSBCKBP100GREENDARK-B24MBSBCKBP100-MXSPR24231023_01-2100.png",
        "assets/mens/tshirt/lush_green_men_base_19_05_2023_700x933 1.png",
        "assets/mens/tshirt/polo.png",
        "assets/mens/tshirt/men-s-duval-v2-t-shirt 1.png",
        "assets/mens/tshirt/mens-nova-combed-cotton-polo-t-shirts-merlot-maroon-side.png",
        "assets/mens/tshirt/s-m9755-navy-98-degree-north-original-imagq9zcgbstpjfz 1.png",
        "assets/mens/tshirt/sportswear-t-shirt-FPcVXK 2.png",
        "assets/mens/tshirt/TS6580UOAY14_BG2_001 1.png",
        "assets/mens/tshirt/White_O_Crew_Regular_NoPocket-bc4d0212-c148-4523-b49c-284e948e0e07 1.png",
      ];
      titles = [
        "Mafia",
        "Hazem",
        "Hazem",
        "Hazem",
        "Hazem",
        "Hazem",
        "Hazem",
        "Mafia",
        "Mafia",
        "Mafia",
        "Mafia",
      ];
      ratings = [
        1, 2, 3, 4, 4,2,3,4,0,1
      ];

      // Combine the lists into a list of tuples
      List<Tuple> items = List.generate(images.length, (index) => Tuple(images[index], titles[index], ratings![index]));

      // Sort the items by rating in descending order
      items.sort((a, b) => b.rating.compareTo(a.rating));

      // Extract the sorted values back into the respective lists
      images = items.map((item) => item.image).toList();
      titles = items.map((item) => item.title).toList();
      ratings = items.map((item) => item.rating).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryOrBrandEntity.name ?? 'No Name'), // Handle null case
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Image.asset(
                MyAssets.logo,
                alignment: Alignment.topLeft,
              ),
              SizedBox(height: 18.0),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(controller: controller,),
                  ),
                  SizedBox(width: 24.0),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                    child: ImageIcon(
                      const AssetImage(MyAssets.shoppingCart),
                      size: 28.0,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              Expanded(
                child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                child: Image.asset(
                                  images[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 128.0,
                                ),
                              ),
                              Positioned(
                                top: 5.0,
                                right: 5.0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 15,
                                  child: IconButton(
                                    icon: const Icon(Icons.favorite_border_rounded),
                                    color: Theme.of(context).primaryColor,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              titles[index],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                fontSize: 14.0,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'EGP 134',
                              maxLines: 1,
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                fontSize: 14.0,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              children: [
                                RatingBarIndicator(
                                  rating:ratings == null ? 0 : ratings[index].toDouble(),
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: Icon(Icons.add_circle, size: 32.0, color: Theme.of(context).primaryColor),
                                  onPressed: () {
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper class to store the combined data
class Tuple {
  final String image;
  final String title;
  final int rating;

  Tuple(this.image, this.title, this.rating);
}




// class DetailScreen extends StatelessWidget {
//   final CategoryOrBrandEntity categoryOrBrandEntity;
//
//    DetailScreen({super.key, required this.categoryOrBrandEntity});
//   final TextEditingController controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     print(categoryOrBrandEntity.id);
//     List<String> images = [];
//     List<int> rating = [];
//     List<String>? title;
//     if (categoryOrBrandEntity.name == "dell") {
//       images = [
//         "assets/mens/tshirt/B24MBSBCKBP100GREENDARK-B24MBSBCKBP100-MXSPR24231023_01-2100.png",
//         "assets/mens/tshirt/lush_green_men_base_19_05_2023_700x933 1.png",
//         "assets/mens/tshirt/polo.png",
//         "assets/mens/tshirt/men-s-duval-v2-t-shirt 1.png",
//         "assets/mens/tshirt/mens-nova-combed-cotton-polo-t-shirts-merlot-maroon-side.png",
//         "assets/mens/tshirt/s-m9755-navy-98-degree-north-original-imagq9zcgbstpjfz 1.png",
//         "assets/mens/tshirt/sportswear-t-shirt-FPcVXK 2.png",
//         "assets/mens/tshirt/TS6580UOAY14_BG2_001 1.png",
//         "assets/mens/tshirt/White_O_Crew_Regular_NoPocket-bc4d0212-c148-4523-b49c-284e948e0e07 1.png",
//       ];
//       title = [
//         "Mafia",
//         "Hazem",
//         "Hazem",
//         "Hazem",
//         "Hazem",
//         "Hazem",
//         "Hazem",
//         "Mafia",
//         "Mafia",
//         "Mafia",
//         "Mafia",
//       ];
//       rating = [
//         1,2,3,4,5,6,7,8,9,10
//       ];
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title:
//             Text(categoryOrBrandEntity.name ?? 'No Name'), // Handle null case
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 17.w),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 10.h),
//               Image.asset(
//                 MyAssets.logo,
//                 alignment: Alignment.topLeft,
//               ),
//               SizedBox(height: 18.h),
//               Row(
//                 children: [
//                    Expanded(
//                     child: CustomTextField(controller: controller,),
//                   ),
//                   SizedBox(width: 24.w),
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context).pushNamed(CartScreen.routeName);
//                     },
//                     child: ImageIcon(
//                       const AssetImage(MyAssets.shoppingCart),
//                       size: 28.sp,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 24.h),
//               Expanded(
//                 child: GridView.builder(
//                   itemCount: images.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 8.0,
//                     mainAxisSpacing: 8.0,
//                     childAspectRatio: 0.75,
//                   ),
//                   itemBuilder: (context, index) {
//                     return Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15.0),
//                         border: Border.all(
//                           color: Theme.of(context).primaryColor,
//                           width: 1,
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Stack(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(15.0),
//                                   topRight: Radius.circular(15.0),
//                                 ),
//                                 child: Image.asset(
//                                   images[index],
//                                   fit: BoxFit.cover,
//                                   width: double.infinity,
//                                   height: 128.0,
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 5.0,
//                                 right: 5.0,
//                                 child: CircleAvatar(
//                                   backgroundColor: Colors.white,
//                                   radius: 15,
//                                   child: IconButton(
//                                     icon: const Icon(Icons.favorite_border_rounded),
//                                     color: Theme.of(context).primaryColor,
//                                     padding: EdgeInsets.zero,
//                                     onPressed: () {
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 7.0),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: Text(
//                               "${title == null ? "ElMon" : title[index]}",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                                 fontSize: 14.0,
//                                 color: Theme.of(context).primaryColorDark,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 7.0),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: Text(
//                               'EGP 134',
//                               maxLines: 1,
//                               style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                                 fontSize: 14.0,
//                                 color: Theme.of(context).primaryColorDark,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 7.0),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                             child: Row(
//                               children: [
//                                 Text(
//                                  "${rating[index]}",
//                                   maxLines: 1,
//                                   style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                                     fontSize: 14.0,
//                                     color: Theme.of(context).primaryColorDark,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 7.0),
//                                 const Icon(Icons.star, size: 16.0, color: Colors.yellow),
//                                 const Spacer(),
//                                 IconButton(
//                                   icon: Icon(Icons.add_circle, size: 32.0, color: Theme.of(context).primaryColor),
//                                   onPressed: () {
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
