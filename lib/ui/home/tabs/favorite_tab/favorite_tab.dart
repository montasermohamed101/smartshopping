import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/my_assets.dart';
import '../home_tab/widgets/custom_search_with_shopping_cart.dart';
import '../product_list_tab/widgets/grid_view_card_item.dart';
import 'package:ecommerce/domain/entities/ProductResponseEntity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteTab extends StatefulWidget {
  @override
  _FavoriteTabState createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  List<ProductEntity> favoriteProducts = [];
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    loadFavoriteProducts();
  }
  Future<void> loadFavoriteProducts() async {
    prefs = await SharedPreferences.getInstance();
    List<String> favoriteProductJsons = prefs!.getStringList('wishlist') ?? [];

    setState(() {
      favoriteProducts = favoriteProductJsons
          .map((productJson) {
        try {
          final Map<String, dynamic> jsonMap = jsonDecode(productJson);
          return ProductEntity.fromJson(jsonMap);
        } catch (e) {
          // Handle the error or log it
          print("Error decoding JSON: $e");
          return null; // Returning null to filter out invalid entries
        }
      })
          .where((product) => product != null) // Filter out null entries
          .cast<ProductEntity>()
          .toList();
    });
  }

  Future<void> loadFavoriteProducts2() async {
    prefs = await SharedPreferences.getInstance();
    List<String> favoriteProductJsons = prefs!.getStringList('wishlist') ?? [];
    setState(() {
      favoriteProducts = favoriteProductJsons
          .map((productJson) => ProductEntity.fromJson(jsonDecode(productJson)))
          .toList();
    });
  }

  Future<void> removeFromWishlist(ProductEntity productEntity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('wishlist') ?? [];
    String productJson = jsonEncode(productEntity.toJson());
    if (wishlist.contains(productJson)) {
      wishlist.remove(productJson);
      await prefs.setStringList('wishlist', wishlist);
      setState(() {
        favoriteProducts.remove(productEntity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favorite Products'),
        ),
        body: favoriteProducts.isEmpty
            ? Center(child: Text('No favorite products yet.'))
            : ListView.builder(
          itemCount: favoriteProducts.length,
          itemBuilder: (context, index) {
            ProductEntity product = favoriteProducts[index];
            return ListTile(
              title: Text(product.title ?? "No Title"),
              subtitle:
              Text("EGP ${product.price ?? 'Unknown Price'}"),
              leading: product.imageCover != null
                  ? Image.network(product.imageCover!)
                  : null,
              trailing: IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  removeFromWishlist(product);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

