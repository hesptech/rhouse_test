import 'package:flutter/material.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/utils/constants.dart';

class CardImagesScreen extends StatelessWidget {
  const CardImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Listing listing = ModalRoute.of(context)?.settings.arguments! as Listing;
    //print(listing.images?[0]);

    return Scaffold(
      //backgroundColor: Colors.black,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            height: 0,  thickness: 5.0, color: Colors.black,
          ),
          itemCount: listing.images!.length,
          scrollDirection: Axis.vertical,
          itemBuilder: ( _, int index ) => _CastCard( image: listing.images?[index])
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.navigate_before_outlined),
        onPressed: () { Navigator.pop(context); } 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}


class _CastCard extends StatelessWidget {
  
  final String? image;

  const _CastCard({ Key? key, required this.image }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeInImage(
          width: double.infinity,
          height: 260,
          fit: BoxFit.cover,
          placeholder: const AssetImage('assets/no-image.jpg'), 
          image: NetworkImage('$kRepliersCdn$image?w=500'),
          //image: AssetImage('assets/house_500x300.jpg'),
        ),
      ],
    );
  }
}