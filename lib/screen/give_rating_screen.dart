import 'package:flutter/material.dart';
import 'package:app_lapangan_futsal/models/review.dart';

class GiveRatingScreen extends StatefulWidget {
  const GiveRatingScreen({super.key});

  @override
  State<GiveRatingScreen> createState() => _GiveRatingScreenState();
}

class _GiveRatingScreenState extends State<GiveRatingScreen> {
  int selectedRating = 0;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Give a Rating', style: TextStyle(color: Colors.blue)),
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < selectedRating ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: 36,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedRating = index + 1;
                        });
                      },
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Comment
            Text(
              'Give a comment',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            TextField(
              controller: commentController,
              maxLength: 300,
              maxLines: 6,
              decoration: InputDecoration(
                counterText: '',
                hintText: 'Tulis Komentar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue)
                )
              ),
            ),
           SizedBox(height: 16,),

            //Submit
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
                onPressed: () async {
                  if (selectedRating == 0 || commentController.text.isEmpty) {
                    return;
                  }
                  final newReview = Review(
                    name: 'user',
                    date: 'Hari ini',
                    rating: selectedRating.toDouble(),
                    comment: commentController.text,
                  );
                  Navigator.pop(context, newReview);
                },
                child: Text('Kirim', style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
