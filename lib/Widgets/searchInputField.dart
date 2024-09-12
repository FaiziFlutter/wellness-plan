import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowfit/Utils/color_resources.dart';
import 'package:wowfit/Utils/styles.dart';

// ignore: must_be_immutable
class SearchInputFields extends StatelessWidget {
  String _hint;
  String _error;
  bool _isPassword, _isEmail, _isPhone, _deco;
  Function(String)? callback;
  final TextEditingController? _controller;

  SearchInputFields(String hint, String error,
      {Key? key,
      this.callback,
      bool isPassword = false,
      bool isEmail = false,
      bool isPhone = false,
      bool deco = false,
      Widget? suffixIcon,
      Widget? prefixIcon,
      TextEditingController? controller})
      : _hint = hint,
        _error = error,
        _isPassword = isPassword,
        _isEmail = isEmail,
        _isPhone = isPhone,
        _deco = deco,
        _controller = controller,
        super(key: key);

  inputDecorationTextField(context, hint) {
    return InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xFF0E0F0F),
        ),
        fillColor: const Color(0xFFF2F4F5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: hint,
        errorStyle: const TextStyle(fontSize: 10),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFF2F4F5), width: 2),
        ),
        //When the TextFormField is ON focus
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFF2F4F5), width: 2),
        ),
        hintStyle: sFProDisplayRegular.copyWith(
          color: ColorResources.INPUT_HINT_COLOR,
          fontSize: 16,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF2F4F5),
      ),
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: TextFormField(
        cursorColor: ColorResources.COLOR_NORMAL_BLACK,
        style: sFProDisplayRegular.copyWith(
          fontSize: 16,
          color: ColorResources.COLOR_NORMAL_BLACK,
        ),
        controller: _controller,
        onChanged: (value) {
          callback!(value);
        },
        keyboardType: TextInputType.emailAddress,
        validator: _isEmail == true
            ? (value) {
                return validateEmail(value!);
              }
            : _isPhone == true
                ? (value) {
                    return validateMobile(value!);
                  }
                : (value) {
                    return null;
                  },
        decoration: inputDecorationTextField(context, 'Search exercise'.tr),
      ),
    );
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    } else if (value.length > 15) {
      return 'length cant be greater than 15';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return null;
    } else {
      return 'Please Enter valid Email'.tr;
    }
  }
}
