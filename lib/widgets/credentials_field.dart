import 'package:flutter/material.dart';

class CredentialsField extends StatefulWidget {
  final Icon icon;
  final String hint;
  final TextEditingController? controller;

  const CredentialsField({super.key, required this.icon, required this.hint, this.controller});

  @override
  State<StatefulWidget> createState() => _CredentialsField();
}

class _CredentialsField extends State<CredentialsField> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: emailController,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                alignLabelWithHint: true,
                prefixIconColor: Colors.black.withOpacity(0.5),
                hintText: widget.hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                prefixIcon: widget.icon,
              ),
            ),
          )
        ],
      ),
    );
  }
}
