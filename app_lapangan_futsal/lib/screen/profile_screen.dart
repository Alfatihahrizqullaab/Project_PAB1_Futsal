import 'dart:io';
import 'package:app_lapangan_futsal/screen/detail_profile_screen.dart';
import 'package:app_lapangan_futsal/screen/hubungi_kami_screen.dart';
import 'package:app_lapangan_futsal/screen/kebijakan_privasi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_lapangan_futsal/service/encrypt.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  String email = '';
  String phoneNumber = '';
  bool isLoading = true;
  bool isLoggedIn = false;
  File? profileImage;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    final encryptedUsername = prefs.getString('username');
    final encryptedEmail = prefs.getString('email');
    final phone = prefs.getString('phone_$username');
    final imagePath = prefs.getString('profile_image');

    if (encryptedUsername != null && encryptedEmail != null) {
      username = await EncryptionHelper.decrypt(encryptedUsername);
      email = await EncryptionHelper.decrypt(encryptedEmail);
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
      phoneNumber = '';
    }

    if (imagePath != null && imagePath.isNotEmpty) {
      profileImage = File(imagePath);
    }

    phoneNumber = phone ?? '';

    setState(() {
      isLoading = false;
    });
  }

  Widget _profileHeader() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.blue.shade100,
          backgroundImage: profileImage != null
              ? FileImage(profileImage!)
              : null,
          child: profileImage == null
              ? Icon(Icons.person, size: 40, color: Colors.blue.shade700)
              : null,
        ),
        SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isLoggedIn ? username : 'Guest',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),

              Text(
                isLoggedIn ? email : 'Login untuk melanjutkan',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),

              // SizedBox(height: 4),
              if (phoneNumber.isNotEmpty) ...[
                SizedBox(height: 4),
                Text(
                  phoneNumber,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                ),
              ],
              // Text(
              //   ,
              //   style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  // Menu Item
  Widget _menuItem({
    required IconData icon,
    required String title,
    required onTap,
    // VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  //Logout
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isSignedIn', false);

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileHeader(),
              SizedBox(height: 16),
              Divider(),
              // _menuItem(icon: Icons.location_on_outlined, title: 'Ubah Lokasi'),
              // _menuItem(icon: Icons.favorite_border, title: 'favorite'),
              SizedBox(height: 4),
              Text(
                'Akun Anda',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              _menuItem(
                icon: Icons.account_circle_outlined,
                title: 'Edit profile',
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfilePage(username: username, email: email)),
                  );
                  if (result != null) {
                    setState(() {
                      username = result['username'] ?? username;
                      email = result['email'] ?? email;
                      phoneNumber = result['phone'] ?? phoneNumber;

                      if (result['image'] != null) {
                        profileImage = File(result['image']);
                      }
                    });
                  }
                },
              ),
              // _menuItem(
              //   icon: Icons.lock_outline,
              //   title: 'Kata Sandi dan Keamanan',
              //   onTap: () {},
              // ),
              Divider(),
              SizedBox(height: 4),
              Text(
                'Info Lainnya',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              _menuItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Kebijakan Privasi',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => KebijakanPrivasiScreen()),
                  );
                },
              ),
              _menuItem(
                icon: Icons.support_agent_outlined,
                title: 'Hubungi Kami',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HubungiKamiScreen()),
                  );
                },
              ),
              Divider(),
              SizedBox(height: 60),

              //Logout button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: isLoggedIn
                        ? _logout
                        : () {
                            Navigator.pushNamed(context, '/signin');
                          },
                    child: Text(
                      isLoggedIn ? 'Logout' : 'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
