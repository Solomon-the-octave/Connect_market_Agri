import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final String unit;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool small;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.unit,
    required this.onIncrement,
    required this.onDecrement,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove_circle_outline, size: small ? 16 : 24),
          constraints: BoxConstraints(minWidth: small ? 24 : 40, minHeight: small ? 24 : 40),
          padding: EdgeInsets.zero,
          visualDensity: small ? VisualDensity.compact : VisualDensity.standard,
          onPressed: quantity > 1 ? onDecrement : null,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: small ? 4 : 8, vertical: small ? 2 : 4),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('$quantity $unit', style: TextStyle(fontWeight: FontWeight.w600, fontSize: small ? 11 : 15)),
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outline, size: small ? 16 : 24),
          constraints: BoxConstraints(minWidth: small ? 24 : 40, minHeight: small ? 24 : 40),
          padding: EdgeInsets.zero,
          visualDensity: small ? VisualDensity.compact : VisualDensity.standard,
          onPressed: onIncrement,
        ),
      ],
    );
  }
}
