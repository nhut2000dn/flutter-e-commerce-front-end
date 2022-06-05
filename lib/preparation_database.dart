import 'package:my_novel/services/brand_service.dart';
import 'package:my_novel/services/category_service.dart';
import 'package:my_novel/services/order_detail_service.dart';
import 'package:my_novel/services/order_service.dart';
import 'package:my_novel/services/product_service.dart';
import 'package:my_novel/services/profile_service.dart';
import 'package:my_novel/services/slideshow_service.dart';
import 'package:my_novel/services/user_service.dart';
import 'package:my_novel/services/user_role_service.dart';
import 'package:my_novel/services/users_products_service.dart';

UserRoleService userRoleService = UserRoleService();
UserService _userService = UserService();
ProfileService _profileService = ProfileService();
ProductService _productService = ProductService();
CategoryService _categoryService = CategoryService();
BrandService _brandService = BrandService();
UsersProductsService _usersProductsService = UsersProductsService();
OrderService _orderService = OrderService();
OrderDetailService _orderDetailService = OrderDetailService();

SlideshowService _slideshowService = SlideshowService();

Future loginTest() async {
  await _userService.signInWithEmailAndPassword('user1@gmail.com', '123456789');
}

Future<void> createAccount() async {
  await _userService.createUserWithEmailAndPassword(
      'admin@gmail.com', '123456789');
  await _userService.createUserWithEmailAndPassword(
      'user1@gmail.com', '123456789');
}

createUsersRoles() {
  userRoleService.createUsersRoles('admin', 'management system');
  userRoleService.createUsersRoles('user', 'just read novel');
}

createProfile() {
  _profileService.createProfile(
      'admin@gmail.com',
      'nhut hoang',
      'male',
      'da nang',
      'https://firebasestorage.googleapis.com/v0/b/fluttere-commerce-a1957.appspot.com/o/users%2Fadmin.png?alt=media&token=494f4b44-8d8a-4550-aca8-09ac9e5ac09b',
      'EiBOFc7JTBNirsf1n1Exucf3yyJ2');
  _profileService.createProfile('user1@gmail.com', 'user 1', 'male', 'da nang',
      '', 'TFq7i2yghXRnDIJIIqKTJg3SEEM2');
}

createCategories() {
  _categoryService.createCategory(
      'Smartphone',
      'https://firebasestorage.googleapis.com/v0/b/fluttere-commerce-a1957.appspot.com/o/categories%2Fsmartphone.png?alt=media&token=3936d542-7ba4-4e4a-ba2a-46b536e5c211',
      'smartphone');
  _categoryService.createCategory(
      'Sport',
      'https://firebasestorage.googleapis.com/v0/b/fluttere-commerce-a1957.appspot.com/o/categories%2Fsports.png?alt=media&token=ca19d990-e313-46e2-966a-4261e4656a7d',
      'sport');
  _categoryService.createCategory(
      'fashion',
      'https://firebasestorage.googleapis.com/v0/b/fluttere-commerce-a1957.appspot.com/o/categories%2Ffashion.png?alt=media&token=f1a101d8-83fb-4415-8c69-4b9a94771f3d',
      'category');
}

createBrands() {
  _brandService.createBrand(
      'Apple',
      'https://firebasestorage.googleapis.com/v0/b/fluttere-commerce-a1957.appspot.com/o/brands%2Fapple.png?alt=media&token=2761e999-85a6-4d88-9bda-b1be4e1974f3',
      'Apple Inc. is an American multinational technology company that specializes in consumer electronics, software and online services headquartered in Cupertino, California, United States');
  _brandService.createBrand(
      'Nike',
      'https://firebasestorage.googleapis.com/v0/b/fluttere-commerce-a1957.appspot.com/o/brands%2Fnike.png?alt=media&token=f08eb81c-87b5-4a45-9701-c0125b51dd2e',
      'The worlds largest athletic apparel company, Nike is best known for its footwear, apparel, and equipment. Founded in 1964 as Blue Ribbon Sports, the company became Nike in 1971 after the Greek goddess of victory. One of the most valuable brands among sport businesses, Nike employs over 76,000 people worldwide.');
  _brandService.createBrand(
      'Dsquared2',
      'https://firebasestorage.googleapis.com/v0/b/fluttere-commerce-a1957.appspot.com/o/brands%2Fdsquared2.png?alt=media&token=e47ba6a2-e86e-4eaf-bf40-1be4dbb1f81e',
      'Dsquared2 is a high fashion brand launched in 1995 by twin brothers dean and Dan Caten in Milan Italy. It was the first brand that released a mens collection, very different from the mainstream womens collection releases at that time. The brand started with basic men wear such as shirts and pants');
}

