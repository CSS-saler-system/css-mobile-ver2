import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/configs/constants/app_color.dart';
import 'package:flutter_application_1/src/configs/constants/app_images.dart';

class CustomGallery extends StatefulWidget {
  final double height;
  final List<String> images;
  const CustomGallery({
    Key? key,
    required this.height,
    required this.images,
  }) : super(key: key);

  @override
  State<CustomGallery> createState() => _CustomGalleryState();
}

class _CustomGalleryState extends State<CustomGallery> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.height,
          child: Image.asset(
            widget.images.isNotEmpty
                ? widget.images[_currentIndex]
                : AppImages.imageBase,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: _buildGallery(context),
        ),
      ],
    );
  }

  Widget _buildGallery(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: Container(
                width: 50,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _currentIndex == index
                        ? AppColors.primarycolor
                        : Colors.transparent,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ));
  }
}
