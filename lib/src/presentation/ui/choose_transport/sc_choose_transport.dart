import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanoshop/src/config/styles/app_color.dart';
import 'package:nanoshop/src/config/styles/app_text_style.dart';
import 'package:nanoshop/src/core/utils/helper/convert_price.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/cubits/transport_cubit/transport_cubit.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';

import '../../../core/constant/strings/strings.dart';
import '../../../core/params/token_param.dart';
import '../../../domain/entities/transport/transport.dart';
import '../../views/components/bottom_nav/bottom_nav_text.dart';

class ScChooseTransport extends StatelessWidget {
  final Transport transport;

  const ScChooseTransport({
    Key? key,
    required this.transport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return injector<TransportCubit>()
          ..onGetListTransPort(injector<TokenParam>())
          ..onChooseTransport(transport);
      },
      child: Scaffold(
        appBar: PageAppBar(
          title: Strings.chooseTransport,
        ),
        body: BlocBuilder<TransportCubit, TransportState>(
          builder: (context, state) {
            if (state.listTransport.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...List.generate(
                      state.listTransport.length,
                      (index) => _TransportListTile(
                        transport: state.listTransport[index],
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state.status == TransportStatus.loading) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            return Center(
              child: Text(
                'Không có đơn vị vận chuyển nào',
                style: TextStyleApp.textStyle1.copyWith(
                  color: Colors.black,
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<TransportCubit, TransportState>(
          builder: (context, state) {
            if (state.listTransport.isNotEmpty) {
              return BottomNavText(
                title: Strings.apply,
                onTap: () {
                  Navigator.of(context).pop(
                    state.transport,
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _TransportListTile extends StatelessWidget {
  final Transport transport;

  const _TransportListTile({
    Key? key,
    required this.transport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<TransportCubit>().onChooseTransport(transport);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 5,
              color: AppColors.grey,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.read<TransportCubit>().state.transport ==
                          transport
                      ? AppColors.primaryColor
                      : AppColors.grey,
                ),
              ),
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.read<TransportCubit>().state.transport ==
                          transport
                      ? AppColors.primaryColor
                      : AppColors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    transport.name ?? '',
                    style: TextStyleApp.textStyle1.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    convertPrice(transport.price ?? 0),
                    style: TextStyleApp.textStyle1.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
