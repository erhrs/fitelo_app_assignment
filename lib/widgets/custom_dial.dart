import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class CustomDial extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double step;
  final double initialValue;
  final Function(double) onChanged;

  const CustomDial({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.step,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<CustomDial> createState() => _CustomDialState();
}

class _CustomDialState extends State<CustomDial>
    with SingleTickerProviderStateMixin {
  late final int _tickCount;
  late final double _anglePerTick;
  late final int _maxIndex;
  late double _rotation; // rotation used by painter
  late int _currentIndex;
  int? _lastHaptic;

  // tuned sensitivities (you can tweak pixels -> rotation scale)
  final double _dragSensitivity = 0.008;
  final double _flingSensitivity = 0.0005;

  late AnimationController _controller;
  Animation<double>? _anim;

  @override
  void initState() {
    super.initState();
    final steps = ((widget.maxValue - widget.minValue) / widget.step).round();
    _tickCount = steps + 1;
    _anglePerTick =
        pi / (_tickCount - 1) * 1.95; // half circle divided into ticks
    _maxIndex = _tickCount - 1;

    _currentIndex =
        (((widget.initialValue - widget.minValue) / widget.step).round()).clamp(
          0,
          _maxIndex,
        );

    // IMPORTANT mapping:
    // rotation range: [pi/2 - maxIndex*anglePerTick, pi/2]
    // rotation = pi/2 - index * anglePerTick  => index = (pi/2 - rotation)/anglePerTick
    _rotation = pi / 2 - _currentIndex * _anglePerTick;

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _valueForIndex(int idx) => widget.minValue + idx * widget.step;

  double _minRotation() => pi / 2 - _maxIndex * _anglePerTick;

  double _maxRotation() => pi / 2;

  double _clampRotation(double r) {
    if (r < _minRotation()) return _minRotation();
    if (r > _maxRotation()) return _maxRotation();
    return r;
  }

  void _updateIndex({bool haptic = true}) {
    final raw = (pi / 2 - _rotation) / _anglePerTick;
    int idx = raw.round().clamp(0, _maxIndex);

    // snap to nearest 0.5
    double value = widget.minValue + idx * widget.step;
    value = (value * 2).round() / 2; // rounds to nearest 0.5
    idx = ((value - widget.minValue) / widget.step).round().clamp(0, _maxIndex);

    if (idx != _currentIndex) {
      _currentIndex = idx;
      widget.onChanged(_valueForIndex(_currentIndex));
      if (haptic && _lastHaptic != idx) {
        HapticFeedback.lightImpact();
        _lastHaptic = idx;
      }
      setState(() {}); // repaint
    }
  }

  void _animateToIndex(int target) {
    target = target.clamp(0, _maxIndex);
    final dest = pi / 2 - target * _anglePerTick;
    _controller.stop();
    _controller.duration = const Duration(milliseconds: 360);
    _anim =
        Tween<double>(begin: _rotation, end: dest).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
          )
          ..addListener(() {
            setState(() => _rotation = _anim!.value);
          })
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed) _updateIndex();
          });
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    // Clip the painted dial so only the top portion is visible (like your reference)
    return ClipRect(
      child: SizedBox(
        height: 260, // adjust to control how much of the dial is visible
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanStart: (_) => _controller.stop(),
          onPanUpdate: (d) {
            // dragging right -> left should increase index:
            // when dx < 0 => _rotation decreases (because we add dx*sensitivity), so (pi/2 - rotation) increases => index increases
            setState(() {
              _rotation = _clampRotation(
                _rotation + d.delta.dx * _dragSensitivity,
              );
            });
            _updateIndex();
          },
          onPanEnd: (d) {
            // final vx = d.velocity.pixelsPerSecond.dx;
            // final predicted = _clampRotation(_rotation + vx * _flingSensitivity);
            // final idx = ((pi / 2 - predicted) / _anglePerTick).round();
            // _animateToIndex(idx);

            final vx = d.velocity.pixelsPerSecond.dx;
            final predicted = _clampRotation(
              _rotation + vx * _flingSensitivity,
            );
            double value =
                widget.minValue +
                ((pi / 2 - predicted) / _anglePerTick * widget.step);
            value = (value * 2).round() / 2; // snap to nearest 0.5
            int idx = ((value - widget.minValue) / widget.step).round().clamp(
              0,
              _maxIndex,
            );
            _animateToIndex(idx);
          },
          child: CustomPaint(
            size: const Size(double.infinity, 260),
            painter: _TopHalfDialPainter(
              rotation: _rotation,
              tickCount: _tickCount,
              anglePerTick: _anglePerTick,
              currentIndex: _currentIndex,
              step: widget.step,
              minValue: widget.minValue,
            ),
          ),
        ),
      ),
    );
  }
}

