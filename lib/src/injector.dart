import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:nanoshop/src/config/environment/app_environment.dart';
import 'package:nanoshop/src/core/interceptor/custom_interceptor.dart';
import 'package:nanoshop/src/data/data_source/local/product_local_service/product_local_service.dart';
import 'package:nanoshop/src/data/data_source/local/user_service/user_local_service.dart';
import 'package:nanoshop/src/data/data_source/remote/auth_service/auth_service.dart';
import 'package:nanoshop/src/data/data_source/remote/notification_service/notification_service.dart';
import 'package:nanoshop/src/data/data_source/remote/page_content_service/page_content_service.dart';
import 'package:nanoshop/src/data/data_source/remote/payment_service/payment_service.dart';
import 'package:nanoshop/src/data/data_source/remote/post_service/post_remote_service.dart';
import 'package:nanoshop/src/data/data_source/remote/product_service/product_service.dart';
import 'package:nanoshop/src/data/data_source/remote/shop_service/shop_service.dart';
import 'package:nanoshop/src/data/repositories/get_list_shop_repository.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/add_user_local_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/change_password_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/get_user_local_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/get_user_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/login_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/remove_user_local_usecase.dart';
import 'package:nanoshop/src/domain/usecases/auth_usecase/sign_up_usecase.dart';
import 'package:nanoshop/src/domain/usecases/notification_usecase/get_type_notification_usecase.dart';
import 'package:nanoshop/src/domain/usecases/payment_usecase/get_address_local_usecase.dart';
import 'package:nanoshop/src/domain/usecases/payment_usecase/get_discount_usecase.dart';
import 'package:nanoshop/src/domain/usecases/post_usecase/detail_post_usecase.dart';
import 'package:nanoshop/src/domain/usecases/post_usecase/get_list_post_usecase.dart';
import 'package:nanoshop/src/domain/usecases/product_usecase/add_comment_usecase.dart';
import 'package:nanoshop/src/domain/usecases/product_usecase/get_detail_product_remote_usecase.dart';
import 'package:nanoshop/src/domain/usecases/product_usecase/get_flash_sale_product_usecase.dart';
import 'package:nanoshop/src/domain/usecases/product_usecase/get_list_comment_usecase.dart';
import 'package:nanoshop/src/presentation/blocs/add_comment_bloc/add_comment_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/address_bloc/address_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/flash_sale_bloc/flash_sale_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/local_product_bloc/local_product_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:nanoshop/src/presentation/blocs/post_bloc/post_bloc.dart';
import 'package:nanoshop/src/presentation/cubits/checkout_cubit/checkout_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/city_cubit/city_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/detail_product_cubit/detail_product_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/district_cubit/district_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/flash_sale_with_list_product_cubit/flash_sale_with_list_product_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/get_detail_post_cubit/get_detail_post_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/get_list_comment_cubit/get_list_comment_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/get_list_coupon/get_list_coupon_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/get_list_notification_cubit/get_list_notification_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/get_list_order_cubit/get_list_order_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/get_list_shop_cubit/get_list_shop_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/get_type_notification/get_type_notification_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/manufacturer_cubit/manufacturer_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/page_content_cubit/page_content_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/payment_cubit/payment_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/range_cubit/range_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/related_list_product_cubit/related_list_product_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/search_list_product_cubit/search_list_product_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/sex_cubit/sex_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/shopping_cart_cubit/shopping_cart_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/time_cubit/time_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/transport_cubit/transport_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/update_user_cubit/update_user_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/voucher_cubit/voucher_cubit.dart';
import 'package:nanoshop/src/presentation/cubits/ward_cubit/ward_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/params/token_param.dart';
import 'data/data_source/local/payment_local_service/payment_local_service.dart';
import 'data/data_source/remote/location_service/location_service.dart';
import 'data/data_source/remote/remote_service.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/data_layer_repository.dart';
import 'data/repositories/location_repository_impl.dart';
import 'data/repositories/notification_repository_impl.dart';
import 'data/repositories/page_content_repository_impl.dart';
import 'data/repositories/payment_repository_impl.dart';
import 'domain/usecases/auth_usecase/add_message_count_local.dart';
import 'domain/usecases/auth_usecase/get_count_message_local.dart';
import 'domain/usecases/auth_usecase/remove_count_message_local_usecase.dart';
import 'domain/usecases/auth_usecase/update_user_remote_usecase.dart';
import 'domain/usecases/domain_layer_usecase.dart';
import 'domain/usecases/location_usecase/get_list_city_usecase.dart';
import 'domain/usecases/location_usecase/get_list_district_usecase.dart';
import 'domain/usecases/location_usecase/get_list_ward_usecase.dart';
import 'domain/usecases/notification_usecase/get_list_notification_usecase.dart';
import 'domain/usecases/page_content_usecase/get_page_content_usecase.dart';
import 'domain/usecases/payment_usecase/checkout_usecase.dart';
import 'domain/usecases/payment_usecase/get_bank_usecase.dart';
import 'domain/usecases/payment_usecase/get_list_discount_usecase.dart';
import 'domain/usecases/payment_usecase/get_list_order_usecase.dart';
import 'domain/usecases/payment_usecase/get_payment_usecase.dart';
import 'domain/usecases/payment_usecase/get_transport_usecase.dart';
import 'domain/usecases/payment_usecase/set_address_local_usecase.dart';
import 'domain/usecases/product_usecase/get_flashsale_with_list_product_usecase.dart';
import 'domain/usecases/product_usecase/get_list_manufacture_usecase.dart';
import 'domain/usecases/product_usecase/get_related_list_product_usecase.dart';
import 'domain/usecases/product_usecase/search_list_product_usecase.dart';
import 'domain/usecases/shop_usecase/get_list_shop_usecase.dart';
import 'presentation/blocs/blocs.dart';
import 'presentation/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'presentation/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  await _dependencyExternal();

  _dependencyService();
  _dependencyUseCase();
  _dependencyRepository();
  _dependencyBloc();
  _dependencyCubit();
}

