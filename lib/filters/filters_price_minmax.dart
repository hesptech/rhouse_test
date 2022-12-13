import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_black_white/utils/constants.dart';
//import 'package:flutter_black_white/utils/constants.dart';

class FiltersPriceMinmax extends StatefulWidget {
  const FiltersPriceMinmax({Key? key}) : super(key: key);

  @override
  State<FiltersPriceMinmax> createState() => _FiltersPriceMinmaxState();
}

class _FiltersPriceMinmaxState extends State<FiltersPriceMinmax> {

  final emailController = TextEditingController();
  final numberController = TextEditingController();
  String password = '0';
  bool isPasswordVisible = false;

  final String pippo = '1';
  late double filterPriceRangeEnd;
  late RangeValues selectedRange;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() => setState(() {}));
    numberController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {





    // 1
    Widget buildNumberMin() => TextFormField(
      //enabled: false,
      maxLength: 11,
      initialValue: '\$ $pippo',
      //inputFormatters: [],
      //maxLengthEnforcement: MaxLengthEnforcement.enforced,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
        label: const Text('1 Min', style: TextStyle( color: kPrimaryColor, fontWeight: FontWeight.w500, )),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kPrimaryColor, ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kPrimaryColor,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kPrimaryColor,), 
        ), 
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kPrimaryColor,), 
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: (String value) {

      },
      validator: (value) {
        return value!.isEmpty ? 'Please enter email' : null ;
      },
    );    


    // 3
    Widget buildEmail() => TextField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: '0',
        labelText: '3 Min',
        prefixIcon: const Icon(Icons.numbers),
        icon: const Icon(Icons.ac_unit),
        suffixIcon: emailController.text.isEmpty
        ? Container( width: 0,)
        : IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => emailController.clear(),
          //onPressed: () => print('Email: ${emailController.text}'), 
        ),
        border: const OutlineInputBorder()
      ),
      textInputAction: TextInputAction.done,
    );

    
    // 4
    Widget buildPassword() => TextField(
      //autofocus: true,
      onChanged: ( value ) => setState(() => password = value ),
      onSubmitted: ( value ) => setState(() {}),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
        hintText: 'your password...',
        labelText: '4 Password',
        errorText: 'wrong password',
        suffixIcon: IconButton(
          onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
          //onPressed: () => setState(() => print('Password: $password')), 
          icon: isPasswordVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
        ),
        border: const OutlineInputBorder(),
        //enabled: false,
      ),
      //readOnly: true,
      obscureText: isPasswordVisible,
    ); 


    // 5
    Widget buildNumber() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('5 Number', style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor, )),
        const SizedBox(height: 8),
        TextField(
          controller: numberController,
          onChanged: (value) {
            setState(() {
              if (value != '') {
                //print(value);
                //numberController.value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
                //numberController.value.replaced(replacementRange, value)
              }
            });
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            //icon: Icon(Icons.attach_money_outlined),
            prefixIcon:  const Icon(Icons.attach_money_outlined, color: kPrimaryColor) ,
            hintText: 'Enter number...',
            hintStyle: const TextStyle(color: kPrimaryColor),
            //filled: true,
            //fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kPrimaryColor, ),              
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kPrimaryColor,),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kPrimaryColor,), 
            ), 
          ),
          style: const TextStyle(color: kPrimaryColor),
          keyboardType: TextInputType.number,
        ),
      ],
    );






    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 28.0, horizontal: 21.0),
      child: Column(
        children: [
          
          // 1
          const SizedBox( height: 20.0, ),
          SizedBox(
            width: 135.0,
            child: buildNumberMin(),
          ),
          const SizedBox( height: 20.0, ),

          // 2
          SizedBox(
            width: 80.0,
            child: 
            TextFormField(
              //enabled: false,
              initialValue: '0',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
                label: const Text('2 Min f', style: TextStyle( color: kPrimaryColor, fontWeight: FontWeight.w500, )),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kPrimaryColor, ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kPrimaryColor,),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kPrimaryColor,), 
                ), 
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: kPrimaryColor,), 
                ),
              ),
              onChanged: (String value) {
        
              },
              validator: (value) {
                return value!.isEmpty ? 'Please enter email' : null ;
              },
            ),
          ),


          // 3
          const SizedBox( height: 10.0, ),
          SizedBox(
            width: 150.0,
            child: buildEmail(),
          ),

          // 4
          const SizedBox( height: 10.0, ),
          const Text('4.', style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor, )),
          SizedBox(
            width: 180.0,
            child: buildPassword(),
          ),


          // 5
          SizedBox(
            width: 150.0,
            child: buildNumber(),
          ),


        ],
      ),
    );





    /* return SizedBox(
      width: 150.0,
      child: Padding(
        padding: const EdgeInsets.symmetric( vertical: 28.0, horizontal: 21.0),
        child: TextFormField(
          //enabled: false,
          initialValue: '0',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            label: const Text('Min', style: TextStyle( color: kPrimaryColor, fontWeight: FontWeight.w500, )),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kPrimaryColor, ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kPrimaryColor,),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kPrimaryColor,), 
            ), 
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kPrimaryColor,), 
            ),
          ),
          onChanged: (String value) {
    
          },
          validator: (value) {
            return value!.isEmpty ? 'Please enter email' : null ;
          },
        ), 
      ),
    ); */
  }
}