import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'utm_sync_status.mapper.dart';

@MappableEnum()
enum UtmSyncStatus {
  unknown(icon: Icons.error, color: Colors.orange, animated: false, label: 'UTM Status unbekannt'),
  noActiveFlight(icon: Icons.error, color: Colors.red, animated: false, label: 'Keine Starterlaubnis'),
  busy(icon: Icons.hourglass_top, color: Colors.orange, animated: true, label: 'UTM Interaktion läuft ...'),
  flying(icon: Icons.check_circle, color: Colors.green, animated: false, label: 'Flugfreigabe erteilt'),
  error(icon: Icons.error, color: Colors.red, animated: false, label: 'UTM Interaktion fehlgeschlagen');

  final IconData icon;
  final Color color;
  final String label;
  final bool animated;
  const UtmSyncStatus({
    required this.icon,
    required this.color,
    required this.label,
    required this.animated,
  });
}
