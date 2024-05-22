import 'package:album_project/manager/color_manager.dart';
import 'package:album_project/manager/font_manager.dart';
import 'package:album_project/manager/space_manger.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatefulWidget {
  final Color? color;
  final List<String> items;
  final String labelText;
  final String? title;
  final String hint;
  final String? Function(String?) validator;
  final Function(String?) onChanged;

  const CustomDropdownFormField(
      {super.key,
      required this.items,
      required this.validator,
      required this.labelText,
      required this.hint,
      this.title,
      required this.onChanged,
      this.color});

  @override
  _CustomDropdownFormFieldState createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: appColors.appGrey!, width: 1.5));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Column(
                children: [
                  Text(widget.title!, style: appFont.f12w600Black),
                  appSpaces.spaceForHeight10,
                ],
              )
            : const SizedBox(),
        DropdownButtonFormField<String>(
          validator: widget.validator,
          value: _selectedItem,
          onChanged: (String? newValue) {
            widget.onChanged(newValue);
            setState(() {
              _selectedItem = newValue!;
            });
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          style: appFont.f12w500Grey,
          decoration: InputDecoration(
              fillColor: Colors.white,
              labelStyle: appFont.f12w500Grey,
              labelText: widget.labelText,
              floatingLabelStyle: appFont.f12w500Grey,
              hintText: widget.hint,
              hintStyle: appFont.f12w500Grey,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              border: border,
              disabledBorder: border,
              enabledBorder: border,
              errorBorder: border.copyWith(
                  borderSide: const BorderSide(color: Colors.red))),
        ),
      ],
    );
  }
}