_dependencyExternal() async {
  final preferences = await SharedPreferences.getInstance();
  injector.registerSingleton<SharedPreferences>(
    preferences,
  );
}

_dependencyUseCase() {
  injector.registerLazySingleton<SetAddressLocalUsecase>(
    () => SetAddressLocalUsecase(
      injector<PaymentRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetAddressLocalUsecase>(
    () => GetAddressLocalUsecase(
      injector<PaymentRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetPageContentUsecase>(
    () => GetPageContentUsecase(
      injector<PageContentRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListNotificationUsecase>(
    () => GetListNotificationUsecase(
      injector<NotificationRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetTypeNotificationUsecase>(
    () => GetTypeNotificationUsecase(
      injector<NotificationRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<UpdateUserRemoteUsecase>(
    () => UpdateUserRemoteUsecase(
      injector<AuthRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListManufacturerUsecase>(
    () => GetListManufacturerUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<SearchListProductUsecase>(
    () => SearchListProductUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<ChangePasswordUsecase>(
    () => ChangePasswordUsecase(
      injector<AuthRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListShopUsecase>(
    () => GetListShopUsecase(
      injector<GetListShopRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListDiscountUsecase>(
    () => GetListDiscountUsecase(
      injector<PaymentRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListOrderUsecase>(
    () => GetListOrderUsecase(
      injector<PaymentRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<CheckoutUsecase>(
    () => CheckoutUsecase(
      injector<PaymentRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetPaymentUsecase>(
    () => GetPaymentUsecase(
      injector<PaymentRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetBankUsecase>(
    () => GetBankUsecase(
      injector<PaymentRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListWardUsecase>(
    () => GetListWardUsecase(
      injector<LocationRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListDistrictUsecase>(
    () => GetListDistrictUsecase(
      injector<LocationRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListCityUsecase>(
    () => GetListCityUsecase(
      injector<LocationRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetRelatedListProductUsecase>(
    () => GetRelatedListProductUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListCommentUsecase>(
    () => GetListCommentUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<AddCommentUsecase>(
    () => AddCommentUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetDetailProductRemoteUsecase>(
    () => GetDetailProductRemoteUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetTransportUsecase>(
    () => GetTransportUsecase(
      injector<PaymentRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetDiscountUsecase>(
    () => GetDiscountUsecase(
      injector<PaymentRepositoryImpl>(),
    ),
  );
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
  injector.registerLazySingleton<GetCountMessageLocalUsecase>(
    () => GetCountMessageLocalUsecase(
      injector<AuthRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<RemoveCountMessageLocalUsecase>(
    () => RemoveCountMessageLocalUsecase(
      injector<AuthRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<AddMessageCountLocalUsecase>(
    () => AddMessageCountLocalUsecase(
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
  // injector.registerLazySingleton<GetTokenUsecase>(
  //   () => GetTokenUsecase(
  //     injector<GetTokenRepositoryImpl>(),
  //   ),
  // );
  injector.registerLazySingleton<GetListFavouriteProductLocalUsecase>(
    () => GetListFavouriteProductLocalUsecase(
      injector<GetListProductRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetFlashSaleWithListProductRemoteUsecase>(
    () => GetFlashSaleWithListProductRemoteUsecase(
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
  injector.registerLazySingleton<DetailPostUsecase>(
    () => DetailPostUsecase(
      injector<PostRepositoryImpl>(),
    ),
  );
  injector.registerLazySingleton<GetListPostUsecase>(
    () => GetListPostUsecase(
      injector<PostRepositoryImpl>(),
    ),
  );
}

_dependencyService() {
  final Dio _dio = Dio()..options.baseUrl = Environment.domain;

  _dio.interceptors.addAll(
    [
      CustomInterceptor(
        _dio,
        injector<SharedPreferences>(),
      ),
    ],
  );

  injector.registerLazySingleton<PageContentService>(
    () => PageContentService(
      _dio,
    ),
  );
  injector.registerLazySingleton<NotificationService>(
    () => NotificationService(
      _dio,
    ),
  );
  injector.registerLazySingleton<ShopService>(
    () => ShopService(
      _dio,
    ),
  );
  injector.registerLazySingleton<LocationService>(
    () => LocationService(
      _dio,
    ),
  );
  injector.registerLazySingleton<PaymentService>(
    () => PaymentService(
      _dio,
    ),
  );
  injector.registerLazySingleton<PaymentLocalService>(
    () => PaymentLocalService(
      injector<SharedPreferences>(),
    ),
  );
  injector.registerLazySingleton<UserLocalService>(
    () => UserLocalService(
      injector<SharedPreferences>(),
    ),
  );
  injector.registerLazySingleton<AuthService>(
    () => AuthService(
      _dio,
    ),
  );
  injector.registerLazySingleton<ProductRemoteService>(
    () => ProductRemoteService(
      _dio,
    ),
  );
  injector.registerLazySingleton<CategoryService>(
    () => CategoryService(
      _dio,
    ),
  );
  injector.registerLazySingleton<BannerService>(
    () => BannerService(
      _dio,
      baseUrl: Environment.domain,
    ),
  );
  injector.registerLazySingleton<GetTokenService>(
    () => GetTokenService(
      _dio,
    ),
  );

  injector.registerLazySingleton<ProductLocalService>(
    () => ProductLocalService(
      injector<SharedPreferences>(),
    ),
  );
  injector.registerLazySingleton<PostRemoteService>(
    () => PostRemoteService(
      _dio,
    ),
  );
}

_dependencyRepository() {
  injector.registerLazySingleton<PageContentRepositoryImpl>(
    () => PageContentRepositoryImpl(
      injector<PageContentService>(),
    ),
  );
  injector.registerLazySingleton<NotificationRepositoryImpl>(
    () => NotificationRepositoryImpl(
      injector<NotificationService>(),
    ),
  );
  injector.registerLazySingleton<GetListShopRepositoryImpl>(
    () => GetListShopRepositoryImpl(
      injector<ShopService>(),
    ),
  );
  injector.registerLazySingleton<LocationRepositoryImpl>(
    () => LocationRepositoryImpl(
      injector<LocationService>(),
    ),
  );
  injector.registerLazySingleton<PaymentRepositoryImpl>(
    () => PaymentRepositoryImpl(
      injector<PaymentService>(),
      injector<PaymentLocalService>(),
    ),
  );
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
  // injector.registerLazySingleton<GetTokenRepositoryImpl>(
  //   () => GetTokenRepositoryImpl(
  //     injector<GetTokenService>(),
  //   ),
  // );
  injector.registerLazySingleton<PostRepositoryImpl>(
    () => PostRepositoryImpl(
      injector<PostRemoteService>(),
    ),
  );
}

_dependencyBloc() {
  injector.registerFactory<ChangePasswordBloc>(
    () => ChangePasswordBloc(injector<ChangePasswordUsecase>()),
  );
  injector.registerFactory(
    () => AddressBloc(
      injector<GetAddressLocalUsecase>(),
      injector<SetAddressLocalUsecase>(),
    ),
  );
  injector.registerFactory(
    () => AddCommentBloc(
      injector<AddCommentUsecase>(),
    ),
  );
  injector.registerLazySingleton(
    () => AuthenticationBloc(
      injector<GetUserUsecase>(),
      injector<GetUserLocalUsecase>(),
      injector<RemoveUserLocalUsecase>(),
      injector<GetCountMessageLocalUsecase>(),
      injector<AddMessageCountLocalUsecase>(),
      injector<RemoveCountMessageLocalUsecase>(),
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
    () => GetDetailPostCubit(
      injector<DetailPostUsecase>(),
    ),
  );
  injector.registerFactory(
    () => PostBloc(
      injector<GetListPostUsecase>(),
    ),
  );

  injector.registerFactory(
    () => LocalProductBloc(
      injector<GetListFavouriteProductLocalUsecase>(),
      injector<AddFavouriteProductLocalUsecase>(),
      injector<RemoveFavouriteProductLocalUsecase>(),
    ),
  );
}

_dependencyCubit() {
  injector.registerFactory<PageContentCubit>(
    () => PageContentCubit(
      injector<GetPageContentUsecase>(),
    ),
  );

  injector.registerFactory<FlashSaleWithListProductCubit>(
    () => FlashSaleWithListProductCubit(
      injector<GetFlashSaleWithListProductRemoteUsecase>(),
    ),
  );
  injector.registerFactory<GetListCouponCubit>(
    () => GetListCouponCubit(
      injector<GetListDiscountUsecase>(),
    ),
  );
  injector.registerFactory<GetListNotificationCubit>(
    () => GetListNotificationCubit(
      injector<GetListNotificationUsecase>(),
    ),
  );
  injector.registerFactory<GetTypeNotificationCubit>(
    () => GetTypeNotificationCubit(
      injector<GetTypeNotificationUsecase>(),
    ),
  );
  injector.registerFactory<UpdateUserCubit>(
    () => UpdateUserCubit(
      injector<UpdateUserRemoteUsecase>(),
    ),
  );
  injector.registerFactory<ManufacturerCubit>(
    () => ManufacturerCubit(
      injector<GetListManufacturerUsecase>(),
    ),
  );
  injector.registerFactory<SearchListProductCubit>(
    () => SearchListProductCubit(injector<SearchListProductUsecase>()),
  );
  injector.registerFactory<GetListShopCubit>(
    () => GetListShopCubit(
      injector<GetListShopUsecase>(),
    ),
  );
  injector.registerFactory<GetListOrderCubit>(
    () => GetListOrderCubit(
      injector<GetListOrderUsecase>(),
    ),
  );
  injector.registerFactory<CheckoutCubit>(
    () => CheckoutCubit(
      injector<CheckoutUsecase>(),
    ),
  );
  injector.registerFactory<PaymentCubit>(
    () => PaymentCubit(
      injector<GetPaymentUsecase>(),
      injector<GetBankUsecase>(),
    ),
  );
  injector.registerFactory<DistrictCubit>(
    () => DistrictCubit(
      injector<GetListDistrictUsecase>(),
    ),
  );
  injector.registerFactory<CityCubit>(
    () => CityCubit(
      injector<GetListCityUsecase>(),
    ),
  );
  injector.registerFactory<SexCubit>(
    () => SexCubit(),
  );
  injector.registerFactory<WardCubit>(
    () => WardCubit(
      injector<GetListWardUsecase>(),
    ),
  );
  injector.registerFactory<RelatedListProductCubit>(
    () => RelatedListProductCubit(injector<GetRelatedListProductUsecase>()),
  );
  injector.registerFactory<GetListCommentCubit>(
    () => GetListCommentCubit(injector<GetListCommentUsecase>()),
  );
  injector.registerFactory<DetailProductCubit>(
    () => DetailProductCubit(injector<GetDetailProductRemoteUsecase>()),
  );
  injector.registerFactory<TransportCubit>(
    () => TransportCubit(injector<GetTransportUsecase>()),
  );
  injector.registerFactory<VoucherCubit>(
    () => VoucherCubit(injector<GetDiscountUsecase>()),
  );
  injector.registerFactory<TimeCubit>(
    () => TimeCubit(),
  );
  injector.registerFactory<RangeCubit>(
    () => RangeCubit(),
  );
  injector.registerLazySingleton<BottomNavCubit>(
    () => BottomNavCubit(),
  );
  injector.registerLazySingleton<ShoppingCartCubit>(
    () => ShoppingCartCubit(),
  );
}
