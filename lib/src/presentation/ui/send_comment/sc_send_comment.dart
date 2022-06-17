import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:formz/formz.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/core/form_model/add_comment/content_input.dart';
import 'package:nanoshop/src/core/form_model/login/username_input.dart';
import 'package:nanoshop/src/core/form_model/sign_up/fullname_input.dart';
import 'package:nanoshop/src/domain/entities/product/product.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';
import 'package:nanoshop/src/presentation/views/components/remove_focus_widget/remove_focus_widget.dart';
import 'package:nanoshop/src/presentation/views/dialog/dialog_loading.dart';

import '../../../config/routers/app_router/app_router.dart';
import '../../../core/constant/strings/strings.dart';
import '../../../core/params/token_param.dart';
import '../../../core/toast/toast.dart';
import '../../../domain/entities/user_login/user_login.dart';
import '../../blocs/add_comment_bloc/add_comment_bloc.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../views/components/bottom_nav/bottom_nav_text.dart';

class ScSendComment extends StatelessWidget {
  final Product product;

  const ScSendComment({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return injector<AddCommentBloc>();
      },
      child: BlocListener<AddCommentBloc, AddCommentState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionInProgress) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: DialogLoading(),
              ),
            ).then((value) {
              Navigator.of(context).pop();
            });
          }

          if (state.status == FormzStatus.submissionSuccess) {
            Navigator.of(context).maybePop();
            Toast.showText(state.message);
          }
        },
        child: RemoveFocusWidget(
          child: Scaffold(
            appBar: const PageAppBar(
              title: Strings.sendComment,
            ),
            body: _Body(),
            bottomNavigationBar: _BottomNav(
              product: product,
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final Product product;

  const _BottomNav({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCommentBloc, AddCommentState>(
      buildWhen: (pre, cur) => pre.status != cur.status,
      builder: (context, state) {
        return BottomNavText(
          title: Strings.send,
          isShowGradient: state.status.isValidated ? true : false,
          onTap: state.status.isValidated
              ? () {
                  var authBloc = context.read<AuthenticationBloc>();
                  var authState = authBloc.state;

                  if (authState.user == UserLogin.empty) {
                    Navigator.of(context).pushNamed(AppRouterEndPoint.LOGIN);
                  } else {
                    context.read<AddCommentBloc>().add(
                          CommentSubmitted(
                            tokenParam: injector<TokenParam>(),
                            userId: injector<AuthenticationBloc>()
                                .state
                                .user
                                .userId!,
                            productId: product.id!,
                          ),
                        );
                    // Navigator.of(context).pushNamed(
                    //   AppRouterEndPoint.PAYMENTSHOPPINGCART,
                    //   arguments:
                    //       List.of(context.read<ShoppingCartCubit>().state.listCart)
                    //           .where((element) => element.isChecking)
                    //           .toList(),
                    // );
                  }
                }
              : null,
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'Vui lòng gửi phản hồi của bạn về sản phẩm cho chúng tôi được biết',
              style: TextStyleApp.textStyle2.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const _Rating(),
            const SizedBox(
              height: 16,
            ),
            // const _UsernameInput(),
            // const SizedBox(
            //   height: 20,
            // ),
            // const _PhoneInput(),
            // const SizedBox(
            //   height: 20,
            // ),
            const _ContentInput(),
          ],
        ),
      ),
    );
  }
}

class _ContentInput extends StatelessWidget {
  const _ContentInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCommentBloc, AddCommentState>(
      buildWhen: (pre, cur) => pre.content != cur.content,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Nhập nội dung bình luận',
              style: TextStyleApp.textStyle2.copyWith(
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              // key: const Key('loginForm_usernameInput_textField'),
              onChanged: (content) => context.read<AddCommentBloc>().add(
                    ContentChanged(
                      content,
                    ),
                  ),
              maxLines: 5,
              decoration: InputDecoration(
                errorText: state.content.invalid
                    ? state.content.error!.toText()
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// class _PhoneInput extends StatelessWidget {
//   const _PhoneInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddCommentBloc, AddCommentState>(
//       buildWhen: (pre, cur) => pre.phone != cur.phone,
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Nhập số điện thoại của bạn',
//               style: TextStyleApp.textStyle2.copyWith(
//                 color: AppColors.black,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             TextField(
//               // key: const Key('loginForm_usernameInput_textField'),
//               onChanged: (phone) => context.read<AddCommentBloc>().add(
//                     PhoneChanged(
//                       phone,
//                     ),
//                   ),
//               decoration: InputDecoration(
//                 errorText:
//                     state.phone.invalid ? state.phone.error!.toText() : null,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: AppColors.grey, width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                   borderSide:
//                       BorderSide(color: AppColors.primaryColor, width: 1),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red, width: 1),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderSide:
//                       BorderSide(color: AppColors.primaryColor, width: 1),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _UsernameInput extends StatelessWidget {
//   const _UsernameInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddCommentBloc, AddCommentState>(
//       buildWhen: (pre, cur) => pre.name != cur.name,
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Nhập tên của bạn',
//               style: TextStyleApp.textStyle2.copyWith(
//                 color: AppColors.black,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             TextField(
//               // key: const Key('loginForm_usernameInput_textField'),
//               onChanged: (username) => context.read<AddCommentBloc>().add(
//                     UsernameChanged(
//                       username,
//                     ),
//                   ),
//               decoration: InputDecoration(
//                 errorText:
//                     state.name.invalid ? state.name.error!.toText() : null,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: AppColors.grey, width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                   borderSide:
//                       BorderSide(color: AppColors.primaryColor, width: 1),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red, width: 1),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderSide:
//                       BorderSide(color: AppColors.primaryColor, width: 1),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

class _Rating extends StatelessWidget {
  const _Rating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCommentBloc, AddCommentState>(
      builder: (context, state) {
        return Row(
          children: [
            RatingBar.builder(
              initialRating: 3,
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 32,
              itemPadding: const EdgeInsets.only(right: 5),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: AppColors.yellow,
              ),
              unratedColor: AppColors.grey,
              onRatingUpdate: (newValue) {
                context.read<AddCommentBloc>().add(
                      RatingChanged(
                        newValue,
                      ),
                    );
              },
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              state.rating.toString() + '/5',
              style: TextStyleApp.textStyle1.copyWith(
                color: AppColors.primaryColor,
                fontSize: 18,
              ),
            ),
          ],
        );
      },
    );
  }
}
