import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_black_white/config/environment.dart';
import 'package:flutter_black_white/models/models.dart';

class CardImagesScreen extends StatelessWidget {
  const CardImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Listing listing = ModalRoute.of(context)?.settings.arguments! as Listing;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Photo Gallery'),
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            height: 0,  thickness: 3.0, color: Colors.black,
          ),
          itemCount: listing.images!.length,
          scrollDirection: Axis.vertical,
          itemBuilder: ( _, int index ) => _CastCard( image: listing.images?[index])
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.navigate_before_outlined),
        onPressed: () { Navigator.pop(context); } 
      ), */
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
          image: NetworkImage('$kRepliersCdn$image?w=1080'),
        ),
      ],
    );
  }
}