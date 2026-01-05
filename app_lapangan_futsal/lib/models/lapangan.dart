class futsalField {
  final String name;
  final String address;
  final String location;
  final String image;
  final String distance;
  //Detail
  final double rating;
  final int reviews;
  final String price;
  final String openHour;
  final String phone;
  final List<String> facilitas;
  bool isFavorite;

  futsalField({
    required this.name,
    required this.address,
    required this.location,
    required this.image,
    required this.distance,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.openHour,
    required this.phone,
    required this.facilitas,
    this.isFavorite = false,
  });
}
