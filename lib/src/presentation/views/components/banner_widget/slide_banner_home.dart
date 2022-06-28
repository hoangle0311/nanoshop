import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/presentation/views/components/image_widget/load_image_form_url_widget.dart';

import '../../../../domain/entities/banner/banner.dart';
import '../indicator/indicator_widget.dart';

class SlideBannerHome extends StatefulWidget {
  final List<Banner> banners;

  const SlideBannerHome({
    Key? key,
    required this.banners,
  }) : super(key: key);

  @override
  State<SlideBannerHome> createState() => _SlideBannerHomeState();
}

class _SlideBannerHomeState extends State<SlideBannerHome> {
  var _indexPage = 0;

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 200,
            enableInfiniteScroll: true,
            onPageChanged: (index, _) {
              _indexPage = index;
              setState(() {});
            },
            autoPlay: true,
            initialPage: 0,
            viewportFraction: 1,
          ),
          items: widget.banners.map(
            (e) {
              var imageUrl = "http://plpharma.nanoweb.vn" + (e.bannerSrc ?? "");

              return LoadImageFromUrlWidget(
                imageUrl: imageUrl,
              );
            },
          ).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.banners.length,
            (index) {
              return IndicatorWidget(
                height: 4,
                isActive: index == _indexPage ? true : false,
                activeColor: AppColors.primaryColor,
                onTap: () {
                  if (_indexPage != index) {
                    // _pageController.animateToPage(index,
                    //     duration: Duration(milliseconds: 1000),
                    //     curve: Curves.fastOutSlowIn);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
