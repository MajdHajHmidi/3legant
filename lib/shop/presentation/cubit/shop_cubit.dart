import 'package:e_commerce/shop/data/shop_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  final ShopRepo shopRepo;
  ShopCubit({required this.shopRepo}) : super(ShopInitial());
}
