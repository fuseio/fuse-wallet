import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: [
          Checkbox(
            side: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
            fillColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.primary),
            checkColor: Theme.of(context).canvasColor,
            overlayColor: MaterialStateProperty.all(Colors.red),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue);
            },
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                ),
          )
        ],
      ),
    );
  }
}
