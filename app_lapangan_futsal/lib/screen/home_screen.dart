// import 'package:app_lapangan_futsal/widget/field_card.dart';
import 'package:app_lapangan_futsal/data/lapangan_data.dart';
import 'package:app_lapangan_futsal/models/lapangan.dart';
import 'package:app_lapangan_futsal/screen/notifikasi_screen.dart';
import 'package:app_lapangan_futsal/widget/field_card.dart';
import 'package:flutter/material.dart';
import 'package:app_lapangan_futsal/screen/favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<FavoriteScreenState> favoriteKey;
  const HomeScreen({super.key, required this.favoriteKey});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<futsalField> filterFields = [];

  @override
  void initState() {
    super.initState();
    filterFields = fields;
  }

  void _filterFields(String query) {
    setState(() {
      filterFields = fields.where((field) {
        final name = field.name.toLowerCase();
        final location = field.location.toLowerCase();
        final search = query.toLowerCase();

        return name.contains(search) || location.contains(search);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fri, 11 march',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => NotificationDemo()),
                      );
                    },
                    icon: Icon(
                      Icons.notifications_none,
                      size: 28,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              //SEARCH
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  _filterFields(value);
                },
                decoration: InputDecoration(
                  hintText: 'Find the nearst field location',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),

              //TITLE
              Text(
                'Last field viewed',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),

              //LIST LAPANGAN
              Expanded(
                child: filterFields.isEmpty
                    ? Center(
                        child: Text(
                          'Lapangan tidak ditemukan',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filterFields.length,
                        itemBuilder: (context, index) {
                          final field = filterFields[index];
                          return FieldCard(
                            field: field,
                            onFavoriteChanged: () {
                              // callback ke FavoriteScreen via GlobalKey dari MainScreen
                              widget.favoriteKey.currentState?.loadFavorites();
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
