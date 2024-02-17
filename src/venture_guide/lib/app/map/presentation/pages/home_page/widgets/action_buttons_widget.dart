import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    return SizedBox(
      height: pixelRatio * 16,
      child: ListView(
        scrollDirection: Axis.horizontal,
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
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: pixelRatio * .2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 5),
          Text(label),
        ],
      ),
    );
  }
}
