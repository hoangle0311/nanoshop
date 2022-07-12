import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nanoshop/src/core/constant/message/message.dart';
import 'package:nanoshop/src/core/form_model/location/location_form_model.dart';
import 'package:nanoshop/src/core/form_model/login/username_input.dart';
import 'package:nanoshop/src/core/form_model/sign_up/fullname_input.dart';
import 'package:nanoshop/src/core/params/district_param.dart';
import 'package:nanoshop/src/core/params/ward_param.dart';
import 'package:nanoshop/src/core/toast/toast.dart';
import 'package:nanoshop/src/domain/entities/address/address.dart';
import 'package:nanoshop/src/injector.dart';
import 'package:nanoshop/src/presentation/views/components/app_bar/main_app_bar.dart';
import 'package:nanoshop/src/presentation/views/components/remove_focus_widget/remove_focus_widget.dart';

import '../../../config/styles/app_text_style.dart';
import '../../../core/constant/strings/strings.dart';
import '../../../core/params/token_param.dart';
import '../../blocs/address_bloc/address_bloc.dart';
import '../../cubits/city_cubit/city_cubit.dart';
import '../../cubits/district_cubit/district_cubit.dart';
import '../../cubits/sex_cubit/sex_cubit.dart';
import '../../cubits/ward_cubit/ward_cubit.dart';
import '../../views/components/bottom_nav/bottom_nav_text.dart';
import '../../views/components/drop_down_field/drop_down_field.dart';
import '../../views/components/text_field/text_field_with_icon.dart';

class ScAddAddress extends StatelessWidget {
  const ScAddAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<AddressBloc>()
            ..add(
              CheckLocalAddress(),
            ),
        ),
        BlocProvider(
          create: (context) => injector<SexCubit>(),
        ),
        BlocProvider(
          create: (context) => injector<CityCubit>()
            ..onGetListData(
              injector<TokenParam>(),
            ),
        ),
        BlocProvider(
          create: (context) => injector<DistrictCubit>(),
        ),
        BlocProvider(
          create: (context) => injector<WardCubit>(),
        ),
      ],
      child: const RemoveFocusWidget(
        child: Scaffold(
          appBar: PageAppBar(
            title: Strings.chooseAddress,
          ),
          body: _Body(),
          bottomNavigationBar: _BottomNav(),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        return BottomNavText(
          title: Strings.apply,
          isShowGradient: state.status == FormzStatus.valid,
          onTap: state.status == FormzStatus.valid
              ? () {
                  Address address = Address(
                    name: state.name.value,
                    phone: state.phone.value,
                    city: state.city.value!.id,
                    district: state.district.value!.id,
                    ward: state.ward.value!.id,
                    address: state.address.value,
                    sex: state.sex.value!.id,
                  );
                  Navigator.of(context).pop(
                    address,
                  );
                  context
                      .read<AddressBloc>()
                      .add(SetLocalAddress(address: address));
                }
              : () {
                  Toast.showText('Vui lòng điền đầy đủ tất cả thông tin');
                },
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
              height: 20,
            ),
            _UsernameInputWidget(),
            const SizedBox(
              height: 20,
            ),
            _PhoneInputWidget(),
            const SizedBox(
              height: 20,
            ),
            _AddressInputWidget(),
            const SizedBox(
              height: 20,
            ),
            const _SexDrop(),
            const SizedBox(
              height: 20,
            ),
            const _CityDrop(),
            const SizedBox(
              height: 20,
            ),
            const _DistrictDrop(),
            const SizedBox(
              height: 20,
            ),
            const _WardDrop(),
          ],
        ),
      ),
    );
  }
}

