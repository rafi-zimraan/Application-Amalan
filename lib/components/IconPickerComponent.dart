import 'package:flutter/material.dart';

class IconPickerDialog extends StatelessWidget {
  final Function(IconData) onIconSelected;

  const IconPickerDialog({super.key, required this.onIconSelected});

  void _selectIcon(BuildContext context, IconData icon) {
    onIconSelected(icon);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width:
            MediaQuery.of(context).size.width * 0.8, // Lebar dialog diperkecil
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pick an Icon',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  IconButton(
                    icon: const Icon(Icons.star),
                    onPressed: () => _selectIcon(context, Icons.star),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () => _selectIcon(context, Icons.favorite),
                  ),
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () => _selectIcon(context, Icons.home),
                  ),
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () => _selectIcon(context, Icons.person),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => _selectIcon(context, Icons.settings),
                  ),
                  IconButton(
                    icon: const Icon(Icons.work),
                    onPressed: () => _selectIcon(context, Icons.work),
                  ),
                  IconButton(
                    icon: const Icon(Icons.alarm),
                    onPressed: () => _selectIcon(context, Icons.alarm),
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera),
                    onPressed: () => _selectIcon(context, Icons.camera),
                  ),
                  IconButton(
                    icon: const Icon(Icons.directions_car),
                    onPressed: () => _selectIcon(context, Icons.directions_car),
                  ),
                  IconButton(
                    icon: const Icon(Icons.flight),
                    onPressed: () => _selectIcon(context, Icons.flight),
                  ),
                  IconButton(
                    icon: const Icon(Icons.local_cafe),
                    onPressed: () => _selectIcon(context, Icons.local_cafe),
                  ),
                  IconButton(
                    icon: const Icon(Icons.map),
                    onPressed: () => _selectIcon(context, Icons.map),
                  ),
                  IconButton(
                    icon: const Icon(Icons.music_note),
                    onPressed: () => _selectIcon(context, Icons.music_note),
                  ),
                  IconButton(
                    icon: const Icon(Icons.pets),
                    onPressed: () => _selectIcon(context, Icons.pets),
                  ),
                  IconButton(
                    icon: const Icon(Icons.school),
                    onPressed: () => _selectIcon(context, Icons.school),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => _selectIcon(context, Icons.shopping_cart),
                  ),
                  IconButton(
                    icon: const Icon(Icons.sports_soccer),
                    onPressed: () => _selectIcon(context, Icons.sports_soccer),
                  ),
                  IconButton(
                    icon: const Icon(Icons.train),
                    onPressed: () => _selectIcon(context, Icons.train),
                  ),
                  IconButton(
                    icon: const Icon(Icons.wifi),
                    onPressed: () => _selectIcon(context, Icons.wifi),
                  ),
                  IconButton(
                    icon: const Icon(Icons.beach_access),
                    onPressed: () => _selectIcon(context, Icons.beach_access),
                  ),
                  IconButton(
                    icon: const Icon(Icons.book),
                    onPressed: () => _selectIcon(context, Icons.book),
                  ),
                  IconButton(
                    icon: const Icon(Icons.brightness_5),
                    onPressed: () => _selectIcon(context, Icons.brightness_5),
                  ),
                  IconButton(
                    icon: const Icon(Icons.build),
                    onPressed: () => _selectIcon(context, Icons.build),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cake),
                    onPressed: () => _selectIcon(context, Icons.cake),
                  ),
                  IconButton(
                    icon: const Icon(Icons.call),
                    onPressed: () => _selectIcon(context, Icons.call),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chat),
                    onPressed: () => _selectIcon(context, Icons.chat),
                  ),
                  IconButton(
                    icon: const Icon(Icons.check_circle),
                    onPressed: () => _selectIcon(context, Icons.check_circle),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cloud),
                    onPressed: () => _selectIcon(context, Icons.cloud),
                  ),
                  IconButton(
                    icon: const Icon(Icons.code),
                    onPressed: () => _selectIcon(context, Icons.code),
                  ),
                  IconButton(
                    icon: const Icon(Icons.credit_card),
                    onPressed: () => _selectIcon(context, Icons.credit_card),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _selectIcon(context, Icons.delete),
                  ),
                  IconButton(
                    icon: const Icon(Icons.description),
                    onPressed: () => _selectIcon(context, Icons.description),
                  ),
                  IconButton(
                    icon: const Icon(Icons.email),
                    onPressed: () => _selectIcon(context, Icons.email),
                  ),
                  IconButton(
                    icon: const Icon(Icons.extension),
                    onPressed: () => _selectIcon(context, Icons.extension),
                  ),
                  IconButton(
                    icon: const Icon(Icons.face),
                    onPressed: () => _selectIcon(context, Icons.face),
                  ),
                  IconButton(
                    icon: const Icon(Icons.fastfood),
                    onPressed: () => _selectIcon(context, Icons.fastfood),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_vintage),
                    onPressed: () => _selectIcon(context, Icons.filter_vintage),
                  ),
                  IconButton(
                    icon: const Icon(Icons.flash_on),
                    onPressed: () => _selectIcon(context, Icons.flash_on),
                  ),
                  IconButton(
                    icon: const Icon(Icons.flip_camera_android),
                    onPressed: () =>
                        _selectIcon(context, Icons.flip_camera_android),
                  ),
                  IconButton(
                    icon: const Icon(Icons.folder),
                    onPressed: () => _selectIcon(context, Icons.folder),
                  ),
                  IconButton(
                    icon: const Icon(Icons.gamepad),
                    onPressed: () => _selectIcon(context, Icons.gamepad),
                  ),
                  IconButton(
                    icon: const Icon(Icons.headset),
                    onPressed: () => _selectIcon(context, Icons.headset),
                  ),
                  IconButton(
                    icon: const Icon(Icons.hourglass_empty),
                    onPressed: () =>
                        _selectIcon(context, Icons.hourglass_empty),
                  ),
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: () => _selectIcon(context, Icons.image),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard),
                    onPressed: () => _selectIcon(context, Icons.keyboard),
                  ),
                  IconButton(
                    icon: const Icon(Icons.laptop),
                    onPressed: () => _selectIcon(context, Icons.laptop),
                  ),
                  IconButton(
                    icon: const Icon(Icons.lightbulb),
                    onPressed: () => _selectIcon(context, Icons.lightbulb),
                  ),
                  IconButton(
                    icon: const Icon(Icons.lock),
                    onPressed: () => _selectIcon(context, Icons.lock),
                  ),
                  IconButton(
                    icon: const Icon(Icons.mail),
                    onPressed: () => _selectIcon(context, Icons.mail),
                  ),
                  IconButton(
                    icon: const Icon(Icons.movie),
                    onPressed: () => _selectIcon(context, Icons.movie),
                  ),
                  IconButton(
                    icon: const Icon(Icons.navigation),
                    onPressed: () => _selectIcon(context, Icons.navigation),
                  ),
                  IconButton(
                    icon: const Icon(Icons.phone),
                    onPressed: () => _selectIcon(context, Icons.phone),
                  ),
                  IconButton(
                    icon: const Icon(Icons.print),
                    onPressed: () => _selectIcon(context, Icons.print),
                  ),
                  IconButton(
                    icon: const Icon(Icons.radio),
                    onPressed: () => _selectIcon(context, Icons.radio),
                  ),
                  IconButton(
                    icon: const Icon(Icons.restaurant),
                    onPressed: () => _selectIcon(context, Icons.restaurant),
                  ),
                  IconButton(
                    icon: const Icon(Icons.school),
                    onPressed: () => _selectIcon(context, Icons.school),
                  ),
                  IconButton(
                    icon: const Icon(Icons.security),
                    onPressed: () => _selectIcon(context, Icons.security),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shop),
                    onPressed: () => _selectIcon(context, Icons.shop),
                  ),
                  IconButton(
                    icon: const Icon(Icons.thumb_up),
                    onPressed: () => _selectIcon(context, Icons.thumb_up),
                  ),
                  IconButton(
                    icon: const Icon(Icons.train),
                    onPressed: () => _selectIcon(context, Icons.train),
                  ),
                  IconButton(
                    icon: const Icon(Icons.wb_sunny),
                    onPressed: () => _selectIcon(context, Icons.wb_sunny),
                  ),
                  IconButton(
                    icon: const Icon(Icons.watch),
                    onPressed: () => _selectIcon(context, Icons.watch),
                  ),
                  IconButton(
                    icon: const Icon(Icons.work),
                    onPressed: () => _selectIcon(context, Icons.work),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Menambah jarak di bawah GridView
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'CLOSE',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
