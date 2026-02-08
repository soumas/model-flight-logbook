// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'endpoint.dart';

class EndpointMapper extends ClassMapperBase<Endpoint> {
  EndpointMapper._();

  static EndpointMapper? _instance;
  static EndpointMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EndpointMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Endpoint';

  static String _$title(Endpoint v) => v.title;
  static const Field<Endpoint, String> _f$title = Field('title', _$title);
  static String _$serverurl(Endpoint v) => v.serverurl;
  static const Field<Endpoint, String> _f$serverurl = Field(
    'serverurl',
    _$serverurl,
  );
  static String _$terminalid(Endpoint v) => v.terminalid;
  static const Field<Endpoint, String> _f$terminalid = Field(
    'terminalid',
    _$terminalid,
  );
  static String _$apikey(Endpoint v) => v.apikey;
  static const Field<Endpoint, String> _f$apikey = Field('apikey', _$apikey);

  @override
  final MappableFields<Endpoint> fields = const {
    #title: _f$title,
    #serverurl: _f$serverurl,
    #terminalid: _f$terminalid,
    #apikey: _f$apikey,
  };

  static Endpoint _instantiate(DecodingData data) {
    return Endpoint(
      title: data.dec(_f$title),
      serverurl: data.dec(_f$serverurl),
      terminalid: data.dec(_f$terminalid),
      apikey: data.dec(_f$apikey),
    );
  }

  @override
  final Function instantiate = _instantiate;
}

mixin EndpointMappable {
  EndpointCopyWith<Endpoint, Endpoint, Endpoint> get copyWith =>
      _EndpointCopyWithImpl<Endpoint, Endpoint>(
        this as Endpoint,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return EndpointMapper.ensureInitialized().stringifyValue(this as Endpoint);
  }

  @override
  bool operator ==(Object other) {
    return EndpointMapper.ensureInitialized().equalsValue(
      this as Endpoint,
      other,
    );
  }

  @override
  int get hashCode {
    return EndpointMapper.ensureInitialized().hashValue(this as Endpoint);
  }
}

extension EndpointValueCopy<$R, $Out> on ObjectCopyWith<$R, Endpoint, $Out> {
  EndpointCopyWith<$R, Endpoint, $Out> get $asEndpoint =>
      $base.as((v, t, t2) => _EndpointCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EndpointCopyWith<$R, $In extends Endpoint, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? title,
    String? serverurl,
    String? terminalid,
    String? apikey,
  });
  EndpointCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EndpointCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Endpoint, $Out>
    implements EndpointCopyWith<$R, Endpoint, $Out> {
  _EndpointCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Endpoint> $mapper =
      EndpointMapper.ensureInitialized();
  @override
  $R call({
    String? title,
    String? serverurl,
    String? terminalid,
    String? apikey,
  }) => $apply(
    FieldCopyWithData({
      if (title != null) #title: title,
      if (serverurl != null) #serverurl: serverurl,
      if (terminalid != null) #terminalid: terminalid,
      if (apikey != null) #apikey: apikey,
    }),
  );
  @override
  Endpoint $make(CopyWithData data) => Endpoint(
    title: data.get(#title, or: $value.title),
    serverurl: data.get(#serverurl, or: $value.serverurl),
    terminalid: data.get(#terminalid, or: $value.terminalid),
    apikey: data.get(#apikey, or: $value.apikey),
  );

  @override
  EndpointCopyWith<$R2, Endpoint, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _EndpointCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

