import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({super.key, this.hintText,this.hintColor,this.label,this.labelColor,this.prefixIcon,this.prefixIconColor, required this.borderColor,this.onChange,this.isHidden=false});

  String? hintText;
  Color? hintColor;

  String? label;
  Color? labelColor;

  IconData? prefixIcon;
  Color? prefixIconColor;

  Function(String)? onChange;

  Color borderColor;

   bool? isHidden  ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isHidden! ,
      validator: (data){
        if(data!.isEmpty) {
          return "can't be empty";
        }
      },
      onChanged: onChange,
      decoration: InputDecoration(

        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),

        label: Text('$label'),
        labelStyle: TextStyle(color:labelColor ),

        prefixIcon: Icon(prefixIcon ),
        prefixIconColor: prefixIconColor,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
