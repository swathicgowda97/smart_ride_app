import 'package:flutter/material.dart';
import '../../../../core/constants/ride_types.dart';

class RideTypeSelector extends StatefulWidget {
  final RideType selected;
  final ValueChanged<RideType> onChanged;

  const RideTypeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<RideTypeSelector> createState() => _RideTypeSelectorState();
}

class _RideTypeSelectorState extends State<RideTypeSelector> {
  late RideType current;

  @override
  void initState() {
    super.initState();
    current = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ride Type',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: RideType.values.map((type) {
            final isSelected = current == type;

            return ChoiceChip(
              label: Text(
                type.label,
                style: TextStyle(
                  // color: isSelected ? Colors.yellow.shade800 : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              selected: isSelected,
              selectedColor: Colors.green.shade100,
              backgroundColor: Colors.green.shade50,
              shape: StadiumBorder(
                side: BorderSide(
                  color:
                  isSelected ? Colors.green.shade300 : Colors.transparent,
                  width: 2,
                ),
              ),
              onSelected: (_) {
                setState(() => current = type);
                widget.onChanged(type);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
