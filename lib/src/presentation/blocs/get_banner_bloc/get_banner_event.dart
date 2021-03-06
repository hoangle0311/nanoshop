part of 'get_banner_bloc.dart';

abstract class GetBannerEvent extends Equatable {
  final String groupId;

  const GetBannerEvent({
    required this.groupId,
  });

  @override
  List<Object> get props => [
        groupId,
      ];
}

class GetBannerByGroupId extends GetBannerEvent {
  final TokenParam tokenParam;

  const GetBannerByGroupId({
    required String groupId,
    required this.tokenParam,
  }) : super(groupId: groupId);
}
