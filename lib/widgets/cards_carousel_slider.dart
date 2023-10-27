import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';

class CardsCarouselSlider extends StatefulWidget {
  final Listing listing;

  const CardsCarouselSlider(this.listing, {super.key});

  @override
  State<CardsCarouselSlider> createState() => _CardsCarouselSliderState();
}

class _CardsCarouselSliderState extends State<CardsCarouselSlider> {

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.listing.images!.length > 1 ? buildImage('$kRepliersCdn${widget.listing.images![1]}?w=1080', 1) : const SizedBox(),
        widget.listing.images!.length > 2 ? buildImage('$kRepliersCdn${widget.listing.images![2]}?w=1080', 2) : const SizedBox(),
        widget.listing.images!.length > 3 ? buildImage('$kRepliersCdn${widget.listing.images![3]}?w=1080', 3) : const SizedBox(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 300.0,
          color: Colors.white,
        ),
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 300,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) =>
              setState(() => activeIndex = index)
          ),
          itemCount: widget.listing.images!.length > 3 ? 4 : widget.listing.images!.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = '$kRepliersCdn${widget.listing.images![index]}?w=1080';

            return buildImage(urlImage, index);
          },


        ),
        //const SizedBox(height: 32),
        Container(
          height: 290,
          alignment: Alignment.bottomCenter,
          child: buildIndicator()
        )
      ],
    );
  }


  Widget buildImage(String urlImage, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 1),
    color: Colors.grey,
    child: FadeInImage(
      width: MediaQuery.of(context).size.width,
      height: 300,
      placeholder: const AssetImage('assets/no-image_2.jpg'),
      image: NetworkImage(urlImage),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/no-image_2.jpg', fit: BoxFit.fitWidth);
      },
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 50),
    ),
  );


  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: widget.listing.images!.length > 1 ? 4 : 1 ,
    onEnd: () {
      if(activeIndex == 3) Navigator.pushNamed(context, 'card_images_screen', arguments: widget.listing);
    },
    effect: const SlideEffect(
      dotColor: Colors.white,
      activeDotColor:  kPrimaryColor,
      dotHeight: 12.0,
      dotWidth: 12.0,
    )
  );
}
