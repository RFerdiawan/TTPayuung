class WellnessProductModel {
  final String id;
  final String name;
  final int price;
  final String type;
  final String image;
  final int minPurchase;
  final int maxPurchase;
  final String description;
  final bool wishlist;

  WellnessProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.image,
    required this.minPurchase,
    required this.maxPurchase,
    required this.description,
    required this.wishlist,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'type': type,
      'image': image,
      'minPurchase': minPurchase,
      'maxPurchase': maxPurchase,
      'description': description,
      'wishlist': wishlist,
    };
  }

  factory WellnessProductModel.fromJson(Map<String, dynamic> json) {
    return WellnessProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      type: json['type'],
      image: json['image'],
      minPurchase: json['minPurchase'],
      maxPurchase: json['maxPurchase'],
      description: json['description'],
      wishlist: json['wishlist'],
    );
  }
}
