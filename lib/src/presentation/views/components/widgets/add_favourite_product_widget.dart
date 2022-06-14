import 'package:flutter/material.dart';

import '../../../../core/constant/message/message.dart';
import '../../../../core/toast/toast.dart';
import '../../../../domain/entities/product/product.dart';
import '../../../../injector.dart';
import '../../../blocs/local_product_bloc/local_product_bloc.dart';

class AddFavouriteProductWidget extends StatelessWidget {
  final Product product;

  const AddFavouriteProductWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (product.isLiked == 0) {
          Toast.showText(
            Message.addFavourite,
          );
          injector<LocalProductBloc>().add(
            AddFavouriteProductEvent(
              product: product,
            ),
          );
        } else {
          Toast.showText(
            Message.removeFavourite,
            iconData: Icons.delete,
          );
          injector<LocalProductBloc>().add(
            RemoveFavouriteProductEvent(
              product: product,
            ),
          );
        }
      },
      child: Icon(
        product.isLiked == 1 ? Icons.favorite : Icons.favorite_outline,
      ),
    );
  }
}
