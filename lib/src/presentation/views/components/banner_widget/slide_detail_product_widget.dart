import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

class DetailProductSliderImage extends StatefulWidget {
  final List<String> images;

  const DetailProductSliderImage({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  _DetailProductSliderImageState createState() =>
      _DetailProductSliderImageState();
}

class _DetailProductSliderImageState extends State<DetailProductSliderImage> {
  var _indexPage = 0;

  CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              onPageChanged: (index, _) {
                _indexPage = index;
                setState(() {});
              },
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 1,
              initialPage: 0,
            ),
            items: widget.images.map(
              (e) {
                return Container(
                  child: LoadImageFromUrlWidget(
                    imageUrl: e,
                  ),
                );
              },
            ).toList(),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${_indexPage + 1}/${widget.images.length}",
            ),
          ),
        ),
      ],
    );
  }
}
