/// Flutter package imports
import 'package:flutter/material.dart';

/// Gauge imports

import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Locals imports

/// Renders the gauge temperature monitor sample.
class GaugeTemperatureMonitorExample extends StatefulWidget {
  /// Creates the gauge temperature monitor sample.
  const GaugeTemperatureMonitorExample({super.key}) ;

  @override
  _GaugeTemperatureMonitorExampleState createState() =>
      _GaugeTemperatureMonitorExampleState();
}

class _GaugeTemperatureMonitorExampleState extends State {
  _GaugeTemperatureMonitorExampleState();

  @override
  Widget build(BuildContext context) {
    setState(() {
      // change axis interval based on orientation for the UI that looks good.
      _interval =
      MediaQuery.of(context).orientation == Orientation.portrait ? 10 : 20;
    });
    return Container(width:140, height:140,child: _buildTemperatureMonitorExample());
  }

  /// Returns the gauge temperature monitor
  SfRadialGauge _buildTemperatureMonitorExample() {
    return SfRadialGauge(
      animationDuration: 3500,
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
            minimum: 0,
            maximum: 151,
            interval:  30 ,
            minorTicksPerInterval: 5,
            showAxisLine: false,
            radiusFactor: 0.8 ,
            labelOffset: 2,
            ranges: <GaugeRange>[

              GaugeRange(
                  startValue: 0,
                  endValue: 40,
                  startWidth: 0.165,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.165,
                  color: Colors.blueAccent.withOpacity(0.2)),
              GaugeRange(
                  startValue: 40,
                  endValue: 90,
                  startWidth: 0.165,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.165,
                  color:  Colors.blueAccent.withOpacity(0.6)),
              GaugeRange(
                  startValue: 90,
                  endValue: 130,
                  startWidth: 0.165,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.165,
                  color: Colors.blueAccent.withOpacity(0.9)),
              GaugeRange(
                  startValue: 130,
                  endValue: 150,
                  startWidth: 0.165,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.165,
                  color: const Color.fromRGBO(238, 79, 34, 0.65)),
            ],
            annotations: const <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.35,
                  widget: Text('°C',
                      style:
                      TextStyle(color: Color(0xFFF8B195), fontSize: 16))),
              GaugeAnnotation(
                angle: 90,
                positionFactor: 0.8,
                widget: Text(
                  '  130 ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              )
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: 130,
                needleLength: 0.60,
                needleStartWidth: 0.4,
                needleEndWidth:  1.5,
                animationType: AnimationType.easeOutBack,
                enableAnimation: true,
                animationDuration: 1200,
                knobStyle: KnobStyle(
                    knobRadius:  0.07,
                    borderColor: const Color(0xFFF8B195),
                    color: Colors.white,
                    borderWidth:  0.03),
                tailStyle: TailStyle(
                    color: const Color(0xFFF8B195),
                    width:  1,
                    length: 0.18),
                needleColor: const Color(0xFFF8B195),
              )
            ],
            axisLabelStyle: GaugeTextStyle(fontSize:  10),
            majorTickStyle: const MajorTickStyle(
                length: 0.15, lengthUnit: GaugeSizeUnit.factor),
            minorTickStyle: const MinorTickStyle(
                length: 0.13, lengthUnit: GaugeSizeUnit.factor, thickness: 1))
      ],
    );
  }

  double _interval = 10;
}
