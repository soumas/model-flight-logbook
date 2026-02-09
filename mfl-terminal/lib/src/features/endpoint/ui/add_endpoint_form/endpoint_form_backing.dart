import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';

class EndpointFormBacking {
  final formKey = GlobalKey<FormState>();
  bool isCreate = true;
  ValueNotifier<String> title = ValueNotifier('');
  ValueNotifier<String> serverurl = ValueNotifier('');
  ValueNotifier<String> terminalid = ValueNotifier('');
  ValueNotifier<String> apikey = ValueNotifier('');

  EndpointFormBacking({Endpoint? entity}) {
    isCreate = entity == null;
    if (entity != null) {
      title.value = entity.title;
      serverurl.value = entity.serverurl;
      terminalid.value = entity.terminalid;
      apikey.value = entity.apikey;
    }
  }

  void dispose() {
    title.dispose();
    serverurl.dispose();
    terminalid.dispose();
    apikey.dispose();
  }
}