class _WardDrop extends StatelessWidget {
  const _WardDrop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      buildWhen: (pre, cur) => pre.ward != cur.ward,
      builder: (context, addressState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<WardCubit, WardState>(
              builder: (context, state) {
                return DropDownField(
                  key: UniqueKey(),
                  iconData: Icons.location_on,
                  listItem: state.listData,
                  hint: 'Phường/ xã',
                  value: state.ward,
                  onChanged: (value) {
                    context.read<AddressBloc>().add(
                          LocationWardChanged(
                            value,
                          ),
                        );
                    context.read<WardCubit>().onChangeWard(value);
                  },
                );
              },
            ),
            addressState.ward.invalid
                ? Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      addressState.ward.error!.toText(),
                      style: TextStyleApp.textStyle1.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}

class _DistrictDrop extends StatelessWidget {
  const _DistrictDrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      buildWhen: (pre, cur) => pre.district != cur.district,
      builder: (context, addressState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<DistrictCubit, DistrictState>(
              builder: (context, state) {
                return DropDownField(
                  key: UniqueKey(),
                  iconData: Icons.location_on,
                  listItem: state.listData,
                  hint: 'Quận/ huyện',
                  value: state.district,
                  onChanged: (value) {
                    if (context.read<AddressBloc>().state.district.value !=
                        value) {
                      context.read<DistrictCubit>().onChangeDistrict(value);
                      context.read<WardCubit>().onGetListData(
                            WardParam(
                              districtId: value.id,
                              token: injector<TokenParam>().token,
                            ),
                          );
                      context.read<AddressBloc>().add(
                            LocationDistrictChanged(
                              value,
                            ),
                          );
                      context.read<AddressBloc>().add(
                            LocationWardChanged(
                              null,
                            ),
                          );
                    }
                  },
                );
                // }

                // if (state.status == DistrictStatus.loading) {
                //   return Container();
                // }
                //
                // return DropDownField(
                //   listItem: const [],
                //   hint: 'Quận/ huyện',
                //   value: null,
                //   onChanged: (value) {},
                // );
              },
            ),
            addressState.district.invalid
                ? Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      addressState.district.error!.toText(),
                      style: TextStyleApp.textStyle1.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}

class _CityDrop extends StatelessWidget {
  const _CityDrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state.typeState == TypeState.initialValue) {
            context.read<CityCubit>().onChangeCity(state.city.value);

            context.read<DistrictCubit>().onGetListData(
                  DistrictParam(
                    token: injector<TokenParam>().token,
                    provinceId: state.city.value!.id,
                  ),
                  initialDistrict: state.district.value,
                );

            context.read<WardCubit>().onGetListData(
                  WardParam(
                    districtId: state.district.value!.id,
                    token: injector<TokenParam>().token,
                  ),
                  initialValue: state.ward.value,
                );
          }
        },
        buildWhen: (pre, cur) => pre.city != cur.city,
        builder: (context, addressState) {
          return Column(
            children: [
              BlocBuilder<CityCubit, CityState>(
                builder: (context, state) {
                  return DropDownField(
                    key: UniqueKey(),
                    iconData: Icons.location_on,
                    listItem: state.listData,
                    hint: 'Tỉnh/ Thành phố',
                    value: state.city,
                    onChanged: (value) {
                      context.read<CityCubit>().onChangeCity(value);

                      if (context.read<AddressBloc>().state.city.value !=
                          value) {
                        context.read<DistrictCubit>().onGetListData(
                              DistrictParam(
                                token: injector<TokenParam>().token,
                                provinceId: value.id,
                              ),
                            );
                        context.read<WardCubit>().onGetListData(
                              WardParam(
                                districtId: value.id,
                                token: injector<TokenParam>().token,
                              ),
                            );
                        context.read<AddressBloc>().add(
                              LocationCityChanged(
                                value,
                              ),
                            );
                        context.read<AddressBloc>().add(
                              LocationCityChanged(
                                value,
                              ),
                            );
                        context.read<AddressBloc>().add(
                              LocationDistrictChanged(
                                null,
                              ),
                            );
                        context.read<AddressBloc>().add(
                              LocationWardChanged(
                                null,
                              ),
                            );
                      }
                    },
                  );

                  // return DropDownField(
                  //   listItem: [],
                  //   hint: 'Tỉnh/ Thành phố',
                  //   value: null,
                  //   onChanged: (value) {},
                  // );
                },
              ),
              addressState.city.invalid
                  ? Text(
                      addressState.city.error!.toText(),
                      style: TextStyleApp.textStyle1.copyWith(
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        });
  }
}

class _SexDrop extends StatelessWidget {
  const _SexDrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state.typeState == TypeState.initialValue) {
            context.read<SexCubit>().onChangeSex(state.sex.value);
          }
        },
        buildWhen: (pre, cur) => pre.sex != cur.sex,
        builder: (context, addressState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<SexCubit, SexState>(
                builder: (context, state) {
                  return DropDownField(
                    key: UniqueKey(),
                    iconData: Icons.transgender_outlined,
                    listItem: state.listData,
                    hint: 'Giới tính',
                    value: state.sex,
                    onChanged: (value) {
                      context.read<SexCubit>().onChangeSex(value);
                      context.read<AddressBloc>().add(
                            LocationSexChanged(
                              value,
                            ),
                          );
                    },
                  );
                },
              ),
              addressState.sex.invalid
                  ? Text(
                      addressState.sex.error!.toText(),
                      style: TextStyleApp.textStyle1.copyWith(
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        });
  }
}

class _UsernameInputWidget extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  _UsernameInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state.typeState == TypeState.initialValue) {
          _textEditingController.text = state.name.value;
        }
      },
      buildWhen: (previous, current) => previous.name != current.name,
      builder: ((context, state) {
        return TextFieldWithIcon(
          controller: _textEditingController,
          // key: const Key('signUpForm_usernameInput_textField'),
          onChanged: (username) => context.read<AddressBloc>().add(
                LocationNameChanged(
                  username,
                ),
              ),

          labelText: Strings.labelFullname,
          errorText: state.name.invalid ? state.name.error!.toText() : null,
          iconData: Icons.person,
        );
      }),
    );
  }
}

class _PhoneInputWidget extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  _PhoneInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state.typeState == TypeState.initialValue) {
          _textEditingController.text = state.phone.value;
        }
      },
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: ((context, state) {
        return TextFieldWithIcon(
          controller: _textEditingController,
          // key: const Key('signUpForm_usernameInput_textField'),
          onChanged: (phone) => context.read<AddressBloc>().add(
                LocationPhoneChanged(
                  phone,
                ),
              ),

          labelText: Strings.labelAccount,
          errorText: state.phone.invalid ? state.phone.error!.toText() : null,
          iconData: Icons.phone,
        );
      }),
    );
  }
}

class _AddressInputWidget extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  _AddressInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state.typeState == TypeState.initialValue) {
          _textEditingController.text = state.address.value;
        }
      },
      buildWhen: (previous, current) => previous.address != current.address,
      builder: ((context, state) {
        return TextFieldWithIcon(
          controller: _textEditingController,
          // key: const Key('signUpForm_usernameInput_textField'),
          onChanged: (address) => context.read<AddressBloc>().add(
                LocationAddressChanged(
                  address,
                ),
              ),

          labelText: Strings.labelAddress,
          errorText: state.address.invalid ? Message.notEmpty : null,
          iconData: Icons.location_on,
        );
      }),
    );
  }
}
