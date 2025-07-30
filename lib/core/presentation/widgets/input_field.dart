import 'package:curated_app/core/presentation/widgets/clickable.dart';
import 'package:curated_app/core/presentation/widgets/custom_image.dart';
import 'package:curated_app/core/presentation/widgets/inputfield_state.dart';
import 'package:curated_app/core/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends TextFieldParent {
  const InputField(
      {required this.hint,
      super.key,
      required super.onChange,
      super.value,
      super.isPassword,
      this.prefix,
      this.suffix,
      this.prefixIcon,
      this.readOnly = false,
      this.maxLines = 1,
      this.maxLength,
      this.error,
      this.isClear = false,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.done,
      this.minLines = 1,
      this.onAction, this.inputFormatters});

  final String? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;

  final bool readOnly;

  final int maxLines;
  final int? maxLength;
  final String? error;
  final String hint;
  final bool isClear;

  final TextInputType inputType;

  final TextInputAction inputAction;

  final VoidCallback? onAction;
  final List<TextInputFormatter>? inputFormatters;
  final int minLines;

  @override
  TextFieldState<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends TextFieldState<InputField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
        data: theme.copyWith(
            inputDecorationTheme: theme.inputDecorationTheme.copyWith()),
        child: TextField(
          controller: controller,
          focusNode: focus,
          readOnly: widget.readOnly,
          showCursor: true,
          obscureText: isPassword,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          onEditingComplete: widget.onAction,
          textInputAction: widget.inputAction,
          style: theme.textTheme.labelMedium,
          cursorColor: theme.colorScheme.onSurface,
          inputFormatters: widget.inputFormatters,
          onTapOutside: (_) {
            focus.unfocus();
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: widget.error,
            prefixIcon: widget.prefix == null
                ? widget.prefixIcon
                : CustomImage(asset: widget.prefix!),
            suffix: widget.isPassword
                ? Clickable(
                    onPressed: () => setState(() {
                      isPassword = !isPassword;
                    }),
                    child: Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      child: Icon(
                        !isPassword ? Icons.visibility_off : Icons.visibility,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        size: 20,
                      ),
                    ),
                  )
                : widget.isClear && value.isNotEmpty
                    ? Clickable(
                        onPressed: () {
                          controller.clear();
                        },
                        child: SvgImage(
                          asset: '',
                          width: 24,
                          height: 24,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                          fit: BoxFit.scaleDown,
                        ),
                      )
                    : widget.suffix,
          ),
        ));
  }
}
