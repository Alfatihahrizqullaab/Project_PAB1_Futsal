import 'package:app_lapangan_futsal/screen/profile_page.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    final encryptedUsername = prefs.getString('username');
    final encryptedEmail = prefs.getString('email');

    if (encryptedUsername != null && encryptedEmail != null) {
      username = await EncryptionHelper.decrypt(encryptedUsername);
      email = await EncryptionHelper.decrypt(encryptedEmail);
    }
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
          child: Icon(Icons.person, size: 40, color: Colors.blue.shade700),
        ),
        SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),

              Text(
                email,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              SizedBox(height: 2),

              // Text(
              //   ,
              //   style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              // ),
            ],
          ),
        ),

        IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
      ],
    );
  }

  // Menu Item
  Widget _menuItem({
    required IconData icon,
    required String title,
    // VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  }

  //Logout
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Profile'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileHeader(),
            SizedBox(height: 16),
            Divider(),
            // _menuItem(icon: Icons.lock_outline, title: 'Keamanan Dan Akun'),
            // _menuItem(icon: Icons.location_on_outlined, title: 'Ubah Lokasi'),
            // _menuItem(icon: Icons.favorite_border, title: 'favorite'),
            SizedBox(height: 6),
            // Text(
            //   'Info Lainnya',
            //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            // ),
            _menuItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Kebijakan Privasi',
            ),
            Divider(),
            _menuItem(
              icon: Icons.support_agent_outlined,
              title: 'Hubungi Kami',
            ),
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
                  onPressed: _logout,
                  child: Text('Logout', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