/* ---- Painter ---- */
class _TopHalfDialPainter extends CustomPainter {
  final double rotation;
  final int tickCount;
  final double anglePerTick;
  final int currentIndex;
  final double step;
  final double minValue;

  _TopHalfDialPainter({
    required this.rotation,
    required this.tickCount,
    required this.anglePerTick,
    required this.currentIndex,
    required this.step,
    required this.minValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 1.5);
    final radius = size.width * 0.9;

    // --- Light grey rings ---
    final ringPaint = Paint()
      ..color = Colors.grey.shade100
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    // --- Light grey ring thickness small ---
    final ringPaintSmallThickness = Paint()
      ..color = Colors.grey.shade100
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius + 30, ringPaint); // outer ring
    canvas.drawCircle(center, radius + 40, ringPaintSmallThickness); // outer ring small thickness
    canvas.drawCircle(center, radius - 70, ringPaint); // inner ring

    // --- Base arc background ---
    final arcPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;
    final arcRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(arcRect, pi, -pi, false, arcPaint);

    // --- Tick mark paints ---
    final smallTickPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.2;
    final mediumTickPaint = Paint()
      ..color = Colors.grey.shade500
      ..strokeWidth = 2;
    final bigTickPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2;

    // Increase total tick count for more spacing between labels
    // Example: step = 0.25 for 0.25 increments (1,1.25,1.5,1.75,2,...)
    final labelRadius = radius - 30;

    // --- Draw ticks ---
    for (int i = 0; i < tickCount; i++) {
      final angle = pi + i * anglePerTick + rotation;

      // Determine tick type based on value
      final double value = minValue + i * step;
      final double remainder = (value * 100) % 100; // decimal part in %
      Paint tickPaint;
      double tickLength;

      if (remainder == 0) {
        // Whole numbers → Big tick
        tickPaint = bigTickPaint;
        tickLength = 25;
      } else if (remainder == 50) {
        // .5 → Medium tick
        tickPaint = mediumTickPaint;
        tickLength = 25;
      } else {
        // Quarter → Small tick
        tickPaint = smallTickPaint;
        tickLength = 12;
      }

      final outer = Offset(
        center.dx + cos(angle) * (radius - 2),
        center.dy + sin(angle) * (radius - 2),
      );
      final inner = Offset(
        center.dx + cos(angle) * (radius - tickLength),
        center.dy + sin(angle) * (radius - tickLength),
      );
      canvas.drawLine(outer, inner, tickPaint);
    }

    // --- Draw labels ---
    for (int i = 0; i < tickCount; i++) {
      final double value = minValue + i * step;
      if (value % 1 != 0) continue; // only draw for whole numbers (1, 2, 3...)

      final angle = pi + i * anglePerTick + rotation;
      final pos = Offset(
        center.dx + cos(angle) * labelRadius,
        center.dy + sin(angle) * labelRadius,
      );

      final isSelected = i == currentIndex;
      final tp = TextPainter(
        text: TextSpan(
          text: value.toStringAsFixed(0),
          style: TextStyle(
            fontSize: isSelected ? 18 : 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.grey.shade700 : Colors.grey.shade500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, pos - Offset(tp.width / 2, -5));
    }

    // --- Orange indicator at top ---
    final indicatorPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    final topY = center.dy - radius + 10;
    canvas.drawLine(
      Offset(center.dx, topY -30),
      Offset(center.dx, topY + 58),
      indicatorPaint,
    );
    canvas.drawCircle(Offset(center.dx, topY -15), 3, indicatorPaint);
    canvas.drawCircle(Offset(center.dx, topY + 58), 3.5, indicatorPaint);
  }

  @override
  bool shouldRepaint(_TopHalfDialPainter old) =>
      old.rotation != rotation || old.currentIndex != currentIndex;
}
