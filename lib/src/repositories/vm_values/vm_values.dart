import 'package:dio/dio.dart';
import 'package:elrond/src/models/request/vm_values/vm_values.dart';
import 'package:elrond/src/models/response/response.dart';
import 'package:retrofit/retrofit.dart';

part 'vm_values.g.dart';

@RestApi(baseUrl: 'https://gateway.multiversx.com')
abstract class VmValuesRepository {
  factory VmValuesRepository(Dio dio, {required String baseUrl}) =
      _VmValuesRepository;

  @POST('/vm-values/query')
  Future<VmValuesQuery> query(@Body() VmValuesRequest request);
}
