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
  static const String detailProduct = '/api/home/getDetail';
  static const String post = '/api/home/getNews';
  static const String detailPost = '/api/home/getDetail';
  static const String login = '/api/home/login';
  static const String getUser = '/api/app/profile/getUser';
  static const String updateUser = '/api/app/profile/updateUser';
  static const String flashSale = '/api/home/getFlashSaleInHome';
  static const String flashSaleWithListProduct = '/api/home/getFlashSale';
  static const String signUp = '/api/home/signup';
  static const String getDiscount = '/api/app/shopping/getdiscount';
  static const String getListDiscount = '/api/home/getCoupon';
  static const String getTransport = '/api/app/shopping/getTransport';
  static const String addComment = '/api/app/product/rating';
  static const String getComment = '/api/home/getRating';
  static const String getCity = '/api/home/getProvince';
  static const String getDistrict = '/api/home/getDistrict';
  static const String getWard = '/api/home/getWard';
  static const String getPayment = '/api/app/shopping/getPaymentMethod';
  static const String getBank = '/api/home/getBank';
  static const String checkout = '/api/app/shopping/checkout';
  static const String getListOrder = '/api/app/profile/order';
  static const String getListShop = '/api/home/getShopStore';
  static const String changePassword = '/api/app/profile/changepassword';
  static const String getManufacturer = '/api/home/GetManufacturer';
  static const String getTypeNotification = '/api/app/profile/getTypeNotifications';
  static const String getNotification = '/api/app/profile/getNotifications';
}
