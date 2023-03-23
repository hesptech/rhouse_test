import 'package:flutter/material.dart';
import 'package:flutter_black_white/models/models.dart';

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
        //child: Text('${listing.listDate}'),
        child: ListView.builder(
          itemCount: listing.images?.length,
          scrollDirection: Axis.vertical,
          itemBuilder: ( _, int index ) => _CastCard( image: listing.images?[index])
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_before_outlined),
        onPressed: () { Navigator.pop(context); } 
      ),
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
          image: NetworkImage('https://cdn.repliers.io/$image?w=500'),
          //image: AssetImage('assets/house_500x300.jpg'),
        ),
      ],
    );
  }
}