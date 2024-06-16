class CartResponseModel {
  final String message;
  final Cart cart;

  CartResponseModel({
    required this.message,
    required this.cart,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      CartResponseModel(
        message: json["message"],
        cart: Cart.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "cart": cart.toJson(),
      };
}

class Cart {
  final String id;
  final String user;
  final List<CartItemData> cartItems;
  final num? totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Cart({
    required this.id,
    required this.user,
    required this.cartItems,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        user: json["user"],
        cartItems: List<CartItemData>.from(
            json["cartItems"].map((x) => CartItemData.fromJson(x))),
        totalPrice: json["totalPrice"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class CartItemData {
  final String product;
  final int quantity;
  final int price;
  final String id;

  CartItemData({
    required this.product,
    required this.quantity,
    required this.price,
    required this.id,
  });

  factory CartItemData.fromJson(Map<String, dynamic> json) => CartItemData(
        product: json["product"],
        quantity: json["quantity"],
        price: json["price"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "price": price,
        "_id": id,
      };
}
