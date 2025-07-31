import 'package:currency_code_to_currency_symbol/currency_code_to_currency_symbol.dart';
import 'package:e_commerce/core/styles/colors.dart';
import 'package:e_commerce/core/styles/text_styles.dart';
import 'package:e_commerce/core/util/date.dart';
import 'package:e_commerce/core/util/localization.dart';
import 'package:e_commerce/profile/domain/profile_data_model.dart';
import 'package:flutter/material.dart';

class ProfileOrders extends StatelessWidget {
  final List<Order> orders;
  const ProfileOrders({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        sliver: SliverToBoxAdapter(
          child: Text(
            localization(context).ordersEmpty,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption2.copyWith(color: AppColors.neutral_04),
          ),
        ),
      );
    }
    return SliverList.separated(
      itemCount: orders.length,
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Divider(color: AppColors.neutral_03, thickness: 1, height: 0),
        );
      },
      itemBuilder: (context, index) => _OrderTile(order: orders[index]),
    );
  }
}

class _OrderTile extends StatelessWidget {
  final Order order;
  const _OrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        _buildOrderDataEntry(
          identifier: localization(context).date,
          value: formatDate(order.createdAt),
        ),
        _buildOrderDataEntry(
          identifier: localization(context).status,
          value: order.status,
        ),
        _buildOrderDataEntry(
          identifier: localization(context).price,
          value: '${getCurrencySymbol(order.currencyCode)}${order.price}',
        ),
      ],
    );
  }
}

Widget _buildOrderDataEntry({
  required String identifier,
  required String value,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          identifier,
          style: AppTextStyles.caption1.copyWith(color: AppColors.neutral_04),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: AppTextStyles.caption1.copyWith(color: AppColors.neutral_07),
        ),
      ),
    ],
  );
}
