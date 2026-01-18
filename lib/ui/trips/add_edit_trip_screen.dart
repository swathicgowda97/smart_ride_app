import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_ride/core/constants/app_strings.dart';
import 'package:smart_ride/ui/widgets/ride_type_selector.dart';
import '../../../core/constants/ride_types.dart';
import '../../../core/constants/trip_status.dart';
import '../../models/trip.dart';
import '../../state/trips/trip_provider.dart';
import '../ui_models/trip_form_field_model.dart';
import '../widgets/trip_form_field.dart';

class AddEditTripScreen extends ConsumerStatefulWidget {
  final Trip? trip;

  const AddEditTripScreen({super.key, this.trip});

  @override
  ConsumerState<AddEditTripScreen> createState() =>
      _AddEditTripScreenState();
}

class _AddEditTripScreenState
    extends ConsumerState<AddEditTripScreen> {
  final _formKey = GlobalKey<FormState>();

  late final pickupController =
  TextEditingController(text: widget.trip?.pickupLocation ?? '');
  late final dropController =
  TextEditingController(text: widget.trip?.dropLocation ?? '');
  late final fareController =
  TextEditingController(text: widget.trip?.fare.toString() ?? '');

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
              TripFormField(
                config: pickupField,
                controller: pickupController,
              ),
              TripFormField(
                config: dropField,
                controller: dropController,
              ),
              RideTypeSelector(
                selected: selectedRideType,
                onChanged: (v) => selectedRideType = v,
              ),
              const SizedBox(height: 16),
              TripFormField(
                config: fareField,
                controller: fareController,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                child: const Text('Save Trip'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final trip = Trip(
                      id: widget.trip?.id ??
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      pickupLocation: pickupController.text,
                      dropLocation: dropController.text,
                      rideType: selectedRideType,
                      fare: double.tryParse(fareController.text) ?? 0,
                      dateTime: DateTime.now(),
                      status: TripStatus.requested,
                    );

                    final notifier =
                    ref.read(tripProvider.notifier);

                    if (widget.trip == null) {
                      notifier.addTrip(trip);
                    } else {
                      notifier.updateTrip(trip);
                    }

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
