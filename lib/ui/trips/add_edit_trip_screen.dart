import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_ride/core/constants/app_strings.dart';
import 'package:smart_ride/core/constants/ride_types.dart';
import 'package:smart_ride/core/constants/trip_status.dart';

import '../../models/trip.dart';
import '../../state/trips/trip_provider.dart';
import '../ui_models/trip_form_field_model.dart';
import '../widgets/trip_form_field.dart';
import '../widgets/ride_type_selector.dart';

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

  RideType selectedRideType = RideType.mini;
  double? calculatedFare;

  @override
  void initState() {
    super.initState();

    /// Calculate fare ONLY when drop is typed fully
    dropController.addListener(_requestFareCalculation);
  }

  void _requestFareCalculation() {
    final notifier = ref.read(tripProvider.notifier);

    final fare = notifier.calculateFare(
      pickup: pickupController.text,
      drop: dropController.text,
      rideType: selectedRideType,
    );

    setState(() {
      calculatedFare = fare == 0 ? null : fare;
    });
  }

  IconData _rideIcon(RideType type) {
    switch (type) {
      case RideType.mini:
        return Icons.directions_car;
      case RideType.sedan:
        return Icons.local_taxi;
      case RideType.auto:
        return Icons.electric_rickshaw;
      case RideType.bike:
        return Icons.two_wheeler;
    }
  }

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
              /// Pickup Location
              TripFormField(
                config: pickupField,
                controller: pickupController,
              ),
             const SizedBox(height: 10),
              /// Drop Location
              TripFormField(
                config: dropField,
                controller: dropController,
              ),
              const SizedBox(height: 10),
              /// Ride Type Selector
              RideTypeSelector(
                selected: selectedRideType,
                onChanged: (type) {
                  setState(() => selectedRideType = type);
                  _requestFareCalculation();
                },
              ),

              /// Fare Card (ONLY when calculated)
              if (calculatedFare != null)
                Card(
                  margin: const EdgeInsets.only(top: 16),
                  color: Colors.orange.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          _rideIcon(selectedRideType),
                          size: 36,
                          color: Colors.orange.shade800,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedRideType.label,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '₹${calculatedFare!.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              /// Save Trip
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Save Trip',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      calculatedFare != null) {
                    final trip = Trip(
                      id: widget.trip?.id ??
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      pickupLocation: pickupController.text,
                      dropLocation: dropController.text,
                      rideType: selectedRideType,
                      fare: calculatedFare!,
                      dateTime: DateTime.now(),
                      status: TripStatus.requested,
                    );

                    ref.read(tripProvider.notifier).addTrip(trip);

                    Navigator.pop(context, true);
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
