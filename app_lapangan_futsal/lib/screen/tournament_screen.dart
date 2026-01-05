import 'package:app_lapangan_futsal/models/tournament.dart';
import 'package:app_lapangan_futsal/widget/tournament_card.dart';
import 'package:flutter/material.dart';

class TournamentScreen extends StatelessWidget {
  TournamentScreen({super.key});

  final List<Tournament> tournament = [
    Tournament(
      title: 'Roxwood Tournament',
      image: 'assets/tournament_empat.jpg',
      price: 'Rp 150.000',
      joined: 10,
      quota: 100,
      date: 'Monday, 3 Nov 2025',
      description: 'Turnamen futsal dengan atmosfer kompetitif dan seru.',
    ),

    Tournament(
      title: '2025 Tournament',
      image: 'assets/tournament_lima.jpg',
      price: 'Rp 100.000',
      joined: 20,
      quota: 100,
      date: 'Sunday, 2 Nov 2025',
      description: 'Bertanding dengan semangat, pemenangnya siapa?',
    ),

    Tournament(
      title: 'Tournament dunia',
      image: 'assets/tournament_satu.jpg',
      price: 'Rp 50.000',
      joined: 44,
      quota: 55,
      date: 'Saturday, 15 Nov 2025',
      description:
          'Tantangan futsal malam hari dengan atmosfer penuh adrenalin.',
    ),

    Tournament(
      title: 'Tournament laLiga',
      image: 'assets/tournament_dua.jpg',
      price: 'Rp 80.000',
      joined: 22,
      quota: 44,
      date: 'Friday, 21 Nov 2025',
      description: 'Ajang unjuk skill futsal antar mahasiswa se-kota.',
    ),

    Tournament(
      title: 'Tournament Champion Cup',
      image: 'assets/tournament_tiga.jpg',
      price: 'Rp 90.000',
      joined: 44,
      quota: 88,
      date: 'Friday, 7 Nov 2025',
      description: 'Satu lapangan, banyak ambisi. Buktikan kemampuanmu!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: tournament.length,
          itemBuilder: (context, index) {
            final item = tournament[index];
            return TournamentCard(item: item);
          },
        ),
      ),
    );
  }
}
