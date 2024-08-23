import 'package:flutter/material.dart';

class ListNameDialog extends StatelessWidget {
  final TextEditingController listNameController;
  final Function(String) onListNameSubmitted;

  const ListNameDialog({
    super.key,
    required this.listNameController,
    required this.onListNameSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('List'),
      content: Stack(
        alignment: Alignment.centerRight,
        children: [
          SizedBox(
            width: 300, // Mengatur lebar InputDecoration
            child: TextField(
              controller: listNameController
                ..text = 'New list', // Mengatur teks awal
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Garis hitam
                ),
                labelText: 'List',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.6),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical:
                      20, // Mengatur padding vertikal untuk meningkatkan tinggi
                ),
              ),
              autofocus: true, // Mengatur fokus ke TextField saat dialog muncul
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            onListNameSubmitted(listNameController.text);
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
