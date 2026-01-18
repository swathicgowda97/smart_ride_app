import 'package:flutter/material.dart';
import '../ui_models/trip_form_field_model.dart';

class TripFormField extends StatelessWidget {
  final TripFormFieldModel config;
  final TextEditingController controller;
  final VoidCallback? onTap;

  const TripFormField({
    super.key,
    required this.config,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: config.readOnly,
        onTap: onTap,
        keyboardType: config.keyboardType,
        validator: (v) =>
        v == null || v.isEmpty ? config.errorMessage : null,
        decoration: InputDecoration(
          labelText: config.label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
