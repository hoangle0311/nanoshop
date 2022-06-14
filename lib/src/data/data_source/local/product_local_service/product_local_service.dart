import 'package:nanoshop/src/core/constant/db_key/shared_paths.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/entities/product/product.dart';

class ProductLocalService {
  final SharedPreferences _sharedPreferences;

  ProductLocalService(
    this._sharedPreferences,
  );

  List<Product> getListFavouriteLocal() {
    final List<Product> _products = [];

    try {
      final jsonString =
          _sharedPreferences.getString(SharedPaths.listFavouriteProduct);

      _products.addAll(
        Product.decode(jsonString!),
      );

      return _products;
    } catch (e) {
      return _products;
    }
  }

  _saveListFavouriteLocalProduct(List<Product> products) async {
    await _sharedPreferences.setString(
        SharedPaths.listFavouriteProduct, Product.encode(products));
  }

  addProductToListFavourite(Product product) async {
    final List<Product> _products = getListFavouriteLocal();

    if (!_products.contains(product)) {
      _products.add(product);

      await _saveListFavouriteLocalProduct(_products);
    }
  }

  Future<void> removeProductToListFavourite(Product product) async {
    final List<Product> _products = getListFavouriteLocal();

    if (_products.contains(product)) {
      _products.remove(product);

      await _saveListFavouriteLocalProduct(_products);
    }
  }
}
