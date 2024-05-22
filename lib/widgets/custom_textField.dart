import 'package:flutter/material.dart';
import '../manager/color_manager.dart';
import '../manager/font_manager.dart';

class CustomTextField extends StatefulWidget {
  final String? floatingTitle;
  final String hint;
  final double? radius;
  final double? height;
  final bool? isPassword;
  final IconData? icon;
  final Function? ontap;
  final double? verticalPadding;
  final bool? isNumberOnly;
  final String? Function(String?) validator;
  final Function(String?)? onChanged;
  final TextEditingController? controller;

  const CustomTextField(
      {super.key,
      this.height,
      this.radius,
      this.floatingTitle,
      this.ontap,
      required this.hint,
      this.isPassword,
      this.icon,
      this.verticalPadding,
      required this.validator,
      this.isNumberOnly,
      this.controller,
      this.onChanged});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.isPassword ?? false;
  }

  @override
  Widget build(BuildContext context) {
    widget.radius ?? 10;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 15.0, vertical: widget.verticalPadding ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.floatingTitle == null
              ? const SizedBox()
              : Text(
                  widget.floatingTitle!,
                  style: appFont.f14w500Black,
                ),
          SizedBox(
            height: widget.height ?? 10,
          ),
          TextFormField(
            obscureText: obscure,
            style: appFont.f12w500Black,
            cursorColor: appColors.brandDark,
            validator: widget.validator,
            keyboardType: widget.isNumberOnly ?? false
                ? TextInputType.number
                : TextInputType.text,
            controller: widget.controller,
            decoration: InputDecoration(
                filled: true,
                prefixIcon: widget.icon == null
                    ? null
                    : IconButton(
                        onPressed: () {
                          widget.ontap!();
                        },
                        icon: Icon(
                          widget.icon,
                          size: 25,
                          color: appColors.brandDark,
                        ),
                      ),
                suffixIcon: widget.isPassword ?? false
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            width: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  obscure
                                      ? Icons.remove_red_eye
                                      : Icons.hide_source,
                                  color:
                                      Colors.deepOrangeAccent.withOpacity(0.5),
                                ),
                                !obscure
                                    ? Text(
                                        "Hide",
                                        style: appFont.f12w500Black,
                                      )
                                    : Text(
                                        "Show",
                                        style: appFont.f12w500Black,
                                      )
                              ],
                            ),
                          ),
                        ),
                      )
                    : null,
                counter: const SizedBox(),
                hintText: widget.hint,
                hintStyle: appFont.f14w400Grey,
                fillColor: Colors.white,
                disabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: appColors.primaryGrey),
                    borderRadius: BorderRadius.circular(widget.radius ?? 10)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: appColors.primaryGrey),
                    borderRadius: BorderRadius.circular(widget.radius ?? 10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: appColors.primaryGrey),
                    borderRadius: BorderRadius.circular(widget.radius ?? 10)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: appColors.primaryGrey),
                    borderRadius: BorderRadius.circular(widget.radius ?? 10))),
            onChanged: (val) {
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              }
            },
          ),
        ],
      ),
    );
  }
}
