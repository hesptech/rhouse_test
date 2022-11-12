import 'package:flutter/material.dart';
import 'package:flutter_black_white/utils/constants.dart';
import 'package:flutter_black_white/utils/shared_preferences.dart';
import 'package:flutter_black_white/utils/widgets_formatting.dart';
import 'package:flutter_black_white/filters/filters_property_icons.dart';


class FiltersPropertyType extends StatefulWidget {
  const FiltersPropertyType({Key? key}) : super(key: key);

  @override
  State<FiltersPropertyType> createState() => _FiltersPropertyTypeState();
}

class _FiltersPropertyTypeState extends State<FiltersPropertyType> {

  late List<bool> _openCloseIcons;
  late List<PropertiesTypes> _propertiesTypes;
  late List<PropertiesTypesOthers> _propertiesTypesOthers;
  late List<String> _filtersPropertyType;

  @override
  void initState() {
    super.initState();

    _openCloseIcons = <bool>[
      false,
      false,
      false,
      false,
    ]; 

    _propertiesTypes = <PropertiesTypes>[
      const PropertiesTypes('DUPLEX'),
      const PropertiesTypes('TIPLEX'),
      const PropertiesTypes('FOURPLEX'),
      const PropertiesTypes('OTHER MULTIPLEX'),
    ];

    _propertiesTypesOthers = <PropertiesTypesOthers>[
      const PropertiesTypesOthers('VACANT LAND'),
      const PropertiesTypesOthers('OTHER'),
    ];

    _filtersPropertyType = Preferences.filterPropertyType;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 24.0),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              title: const Text('PROPERTY TYPE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),),
              trailing: Icon(
                _openCloseIcons[0] ? Icons.remove : Icons.add,
                color: kSecondaryColor,
              ),
              children: <Widget>[
                const FiltersPropertyIcons(),
                ExpansionTile(
                  title: const Text('Other', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, ),),
                  trailing: Icon(
                    _openCloseIcons[1] ? Icons.remove : Icons.add,
                    color: kPrimaryColor,
                    size: 18.0,
                  ),
                  children: [
                    const SizedBox( height: 7.0, ),
                    const BlueDivider(),
                    ExpansionTile(
                      title: const Text('Multiplex', style: TextStyle(color: kPrimaryColor),),
                      trailing: Icon(
                        _openCloseIcons[2] ? Icons.remove : Icons.add,
                        color: kPrimaryColor,
                        size: 18.0,
                      ),
                      children: [
                        const SizedBox( height: 1.0, ),
                        const SizedBox( height: 14.0, ),
                        Wrap(
                          children: propertiesTypesWidgets.toList(),
                        ),
                        const SizedBox( height: 14.0, ),
                      ],
                      onExpansionChanged: (bool expanded) {
                        setState(() => _openCloseIcons[2] = expanded );
                      },
                    ),
                    const BlueDivider(), 
                    const SizedBox( height: 24.0, ),
                    Wrap(
                      children: propertiesTypesOthersWidgets.toList(),
                    ),
                    const SizedBox( height: 18.0,)
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _openCloseIcons[1] = expanded );
                  },
                ),

               
              ],
              onExpansionChanged: (bool expanded) {
                setState(() => _openCloseIcons[0] = expanded );
                if (expanded == false) {
                  setState(() => _openCloseIcons[1] = false );
                  setState(() => _openCloseIcons[2] = false );
                }
              },
            ),            
          ],
        )
      ),
    );
  }


  Iterable<Widget> get propertiesTypesWidgets sync* {
    for (PropertiesTypes propertiesTypes in _propertiesTypes) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 6.0 ),
        child: ChoiceChip(
          label: Container(
            width: 140,          
            alignment: Alignment.center,
            child: Text(propertiesTypes.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersPropertyType.contains(propertiesTypes.name) ? Colors.white : kPrimaryColor),),
          ),
          backgroundColor: Colors.white,
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersPropertyType.contains(propertiesTypes.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersPropertyType.add(propertiesTypes.name) : _filtersPropertyType.removeWhere((String name) => name == propertiesTypes.name) ;
                Preferences.filterPropertyType = _filtersPropertyType;
            });
          },
        )
      );
    }
  }

  Iterable<Widget> get propertiesTypesOthersWidgets sync* {
    for (PropertiesTypesOthers propertiesTypesOthers in _propertiesTypesOthers) {
      yield Padding(
        padding: const EdgeInsets.symmetric( horizontal: 6.0 ),
        child: ChoiceChip(
          label: Container(
            width: 140,          
            alignment: Alignment.center,
            child: Text(propertiesTypesOthers.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: _filtersPropertyType.contains(propertiesTypesOthers.name) ? Colors.white : kPrimaryColor),),
          ),
          backgroundColor: Colors.white,
          selectedColor: kPrimaryColor,
          shape: const RoundedRectangleBorder(side: BorderSide(), borderRadius: BorderRadius.all(Radius.circular(8))),
          side: const BorderSide( color: kPrimaryColor ),
          selected: _filtersPropertyType.contains(propertiesTypesOthers.name),
          onSelected: ( bool selected ) {
            setState(() {
                selected ? _filtersPropertyType.add(propertiesTypesOthers.name) : _filtersPropertyType.removeWhere((String name) => name == propertiesTypesOthers.name) ;
                Preferences.filterPropertyType = _filtersPropertyType;
            });
          },
        )
      );
    }
  }
}


class PropertiesTypes {
  const PropertiesTypes(this.name);
  final String name;
}

class PropertiesTypesOthers {
  const PropertiesTypesOthers(this.name);
  final String name;
}