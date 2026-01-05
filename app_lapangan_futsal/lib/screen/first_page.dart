import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  //Key untuk validasiForm
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Tentukan ukuran font dan padding berdasarkan lebar layar
    double fontSize = screenWidth * 0.05; // 5% dari lebar layar
    // double padding = screenWidth * 0.1;   // 10% dari lebar layar

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image-bg4.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Membuat bagian bawah gambar mempunyai efek hitam atau fade
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.95),
                  Colors.black.withOpacity(0.96),
                  Colors.black.withOpacity(1.00),
                ],
                stops: [0.00, 0.35, 0.99, 1.00],
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.35,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Explore Courts. Create Moments",
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 25),

          Positioned(
            bottom: screenHeight * 0.30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Search courts instanly, compare location and facilities,"
                "and explore ongoing events to make your game time easier to"
                "plan and more enjoyable",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white60,
                ),
              ),
            ),
          ),

          // Cara agar button tidak turun saat text di naik atau turunkan
          Positioned(
            bottom: screenHeight * 0.13,
            left: screenWidth * 0.08,
            right: screenWidth * 0.08,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      padding: EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 45),

                RichText(
                  text: TextSpan(
                    text: "Alredy have an Account? ",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
