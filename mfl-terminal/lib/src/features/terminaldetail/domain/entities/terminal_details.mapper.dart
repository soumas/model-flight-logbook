// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'terminal_details.dart';

class TerminalDetailsMapper extends ClassMapperBase<TerminalDetails> {
  TerminalDetailsMapper._();

  static TerminalDetailsMapper? _instance;
  static TerminalDetailsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TerminalDetailsMapper._());
      TerminalTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TerminalDetails';

  static TerminalType _$terminaltype(TerminalDetails v) => v.terminaltype;
  static const Field<TerminalDetails, TerminalType> _f$terminaltype = Field(
    'terminaltype',
    _$terminaltype,
  );
  static String _$airportname(TerminalDetails v) => v.airportname;
  static const Field<TerminalDetails, String> _f$airportname = Field(
    'airportname',
    _$airportname,
  );
  static String _$terminalname(TerminalDetails v) => v.terminalname;
  static const Field<TerminalDetails, String> _f$terminalname = Field(
    'terminalname',
    _$terminalname,
  );
  static int _$maxAltitudeM(TerminalDetails v) => v.maxAltitudeM;
  static const Field<TerminalDetails, int> _f$maxAltitudeM = Field(
    'maxAltitudeM',
    _$maxAltitudeM,
  );
  static int _$maxAltitudeWithoutObserverM(TerminalDetails v) =>
      v.maxAltitudeWithoutObserverM;
  static const Field<TerminalDetails, int> _f$maxAltitudeWithoutObserverM =
      Field('maxAltitudeWithoutObserverM', _$maxAltitudeWithoutObserverM);
  static int _$maxNumFlights(TerminalDetails v) => v.maxNumFlights;
  static const Field<TerminalDetails, int> _f$maxNumFlights = Field(
    'maxNumFlights',
    _$maxNumFlights,
  );
  static bool _$showPilotIDOnDashboard(TerminalDetails v) =>
      v.showPilotIDOnDashboard;
  static const Field<TerminalDetails, bool> _f$showPilotIDOnDashboard = Field(
    'showPilotIDOnDashboard',
    _$showPilotIDOnDashboard,
  );
  static DateTime? _$operatinghourStart(TerminalDetails v) =>
      v.operatinghourStart;
  static const Field<TerminalDetails, DateTime> _f$operatinghourStart = Field(
    'operatinghourStart',
    _$operatinghourStart,
    opt: true,
  );
  static DateTime? _$operatinghourEnd(TerminalDetails v) => v.operatinghourEnd;
  static const Field<TerminalDetails, DateTime> _f$operatinghourEnd = Field(
    'operatinghourEnd',
    _$operatinghourEnd,
    opt: true,
  );
  static List<String>? _$dashboardMessages(TerminalDetails v) =>
      v.dashboardMessages;
  static const Field<TerminalDetails, List<String>> _f$dashboardMessages =
      Field('dashboardMessages', _$dashboardMessages, opt: true);

  @override
  final MappableFields<TerminalDetails> fields = const {
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

  static TerminalDetails _instantiate(DecodingData data) {
    return TerminalDetails(
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
}

mixin TerminalDetailsMappable {
  TerminalDetailsCopyWith<TerminalDetails, TerminalDetails, TerminalDetails>
  get copyWith =>
      _TerminalDetailsCopyWithImpl<TerminalDetails, TerminalDetails>(
        this as TerminalDetails,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TerminalDetailsMapper.ensureInitialized().stringifyValue(
      this as TerminalDetails,
    );
  }

  @override
  bool operator ==(Object other) {
    return TerminalDetailsMapper.ensureInitialized().equalsValue(
      this as TerminalDetails,
      other,
    );
  }

  @override
  int get hashCode {
    return TerminalDetailsMapper.ensureInitialized().hashValue(
      this as TerminalDetails,
    );
  }
}

extension TerminalDetailsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TerminalDetails, $Out> {
  TerminalDetailsCopyWith<$R, TerminalDetails, $Out> get $asTerminalDetails =>
      $base.as((v, t, t2) => _TerminalDetailsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TerminalDetailsCopyWith<$R, $In extends TerminalDetails, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get dashboardMessages;
  $R call({
    TerminalType? terminaltype,
    String? airportname,
    String? terminalname,
    int? maxAltitudeM,
    int? maxAltitudeWithoutObserverM,
    int? maxNumFlights,
    bool? showPilotIDOnDashboard,
    DateTime? operatinghourStart,
    DateTime? operatinghourEnd,
    List<String>? dashboardMessages,
  });
  TerminalDetailsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _TerminalDetailsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TerminalDetails, $Out>
    implements TerminalDetailsCopyWith<$R, TerminalDetails, $Out> {
  _TerminalDetailsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TerminalDetails> $mapper =
      TerminalDetailsMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get dashboardMessages => $value.dashboardMessages != null
      ? ListCopyWith(
          $value.dashboardMessages!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(dashboardMessages: v),
        )
      : null;
  @override
  $R call({
    TerminalType? terminaltype,
    String? airportname,
    String? terminalname,
    int? maxAltitudeM,
    int? maxAltitudeWithoutObserverM,
    int? maxNumFlights,
    bool? showPilotIDOnDashboard,
    Object? operatinghourStart = $none,
    Object? operatinghourEnd = $none,
    Object? dashboardMessages = $none,
  }) => $apply(
    FieldCopyWithData({
      if (terminaltype != null) #terminaltype: terminaltype,
      if (airportname != null) #airportname: airportname,
      if (terminalname != null) #terminalname: terminalname,
      if (maxAltitudeM != null) #maxAltitudeM: maxAltitudeM,
      if (maxAltitudeWithoutObserverM != null)
        #maxAltitudeWithoutObserverM: maxAltitudeWithoutObserverM,
      if (maxNumFlights != null) #maxNumFlights: maxNumFlights,
      if (showPilotIDOnDashboard != null)
        #showPilotIDOnDashboard: showPilotIDOnDashboard,
      if (operatinghourStart != $none) #operatinghourStart: operatinghourStart,
      if (operatinghourEnd != $none) #operatinghourEnd: operatinghourEnd,
      if (dashboardMessages != $none) #dashboardMessages: dashboardMessages,
    }),
  );
  @override
  TerminalDetails $make(CopyWithData data) => TerminalDetails(
    terminaltype: data.get(#terminaltype, or: $value.terminaltype),
    airportname: data.get(#airportname, or: $value.airportname),
    terminalname: data.get(#terminalname, or: $value.terminalname),
    maxAltitudeM: data.get(#maxAltitudeM, or: $value.maxAltitudeM),
    maxAltitudeWithoutObserverM: data.get(
      #maxAltitudeWithoutObserverM,
      or: $value.maxAltitudeWithoutObserverM,
    ),
    maxNumFlights: data.get(#maxNumFlights, or: $value.maxNumFlights),
    showPilotIDOnDashboard: data.get(
      #showPilotIDOnDashboard,
      or: $value.showPilotIDOnDashboard,
    ),
    operatinghourStart: data.get(
      #operatinghourStart,
      or: $value.operatinghourStart,
    ),
    operatinghourEnd: data.get(#operatinghourEnd, or: $value.operatinghourEnd),
    dashboardMessages: data.get(
      #dashboardMessages,
      or: $value.dashboardMessages,
    ),
  );

  @override
  TerminalDetailsCopyWith<$R2, TerminalDetails, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TerminalDetailsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

