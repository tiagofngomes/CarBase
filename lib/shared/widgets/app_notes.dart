import 'package:flutter/material.dart';

class AppNotesField extends StatelessWidget {
  const AppNotesField({
    super.key,
    required this.controller,
    this.hintText = 'Acrescente alguma informação relevante',
  });

  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 1,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: 'Notas (opcional)',
        hintText: hintText,
        alignLabelWithHint: true,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 48,
          minHeight: 48,
        ),
        prefixIcon: const SizedBox(
          width: 48,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Icon(Icons.notes_rounded),
            ),
          ),
        ),
      ),
    );
  }
}

class AppNotesText extends StatelessWidget {
  const AppNotesText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall
        ?.copyWith(fontStyle: FontStyle.italic);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 50),
      child: SingleChildScrollView(
        primary: false,
        child: Text(text, style: style),
      ),
    );
  }
}
