
class CategoryResponse {
  String message;
  List<SubCategoryDto> results;

  CategoryResponse({
    required this.message,
    required this.results,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> results = json['results'];
    return CategoryResponse(
      message: json['message'],
      results: results.map((e) => SubCategoryDto.fromJson(e)).toList(),
    );
  }
}

class SubCategoryDto {
  final String id;
  final String name;
  final String slug;
  final String category;
  final String image;
  final String createdAt;
  final String updatedAt;
  final int v;

  SubCategoryDto({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SubCategoryDto.fromJson(Map<String, dynamic> json) {
    return SubCategoryDto(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      category: json['category'],
      image: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
