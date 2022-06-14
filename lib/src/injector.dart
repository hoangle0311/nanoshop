import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/data/data_source/local/product_local_service/product_local_service.dart';
import 'package:nanoshop/src/data/data_source/local/user_service/user_local_service.dart';
import 'package:nanoshop/src/data/data_source/remote/auth_service/auth_service.dart';
import 'package:nanoshop/src/data/data_source/remote/post_service/post_remote_service.dart';
import 'package:nanoshop/src/data/data_source/remote/product_service/product_service.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/add_user_local_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/get_user_local_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/get_user_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/login_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/remove_user_local_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/sign_up_usecase.dart';
import 'package:nanoshop/src/domain/usecases/post_usecase/get_list_post_usecase.dart';
import 'package:nanoshop/src/domain/usecases/product_usecase/get_flash_sale_product_usecase.dart';
import 'package:nanoshop/src/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/flash_sale_bloc/flash_sale_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/local_product_bloc/local_product_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/post_bloc/post_bloc.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/time_cubit/time_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/params/token_param.dart';
import 'data/data_source/remote/remote_service.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/data_layer_repository.dart';
import 'domain/usecases/domain_layer_usecase.dart';
import 'presentation/blocs/blocs.dart';
import 'presentation/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'presentation/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  await _dependencyExternal();

  // Lay token cho toan app
  _dependencyToken();

  _dependencyUseCase();
  _dependencyService();
  _dependencyRepository();
  _dependencyBloc();
  _dependecyCubit();
}

_dependencyExternal() async {
  injector.registerLazySingleton<Dio>(() => Dio());
  final preferences = await SharedPreferences.getInstance();
  injector.registerSingleton<SharedPreferences>(
    preferences,
  );
}

