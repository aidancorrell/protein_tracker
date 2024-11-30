import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProgressGauge extends StatelessWidget {
  final double total;
  final double target;

  ProgressGauge({required this.total, required this.target});

  @override
  Widget build(BuildContext context) {
    double progress = (total / target).clamp(0.0, 1.0);

    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: target,
          showLabels: false,
          showTicks: false,
          axisLineStyle: AxisLineStyle(
            thickness: 0.2,
            thicknessUnit: GaugeSizeUnit.factor,
            color: Colors.grey[300],
          ),
          pointers: [
            RangePointer(
              value: total,
              width: 0.2,
              sizeUnit: GaugeSizeUnit.factor,
              color: const Color.fromARGB(255, 58, 59, 60),
              enableAnimation: true,
            ),
          ],
          annotations: [
            GaugeAnnotation(
              angle: 90,
              positionFactor: 0.5,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fitness_center, // Dumbbell icon
                    size: 40,
                    color: const Color.fromARGB(255, 58, 59, 60),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${total.toStringAsFixed(1)} / ${target.toStringAsFixed(1)} g',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
