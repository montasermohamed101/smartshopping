import 'package:ecommerce/core/utils/my_assets.dart';
import 'package:ecommerce/core/utils/my_colors.dart';
import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/data/model/response/sub_category_model.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


import '../../cart/cart_screen.dart';
class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String selectedCategory = '';
  TextEditingController controller = TextEditingController();
  Map<String, List<SubCategoryDto>> categories = {
    'Men\'s Fashion': [],
    'Women\'s Fashion': [],
    'Skincare': [],
    'Beauty': [],
    'Cameras': [],
    'Mobile': [],
    'Laptop': [],
    'Baby & Toys': [],
  };
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchSubCategories();
  }
  final Map<String, String> categoryImages = {
    'Men\'s Fashion': 'assets/images/Frame 32.png',
    'Women\'s Fashion': 'assets/images/Frame 31.png',
    'Skincare': 'assets/images/skincare.png',
    'Beauty': 'assets/images/beauty.png',
    'Cameras': 'assets/images/camera cover.png',
    'Mobile': 'assets/images/mobile.png',
    'Laptop': 'assets/images/laptop cover.png',
    'Baby & Toys': 'assets/images/toys 1.png',
  };
  Future<void> fetchSubCategories() async {
    final apiManager = ApiManager.getInstance();
    final result = await apiManager.getSubCategories();

    result.fold(
          (failure) {
        setState(() {
          isLoading = false;
          errorMessage = failure.errorMessage ?? 'Failed to load data.';
        });
      },
          (subCategories) {
        setState(() {
          isLoading = false;
          categories.forEach((key, value) {
            categories[key] = [];
          });
          for (var subCategory in subCategories) {
            if (categories.containsKey("Men's Fashion") &&
                ["t-shirts", "jeans", "pants", "footwear", "suits", "watches", "eyewears"].contains(subCategory.name)) {
              categories["Men's Fashion"]!.add(subCategory);
            } else if (categories.containsKey("Women's Fashion") &&
                ["Dresses", "Jeans", "Skirts", "Pajamas", "Bags", "T-shirt", "Footwear", "Watches"].contains(subCategory.name)) {
              categories["Women's Fashion"]!.add(subCategory);
            } else if (categories.containsKey("Skincare") &&
                ["Moisturizer", "Cleanser", "Sheet mask", "Sunblock", "Face Oil"].contains(subCategory.name)) {
              categories["Skincare"]!.add(subCategory);
            } else if (categories.containsKey("Beauty") &&
                ["Foundation", "Concealer", "Primer", "Lip gloss", "Blusher"].contains(subCategory.name)) {
              categories["Beauty"]!.add(subCategory);
            } else if (categories.containsKey("Cameras") &&
                ["DSLR", "mirrorless"].contains(subCategory.name)) {
              categories["Cameras"]!.add(subCategory);
            } else if (categories.containsKey("Mobile") &&
                ["ios", "Android"].contains(subCategory.name)) {
              categories["Mobile"]!.add(subCategory);
            } else if (categories.containsKey("Laptop") &&
                ["Gaming Laptops", "Business Laptops"].contains(subCategory.name)) {
              categories["Laptop"]!.add(subCategory);
            } else if (categories.containsKey("Baby & Toys") &&
                ["Scooter"].contains(subCategory.name)) {
              categories["Baby & Toys"]!.add(subCategory);
            }
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      MyAssets.logo,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                         Expanded(
                          child: CustomTextField(
                            controller: controller,
                          ),
                        ),
                        const SizedBox(width: 24),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(CartScreen.routeName);
                          },
                          child: const ImageIcon(
                            AssetImage(MyAssets.shoppingCart),
                            size: 28,
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                  ? Center(child: Text(errorMessage))
                  : Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 150,
                      color: const Color.fromARGB(128, 219, 228, 237),
                      child: ListView(
                        children: categories.keys.map((category) {
                          return Container(
                            color: selectedCategory == category
                                ? Colors.white
                                : const Color.fromARGB(128, 219, 228, 237),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    category,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(6, 0, 79, 1),
                                    ),
                                  ),
                                  const SizedBox(height: 27),
                                  const Text(
                                    '',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: selectedCategory.isEmpty
                        ? const Center(child: Text('Select a category'))
                        : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              16.0, 16.0, 16.0, 8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                selectedCategory,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromRGBO(6, 0, 79, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            categoryImages[selectedCategory]!,
                            width: 500,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.5,
                            ),
                            itemCount: categories[selectedCategory]!.length,
                            itemBuilder: (BuildContext context, int index) {
                              var subcategory = categories[selectedCategory]![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SubcategoryPage(
                                        category:  subcategory.name,
                                        subcategory: subcategory.name,
                                        imageUrl: subcategory.image,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Image.network(
                                        subcategory.image,
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        subcategory.name,
                                        style: const TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SubcategoryPage extends StatelessWidget {
  final String category;
  final String subcategory;
  final String imageUrl;

  SubcategoryPage({
    required this.category,
    required this.subcategory,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    List<String> images;
    List<String>? title;
    List<int> ratings = [];

    if (category == "t-shirts") {
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
      title = [
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
      ratings = [3, 4, 2, 5, 3, 4, 2, 5, 3];
    }
    else if (category == "Skirts") {
      images = [
        "assets/women/skirts/1.png",
        "assets/women/skirts/24-0143_W_Classic_Pleated_Skirt_W_DKC_640x740.png",
        "assets/women/skirts/2778600-home_default 1.png",
        "assets/women/skirts/7636681_1547316.png",
        "assets/women/skirts/8225127_khaki.png",
        "assets/women/skirts/718779617_max.png",
        "assets/women/skirts/aeda641d5b9c7c0d60a7d632e7ded6b3--tights-and-heels-plaid-outfits.png",
        "assets/women/skirts/be2b7a408de24962cc811fbcf543e505.png",
        "assets/women/skirts/BKBD-206-2__Tartan_018__74550.png",
        "assets/women/skirts/Skirts-for-Women-Women-s-Summer-Cute-High-Waist-Ruffle-Skirt-Print-Swing-Beach-Mini-Skirt-Women-s-Skirts-Black-L_dd8221f3-3d95-4350-9c7a-6861183cf187.png",
      ];
      title = [
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
      ratings = [4, 5, 3, 4, 2, 5, 4, 3, 2];
    }
    else if(category == "pants"){
      images = [
        "assets/mens/pants/1.png",
        "assets/mens/pants/1 (1).png",
        "assets/mens/pants/2.png",
        "assets/mens/pants/71NE8DcDW7L.png",
        "assets/mens/pants/45934e04-84d0-4e10-aafa-14a6bcc571f5.png",
        "assets/mens/pants/American-Tall-Men-Traveler-Chino-Pants-LightKhaki-front.png",
        "assets/mens/pants/Group_4_878378ec-4548-49ad-8e07-b59c1e551e60.png",
        "assets/mens/pants/images.png",
        "assets/mens/pants/Jeans-Men-s-2023-Spring-New-Korean-Style-of-Elastic-Straight-Jeans-Casual-Pants.png",
        "assets/mens/pants/s-l1200.png",
      ];
      title = [
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
      ratings = [3, 4, 5, 2, 3, 4, 5, 2, 3];
    } else if(category == "jeans"){
      images = [
        "assets/mens/shorts/41J1vmywiZL.png",
        "assets/mens/shorts/070642f4e6b058db5a774300e18d5841.png",
        "assets/mens/shorts/1714140388-mhl-0416240746-copy-2-662bb4d0c9065.png",
        "assets/mens/shorts/A6431AX_23SM_NM41_01_01.png",
        "assets/mens/shorts/images.png",
        "assets/mens/shorts/images (1).png",
        "assets/mens/shorts/images (2).png",
        "assets/mens/shorts/images (3).png",
        "assets/mens/shorts/opchic-1750-1013756-1 1.png",
        "assets/mens/shorts/Vedolay-Men-s-Shorts-Shorts-for-Men-Men-s-Sports-Casual-Jogging-Trousers-Lightweight-Hiking-Work-Shorts-Outdoor-Short-Red-M_16700e51-bacd-4b2e-a3b4-6f90a51117bb.png",
      ];
      title = [
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
      ];
      ratings = [2, 5, 4, 3, 2, 5, 4, 3, 2,4, 3, 2];
    } else if(category == "footwear"){
      images = [
        "assets/mens/footwear/1e9a7c9daa62a9d0e9e0c5c31b50fed0f9239c2e_original.png",
        "assets/mens/footwear/1f6bf62b-fc7e-4372-a419-88862ca9b852.png",
        "assets/mens/footwear/51asACj8+sL.png",
        "assets/mens/footwear/767c171086ce429c5f918a78f311002ddf41cf1c_original.png",
        "assets/mens/footwear/17037357136e85a9206151708676fcdb6942857bca_thumbnail_720x.png",
        "assets/mens/footwear/b88a648b-4523-4d1e-824a-4bbc10f0e117_800x800.png",
        "assets/mens/footwear/b74676b3e60feade8a5f46ba3dcd2379.png",
        "assets/mens/footwear/Big-Size-40-48-Men-Sneakers-Soft-Men-Casual-Shoes-Breathable-Mesh-Fashion-Dropship-Loafers-Office.png",
        "assets/mens/footwear/dj6106-001_12.png",
        "assets/mens/footwear/S1efa2f0a794f40cba186c91ca878b59eS.png",
      ];
      title = [
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
      ratings = [4, 2, 5, 3, 4, 2, 5, 3, 4,4, 3, 2];
    }else if (category == "Skincare") {
      images = [
        "assets/images/camera cover.png",
        "assets/images/camera cover.png",
        "assets/images/camera cover.png",
        "assets/images/camera cover.png",
        "assets/images/Frame 31.png",
        "assets/images/Frame 31.png",
        "assets/images/Frame 31.png",
        "assets/images/Frame 31.png",
        "assets/images/banner-3.png",
        "assets/images/banner-3.png",
      ];
      title = [
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
      ratings = [3, 4, 5, 2, 3, 4, 5, 2, 3];
    } else {
      images = [];
      title = [];
      ratings = [];
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('$subcategory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.8,
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
                      "${title == null ? "ElMon" : title[index]}",
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
                          rating: ratings[index].toDouble(),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 16.0,
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
    );
  }
}




// class SubcategoryPage extends StatelessWidget {
//   final String category;
//   final String subcategory;
//   final String imageUrl;
//
//   SubcategoryPage({
//     required this.category,
//     required this.subcategory,
//     required this.imageUrl,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> images;
//     List<String>? title;
//     if (category == "t-shirts") {
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
//     }
//     else if (category == "Skirts") {
//       images = [
//         "assets/women/skirts/1.png",
//         "assets/women/skirts/24-0143_W_Classic_Pleated_Skirt_W_DKC_640x740.png",
//         "assets/women/skirts/2778600-home_default 1.png",
//         "assets/women/skirts/7636681_1547316.png",
//         "assets/women/skirts/8225127_khaki.png",
//         "assets/women/skirts/718779617_max.png",
//         "assets/women/skirts/aeda641d5b9c7c0d60a7d632e7ded6b3--tights-and-heels-plaid-outfits.png",
//         "assets/women/skirts/be2b7a408de24962cc811fbcf543e505.png",
//         "assets/women/skirts/BKBD-206-2__Tartan_018__74550.png",
//         "assets/women/skirts/Skirts-for-Women-Women-s-Summer-Cute-High-Waist-Ruffle-Skirt-Print-Swing-Beach-Mini-Skirt-Women-s-Skirts-Black-L_dd8221f3-3d95-4350-9c7a-6861183cf187.png",
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
//     }
//     else if(category == "pants"){
//       images = [
//         "assets/mens/pants/1.png",
//         "assets/mens/pants/1 (1).png",
//         "assets/mens/pants/2.png",
//         "assets/mens/pants/71NE8DcDW7L.png",
//         "assets/mens/pants/45934e04-84d0-4e10-aafa-14a6bcc571f5.png",
//         "assets/mens/pants/American-Tall-Men-Traveler-Chino-Pants-LightKhaki-front.png",
//         "assets/mens/pants/Group_4_878378ec-4548-49ad-8e07-b59c1e551e60.png",
//         "assets/mens/pants/images.png",
//         "assets/mens/pants/Jeans-Men-s-2023-Spring-New-Korean-Style-of-Elastic-Straight-Jeans-Casual-Pants.png",
//         "assets/mens/pants/s-l1200.png",
//       ];
//     } else if(category == "jeans"){
//       images = [
//         "assets/mens/shorts/41J1vmywiZL.png",
//         "assets/mens/shorts/070642f4e6b058db5a774300e18d5841.png",
//         "assets/mens/shorts/1714140388-mhl-0416240746-copy-2-662bb4d0c9065.png",
//         "assets/mens/shorts/A6431AX_23SM_NM41_01_01.png",
//         "assets/mens/shorts/images.png",
//         "assets/mens/shorts/images (1).png",
//         "assets/mens/shorts/images (2).png",
//         "assets/mens/shorts/images (3).png",
//         "assets/mens/shorts/opchic-1750-1013756-1 1.png",
//         "assets/mens/shorts/Vedolay-Men-s-Shorts-Shorts-for-Men-Men-s-Sports-Casual-Jogging-Trousers-Lightweight-Hiking-Work-Shorts-Outdoor-Short-Red-M_16700e51-bacd-4b2e-a3b4-6f90a51117bb.png",
//       ];
//     } else if(category == "footwear"){
//       images = [
//         "assets/mens/footwear/1e9a7c9daa62a9d0e9e0c5c31b50fed0f9239c2e_original.png",
//         "assets/mens/footwear/1f6bf62b-fc7e-4372-a419-88862ca9b852.png",
//         "assets/mens/footwear/51asACj8+sL.png",
//         "assets/mens/footwear/767c171086ce429c5f918a78f311002ddf41cf1c_original.png",
//         "assets/mens/footwear/17037357136e85a9206151708676fcdb6942857bca_thumbnail_720x.png",
//         "assets/mens/footwear/b88a648b-4523-4d1e-824a-4bbc10f0e117_800x800.png",
//         "assets/mens/footwear/b74676b3e60feade8a5f46ba3dcd2379.png",
//         "assets/mens/footwear/Big-Size-40-48-Men-Sneakers-Soft-Men-Casual-Shoes-Breathable-Mesh-Fashion-Dropship-Loafers-Office.png",
//         "assets/mens/footwear/dj6106-001_12.png",
//         "assets/mens/footwear/S1efa2f0a794f40cba186c91ca878b59eS.png",
//       ];
//     }else if (category == "Skincare") {
//       images = [
//         "assets/images/camera cover.png",
//         "assets/images/camera cover.png",
//         "assets/images/camera cover.png",
//         "assets/images/camera cover.png",
//         "assets/images/Frame 31.png",
//         "assets/images/Frame 31.png",
//         "assets/images/Frame 31.png",
//         "assets/images/Frame 31.png",
//         "assets/images/banner-3.png",
//         "assets/images/banner-3.png",
//       ];
//     } else {
//       images = [];
//     }
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$subcategory'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           itemCount: images.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 8.0,
//             mainAxisSpacing: 8.0,
//             childAspectRatio: 0.8,
//           ),
//           itemBuilder: (context, index) {
//             return Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.0),
//                 border: Border.all(
//                   color: Theme.of(context).primaryColor,
//                   width: 1,
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(15.0),
//                           topRight: Radius.circular(15.0),
//                         ),
//                         child: Image.asset(
//                           images[index],
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                           height: 128.0,
//                         ),
//                       ),
//                       Positioned(
//                         top: 5.0,
//                         right: 5.0,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.white,
//                           radius: 15,
//                           child: IconButton(
//                             icon: const Icon(Icons.favorite_border_rounded),
//                             color: Theme.of(context).primaryColor,
//                             padding: EdgeInsets.zero,
//                             onPressed: () {
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 7.0),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       "${title == null ? "ElMon" : title[index]}",
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                         fontSize: 14.0,
//                         color: Theme.of(context).primaryColorDark,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 7.0),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       'EGP 134',
//                       maxLines: 1,
//                       style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                         fontSize: 14.0,
//                         color: Theme.of(context).primaryColorDark,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 7.0),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Review (3)',
//                           maxLines: 1,
//                           style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                             fontSize: 14.0,
//                             color: Theme.of(context).primaryColorDark,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(width: 7.0),
//                         const Icon(Icons.star, size: 16.0, color: Colors.yellow),
//                         const Spacer(),
//                         IconButton(
//                           icon: Icon(Icons.add_circle, size: 32.0, color: Theme.of(context).primaryColor),
//                           onPressed: () {
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




