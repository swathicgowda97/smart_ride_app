import 'package:flutter/material.dart';
import '../ui_models/trip_form_field_model.dart';

class TripFormField extends StatelessWidget {
  final TripFormFieldModel config;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;

  const TripFormField({
    super.key,
    required this.config,
    required this.controller,
    this.onTap,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: config.readOnly,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        keyboardType: config.keyboardType,
        cursorColor: Colors.grey,
        validator: (v) =>
        v == null || v.isEmpty ? config.errorMessage : null,
        decoration: InputDecoration(
          labelText: config.label,
          labelStyle: const TextStyle(color: Colors.black54),
          floatingLabelStyle: TextStyle(
            color: Colors.blue.shade300,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.blue.shade100,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

