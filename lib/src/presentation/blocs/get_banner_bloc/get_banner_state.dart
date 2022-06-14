part of 'get_banner_bloc.dart';

abstract class GetBannerState extends Equatable {
  const GetBannerState();

  @override
  List<Object> get props => [];
}

class GetBannerLoading extends GetBannerState {}

class GetBannerDone extends GetBannerState {
  final List<Banner> banners;

  const GetBannerDone({
    required this.banners,
  });
}

class GetBannerFailed extends GetBannerState {
  final DioError? error;

  const GetBannerFailed({
    this.error,
  });
}
