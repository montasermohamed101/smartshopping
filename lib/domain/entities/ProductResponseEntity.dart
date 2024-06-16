


class ProductResponseEntity {
  ProductResponseEntity({
    // this.results,
    this.data,
  });

  // int? results;
  List<ProductEntity>? data;
}



class ProductEntity {
  ProductEntity({
    this.sold,
    this.images,
    this.subcategory,
    this.ratingCount,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
  });

  int? sold;
  List<String>? images;
  String? subcategory;
  num? ratingCount;
  String? id;
  String? title;
  String? slug;
  String? description;
  int? quantity;
  int? price;
  String? imageCover;
  String? category;
  String? brand;
  num? ratingsAverage;

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    sold: json['sold'],
    images: List<String>.from(json['images']),
    subcategory: json['subcategory'],
    ratingCount: json['ratingCount'],
    id: json['id'],
    title: json['title'],
    slug: json['slug'],
    description: json['description'],
    quantity: json['quantity'],
    price: json['price'],
    imageCover: json['imageCover'],
    category: json['category'],
    brand: json['brand'],
    ratingsAverage: json['ratingsAverage'],
  );

  Map<String, dynamic> toJson() => {
    'sold': sold,
    'images': images,
    'subcategory': subcategory,
    'ratingCount': ratingCount,
    'id': id,
    'title': title,
    'slug': slug,
    'description': description,
    'quantity': quantity,
    'price': price,
    'imageCover': imageCover,
    'category': category,
    'brand': brand,
    'ratingsAverage': ratingsAverage,
  };
}



class SubcategoryEntity {
  SubcategoryEntity({
    this.id,
    this.name,
    this.slug,
    this.category,
  });

  String? id;
  String? name;
  String? slug;
  String? category;
}
