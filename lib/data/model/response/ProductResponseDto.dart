import '../../../domain/entities/ProductResponseEntity.dart';

class ProductResponseDto extends ProductResponseEntity {
  ProductResponseDto({
    // super.results,
    // this.metadata,
    this.message,
    super.data,
  });

  ProductResponseDto.fromJson(dynamic json) {
    // results = json['results'];
    message = json['message'];
    // metadata =
    //     json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['results'] != null) {
      data = [];
      json['results'].forEach((v) {
        data?.add(ProductDto.fromJson(v));
      });
    }
  }

  Metadata? metadata;
  String? message;
}

class ProductDto extends ProductEntity {
  ProductDto({
    super.sold,
    super.images,
    super.subcategory,
    super.ratingCount,
    super.id,
    super.title,
    super.slug,
    super.description,
    super.quantity,
    super.price,
    super.imageCover,
    super.category,
    super.brand,
    super.ratingsAverage,
    this.createdAt,
    this.updatedAt,
  });

  String? createdAt;
  String? updatedAt;

  ProductDto.fromJson(dynamic json) {
    sold = json['sold'];
    images = json['images'] != null ? json['images'].cast<String>() : [];

    subcategory:
    json['subcategory'];
    ratingCount = json['ratingCount'];
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];

    category = json['category'];
    brand = json['brand'];
    ratingsAverage = json['ratingAvg'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }
}

class SubcategoryDto extends SubcategoryEntity {
  SubcategoryDto({
    super.id,
    super.name,
    super.slug,
    super.category,
  });

  SubcategoryDto.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    category = json['category'];
  }
}

class Metadata {
  Metadata({
    this.currentPage,
    this.numberOfPages,
    this.limit,
    this.nextPage,
  });

  Metadata.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    numberOfPages = json['numberOfPages'];
    limit = json['limit'];
    nextPage = json['nextPage'];
  }

  int? currentPage;
  int? numberOfPages;
  int? limit;
  int? nextPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = currentPage;
    map['numberOfPages'] = numberOfPages;
    map['limit'] = limit;
    map['nextPage'] = nextPage;
    return map;
  }
}
