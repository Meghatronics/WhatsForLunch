// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/widgets.dart';
// import 'package:intl/intl.dart';

// import 'constants/constants.dart';
// import 'extensions/string_extensions.dart';

// ImageProvider makeNetworkAvatar(String url) {
//   return url == null || !url.validateLink()
//       ? const AssetImage(defaultAvatarAsset)
//       : CachedNetworkImageProvider(url);
// }

// ImageProvider makeNetworkImage(String link) {
//   return link == null || !link.validateLink()
//       ? const CachedNetworkImageProvider(defaultNetworkImage)
//       : CachedNetworkImageProvider(link);
// }

// String formatToMoneyString(value, [bool addKobo = false]) {
//   final moneyString = '${NumberFormat.currency(
//     symbol: '₦',
//     decimalDigits: addKobo ? 2 : 0,
//   ).format(value)}';
//   return moneyString;
// }
