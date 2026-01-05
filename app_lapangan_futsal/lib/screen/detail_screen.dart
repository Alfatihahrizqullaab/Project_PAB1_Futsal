import 'dart:async';
import 'package:app_lapangan_futsal/screen/detail_view_screen.dart';
import 'package:app_lapangan_futsal/screen/give_rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_lapangan_futsal/models/lapangan.dart';

class DetailScreen extends StatefulWidget {
  final futsalField field;

  const DetailScreen({super.key, required this.field});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;
  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
    _loadFavoriteStatus();
  }

  void _checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool signedIn = prefs.getBool('isSignedIn') ?? false;
    setState(() {
      isSignedIn = signedIn;
    });
  }

  // Memeriksa status Favorite
  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorite = prefs.getStringList('favorite') ?? [];

    setState(() {
      isFavorite = favorite.contains(widget.field.name);
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // memeriksa apakan pengguna sudah login
    if (!isSignedIn) {
      Navigator.pushNamed(context, '/signin');
      return;
    }

    List<String> favorite = prefs.getStringList('favorite') ?? [];

    setState(() {
      if (favorite.contains(widget.field.name)) {
        favorite.remove(widget.field.name);
        isFavorite = false;
      } else {
        favorite.add(widget.field.name);
        isFavorite = true;
      }
    });

    await prefs.setStringList('favorite', favorite);

    setState(() {});
  }

  // Badge and Rating
  Widget _excellentPitchCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // LEFT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Excellent pitch',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 6),

                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailViewScreen(field: widget.field),
                        ),
                      ),

                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'View Detail',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),

                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => GiveRatingScreen()),
                        );

                        if (result != null && mounted) {
                          // Kirim Comment ke Detail Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailViewScreen(
                                field: widget.field,
                                newReview: result,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 149, 8),
                          border: Border.all(
                            color: const Color.fromARGB(255, 243, 149, 8),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Give a Rating',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // RIGHT
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: const Color.fromARGB(255, 243, 149, 8),
                    size: 35,
                  ),
                  SizedBox(width: 4),
                  Text(
                    widget.field.rating.toString(),
                    style: TextStyle(
                      color: const Color.fromARGB(255, 243, 149, 8),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2),
              Text(
                '(${widget.field.reviews ~/ 1000}k+)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Header
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  widget.field.image,
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Back Button
                Positioned(
                  top: 16,
                  left: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.35),
                    foregroundColor: Colors.black,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new, color: Colors.blue),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                // Badge and Rating dipanggil disini
                Transform.translate(
                  offset: Offset(0, 180),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: _excellentPitchCard(),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(16, 56, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title and Favorite
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.field.name,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        iconSize: 30,
                        icon: Icon(
                          isSignedIn && isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isSignedIn && isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          _toggleFavorite();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  SizedBox(height: 12),

                  //Addres
                  Text(
                    widget.field.address,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 14),

                  //Proce and Time
                  Row(
                    children: [
                      Icon(Icons.attach_money, color: Colors.green),
                      SizedBox(width: 6),
                      Text(
                        widget.field.price,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 40),

                      Icon(Icons.access_time_filled, color: Colors.red),
                      SizedBox(width: 6),
                      Expanded(child: Text(widget.field.openHour)),
                    ],
                  ),
                  SizedBox(height: 16),

                  //Contact Icons
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blue),
                      SizedBox(width: 6),
                      Text(widget.field.phone),
                      SizedBox(width: 34),

                      GestureDetector(
                        onTap: () {},
                        child: Image.asset('assets/logo-ig.png', height: 24),
                      ),
                      SizedBox(width: 14),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/logo-tiktok.png',
                          height: 24,
                        ),
                      ),
                      SizedBox(width: 14),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset('assets/logo-wa.png', height: 24),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  Divider(thickness: 1, color: Colors.grey),
                  SizedBox(height: 20),

                  //Description
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 8),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.field.facilitas
                        .map(
                          (item) => Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text('• $item'),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
