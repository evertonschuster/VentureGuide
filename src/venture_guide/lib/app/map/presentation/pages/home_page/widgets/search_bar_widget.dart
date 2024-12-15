import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: pixelRatio * 18,
      margin: EdgeInsets.only(
        top: statusBarHeight + pixelRatio * 2,
        right: pixelRatio * 2,
        left: pixelRatio * 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: pixelRatio * .2,
        ),
      ),
      child: const SearchText(),
    );
  }
}

class SearchText extends StatelessWidget {
  const SearchText({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.of(context).textScaler.scale(22);
    final iconColor = Theme.of(context).iconTheme.color;

    return TextField(
      maxLines: 1,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        color: Theme.of(context).iconTheme.color,
        fontSize: MediaQuery.of(context).textScaler.scale(15),
      ),
      decoration: InputDecoration(
        hintText: 'Buscar...',
        border: InputBorder.none,
        isDense: true,


        icon: Icon(
          Icons.search,
          color: iconColor,
          size: iconSize,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.clear,
            color: iconColor,
            size: iconSize,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
