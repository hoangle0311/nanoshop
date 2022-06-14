import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanoshop/src/presentation/blocs/blocs.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../../domain/entities/product/product.dart';
import '../widgets/product_grid_tile.dart';

class ListVerticalProductWidget extends StatelessWidget {
  final bool isShowLoading;
  final List<Product> products;

  const ListVerticalProductWidget({
    Key? key,
    required this.products,
    this.isShowLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
        staggeredTiles: List.generate(
          products.length >= ProductBloc.postPerPage && isShowLoading
              ? products.length + 1
              : products.length,
          (index) => StaggeredTile.fit(index < products.length ? 1 : 2),
        ),
        // staggeredTiles: products
        //     .map<StaggeredTile>((_) => const StaggeredTile.fit(1))
        //     .toList(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
        children: List.generate(
          products.length >= ProductBloc.postPerPage && isShowLoading
              ? products.length + 1
              : products.length,
          (index) {
            if (index < products.length) {
              return ProductGridTile(product: products[index]);
            }

            return Container(
              height: 50,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          },
        )
        // children: products.map(
        //   (e) {
        //     return ProductGridTile(product: e);
        //   },
        // ).toList(),
        );
  }
}
