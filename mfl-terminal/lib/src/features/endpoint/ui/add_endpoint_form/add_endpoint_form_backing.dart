import 'package:flutter/material.dart';
import 'package:mfl_terminal/src/common/utils/mfl_injector.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/entities/endpoint.dart';
import 'package:mfl_terminal/src/features/endpoint/domain/repos/endpoint_repo.dart';
import 'package:mfl_terminal/src/features/endpoint/ui/global_endpointslist_state.dart';

class AddEndpointFormBacking extends ChangeNotifier {
  ValueNotifier<String> title = ValueNotifier('localhost:8082');
  ValueNotifier<String> serverurl = ValueNotifier('http://localhost:8082');
  ValueNotifier<String> terminalid = ValueNotifier('terminal1');
  ValueNotifier<String> apikey = ValueNotifier('terminal');

  final formKey = GlobalKey<FormState>();

  void submit() async {
    final endpoint = Endpoint(title: title.value, serverurl: serverurl.value, terminalid: terminalid.value, apikey: apikey.value);
    // validate connection
    try {
      await injector.get<EndpointRepo>().ping(endpoint);
    } catch (e) {
      showModalBottomSheet(context: formKey.currentContext!, builder: (context) => Text('Connection failed: $e'));
      return;
    }
    // save new endpoint
    await injector.get<EndpointRepo>().addEndpoint(endpoint);
    // refresh global endpoints list
    await injector.get<GlobalEndpointsListState>().load();
  }

  @override
  void dispose() {
    title.dispose();
    serverurl.dispose();
    terminalid.dispose();
    apikey.dispose();
    super.dispose();
  }
}
