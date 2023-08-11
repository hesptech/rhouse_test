import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/models/models.dart';
import 'package:flutter_black_white/providers/repliers_search.dart'; 
import 'package:flutter_black_white/modules/cards/card_search/card_search.dart'; 



class InputSearchDelegate extends SearchDelegate {

  StreamController<List<Listing>> debouncedListings = StreamController.broadcast();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: kPrimaryColor,
      ),

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(
          decorationThickness: 0.0000001,
          color: Colors.white // input color of text
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey),
      ),
    );
  }

  @override
  String? get searchFieldLabel => 'Address, Street Name or Listing#....';


  @override
  List<Widget>? buildActions(BuildContext context) {

    List<Widget> widgetsActions = <Widget>[];

    if ( query.isEmpty ) {
      return widgetsActions;
    }

    return [
      IconButton(
        icon: const Icon( Icons.clear ),
        onPressed: () => query = '', 
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon( Icons.arrow_back ),
      onPressed: () {
        clearStreams();
        close(context, null);
      }, 
    );
  }


  Widget buildResultsAndSuggestions(BuildContext context) {

    final searchProvider = Provider.of<RepliersSearch>(context, listen: false);
    
    return StreamBuilder(
      stream: searchProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Listing>> snapshot) {

        if ( !snapshot.hasData ) return const Center(child: CircularProgressIndicator( color: kPrimaryColor, ));

        final propertiesItems = snapshot.data!;
      
        return propertiesItems.isNotEmpty ?
        ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            indent: 10.0,
            endIndent: 10.0,
            height: 0,  
            thickness: 1.0, 
            color: kSecondaryColor,
          ),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: propertiesItems.length,
          //itemBuilder: ( _, int index) => _PropertyTile(propertiesItems[index])
          itemBuilder: ( _, int index) => CardSearch(propertiesItems[index],)
        )
        : _emptyResults();
      }
    );
  }

  
  @override
  Widget buildResults(BuildContext context) {
    //return const Text('build results');

    if ( query.isEmpty ) {
      return _emptyContainer();
    }

    final searchProvider = Provider.of<RepliersSearch>(context, listen: false);
    searchProvider.getSuggestionsByQuery(query);
    
    return buildResultsAndSuggestions(context);
  }


  Widget _emptyContainer() {
    return Container(
      color: const Color(0xFFe8eaf6),
      child: const Center(
        child: Icon(Icons.content_paste_search_outlined, color: Colors.black38, size: 100,),
      ),
    );
  }

  Widget _emptyResults() {
    return Center(
      child: Container(
        color: const Color(0xFFe8eaf6),
        child: const Center(
          child: Icon(Icons.content_paste_off_outlined, color: Colors.black38, size: 100,),
        ),
      ),
    );
  }


  void clearStreams() {
    debouncedListings.close();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if ( query.isEmpty ) {
      return _emptyContainer();
    }

    final searchProvider = Provider.of<RepliersSearch>(context, listen: false);
    searchProvider.getSuggestionsByQuery(query);
    
    return buildResultsAndSuggestions(context);
  }
}