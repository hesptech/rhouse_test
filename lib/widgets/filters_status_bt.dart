import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/providers/repliers_provider.dart';
import 'package:flutter_black_white/providers/filter_provider.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';

class FiltersStatusBt extends StatefulWidget {
  const FiltersStatusBt({super.key});

  @override
  State<FiltersStatusBt> createState() => _FiltersStatusBtState();
}

class _FiltersStatusBtState extends State<FiltersStatusBt> {
  @override
  Widget build(BuildContext context) {

    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TypePropertyBtn('FOR SALE'),
        SizedBox(width: 10.0,),
        TypePropertyBtn('SOLD'),
      ],
    );
  }
}


class TypePropertyBtn extends StatelessWidget {
  final String typeBtn;
 
  const TypePropertyBtn(this.typeBtn, { super.key });

  @override
  Widget build(BuildContext context) {
   
    final stateSaleSold = Provider.of<RepliersProvider>(context);
    final filterProvider = Provider.of<FilterProvider>( context );
   
    final bool typePropertyState = filterProvider.filtersStatusProperties.contains('A') ? true : false ;
    final typePropertyColor = typeBtn == 'FOR SALE'
    ? typePropertyState ? kPrimaryColor : Colors.white
    : typePropertyState ? Colors.white : kWarningColor;
    final typePropertyColorBorder = typeBtn == 'FOR SALE'
    ? kPrimaryColor
    : kWarningColor;

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(7.0),
        width: 145.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          color: typePropertyColor,
          border: Border(
            left: BorderSide(
            color: typePropertyColorBorder,
            width: 2,
            ),
            top: BorderSide(
            color: typePropertyColorBorder,
            width: 0,
            ),
            right: BorderSide(
            color: typePropertyColorBorder,
            width: 2,
            ),
            bottom: BorderSide(
            color: typePropertyColorBorder,
            width: 2,
            )
          )
        ),
        child: Text(
          typeBtn,
          textAlign: TextAlign.center,
          style: TextStyle(
            color:  typeBtn == 'FOR SALE'
            ? typePropertyState ? Colors.white : kPrimaryColor
            : !typePropertyState ? Colors.white : kWarningColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        )    
      ),
      onTap: () {

        if (typeBtn == 'FOR SALE') {
          if(filterProvider.filtersStatusProperties.contains('A')) {
            // null
          } else {
            filterProvider.filtersStatusProperties.add('A');
            filterProvider.filtersStatusProperties.remove('U');

            stateSaleSold.displayPageHouses = 1;
            stateSaleSold.displayPageCondo = 1;
            stateSaleSold.onDisplayHouses = [];
            stateSaleSold.onDisplayCondo = [];
            stateSaleSold.getDisplayHousesStatus(filterProvider.filtersStatusProperties);
            stateSaleSold.getDisplayCondoStatus(filterProvider.filtersStatusProperties);
            Navigator.pushNamed(context, '/');
          }
        } else {
          if(filterProvider.filtersStatusProperties.contains('U')) {
            // null
          } else {
            filterProvider.filtersStatusProperties.add('U');
            filterProvider.filtersStatusProperties.remove('A');

            stateSaleSold.displayPageHouses = 1;
            stateSaleSold.displayPageCondo = 1;
            stateSaleSold.onDisplayHouses = [];
            stateSaleSold.onDisplayCondo = [];
            stateSaleSold.getDisplayHousesStatus(filterProvider.filtersStatusProperties);
            stateSaleSold.getDisplayCondoStatus(filterProvider.filtersStatusProperties);
            Navigator.pushNamed(context, '/');
          }
        }

        Preferences.filtersStatusProperties = filterProvider.filtersStatusProperties;
      },
    );
  }
}

class ContainerUpperBorder extends StatelessWidget {
  final String typeBtn;

  const ContainerUpperBorder(this.typeBtn, {super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.all(7.0),
        width: 145.0,
        height: 2.0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          color: kSecondaryColor,
        ),
        child: const Text(''),   
      );
  }
}
