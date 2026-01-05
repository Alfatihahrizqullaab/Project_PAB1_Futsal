import 'package:app_lapangan_futsal/models/lapangan.dart';
// import 'package:app_lapangan_futsal/screen/detail_screen.dart';
import 'package:app_lapangan_futsal/widget/field_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  final List<futsalField> allFields;

  const FavoriteScreen({super.key, required this.allFields});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<futsalField> favoriteFields = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorite = prefs.getStringList('favorite') ?? [];

    setState(() {
      favoriteFields = widget.allFields
      .where((field) => favorite
      .contains(field.name)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Favorite', 
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: favoriteFields.isEmpty 
            ? Center(child: Text('Belum Ada lapangan yang di suka'))
            : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: favoriteFields.length,
              itemBuilder: (context, index) {
                return FieldCard(field: favoriteFields[index]);
              },
            )
    );
  }
}