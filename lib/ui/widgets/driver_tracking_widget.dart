import 'package:flutter/material.dart';

class DriverTrackingWidget extends StatelessWidget {
  final int? etaSeconds;
  final double? progress;

  const DriverTrackingWidget({
    super.key,
    required this.etaSeconds,
    required this.progress,
  });

  String _formatEta(int seconds) {
    final min = seconds ~/ 60;
    final sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:'
        '${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (etaSeconds == null || progress == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ETA TEXT
        Text(
          'Driver arriving in ${_formatEta(etaSeconds!)}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),

        /// PROGRESS TRACK WITH MOVING CAR
        SizedBox(
          height: 28,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final trackWidth = constraints.maxWidth;
              final carPosition = trackWidth * progress!.clamp(0.0, 1.0);

              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  /// Background track
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  /// Animated progress bar
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    height: 6,
                    width: trackWidth * progress!,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  /// Moving car icon
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    left: carPosition - 12, // center the icon
                    child: const Icon(
                      Icons.local_taxi,
                      size: 20,
                      color: Colors.orange,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
