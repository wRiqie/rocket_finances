class CategoryModel {
  final int id;
  final String name;
  final String iconUrl;

  CategoryModel({required this.id, required this.name, required this.iconUrl});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      iconUrl: map['icon_url'],
    );
  }
}
