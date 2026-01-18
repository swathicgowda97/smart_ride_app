import 'package:flutter/material.dart';

class TripFormFieldModel {
  final String label;
  final String errorMessage;
  final bool readOnly;
  final TextInputType keyboardType;

  const TripFormFieldModel({
    required this.label,
    required this.errorMessage,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
  });
}
