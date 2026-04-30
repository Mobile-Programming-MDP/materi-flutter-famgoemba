class ItemModel {
  final String? id;
  final String name;
  final String description;
  final String imageUrl;

  ItemModel({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  // Untuk konversi dari Map Firebase ke Object
  factory ItemModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ItemModel(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  get isWishlist => null;

  // Untuk upload ke Firebase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}