import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 300,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) =>
              setState(() => activeIndex = index)
          ),
          itemCount: widget.listing.images!.length > 1 ? 4 : 1 ,
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
      height: 300,
      placeholder: const AssetImage('assets/no-image_2.jpg'),
      //image: AssetImage('assets/house_500x300.jpg'),
      image: NetworkImage(urlImage),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/no-image.jpg', fit: BoxFit.fitWidth);
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
    //=> Navigator.pushNamed(context, 'card_images_screen', arguments: widget.listing),
    effect: const SlideEffect(
      dotColor: Colors.white,
      activeDotColor:  kPrimaryColor,
      dotHeight: 12.0,
      dotWidth: 12.0,
    )
  );
}
