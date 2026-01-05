import 'package:flutter/material.dart';

class ProfileItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final dynamic value;
  final bool showEditIcon;
  final VoidCallback? onEditPressed;
  final Color iconColor;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.showEditIcon = false,
    this.onEditPressed,
    this.iconColor = Colors.blue,
  });

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  // TODO: 1. Membuat variabel untuk edit mode
  bool isEditing = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  // Variabel untuk Membuat tombol edit di keyboard bisa di tekan
  void finishEditing() {
    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label di atas (username, email, phone number)
          Text(
            widget.label,
            style: const TextStyle(fontSize: 16, color: Colors.blue),
          ),
          const SizedBox(height: 6),

          // Box Putih + shadow + isi row
          Container(
            width: double.infinity,
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 6),
                ),
              ],
            ),

            child: Row(
              children: [
                Icon(widget.icon, color: widget.iconColor, size: 28),
                // SizedBox(width: 12,),
                // const Text(':', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                const SizedBox(width: 16),

                //TODO: 2. Membuat textfield untuk edit mode
                Expanded(
                  child: isEditing
                      ? TextField(
                          controller: controller,
                          autofocus: true,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),

                          // Membuat tombol centang di keyboard bisa di tekan setelah selesai edit
                          textInputAction: TextInputAction.done,
                          onSubmitted: (value) {
                            finishEditing();
                          },
                          onEditingComplete: () {
                            finishEditing();
                          },
                        )

                      : Text(
                          controller.text,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                ),

                // Icon Edit
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isEditing) {
                        // save value
                        // kalau mau menyimpan di data  base tambhkan di sini
                      }
                      isEditing = !isEditing;
                    });
                  },
                  child: Icon(
                    isEditing ? Icons.check : Icons.edit_outlined,
                    color: widget.showEditIcon
                        ? widget.iconColor
                        : Colors.transparent,
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
