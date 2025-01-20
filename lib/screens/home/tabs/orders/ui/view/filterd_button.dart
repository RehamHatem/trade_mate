import 'package:flutter/material.dart';
import 'package:trade_mate/utils/app_colors.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const FilterButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.darkPrimaryColor : Colors.grey[350],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(label, style: TextStyle(fontSize: 16)),
    );
  }
}