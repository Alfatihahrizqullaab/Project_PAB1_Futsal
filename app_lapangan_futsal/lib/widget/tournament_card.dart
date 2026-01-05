import 'package:flutter/material.dart';
import 'package:app_lapangan_futsal/models/tournament.dart';

class TournamentCard extends StatelessWidget {
  final Tournament item;

  const TournamentCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item.image,
                width: 145,
                height: 185,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),

            //Konten
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Chip judul
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),

                  //Harga
                  Text(
                    item.price,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),

                  //Peserta
                  Row(
                    children: [
                      const Icon(Icons.people, size: 16, color: Colors.red),
                      const SizedBox(width: 4),
                      Text("${item.joined}/${item.quota}"),
                    ],
                  ),
                  SizedBox(height: 4),

                  //Tanggal
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.green),
                      SizedBox(width: 4),
                      Text(item.date),
                    ],
                  ),
                  SizedBox(height: 6),

                  // Deskripsi
                  Text(
                    item.description,
                    style: TextStyle(fontSize: 12, color: Colors.green[700]),
                  ),
                  SizedBox(width: 20)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
