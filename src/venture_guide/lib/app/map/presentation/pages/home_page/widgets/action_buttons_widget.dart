import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    return SizedBox(
      height: pixelRatio * 18,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(top: pixelRatio * 2),
        children: const [
          ActionButton(
            icon: Icons.store_mall_directory,
            label: 'Mercados',
          ),
          ActionButton(
            icon: Icons.monetization_on,
            label: 'Câmbios',
          ),
          ActionButton(
            icon: Icons.local_cafe,
            label: 'Café',
          ),
          
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Container(
      margin: EdgeInsets.only(left: pixelRatio * 1, right: pixelRatio * 1),
      padding: EdgeInsets.symmetric(horizontal: pixelRatio * 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(pixelRatio * 30),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: pixelRatio * 0.2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: pixelRatio * 8,
          ),
          SizedBox(width: pixelRatio * 2),
          Text(label),
        ],
      ),
    );
  }
}
