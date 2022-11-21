class Recipe {
  final String id;
  String title;
  String? descr;
  String? imageUrl;


  Recipe({
    required this.id,
    required this.title,
    this.descr,
    this.imageUrl,
  });
}