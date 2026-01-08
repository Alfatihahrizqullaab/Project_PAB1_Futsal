import 'package:app_lapangan_futsal/models/lapangan.dart';
import 'package:app_lapangan_futsal/widget/field_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  final List<futsalField> allFields;

  const FavoriteScreen({super.key, required this.allFields});

  @override
  State<FavoriteScreen> createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {
  List<futsalField> favoriteFields = [];

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorite = prefs.getStringList('favorite') ?? [];

    setState(() {
      favoriteFields = widget.allFields
          .where((field) => favorite.contains(field.name))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Favorite',
          style: TextStyle(color: Colors.blue),
        ),
        automaticallyImplyLeading: false,
      ),
      body: favoriteFields.isEmpty
          ? const Center(child: Text('Belum Ada lapangan yang di suka'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteFields.length,
              itemBuilder: (context, index) {
                final field = favoriteFields[index];
                return FieldCard(
                  field: field,
                  // Callback ketika status favorite berubah
                  onFavoriteChanged: () {
                    loadFavorites(); // reload favoriteFields secara realtime
                  },
                );
              },
            ),
    );
  }
}
