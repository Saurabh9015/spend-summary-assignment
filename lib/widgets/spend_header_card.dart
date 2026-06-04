import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../theme/app_theme.dart';
import '../utils/format_utils.dart';

class SpendHeaderCard extends StatelessWidget {
  const SpendHeaderCard({
    super.key,
    required this.monthLabel,
    required this.monthlySpend,
    required this.percentChange,
    this.trendPoints = const [],
    this.animate = true,
  });

  SpendHeaderCard.fromSummary({
    super.key,
    required SpendSummaryData summary,
    this.animate = true,
    List<double>? trendPoints,
  })  : monthLabel = summary.monthLabel,
        monthlySpend = summary.monthlySpend,
        percentChange = summary.percentChange,
        trendPoints = trendPoints ?? DummyData.spendTrendPoints;

  final String monthLabel;
  final double monthlySpend;
  final double percentChange;
  final List<double> trendPoints;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final card = _SpendHeaderCardContent(
      monthLabel: monthLabel,
      monthlySpend: monthlySpend,
      percentChange: percentChange,
      trendPoints: trendPoints,
    );

    if (!animate) return card;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - value)),
            child: child,
          ),
        );
      },
      child: card,
    );
  }
}

class _SpendHeaderCardContent extends StatelessWidget {
  const _SpendHeaderCardContent({
    required this.monthLabel,
    required this.monthlySpend,
    required this.percentChange,
    required this.trendPoints,
  });

  final String monthLabel;
  final double monthlySpend;
  final double percentChange;
  final List<double> trendPoints;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;
    final spendIncreased = percentChange >= 0;
    final changeColor = AppTheme.spendChangeColor(
      spendIncreased: spendIncreased,
      brightness: brightness,
    );
    final changeIcon = spendIncreased
        ? Icons.trending_up_rounded
        : Icons.trending_down_rounded;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 340;
        final amountStyle = theme.textTheme.headlineLarge?.copyWith(
          fontSize: isCompact ? 34 : 40,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.8,
          color: Colors.white,
          height: 1.05,
        );

        return Material(
          elevation: 8,
          shadowColor: colorScheme.primary.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(24),
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0F766E),
                    colorScheme.primary,
                    Color.lerp(
                      colorScheme.primary,
                      const Color(0xFF6366F1),
                      0.55,
                    )!,
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -12,
                    top: 12,
                    bottom: 12,
                    child: Opacity(
                      opacity: 0.22,
                      child: Icon(
                        Icons.insights_rounded,
                        size: 120,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(isCompact ? 20 : 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.account_balance_wallet_outlined,
                                        size: 18,
                                        color: Colors.white.withValues(
                                          alpha: 0.9,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        monthLabel,
                                        style:
                                            theme.textTheme.labelLarge?.copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.92,
                                          ),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    'Monthly spend',
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.78,
                                      ),
                                      fontSize: 13,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      FormatUtils.currency(monthlySpend),
                                      style: amountStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (trendPoints.isNotEmpty)
                              _TrendSparkline(points: trendPoints),
                          ],
                        ),
                        const SizedBox(height: 18),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(changeIcon, size: 20, color: changeColor),
                                const SizedBox(width: 8),
                                Text(
                                  '${percentChange.abs().toStringAsFixed(1)}%',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    color: changeColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  spendIncreased
                                      ? 'more than last month'
                                      : 'less than last month',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.88),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TrendSparkline extends StatelessWidget {
  const _TrendSparkline({required this.points});

  final List<double> points;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: 72,
          height: 44,
          child: CustomPaint(
            painter: _SparklinePainter(points: points),
          ),
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.points});

  final List<double> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withValues(alpha: 0.28),
          Colors.white.withValues(alpha: 0.02),
        ],
      ).createShader(Offset.zero & size);

    final dx = size.width / (points.length - 1);
    final path = Path();
    final fillPath = Path()..moveTo(0, size.height);

    for (var i = 0; i < points.length; i++) {
      final x = i * dx;
      final y = size.height - (points[i] * size.height * 0.85);
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    final lastX = size.width;
    final lastY = size.height - (points.last * size.height * 0.85);
    canvas.drawCircle(
      Offset(lastX, lastY),
      3.5,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
