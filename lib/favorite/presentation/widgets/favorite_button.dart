import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/styles/colors.dart';
// import '../../cubit/favorite_cubit.dart';
// import '../../../core/util/dependency_injection.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../data/favorite_repo.dart';

// class FavoriteButton extends StatelessWidget {
//   final double width;
//   final double height;
//   final bool isFavorite;
//   final String productId;

//   /// Function to update the product model
//   final void Function()? onRequestSuccess;

//   const FavoriteButton({
//     super.key,
//     this.width = 32,
//     this.height = 32,
//     required this.isFavorite,
//     required this.productId,
//     this.onRequestSuccess,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create:
//           (context) => FavoriteCubit(
//             isFavorite,
//             favoriteRepo: serviceLocator<FavoriteRepo>(),
//           ),
//       child: _FavoriteButtonBody(
//         width: width,
//         height: height,
//         initialIsFavorite: isFavorite,
//         productId: productId,
//         onRequestSuccess: onRequestSuccess,
//       ),
//     );
//   }
// }

// class _FavoriteButtonBody extends StatefulWidget {
//   final double width;
//   final double height;
//   final bool initialIsFavorite;
//   final String productId;
//   final void Function()? onRequestSuccess;

//   const _FavoriteButtonBody({
//     required this.width,
//     required this.height,
//     required this.initialIsFavorite,
//     required this.productId,
//     this.onRequestSuccess,
//   });

//   @override
//   State<_FavoriteButtonBody> createState() => _FavoriteButtonBodyState();
// }

// class _FavoriteButtonBodyState extends State<_FavoriteButtonBody>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _animationController;
//   late final Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 150),
//     );

//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeOut,
//         reverseCurve: Curves.easeIn,
//       ),
//     );

//     _animationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _animationController.reverse();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();

//     super.dispose();
//   }

//   void _onTap(BuildContext context) {
//     _animationController.forward();
//     context.read<FavoriteCubit>().toggle(widget.productId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<FavoriteCubit, FavoriteState>(
//       // When the request succeeds, change the value in the data model
//       listenWhen: (_, state) => state is FavoriteSuccessState,
//       listener: (context, state) {
//         if (widget.onRequestSuccess != null) {
//           widget.onRequestSuccess!();
//         }
//       },
//       bloc: context.read<FavoriteCubit>(),
//       builder: (context, state) {
//         final isFavorite = context.read<FavoriteCubit>().isFavorite;

//         return ScaleTransition(
//           scale: _scaleAnimation,
//           child: InkWell(
//             onTap: () => _onTap(context),
//             child: Container(
//               width: widget.width,
//               height: widget.height,
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: HexColor('#141718').withAlpha(115),
//               ),
//               child: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 200),
//                 transitionBuilder:
//                     (child, animation) =>
//                         FadeTransition(opacity: animation, child: child),
//                 child: SvgPicture.asset(
//                   isFavorite ? AppIcons.heart : AppIcons.outlinedHeart,
//                   key: ValueKey<bool>(isFavorite),
//                   theme: SvgTheme(currentColor: AppColors.neutral_01),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  const FavoriteButton({super.key, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: HexColor('#141718').withAlpha(115),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder:
            (child, animation) =>
                FadeTransition(opacity: animation, child: child),
        child: SvgPicture.asset(
          isFavorite ? AppIcons.heart : AppIcons.outlinedHeart,
          key: ValueKey<bool>(isFavorite),
          theme: SvgTheme(currentColor: AppColors.neutral_01),
        ),
      ),
    );
  }
}
