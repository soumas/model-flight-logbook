import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'utm_sync_status.mapper.dart';

@MappableEnum()
enum UtmSyncStatus {
  disabled(icon: Icons.info, color: Colors.grey, label: 'UTM Modul nicht konfiguriert'),
  unknown(icon: Icons.hourglass_bottom, color: Colors.orange, label: 'Status unbekannt'),
  noActiveFlight(icon: Icons.warning, color: Colors.red, label: 'Keine Flugfreigabe'),
  flying(icon: Icons.airplanemode_active, color: Colors.green, label: 'Flugfreigabe vorhanden'),
  error(icon: Icons.hourglass_bottom, color: Colors.orange, label: 'Status unbekannt'),
  updateFailed(icon: Icons.error, color: Colors.red, label: 'Statusupdate fehlgeschlagen');

  final IconData icon;
  final Color color;
  final String label;
  const UtmSyncStatus({
    required this.icon,
    required this.color,
    required this.label,
  });
}
