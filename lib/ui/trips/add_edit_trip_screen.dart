import 'package:flutter/material.dart';
import 'package:smart_ride/core/constants/app_strings.dart';
import 'package:smart_ride/ui/trips/ride_type_selector.dart';
import '../../../core/constants/ride_types.dart';

import '../../models/trip.dart';
import '../ui_models/trip_form_field_model.dart';
import '../widgets/trip_form_field.dart';

class AddEditTripScreen extends StatefulWidget {
  final Trip? trip;

  const AddEditTripScreen({super.key, this.trip});

  @override
  State<AddEditTripScreen> createState() => _AddEditTripScreenState();
}

class _AddEditTripScreenState extends State<AddEditTripScreen> {
  final _formKey = GlobalKey<FormState>();

  late final pickupController = TextEditingController(
    text: widget.trip?.pickupLocation ?? '',
  );
  late final dropController = TextEditingController(
    text: widget.trip?.dropLocation ?? '',
  );
  late final fareController = TextEditingController(
    text: widget.trip?.fare.toString() ?? '',
  );

  RideType selectedRideType = RideType.mini;

  @override
  Widget build(BuildContext context) {
    final pickupField = TripFormFieldModel(
      label: AppStrings.pickupLabel,
      errorMessage: AppStrings.pickupError,
    );

    final dropField = TripFormFieldModel(
      label: AppStrings.dropLabel,
      errorMessage: AppStrings.dropError,
    );

    final fareField = TripFormFieldModel(
      label: AppStrings.fareLabel,
      errorMessage: AppStrings.fareError,
      keyboardType: TextInputType.number,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trip == null ? 'Book Trip' : 'Edit Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TripFormField(config: pickupField, controller: pickupController),
              TripFormField(config: dropField, controller: dropController),
              RideTypeSelector(
                selected: selectedRideType,
                onChanged: (v) => selectedRideType = v,
              ),
              const SizedBox(height: 16),
              TripFormField(config: fareField, controller: fareController),
              const SizedBox(height: 24),
              ElevatedButton(
                child: const Text('Save Trip'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