createProducts() {
  _productService.createProduct(
      'Nike Joyride Flyknit',
      'https://firebasestorage.googleapis.com/v0/b/fluttere-commerce-a1957.appspot.com/o/products%2Fshoes2.png?alt=media&token=831ea2ce-e8c2-4fcc-b67b-117f7398381d',
      'white;red;black',
      'That soft ride doesnt just go easy on your feet—it helps your whole body to feel good. The Nike Joyride cushioning system offers 14% better impact absorption when compared to some of our most trusted running shoes (tested with Nike Air Zoom Pegasus 36 and Nike Epic React FK2).',
      471,
      10,
      0,
      100,
      'NiyavkmDnHLqoKohdj3B',
      '1H9sLJkP8tf1mZAAobZx');
  _productService.createProduct(
      'Iphone 12 pro',
      'https://firebasestorage.googleapis.com/v0/b/fluttere-commerce-a1957.appspot.com/o/products%2Fiphone-12-pro-silver.jpg?alt=media&token=e12653d4-e160-412e-bcbc-229744e1aa21',
      'silver;red;black',
      'The iPhone 12 and iPhone 12 mini were Apples mainstream flagship iPhones for 2020. The phones come in 6.1-inch and 5.4-inch sizes with identical features, including support for 5G cellular networks, OLED displays, improved cameras, and Apples A14 chip, all in a completely refreshed design',
      999,
      20,
      0,
      100,
      'DvXC6frPXJUBIgsL5X4w',
      '5JCsi5ukdnLQqOBr2tBj');

  _productService.createProduct(
      'Dsquared2 T-Shirt',
      'https://firebasestorage.googleapis.com/v0/b/fluttere-commerce-a1957.appspot.com/o/products%2Ftshirt.png?alt=media&token=bde53856-e98f-4fa2-8f5d-797fd5198908',
      'silver;red;black',
      '88% Cotton, 12% Viscose Made in Italy',
      999,
      20,
      0,
      100,
      'Bt6TbBFQMD50SkcfySFk',
      '1H9sLJkP8tf1mZAAobZx');
}

createUsersProducts() {
  _usersProductsService.createUserProduct(
      'EiBOFc7JTBNirsf1n1Exucf3yyJ2', 'qse4D9XbVixstgmT310i');
}

createSlideshow() {
  _slideshowService.createSlideshow(
      'The Second Coming of Gluttony',
      'https://firebasestorage.googleapis.com/v0/b/fluttermynovel.appspot.com/o/slideshows%2Fthe-second-return-of-gluttonl.PNG?alt=media&token=ce7477e7-3723-4704-8e8b-17d41d22241a',
      1,
      'jtn8pMLHI7QzilmdmxzU');
  _slideshowService.createSlideshow(
      'Solo Leveling',
      'https://firebasestorage.googleapis.com/v0/b/fluttermynovel.appspot.com/o/slideshows%2Fsolo-leveling.jpeg?alt=media&token=7764e675-f930-4891-806b-5017632de86a',
      2,
      'IcCUHTP9WNHSuBUkxpMo');
  _slideshowService.createSlideshow(
      'The King of the Battlefield',
      'https://firebasestorage.googleapis.com/v0/b/fluttermynovel.appspot.com/o/slideshows%2Fking-of-the-battlefield.jpg?alt=media&token=ae0da502-a698-4947-9185-781ba0dbae50',
      3,
      'CO2hG1loqM56Dz2rMb0K');
}