_dependencyUseCase() {
  injector.registerLazySingleton<AddUserLocalUsecase>(
    () => AddUserLocalUsecase(
      injector<AuthRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetUserLocalUsecase>(
    () => GetUserLocalUsecase(
      injector<AuthRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<RemoveUserLocalUsecase>(
    () => RemoveUserLocalUsecase(
      injector<AuthRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(
      injector<AuthRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetUserUsecase>(
    () => GetUserUsecase(
      injector<AuthRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      injector<AuthRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListFlashSaleProductRemoteUsecase>(
    () => GetListFlashSaleProductRemoteUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListProductRemoteUsecase>(
    () => GetListProductRemoteUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListCategoryUsecase>(
    () => GetListCategoryUsecase(
      injector<CategoryRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetBannerUsecase>(
    () => GetBannerUsecase(
      injector<BannerRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetTokenUsecase>(
    () => GetTokenUsecase(
      injector<GetTokenRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListFavouriteProductLocalUsecase>(
    () => GetListFavouriteProductLocalUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<AddFavouriteProductLocalUsecase>(
    () => AddFavouriteProductLocalUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<RemoveFavouriteProductLocalUsecase>(
    () => RemoveFavouriteProductLocalUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListPostUsecase>(
    () => GetListPostUsecase(
      injector<PostRepositoryImpl>(),
    ),
  );
}

_dependencyService() {
  injector.registerLazySingleton<UserLocalService>(
    () => UserLocalService(
      injector<SharedPreferences>(),
    ),
  );
  injector.registerLazySingleton<AuthService>(
    () => AuthService(
      injector<Dio>(),
      baseUrl: Environment.domain,
    ),
  );
  injector.registerLazySingleton<ProductRemoteService>(
    () => ProductRemoteService(
      injector<Dio>(),
      baseUrl: Environment.domain,
    ),
  );
  injector.registerLazySingleton<CategoryService>(
    () => CategoryService(
      injector<Dio>(),
      baseUrl: Environment.domain,
    ),
  );
  injector.registerLazySingleton<BannerService>(
    () => BannerService(
      injector<Dio>(),
      baseUrl: Environment.domain,
    ),
  );
  injector.registerLazySingleton<GetTokenService>(
    () => GetTokenService(
      injector<Dio>(),
      baseUrl: Environment.domain,
    ),
  );

  injector.registerLazySingleton<ProductLocalService>(
    () => ProductLocalService(
      injector<SharedPreferences>(),
    ),
  );
  injector.registerLazySingleton<PostRemoteService>(
    () => PostRemoteService(
      injector<Dio>(),
      baseUrl: Environment.domain,
    ),
  );
}

_dependencyRepository() {
  injector.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(
      injector<AuthService>(),
      injector<UserLocalService>(),
    ),
  );
  injector.registerLazySingleton<GetListProductRepositoryImpl>(
    () => GetListProductRepositoryImpl(
      injector<ProductRemoteService>(),
      injector<ProductLocalService>(),
    ),
  );
  injector.registerLazySingleton<CategoryRepositoryImpl>(
    () => CategoryRepositoryImpl(
      injector<CategoryService>(),
    ),
  );

  injector.registerLazySingleton<BannerRepositoryImpl>(
    () => BannerRepositoryImpl(
      injector<BannerService>(),
    ),
  );
  injector.registerLazySingleton<GetTokenRepositoryImpl>(
    () => GetTokenRepositoryImpl(
      injector<GetTokenService>(),
    ),
  );
  injector.registerLazySingleton<PostRepositoryImpl>(
    () => PostRepositoryImpl(
      injector<PostRemoteService>(),
    ),
  );
}

_dependencyBloc() {
  injector.registerLazySingleton(
    () => GetTokenBloc(
      injector<GetTokenUsecase>(),
    ),
  );
  injector.registerLazySingleton(
    () => AuthenticationBloc(
      injector<GetUserUsecase>(),
      injector<GetUserLocalUsecase>(),
    ),
  );
  injector.registerFactory(
    () => FlashSaleBloc(
      injector<GetListFlashSaleProductRemoteUsecase>(),
    ),
  );
  injector.registerFactory(
    () => SignUpBloc(
      injector<SignUpUsecase>(),
    ),
  );
  injector.registerFactory(
    () => LoginBloc(
      injector<LoginUsecase>(),
      injector<AddUserLocalUsecase>(),
    ),
  );
  injector.registerFactory(
    () => ProductBloc(
      injector<GetListProductRemoteUsecase>(),
      injector<GetListFavouriteProductLocalUsecase>(),
    ),
  );
  injector.registerFactory(
    () => GetCategoryBloc(
      injector<GetListCategoryUsecase>(),
    ),
  );
  injector.registerFactory(
    () => GetBannerBloc(
      injector<GetBannerUsecase>(),
    ),
  );
  injector.registerFactory(
    () => PostBloc(
      injector<GetListPostUsecase>(),
    ),
  );

  injector.registerLazySingleton(
    () => LocalProductBloc(
      injector<GetListFavouriteProductLocalUsecase>(),
      injector<AddFavouriteProductLocalUsecase>(),
      injector<RemoveFavouriteProductLocalUsecase>(),
    ),
  );
}

_dependecyCubit() {
  injector.registerFactory<TimeCubit>(
    () => TimeCubit(),
  );
  injector.registerLazySingleton<BottomNavCubit>(
    () => BottomNavCubit(),
  );
  injector.registerLazySingleton<ShoppingCartCubit>(
    () => ShoppingCartCubit(),
  );
}

_dependencyToken() {
  // Tao token theo thoi gian hien tai cua app
  DateTime now = DateTime.now();

  var token = sha1.convert(
    utf8.encode(
      now.millisecondsSinceEpoch.toString() + Environment.token,
    ),
  );

  injector.registerLazySingleton<TokenParam>(
    () => TokenParam(
      token: token.toString(),
      string: now.millisecondsSinceEpoch.toString(),
    ),
  );
}
