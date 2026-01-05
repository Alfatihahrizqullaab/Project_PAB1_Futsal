import 'package:flutter/material.dart';
import 'package:app_lapangan_futsal/widget/profile_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //TODO: 1. Deklarasi variabel
  String username = '';
  String email = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Membuat Fungsi Kembali
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.blue),
            ),
            const SizedBox(width: 12),
            const Text(
              'Pengaturan Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          Container(width: double.infinity, color: Colors.white),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // TODO: 2. Membuat profile Header Yang berisi foto profile
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 100 - 50),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: AssetImage(
                                'assets/placeholder_image.png',
                              ),
                            ),
                          ),

                          //Membuat icon edit pada foto profile
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // TODO:; 3. Membuat informasi profile
                  SizedBox(height: 20),

                  // Divider(color: Colors.grey), // Membuat garis pemisah
                  ProfileItem(
                    icon: Icons.person,
                    label: 'Username',
                    value: username,
                    showEditIcon: true,
                    // onEditPressed: () {
                    //   editField(
                    //     title: 'Username',
                    //     currentValue: username,
                    //     onSave: (newValue) {
                    //       setState(() {
                    //         username = newValue;
                    //       });
                    //     },
                    //   );
                    // },
                    iconColor: Colors.blue.shade300,
                  ),
                  SizedBox(height: 2),

                  SizedBox(height: 2),
                  ProfileItem(
                    icon: Icons.email,
                    label: 'Email',
                    value: email,
                    showEditIcon: true,
                    // onEditPressed: () {
                    //   debugPrint('Edit Email pressed');
                    // },
                    iconColor: Colors.blue.shade300,
                  ),
                  SizedBox(height: 2),

                  SizedBox(height: 3),
                  ProfileItem(
                    icon: Icons.phone,
                    label: 'Contact',
                    value: phoneNumber,
                    showEditIcon: true,
                    // onEditPressed: () {
                    //   debugPrint('Edit Phone Number pressed');
                    // },
                    iconColor: Colors.blue.shade300,
                  ),

                  // TODO: 4. Membuat tombol Save Changes
                  SizedBox(height: 4),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




// Membuat Action ketika icon edit ditekan diletakan di bawah todo 1
  // Future<void> editField({
  //   required String title,
  //   required String currentValue,
  //   required Function(String) onSave,
  // }) async {
  //   TextEditingController controller = TextEditingController(
  //     text: currentValue,
  //   );

  //   await showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: Text("Edit $title"),
  //       content: TextField(
  //         controller: controller,
  //         // decoration: InputDecoration(
  //         //   labelText: title,
  //         //   border: OutlineInputBorder(),
  //         // ),
  //       ),
  //       // Tombol Save dan Cancel
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text("Cancel"),
  //         ),

  //         ElevatedButton(
  //           onPressed: () {
  //             onSave(controller.text);
  //             Navigator.pop(context);
  //           },
  //           child: const Text("Save"),
  //         ),
  //       ],
  //     ),
  //   );
  // }