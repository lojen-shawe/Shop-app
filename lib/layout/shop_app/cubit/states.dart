import '../../../models/shop_model/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeButtonNavBarState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopLoadingCategoriesState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopLoadingFavoritesState extends ShopStates{}

class ShopSuccessFavoritesState extends ShopStates{}

class ShopErrorFavoritesState extends ShopStates{}

class ShopLoadingGetUserState extends ShopStates{}

class ShopSuccessGetUserState extends ShopStates{}

class ShopErrorGetUserState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates{}

class ShopErrorUpdateUserState extends ShopStates{}