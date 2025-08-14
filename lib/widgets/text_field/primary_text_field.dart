import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_assistant/themes/colors/colors.dart';
import 'package:game_assistant/themes/styles/text_style.dart';

class PrimaryTextField extends StatefulWidget {
  final VoidCallback? onSendMessage;
  final TextEditingController? controller;
  const PrimaryTextField({
    super.key,
    this.onSendMessage,
    this.controller,
  });

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      expands: false,
      maxLines: 3,
      minLines: 1,
      cursorColor: Colors.green,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: bigStyle.copyWith(
        color: Colors.black,
        height: 1.5,
        fontWeight: FontWeight.w400,
      ),
      onTapOutside: (event) => SystemChannels.textInput.invokeMethod('TextInput.hide'),
      decoration: InputDecoration(
        filled: true,
        isCollapsed: true,
        contentPadding: const EdgeInsets.all(10),
        fillColor: Colors.white,
        hintText: 'Start a new chat...',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.2,
        ),
        border: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.4),
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: widget.onSendMessage,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.arrow_circle_right_rounded,
              size: 28,
              color: blueColor,
            ),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 24,
          minWidth: 24,
        ),
      ),
    );
  }
}
