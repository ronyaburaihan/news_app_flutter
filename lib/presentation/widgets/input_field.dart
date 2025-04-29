import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String? title;
  final String hint;
  final TextEditingController? controller;
  final bool isPassword;
  final ValueChanged<String>? onTextChanged;
  final Color? borderColor;

  const InputField({
    super.key,
    this.title,
    required this.hint,
    this.controller,
    this.isPassword = false,
    this.onTextChanged,
    this.borderColor,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isObscureText = true;

  void _toggleObscured() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = widget.borderColor ?? theme.colorScheme.outline;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(widget.title!, style: theme.textTheme.titleSmall),
          ),
        Container(
          margin:
              widget.title != null ? EdgeInsets.only(top: 5) : EdgeInsets.zero,
          padding: const EdgeInsets.only(left: 12),
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: borderColor,
              width: 0.5,
            ),
            color: theme.colorScheme.surfaceContainer,
          ),
          child: TextFormField(
            onChanged: widget.onTextChanged,
            autofocus: false,
            obscureText: widget.isPassword && _isObscureText,
            cursorColor: theme.colorScheme.onSurface,
            keyboardType: TextInputType.text,
            controller: widget.controller,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: widget.hint,
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              suffixIcon:
                  widget.isPassword
                      ? GestureDetector(
                        onTap: _toggleObscured,
                        child: Icon(
                          _isObscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 24,
                          color: borderColor,
                        ),
                      )
                      : null,
            ),
          ),
        ),
      ],
    );
  }
}
