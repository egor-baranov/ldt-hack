import '../generated/app.pbgrpc.dart';

import 'dart:async' as $async;

import 'dart:core' as $core;
import 'package:grpc/grpc.dart';

final apiClient = AppServiceClient(
  ClientChannel('ldt.renbou.ru:30081'),
);