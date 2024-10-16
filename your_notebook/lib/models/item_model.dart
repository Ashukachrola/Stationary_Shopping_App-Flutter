class Item {
  final String imageUrl;
  final String title;

  Item({required this.imageUrl, required this.title});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      imageUrl: json['download_url'], // Use 'download_url' from Picsum API
      title: json['author'], // Use 'author' from Picsum API as title
    );
  }
}
