import 'package:flutter/material.dart';
import 'package:giveup/components/NewListBottomSheetComponent.dart';

class SelectableButtonActivity extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isSpecialButton;

  const SelectableButtonActivity({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.isSpecialButton = false,
  });

  @override
  _SelectableButtonActivityState createState() =>
      _SelectableButtonActivityState();
}

class _SelectableButtonActivityState extends State<SelectableButtonActivity> {
  bool _isSelected = false;

  void _handleTap() {
    if (!widget.isSpecialButton) {
      setState(() {
        _isSelected = !_isSelected;
      });
    }
    if (widget.onTap != null) {
      widget.onTap!();
    }

    if (widget.isSpecialButton) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => const NewListBottomSheetComponent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        padding: widget.icon != null
            ? const EdgeInsets.symmetric(horizontal: 11.0, vertical: 4.0)
            : const EdgeInsets.symmetric(horizontal: 18.0, vertical: 7.0),
        decoration: BoxDecoration(
          color: widget.isSpecialButton
              ? Colors.blue[300]
              : _isSelected
                  ? Colors.blueAccent
                  : Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            if (widget.icon != null)
              Icon(
                widget.icon,
                color: Colors.white,
              ),
            if (widget.icon != null) const SizedBox(width: 8.0),
            Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
                fontWeight:
                    widget.icon != null ? FontWeight.w500 : FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
