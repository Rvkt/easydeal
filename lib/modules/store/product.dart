class Product {
   int id;
   String name;
   double price;
   String image; // Path or URL to the image
   int discount; // Discount in percentage

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.discount,
  });
}
