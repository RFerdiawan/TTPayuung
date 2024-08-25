import 'package:flutter/material.dart';

class IconButtonWithBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final int badgeCount;
  final Function()? onPressed;
  final Color? iconColor;
  const IconButtonWithBadge({
    super.key,
    required this.icon,
    required this.label,
    required this.badgeCount,
    this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  icon,
                  size: 28,
                  color: iconColor ?? Colors.black,
                ),
                onPressed: onPressed,
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Center(
                    child: Text(
                      '$badgeCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          label.isNotEmpty
              ? Text(label, style: const TextStyle(fontSize: 14))
              : const SizedBox(),
        ],
      ),
    );
  }
}
