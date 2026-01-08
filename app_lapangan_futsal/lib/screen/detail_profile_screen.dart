import 'package:app_lapangan_futsal/service/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:app_lapangan_futsal/widget/profile_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String email;

  const ProfilePage({super.key, required this.username, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //TODO: 1. Deklarasi variabel
  late String username;
  late String email;
  String phoneNumber = '';
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image');

    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  //Fungsi untuk memilih Foto
  Future<void> _pickImage(ImageSource source) async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fitur foto hanya tersedia di android')),
      );
      return;
    }

    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _loadPhone() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneNumber = prefs.getString('phone_${widget.username}') ?? '';
    });
  }

  void _showImageSourcePicker() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil Foto dari Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),

              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text('Pilih dari Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              SizedBox(height: 8,)
            ],
          )
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
    username = widget.username;
    email = widget.email;
    _loadPhone();
    _loadProfileImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text('Pengaturan Profile', style: TextStyle(color: Colors.blue)),
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
                              radius: 52,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: _profileImage != null
                                  ? FileImage(_profileImage!)
                                  : const AssetImage(
                                          'assets/placeholder_image.png',
                                        )
                                        as ImageProvider,
                            ),
                          ),

                          //Membuat icon edit pada foto profile
                          IconButton(
                            onPressed: _showImageSourcePicker,
                            icon: Icon(
                              Icons.camera_alt,
                              size: 28,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // TODO:; 3. Membuat informasi profile
                  SizedBox(height: 16),

                  // Divider(color: Colors.grey), // Membuat garis pemisah
                  ProfileItem(
                    icon: Icons.person,
                    label: 'Username',
                    value: username,
                    showEditIcon: true,
                    onSaved: (value) {
                      setState(() {
                        username = value;
                      });
                    },
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
                    onSaved: (value) {
                      setState(() {
                        email = value;
                      });
                    },
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
                    onSaved: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                    },
                  ),

                  // TODO: 4. Membuat tombol Save Changes
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();

                        await prefs.setString(
                          'phone_${widget.username}',
                          phoneNumber,
                        );

                        await prefs.setString(
                          'username',
                          await EncryptionHelper.encrypt(username),
                        );

                        await prefs.setString(
                          'email',
                          await EncryptionHelper.encrypt(email),
                        );

                        //Simpan Foto saat save change
                        if (_profileImage != null) {
                          await prefs.setString(
                            'profile_image',
                            _profileImage!.path,
                          );
                        }

                        Navigator.pop(context, {
                          'phone': phoneNumber,
                          'username': username,
                          'email': email,
                          'image': _profileImage?.path,
                        });
                      },
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
                  SizedBox(height: 60),
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
