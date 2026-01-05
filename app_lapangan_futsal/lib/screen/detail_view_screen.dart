import 'package:app_lapangan_futsal/models/review.dart';
import 'package:flutter/material.dart';
import 'package:app_lapangan_futsal/models/lapangan.dart';

class DetailViewScreen extends StatefulWidget {
  final futsalField field;
  final Review? newReview;

  const DetailViewScreen({super.key, required this.field, this.newReview});

  @override
  State<DetailViewScreen> createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen> {
  final List<Review> reviews = [
    // Review Item Dummy
    Review(
      name: 'Juned',
      date: '6 Oktober 2024',
      rating: 4.4,
      comment:
          'Lapangan di Big One sangat bersih dan terawat. Detail kebersihan diperhatikan sampai ke bagian kecil seperti sudut-sudut dan area yang jarang terlihat.',
    ),
    Review(
      name: 'Pace',
      date: '7 September 2024',
      rating: 4.9,
      comment:
          'Mulai dari lantai lapangan, pencahayaan, sampai fasilitas, semuanya terasa dipikirkan dengan baik.',
    ),
    Review(
      name: 'Abel',
      date: '8 Agustus 2024',
      rating: 4.8,
      comment:
          'Hal yang paling bikin kagum adalah seberapa detail mereka menjaga kebersihan.',
    ),
  ];

  @override
  void initState() {
    super.initState();

    if (widget.newReview != null) {
      reviews.insert(0, widget.newReview!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail rating',
          style: TextStyle(color: Colors.blue),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _ratingSummary(),
            const SizedBox(height: 20),

            // Review Item tampilkan ketika ada comment baru
            Column(
              children: reviews.map((review) {
                return _reviewItem(
                  name: review.name, 
                  date: review.date, 
                  rating: review.rating, 
                  comment: review.comment
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _ratingSummary() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.field.rating.toString(),
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('10K+ rating', style: TextStyle(color: Colors.grey)),
            ],
          ),
          Spacer(),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < 4 ? Icons.star : Icons.star_half,
                color: Colors.orange,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= REVIEW ITEM =================
  Widget _reviewItem({
    required String name,
    required String date,
    required double rating,
    required String comment,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16), // 🔧 DIUBAH: pakai const
      padding: EdgeInsets.all(16), // 🔧 DIUBAH: pakai const
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.person, color: Colors.blue),
              ),
              SizedBox(width: 12), // 🔧 DIUBAH: pakai const
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ), // 🔧 DIUBAH: pakai const
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.orange.withOpacity(0.15),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 4), // 🔧 DIUBAH: pakai const
                    Text(
                      rating.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12), // 🔧 DIUBAH: pakai const
          Text(
            comment,
            textAlign: TextAlign.left,
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
