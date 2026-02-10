// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'terminal_details_dto.dart';

class TerminalDetailsDtoMapper extends ClassMapperBase<TerminalDetailsDto> {
  TerminalDetailsDtoMapper._();

  static TerminalDetailsDtoMapper? _instance;
  static TerminalDetailsDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TerminalDetailsDtoMapper._());
      TerminalTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TerminalDetailsDto';

  static TerminalType _$terminaltype(TerminalDetailsDto v) => v.terminaltype;
  static const Field<TerminalDetailsDto, TerminalType> _f$terminaltype = Field(
    'terminaltype',
    _$terminaltype,
  );
  static String _$airportname(TerminalDetailsDto v) => v.airportname;
  static const Field<TerminalDetailsDto, String> _f$airportname = Field(
    'airportname',
    _$airportname,
  );
  static String _$terminalname(TerminalDetailsDto v) => v.terminalname;
  static const Field<TerminalDetailsDto, String> _f$terminalname = Field(
    'terminalname',
    _$terminalname,
  );
  static int _$maxAltitudeM(TerminalDetailsDto v) => v.maxAltitudeM;
  static const Field<TerminalDetailsDto, int> _f$maxAltitudeM = Field(
    'maxAltitudeM',
    _$maxAltitudeM,
  );
  static int _$maxAltitudeWithoutObserverM(TerminalDetailsDto v) =>
      v.maxAltitudeWithoutObserverM;
  static const Field<TerminalDetailsDto, int> _f$maxAltitudeWithoutObserverM =
      Field('maxAltitudeWithoutObserverM', _$maxAltitudeWithoutObserverM);
  static int _$maxNumFlights(TerminalDetailsDto v) => v.maxNumFlights;
  static const Field<TerminalDetailsDto, int> _f$maxNumFlights = Field(
    'maxNumFlights',
    _$maxNumFlights,
  );
  static bool _$showPilotIDOnDashboard(TerminalDetailsDto v) =>
      v.showPilotIDOnDashboard;
  static const Field<TerminalDetailsDto, bool> _f$showPilotIDOnDashboard =
      Field('showPilotIDOnDashboard', _$showPilotIDOnDashboard);
  static DateTime? _$operatinghourStart(TerminalDetailsDto v) =>
      v.operatinghourStart;
  static const Field<TerminalDetailsDto, DateTime> _f$operatinghourStart =
      Field('operatinghourStart', _$operatinghourStart, opt: true);
  static DateTime? _$operatinghourEnd(TerminalDetailsDto v) =>
      v.operatinghourEnd;
  static const Field<TerminalDetailsDto, DateTime> _f$operatinghourEnd = Field(
    'operatinghourEnd',
    _$operatinghourEnd,
    opt: true,
  );
  static List<String>? _$dashboardMessages(TerminalDetailsDto v) =>
      v.dashboardMessages;
  static const Field<TerminalDetailsDto, List<String>> _f$dashboardMessages =
      Field('dashboardMessages', _$dashboardMessages, opt: true);

  @override
  final MappableFields<TerminalDetailsDto> fields = const {
    #terminaltype: _f$terminaltype,
    #airportname: _f$airportname,
    #terminalname: _f$terminalname,
    #maxAltitudeM: _f$maxAltitudeM,
    #maxAltitudeWithoutObserverM: _f$maxAltitudeWithoutObserverM,
    #maxNumFlights: _f$maxNumFlights,
    #showPilotIDOnDashboard: _f$showPilotIDOnDashboard,
    #operatinghourStart: _f$operatinghourStart,
    #operatinghourEnd: _f$operatinghourEnd,
    #dashboardMessages: _f$dashboardMessages,
  };

  static TerminalDetailsDto _instantiate(DecodingData data) {
    return TerminalDetailsDto(
      terminaltype: data.dec(_f$terminaltype),
      airportname: data.dec(_f$airportname),
      terminalname: data.dec(_f$terminalname),
      maxAltitudeM: data.dec(_f$maxAltitudeM),
      maxAltitudeWithoutObserverM: data.dec(_f$maxAltitudeWithoutObserverM),
      maxNumFlights: data.dec(_f$maxNumFlights),
      showPilotIDOnDashboard: data.dec(_f$showPilotIDOnDashboard),
      operatinghourStart: data.dec(_f$operatinghourStart),
      operatinghourEnd: data.dec(_f$operatinghourEnd),
      dashboardMessages: data.dec(_f$dashboardMessages),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TerminalDetailsDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TerminalDetailsDto>(map);
  }

  static TerminalDetailsDto fromJson(String json) {
    return ensureInitialized().decodeJson<TerminalDetailsDto>(json);
  }
}

mixin TerminalDetailsDtoMappable {
  String toJson() {
    return TerminalDetailsDtoMapper.ensureInitialized()
        .encodeJson<TerminalDetailsDto>(this as TerminalDetailsDto);
  }

  Map<String, dynamic> toMap() {
    return TerminalDetailsDtoMapper.ensureInitialized()
        .encodeMap<TerminalDetailsDto>(this as TerminalDetailsDto);
  }

  @override
  String toString() {
    return TerminalDetailsDtoMapper.ensureInitialized().stringifyValue(
      this as TerminalDetailsDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return TerminalDetailsDtoMapper.ensureInitialized().equalsValue(
      this as TerminalDetailsDto,
      other,
    );
  }

  @override
  int get hashCode {
    return TerminalDetailsDtoMapper.ensureInitialized().hashValue(
      this as TerminalDetailsDto,
    );
  }
}

