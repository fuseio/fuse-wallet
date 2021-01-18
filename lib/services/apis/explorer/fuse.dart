// import 'package:dio/dio.dart';
// import 'package:fusecash/constants/urls.dart';
// import 'package:fusecash/services/apis/explorer.dart';
// import 'package:injectable/injectable.dart';
// import 'package:retrofit/retrofit.dart';

// part 'fuse.g.dart';

// @lazySingleton
// @RestApi(baseUrl: UrlConstants.FUSE_EXPLORER_URL)
// abstract class FuseExplorerService {
//   factory FuseExplorerService(Dio dio, {String baseUrl}) = _FuseExplorerService;

//   @factoryMethod
//   static FuseExplorerService create() {
//     final dio = Dio()
//       ..interceptors.add(LogInterceptor(
//           responseBody: true,
//           error: true,
//           requestHeader: true,
//           responseHeader: true,
//           request: true,
//           requestBody: true));
//     return FuseExplorerService(dio);
//   }

//   @override
//   @POST('/accounts:signUp?key={authKey}')
//   Future<Map> getTokeInfo(
//       @Path('authKey') String authKey, @Body() Map<String, dynamic> body);

//   // @POST('/accounts:signInWithPassword?key={authKey}')
//   // Future<User> login(
//   //     @Path('authKey') String authKey, @Body() Map<String, dynamic> body);
// }
