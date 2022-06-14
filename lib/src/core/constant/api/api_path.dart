//  Enviroment dev

// class ApiPath {
//   static const String token = '/token';
//   static const String banner = '/banners';
//   static const String category = '/categories';
//   static const String product = '/products';
//   static const String post = '/news';
//   static const String login = '/login';
//   static const String getUser = '/user';
//   static const String flashSale = '/flashSale';
//   static const String signUp = '/flashSale';
// }

// Enviroment prod

class ApiPath {
  static const String token = '/api/home/start';
  static const String banner = '/api/home/getBanner';
  static const String category = '/api/home/getCategory';
  static const String product = '/api/home/getProduct';
  static const String post = '/api/home/getNews';
  static const String login = '/api/home/login';
  static const String getUser = '/api/app/profile/getUser';
  static const String flashSale = '/api/home/getFlashSaleInHome';
  static const String signUp = '/api/home/signup';
}
