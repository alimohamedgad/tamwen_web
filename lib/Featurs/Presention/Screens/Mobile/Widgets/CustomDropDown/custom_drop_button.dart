// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDownField extends StatelessWidget {
  final void Function(Object?)? onChange;
  final String hint;
  final Object? selectVaule;
  final List<DropdownMenuItem<Object>>? items;
  final Key? keyDropDown;
  final String? Function(Object?)? validator;

  const CustomDropDownField({
    Key? key,
    this.onChange,
    required this.hint,
    required this.selectVaule,
    required this.items,
    this.keyDropDown,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: ButtonTheme(
        child: DropdownButtonFormField2(
          key: keyDropDown,
          validator: validator,
          isExpanded: true,
          dropdownDecoration:
              BoxDecoration(borderRadius: BorderRadius.circular(20)),
          decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: 17, color: Colors.red.shade50),
            fillColor: Colors.white,
            filled: true,
            // label: la,
            isDense: true,
            contentPadding: const EdgeInsets.all(18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          hint: Text(
            hint,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          value: selectVaule,
          items: items,
          onChanged: onChange,
        ),
      ),
    );
  }
}
