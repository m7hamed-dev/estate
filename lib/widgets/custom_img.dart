import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImg extends StatelessWidget {
  //
  const CustomImg({
    Key? key,
    required this.imageUrl,
    this.height,
  }) : super(key: key);
  //
  final String imageUrl;
  final double? height;
  //
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      imageBuilder: (context, imageProvider) => Container(
        // width: 40.0,
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
    );
  }
}
