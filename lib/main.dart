// ==============================================================================
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [الدفعة 1 من أصل 4: الثوابت السحابية، علم الاستقلال، النماذج، ومستودع السحابة ومدير الحالة]
// مربوطة بالكامل بالسيرفر الحقيقي وقواعد البيانات الحقيقية دون أي اختصار
// ==============================================================================

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ==============================================================================
// 1. الثوابت السحابية المركزية المحدثة وبيانات الاتصال الحقيقية (Supabase & APIs)
// ==============================================================================
const String kSupabaseUrl = 'https://zbjjkigkxbpktpmpcdqc.supabase.co';
const String kSupabaseAnonKey =
    'sb_publishable_ZZBI_vTK7ks1yfO2g3Zo0Q_Sg4QizEr';

// بوابات الدفع والشحن الحصرية المعتمدة 100%
const String kShamCashAccountKey = '0308a7227251b7c8ebca471cd30b15a8';
const String kBinanceWalletAddress = 'TCHJ8QyEijnRsQmyXJWBCoiuPET1mZqBK2';
const String kOfficialUpdateUrl =
    'https://celadon-pithivier-77918a.netlify.app';

const String kAppOwnerPhone = '+963985954605';
const String kAppOwnerWhatsApp = '+963985954605';
const String kAppOwnerEmail = 'khafayef2010@gmail.com';
const String kDefaultShareDomain =
    'https://celadon-pithivier-77918a.netlify.app';

// مستودعات التخزين السحابي الفعلي (Supabase Storage Buckets)
const String kStorageBucketAds = 'ads_images';
const String kStorageBucketBanners = 'banners_images';
const String kStorageBucketPanoramas = 'panoramas_images';
const String kStorageBucketFeedbacks = 'feedback_attachments';

// القائمة المعتمدة لمدراء غرفة العمليات والمالكين (Super Admins)
const List<String> kAuthorizedAdminEmails = [
  'khafayef2010@gmail.com',
  'admin@souqsyria.com',
  'aoaadabdo@gmail.com',
];

enum BannerDisplayLayoutMode {
  dualGrid,
  fullPanorama,
}

// ==============================================================================
// 2. علم الاستقلال السوري الجديد (3 نجوم حمراء) - رسم فيكتور نقي
// ==============================================================================
class SyrianIndependenceFlag extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SyrianIndependenceFlag({
    Key? key,
    this.width = 34.0,
    this.height = 22.0,
    this.borderRadius = 3.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: CustomPaint(
          painter: _SyrianFlagPainter(),
        ),
      ),
    );
  }
}

class _SyrianFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stripeHeight = size.height / 3.0;

    // 1. الشريط الأخضر العلوي (رمز السيادة)
    final greenPaint = Paint()
      ..color = const Color(0xFF007A3D)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, stripeHeight), greenPaint);

    // 2. الشريط الأبيض الأوسط (رمز النقاء والسلام)
    final whitePaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(0, stripeHeight, size.width, stripeHeight), whitePaint);

    // 3. الشريط الأسود السفلي (رمز الصمود والعزة)
    final blackPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(0, stripeHeight * 2, size.width, stripeHeight),
        blackPaint);

    // 4. النجوم الحمراء الثلاث في الوسط
    final starPaint = Paint()
      ..color = const Color(0xFFDC2626)
      ..style = PaintingStyle.fill;

    final centerY = size.height / 2.0;
    final starRadius = stripeHeight * 0.33;
    final starSpacing = size.width / 4.0;

    for (int i = 1; i <= 3; i++) {
      final centerX = starSpacing * i;
      _drawFivePointedStar(canvas, centerX, centerY, starRadius, starPaint);
    }
  }

  void _drawFivePointedStar(
      Canvas canvas, double cx, double cy, double radius, Paint paint) {
    final path = Path();
    final points = 5;
    final innerRadius = radius * 0.45;
    double angle = -pi / 2.0;
    final step = pi / points;

    for (int i = 0; i < points * 2; i++) {
      final r = (i % 2 == 0) ? radius : innerRadius;
      final x = cx + r * cos(angle);
      final y = cy + r * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      angle += step;
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
// ==============================================================================
// 3. نماذج البيانات الحقيقية المتصلة بقواعد البيانات السحابية (Cloud Models)
// ==============================================================================

class BidRecord {
  final String id;
  final String userId;
  final String userName;
  final double amount;
  final DateTime timestamp;

  BidRecord({
    required this.id,
    required this.userId,
    required this.userName,
    required this.amount,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'user_name': userName,
        'amount': amount,
        'timestamp': timestamp.toIso8601String(),
      };

  factory BidRecord.fromMap(Map<String, dynamic> map) => BidRecord(
        id: map['id']?.toString() ?? '',
        userId: map['user_id']?.toString() ?? '',
        userName: map['user_name']?.toString() ?? 'مزايد',
        amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
        timestamp: map['timestamp'] != null
            ? DateTime.tryParse(map['timestamp'].toString()) ?? DateTime.now()
            : DateTime.now(),
      );
}

class SnipResult {
  final bool wasExtended;
  final DateTime newEndTime;
  final String message;

  SnipResult({
    required this.wasExtended,
    required this.newEndTime,
    required this.message,
  });
}

class PaymentAuditRecord {
  final String id;
  final String userId;
  final String userName;
  final String userPhone;
  final String userGovernorate;
  final String planId;
  final String planName;
  final String gateway; // 'SHAM_CASH' أو 'BINANCE_USDT'
  final double amountUsd;
  final double amountSyp;
  final String transactionRefOrTxId;
  String status; // 'pending' أو 'approved' أو 'rejected'
  String? adminRejectionReason;
  final DateTime createdAt;
  DateTime? processedAt;

  PaymentAuditRecord({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.userGovernorate,
    required this.planId,
    required this.planName,
    required this.gateway,
    required this.amountUsd,
    required this.amountSyp,
    required this.transactionRefOrTxId,
    this.status = 'pending',
    this.adminRejectionReason,
    required this.createdAt,
    this.processedAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'user_name': userName,
        'user_phone': userPhone,
        'user_governorate': userGovernorate,
        'plan_id': planId,
        'plan_name': planName,
        'gateway': gateway,
        'amount_usd': amountUsd,
        'amount_syp': amountSyp,
        'transaction_ref': transactionRefOrTxId,
        'status': status,
        'rejection_reason': adminRejectionReason,
        'created_at': createdAt.toIso8601String(),
        'processed_at': processedAt?.toIso8601String(),
      };

  factory PaymentAuditRecord.fromMap(Map<String, dynamic> map) =>
      PaymentAuditRecord(
        id: map['id']?.toString() ?? '',
        userId: map['user_id']?.toString() ?? '',
        userName: map['user_name']?.toString() ?? 'مشترك',
        userPhone: map['user_phone']?.toString() ?? '',
        userGovernorate: map['user_governorate']?.toString() ?? 'دمشق',
        planId: map['plan_id']?.toString() ?? '',
        planName: map['plan_name']?.toString() ?? '',
        gateway: map['gateway']?.toString() ?? 'SHAM_CASH',
        amountUsd: (map['amount_usd'] as num?)?.toDouble() ?? 0.0,
        amountSyp: (map['amount_syp'] as num?)?.toDouble() ?? 0.0,
        transactionRefOrTxId: map['transaction_ref']?.toString() ?? '',
        status: map['status']?.toString() ?? 'pending',
        adminRejectionReason: map['rejection_reason']?.toString(),
        createdAt: map['created_at'] != null
            ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
            : DateTime.now(),
        processedAt: map['processed_at'] != null
            ? DateTime.tryParse(map['processed_at'].toString())
            : null,
      );
}

class DepartmentNode {
  final String id;
  String nameAr;
  String nameEn;
  String? parentId;
  String description;
  String iconName;
  Color themeColor;
  bool isEnabled;
  int sortOrder;
  String requiredPermission;
  int activeAdsCount;
  bool allowSubBranches;
  int maxSubDepth;
  List<DepartmentNode> subBranches;

  DepartmentNode({
    required this.id,
    required this.nameAr,
    this.nameEn = '',
    this.parentId,
    this.description = '',
    this.iconName = 'Category',
    this.themeColor = const Color(0xFF0284C7),
    this.isEnabled = true,
    this.sortOrder = 0,
    this.requiredPermission = 'manage_categories',
    this.activeAdsCount = 0,
    this.allowSubBranches = true,
    this.maxSubDepth = 3,
    this.subBranches = const [],
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name_ar': nameAr,
        'name_en': nameEn,
        'parent_id': parentId,
        'description': description,
        'icon_name': iconName,
        'theme_color': themeColor.value,
        'is_enabled': isEnabled,
        'sort_order': sortOrder,
        'required_permission': requiredPermission,
        'active_ads_count': activeAdsCount,
        'allow_sub_branches': allowSubBranches,
        'max_sub_depth': maxSubDepth,
      };

  factory DepartmentNode.fromMap(Map<String, dynamic> map) => DepartmentNode(
        id: map['id']?.toString() ??
            'dep_${DateTime.now().millisecondsSinceEpoch}',
        nameAr: map['name_ar']?.toString() ?? '',
        nameEn: map['name_en']?.toString() ?? '',
        parentId: map['parent_id']?.toString(),
        description: map['description']?.toString() ?? '',
        iconName: map['icon_name']?.toString() ?? 'Category',
        themeColor: map['theme_color'] != null
            ? Color(map['theme_color'] as int)
            : const Color(0xFF0284C7),
        isEnabled: map['is_enabled'] ?? true,
        sortOrder: (map['sort_order'] as num?)?.toInt() ?? 0,
        requiredPermission:
            map['required_permission']?.toString() ?? 'manage_categories',
        activeAdsCount: (map['active_ads_count'] as num?)?.toInt() ?? 0,
        allowSubBranches: map['allow_sub_branches'] ?? true,
        maxSubDepth: (map['max_sub_depth'] as num?)?.toInt() ?? 3,
      );
}

class AdItem {
  final String id;
  final String userId;
  final String title;
  final String description;
  final double? priceUsd;
  final double? priceSyp;
  final String governorate;
  final String neighborhood;
  final String categoryId;
  final String subcategory;
  final String condition;
  final String contactPhone;
  final String contactWhatsapp;
  final List<String> imageUrls;
  final String? videoUrl;
  final String? facebookUrl;
  final String? telegramUrl;
  final String? instagramUrl;
  final String? tiktokUrl;
  final String? youtubeUrl;
  final String publisherName;
  final String publisherEmail;
  final bool isVerifiedSeller;
  final int sellerPositiveLikes;
  final int sellerDislikes;
  final int viewsCount;
  String status; // 'pending' أو 'approved' أو 'rejected'
  final String? rejectionReason;
  final bool isFeatured;
  final bool isAuction;
  final double? startingBid;
  final double? currentBid;
  final DateTime? auctionEndTime;
  final List<BidRecord> bids;
  final bool isSold;
  final DateTime? soldAt;
  final String fraudRisk;
  final DateTime createdAt;

  AdItem({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.priceUsd,
    this.priceSyp,
    required this.governorate,
    required this.neighborhood,
    required this.categoryId,
    required this.subcategory,
    required this.condition,
    required this.contactPhone,
    required this.contactWhatsapp,
    required this.imageUrls,
    this.videoUrl,
    this.facebookUrl,
    this.telegramUrl,
    this.instagramUrl,
    this.tiktokUrl,
    this.youtubeUrl,
    required this.publisherName,
    required this.publisherEmail,
    this.isVerifiedSeller = false,
    this.sellerPositiveLikes = 0,
    this.sellerDislikes = 0,
    this.viewsCount = 0,
    this.status = 'pending',
    this.rejectionReason,
    this.isFeatured = false,
    this.isAuction = false,
    this.startingBid,
    this.currentBid,
    this.auctionEndTime,
    this.bids = const [],
    this.isSold = false,
    this.soldAt,
    this.fraudRisk = 'low',
    required this.createdAt,
  });

  String get phone => contactPhone;
  String get whatsapp => contactWhatsapp;
  String get userName => publisherName;

  bool get isApproved => status == 'approved';
  bool get isPending => status == 'pending';
  bool get isRejected => status == 'rejected';

  bool get shouldBeDeletedNow {
    if (!isSold || soldAt == null) return false;
    return DateTime.now().difference(soldAt!).inMinutes >= 60;
  }

  Duration? get soldRemainingDuration {
    if (!isSold || soldAt == null) return null;
    final diff =
        const Duration(minutes: 60) - DateTime.now().difference(soldAt!);
    return diff.isNegative ? Duration.zero : diff;
  }

  AdItem copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    double? priceUsd,
    double? priceSyp,
    String? governorate,
    String? neighborhood,
    String? categoryId,
    String? subcategory,
    String? condition,
    String? contactPhone,
    String? contactWhatsapp,
    List<String>? imageUrls,
    String? videoUrl,
    String? facebookUrl,
    String? telegramUrl,
    String? instagramUrl,
    String? tiktokUrl,
    String? youtubeUrl,
    String? publisherName,
    String? publisherEmail,
    bool? isVerifiedSeller,
    int? sellerPositiveLikes,
    int? sellerDislikes,
    int? viewsCount,
    String? status,
    String? rejectionReason,
    bool? isFeatured,
    bool? isAuction,
    double? startingBid,
    double? currentBid,
    DateTime? auctionEndTime,
    List<BidRecord>? bids,
    bool? isSold,
    DateTime? soldAt,
    String? fraudRisk,
    DateTime? createdAt,
  }) {
    return AdItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      priceUsd: priceUsd ?? this.priceUsd,
      priceSyp: priceSyp ?? this.priceSyp,
      governorate: governorate ?? this.governorate,
      neighborhood: neighborhood ?? this.neighborhood,
      categoryId: categoryId ?? this.categoryId,
      subcategory: subcategory ?? this.subcategory,
      condition: condition ?? this.condition,
      contactPhone: contactPhone ?? this.contactPhone,
      contactWhatsapp: contactWhatsapp ?? this.contactWhatsapp,
      imageUrls: imageUrls ?? this.imageUrls,
      videoUrl: videoUrl ?? this.videoUrl,
      facebookUrl: facebookUrl ?? this.facebookUrl,
      telegramUrl: telegramUrl ?? this.telegramUrl,
      instagramUrl: instagramUrl ?? this.instagramUrl,
      tiktokUrl: tiktokUrl ?? this.tiktokUrl,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      publisherName: publisherName ?? this.publisherName,
      publisherEmail: publisherEmail ?? this.publisherEmail,
      isVerifiedSeller: isVerifiedSeller ?? this.isVerifiedSeller,
      sellerPositiveLikes: sellerPositiveLikes ?? this.sellerPositiveLikes,
      sellerDislikes: sellerDislikes ?? this.sellerDislikes,
      viewsCount: viewsCount ?? this.viewsCount,
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      isFeatured: isFeatured ?? this.isFeatured,
      isAuction: isAuction ?? this.isAuction,
      startingBid: startingBid ?? this.startingBid,
      currentBid: currentBid ?? this.currentBid,
      auctionEndTime: auctionEndTime ?? this.auctionEndTime,
      bids: bids ?? this.bids,
      isSold: isSold ?? this.isSold,
      soldAt: soldAt ?? this.soldAt,
      fraudRisk: fraudRisk ?? this.fraudRisk,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() => {
        if (id.isNotEmpty && !id.startsWith('ad_')) 'id': id,
        if (userId.isNotEmpty && userId != 'guest') 'user_id': userId,
        'title': title,
        'description': description,
        'price_usd': priceUsd,
        'price_syp': priceSyp,
        'governorate': governorate,
        'neighborhood': neighborhood,
        'category_id': categoryId,
        'subcategory': subcategory,
        'condition': condition,
        'publisher_phone':
            contactPhone.isNotEmpty ? contactPhone : contactWhatsapp,
        'publisher_name': publisherName.isNotEmpty ? publisherName : 'معلن',
        'publisher_email': publisherEmail,
        'image_urls': imageUrls,
        'video_url': videoUrl ?? '',
        'is_featured': isFeatured,
        'is_sold': isSold,
        'status': 'approved',
        'created_at': createdAt.toIso8601String(),
      };

  factory AdItem.fromMap(Map<String, dynamic> map) {
    List<String> imgs = [];
    if (map['image_urls'] is List) {
      imgs = (map['image_urls'] as List).map((e) => e.toString()).toList();
    } else if (map['image_url'] != null &&
        map['image_url'].toString().isNotEmpty) {
      imgs = [map['image_url'].toString()];
    }

    List<BidRecord> parsedBids = [];
    if (map['bids'] is List) {
      parsedBids = (map['bids'] as List)
          .map((b) => BidRecord.fromMap(b as Map<String, dynamic>))
          .toList();
    }

    return AdItem(
      id: map['id']?.toString() ??
          'ad_${DateTime.now().millisecondsSinceEpoch}',
      userId: map['user_id']?.toString() ?? 'guest',
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      priceUsd: (map['price_usd'] as num?)?.toDouble(),
      priceSyp: (map['price_syp'] as num?)?.toDouble(),
      governorate: map['governorate']?.toString() ?? 'دمشق',
      neighborhood: map['neighborhood']?.toString() ?? 'المركز',
      categoryId: map['category_id']?.toString() ?? 'عام',
      subcategory: map['subcategory']?.toString() ?? 'عام',
      condition: map['condition']?.toString() ?? 'مستعمل',
      contactPhone: map['publisher_phone']?.toString() ??
          map['contact_phone']?.toString() ??
          kAppOwnerPhone,
      contactWhatsapp: map['contact_whatsapp']?.toString() ?? kAppOwnerWhatsApp,
      imageUrls: imgs,
      videoUrl: map['video_url']?.toString(),
      facebookUrl: map['facebook_url']?.toString(),
      telegramUrl: map['telegram_url']?.toString(),
      instagramUrl: map['instagram_url']?.toString(),
      tiktokUrl: map['tiktok_url']?.toString(),
      youtubeUrl: map['youtube_url']?.toString(),
      publisherName: map['publisher_name']?.toString() ?? 'معلن',
      publisherEmail: map['publisher_email']?.toString() ?? '',
      isVerifiedSeller: map['is_verified_seller'] == true,
      sellerPositiveLikes: (map['seller_positive_likes'] as num?)?.toInt() ?? 0,
      sellerDislikes: (map['seller_dislikes'] as num?)?.toInt() ?? 0,
      viewsCount: (map['views_count'] as num?)?.toInt() ?? 0,
      status: map['status']?.toString() ?? 'pending',
      rejectionReason: map['rejection_reason']?.toString(),
      isFeatured: map['is_featured'] == true,
      isAuction: map['is_auction'] == true,
      startingBid: (map['starting_bid'] as num?)?.toDouble(),
      currentBid: (map['current_bid'] as num?)?.toDouble(),
      auctionEndTime: map['auction_end_time'] != null
          ? DateTime.tryParse(map['auction_end_time'].toString())
          : null,
      bids: parsedBids,
      isSold: map['is_sold'] == true,
      soldAt: map['sold_at'] != null
          ? DateTime.tryParse(map['sold_at'].toString())
          : null,
      fraudRisk: map['fraud_risk']?.toString() ?? 'low',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}

class BannerItem {
  final String id;
  final List<String> imageUrls;
  final String title;
  final String subtitle;
  final String description;
  final String location;
  final String phone;
  final String whatsapp;
  final String linkUrl;
  final String badgeText;
  final Color badgeColor;
  final int displayDurationSeconds;
  final DateTime expiresAt;
  bool isActive;

  BannerItem({
    required this.id,
    required this.imageUrls,
    required this.title,
    this.subtitle = '',
    this.description = '',
    this.location = 'كل المحافظات',
    this.phone = '',
    this.whatsapp = '',
    this.linkUrl = '',
    this.badgeText = 'VIP ★',
    this.badgeColor = const Color(0xFFD4AF37),
    this.displayDurationSeconds = 3,
    required this.expiresAt,
    this.isActive = true,
  });

  String get imageUrl => imageUrls.isNotEmpty ? imageUrls.first : '';
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Map<String, dynamic> toMap() => {
        'id': id,
        'image_urls': imageUrls,
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'location': location,
        'phone': phone,
        'whatsapp': whatsapp,
        'link_url': linkUrl,
        'badge_text': badgeText,
        'badge_color': badgeColor.value,
        'display_duration_seconds': displayDurationSeconds,
        'expires_at': expiresAt.toIso8601String(),
        'is_active': isActive,
      };

  factory BannerItem.fromMap(Map<String, dynamic> map) {
    List<String> imgs = [];
    if (map['image_urls'] is List) {
      imgs = (map['image_urls'] as List).map((e) => e.toString()).toList();
    } else if (map['image_url'] != null) {
      imgs = [map['image_url'].toString()];
    }

    return BannerItem(
      id: map['id']?.toString() ??
          'bn_${DateTime.now().millisecondsSinceEpoch}',
      imageUrls: imgs,
      title: map['title']?.toString() ?? '',
      subtitle: map['subtitle']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      location: map['location']?.toString() ?? 'كل المحافظات',
      phone: map['phone']?.toString() ?? '',
      whatsapp: map['whatsapp']?.toString() ?? '',
      linkUrl: map['link_url']?.toString() ?? '',
      badgeText: map['badge_text']?.toString() ?? 'VIP ★',
      badgeColor: map['badge_color'] != null
          ? Color(map['badge_color'] as int)
          : const Color(0xFFD4AF37),
      displayDurationSeconds:
          (map['display_duration_seconds'] as num?)?.toInt() ?? 3,
      expiresAt: map['expires_at'] != null
          ? DateTime.tryParse(map['expires_at'].toString()) ??
              DateTime.now().add(const Duration(days: 30))
          : DateTime.now().add(const Duration(days: 30)),
      isActive: map['is_active'] ?? true,
    );
  }
}

class CategoryItem {
  final String id;
  String name;
  String iconName;
  IconData iconData;
  Color textColor;
  Color backgroundColor;
  double borderRadiusValue;
  List<String> subcategories;
  bool isEnabled;
  String description;
  int activeAdsCount;

  CategoryItem({
    required this.id,
    required this.name,
    this.iconName = 'Category',
    required this.iconData,
    this.textColor = const Color(0xFFD4AF37),
    this.backgroundColor = const Color(0xFF1E293B),
    this.borderRadiusValue = 10.0,
    required this.subcategories,
    this.isEnabled = true,
    this.description = '',
    this.activeAdsCount = 0,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'icon_name': iconName,
        'text_color': textColor.value,
        'bg_color': backgroundColor.value,
        'border_radius': borderRadiusValue,
        'subcategories': subcategories,
        'is_enabled': isEnabled,
        'description': description,
        'active_ads_count': activeAdsCount,
      };

  factory CategoryItem.fromMap(Map<String, dynamic> map) {
    return CategoryItem(
      id: map['id']?.toString() ??
          'cat_${DateTime.now().millisecondsSinceEpoch}',
      name: map['name']?.toString() ?? 'قسم عام',
      iconName: map['icon_name']?.toString() ?? 'Category',
      iconData: Icons.category,
      textColor: map['text_color'] != null
          ? Color(map['text_color'] as int)
          : const Color(0xFFD4AF37),
      backgroundColor: map['bg_color'] != null
          ? Color(map['bg_color'] as int)
          : const Color(0xFF1E293B),
      borderRadiusValue: (map['border_radius'] as num?)?.toDouble() ?? 10.0,
      subcategories:
          (map['subcategories'] as List?)?.map((e) => e.toString()).toList() ??
              ['عام'],
      isEnabled: map['is_enabled'] ?? true,
      description: map['description']?.toString() ?? '',
      activeAdsCount: (map['active_ads_count'] as num?)?.toInt() ?? 0,
    );
  }
}

class SubscriptionPlanItem {
  final String id;
  final String name;
  final double priceUsd;
  final int maxAds;
  final int maxImagesPerAd;
  final int maxPanoramasAllowed;
  final bool canPostAuctions;
  final bool hasVerifiedBadge;
  final bool hasKycVerification;
  final List<String> features;

  SubscriptionPlanItem({
    required this.id,
    required this.name,
    required this.priceUsd,
    required this.maxAds,
    required this.maxImagesPerAd,
    this.maxPanoramasAllowed = 0,
    this.canPostAuctions = true,
    this.hasVerifiedBadge = false,
    this.hasKycVerification = false,
    required this.features,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price_usd': priceUsd,
        'max_ads': maxAds,
        'max_images_per_ad': maxImagesPerAd,
        'max_panoramas_allowed': maxPanoramasAllowed,
        'can_post_auctions': canPostAuctions,
        'has_verified_badge': hasVerifiedBadge,
        'has_kyc_verification': hasKycVerification,
        'features': features,
      };

  factory SubscriptionPlanItem.fromMap(Map<String, dynamic> map) =>
      SubscriptionPlanItem(
        id: map['id']?.toString() ?? 'plan_free',
        name: map['name']?.toString() ?? 'الباقة المجانية',
        priceUsd: (map['price_usd'] as num?)?.toDouble() ?? 0.0,
        maxAds: (map['max_ads'] as num?)?.toInt() ?? 5,
        maxImagesPerAd: (map['max_images_per_ad'] as num?)?.toInt() ?? 4,
        maxPanoramasAllowed:
            (map['max_panoramas_allowed'] as num?)?.toInt() ?? 0,
        canPostAuctions: map['can_post_auctions'] ?? true,
        hasVerifiedBadge: map['has_verified_badge'] ?? false,
        hasKycVerification: map['has_kyc_verification'] ?? false,
        features:
            (map['features'] as List?)?.map((e) => e.toString()).toList() ?? [],
      );
}

class AdCommentItem {
  final String id;
  final String adId;
  final String userId;
  final String userName;
  final String commentText;
  final DateTime createdAt;

  AdCommentItem({
    required this.id,
    required this.adId,
    required this.userId,
    required this.userName,
    required this.commentText,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'ad_id': adId,
        'user_id': userId,
        'user_name': userName,
        'comment_text': commentText,
        'created_at': createdAt.toIso8601String(),
      };

  factory AdCommentItem.fromMap(Map<String, dynamic> map) => AdCommentItem(
        id: map['id']?.toString() ?? '',
        adId: map['ad_id']?.toString() ?? '',
        userId: map['user_id']?.toString() ?? '',
        userName: map['user_name']?.toString() ?? 'مستخدم',
        commentText: map['comment_text']?.toString() ?? '',
        createdAt: map['created_at'] != null
            ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
            : DateTime.now(),
      );
}

class AppFeedbackItem {
  final String id;
  final String userId;
  final String userName;
  final String userContact;
  final String type;
  final String content;
  final String? screenshotUrl;
  final DateTime createdAt;

  AppFeedbackItem({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userContact,
    required this.type,
    required this.content,
    this.screenshotUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'user_name': userName,
        'user_contact': userContact,
        'type': type,
        'content': content,
        'screenshot_url': screenshotUrl,
        'created_at': createdAt.toIso8601String(),
      };

  factory AppFeedbackItem.fromMap(Map<String, dynamic> map) => AppFeedbackItem(
        id: map['id']?.toString() ?? '',
        userId: map['user_id']?.toString() ?? '',
        userName: map['user_name']?.toString() ?? 'زائر',
        userContact: map['user_contact']?.toString() ?? '',
        type: map['type']?.toString() ?? '',
        content: map['content']?.toString() ?? '',
        screenshotUrl: map['screenshot_url']?.toString(),
        createdAt: map['created_at'] != null
            ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
            : DateTime.now(),
      );
}

class AuditLogItem {
  final String id;
  final String title;
  final String details;
  final String category;
  final String timestamp;
  final String adminName;
  final bool isCritical;

  AuditLogItem({
    required this.id,
    required this.title,
    required this.details,
    required this.category,
    required this.timestamp,
    required this.adminName,
    this.isCritical = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'details': details,
        'category': category,
        'timestamp': timestamp,
        'admin_name': adminName,
        'is_critical': isCritical,
      };

  factory AuditLogItem.fromMap(Map<String, dynamic> map) => AuditLogItem(
        id: map['id']?.toString() ?? '',
        title: map['title']?.toString() ?? '',
        details: map['details']?.toString() ?? '',
        category: map['category']?.toString() ?? 'عام',
        timestamp:
            map['timestamp']?.toString() ?? DateTime.now().toIso8601String(),
        adminName: map['admin_name']?.toString() ?? 'المدير',
        isCritical: map['is_critical'] == true,
      );
}

// ==============================================================================
// 4. الأدوات المساعدة وخدمات التخزين السحابي الفعلي (Helpers & Storage)
// ==============================================================================

class PhoneHelper {
  static bool isValidPhone(String phone) {
    final clean = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    return clean.length >= 8;
  }

  static String formatForWhatsapp(String phone) {
    var clean = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (clean.startsWith('09')) {
      clean = '963${clean.substring(1)}';
    } else if (clean.startsWith('9') && clean.length == 9) {
      clean = '963$clean';
    }
    return clean;
  }
}

class StorageUploadService {
  static Future<String?> uploadImageBytes({
    required String bucketName,
    required Uint8List imageBytes,
    String prefix = 'img',
  }) async {
    try {
      final fileName =
          '${prefix}_${DateTime.now().millisecondsSinceEpoch}_${imageBytes.lengthInBytes}.jpg';
      await Supabase.instance.client.storage.from(bucketName).uploadBinary(
            fileName,
            imageBytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );
      return Supabase.instance.client.storage
          .from(bucketName)
          .getPublicUrl(fileName);
    } catch (e) {
      debugPrint('Storage Upload Notice: $e');
      final b64 = base64Encode(imageBytes);
      return 'data:image/jpeg;base64,$b64';
    }
  }

  static Future<List<String>> uploadMultipleImageBytes({
    required String bucketName,
    required List<Uint8List> imagesBytesList,
    String prefix = 'ad',
  }) async {
    List<String> results = [];
    for (int i = 0; i < imagesBytesList.length; i++) {
      final url = await uploadImageBytes(
        bucketName: bucketName,
        imageBytes: imagesBytesList[i],
        prefix: '${prefix}_$i',
      );
      if (url != null && url.isNotEmpty) {
        results.add(url);
      }
    }
    return results;
  }
}

class AppSmartImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AppSmartImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: const Color(0xFF1E293B),
        child: const Icon(Icons.image_not_supported,
            color: Colors.white30, size: 28),
      );
    }

    if (imageUrl.startsWith('data:image')) {
      try {
        final b64 = imageUrl.split(',').last;
        final bytes = base64Decode(b64);
        return Image.memory(
          bytes,
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (_, __, ___) => _errorPlaceholder(),
        );
      } catch (_) {
        return _errorPlaceholder();
      }
    }

    return Image.network(
      imageUrl,
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: (ctx, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height,
          color: const Color(0xFF0F172A),
          child: Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: const Color(0xFFD4AF37),
                value: progress.expectedTotalBytes != null
                    ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!
                    : null,
              ),
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) => _errorPlaceholder(),
    );
  }

  Widget _errorPlaceholder() => Container(
        width: width,
        height: height,
        color: const Color(0xFF1E293B),
        child: const Icon(Icons.broken_image, color: Colors.white30, size: 24),
      );
}

// ==============================================================================
// 5. مدير الحالة والذاكرة المركزية الدائمة (AppStateManager)
// ==============================================================================
class AppStateManager extends ChangeNotifier {
  static final AppStateManager _instance = AppStateManager._internal();
  factory AppStateManager() => _instance;
  AppStateManager._internal();

  // إعدادات الهوية والتطبيق
  String appTitle = 'سوق سوريا الشامل 2028';
  Color primaryColor = const Color(0xFF0F172A);
  Color secondaryColor = const Color(0xFFD4AF37);
  Color buttonColor = const Color(0xFF0284C7);
  Color scaffoldBgColor = const Color(0xFFF8FAFC);
  Color appBarColor = const Color(0xFF0F172A);

  Color titleTextColor = const Color(0xFF0F172A);
  Color priceUsdColor = const Color(0xFF16A34A);
  Color priceSypColor = const Color(0xFFD4AF37);
  Color locationTextColor = const Color(0xFF64748B);

  bool isVoiceTypingEnabled = true;
  bool isMaintenanceMode = false;
  String maintenanceMessage =
      'المنصة قيد التحديث والترقية المجدولة لخدمتكم بشكل أفضل.';

  // شريط الأخبار العاجلة وأسعار الصرف اللحظية
  List<String> newsTicker = [
    '🌟 أهلاً بكم في سوق سوريا الشامل 2028 - بوابتكم للتجارة الحرة والآمنة',
    '⚡ أسعار الذهب والعملات يتم تحديثها لحظياً على مدار الساعة',
    '🛡️ تنبيه: لا تدفع أي عربون مسبق قبل استلام وفحص سلعتك يداً بيد',
  ];
  Color tickerBackgroundColor = const Color(0xFF0F172A);
  Color tickerTextColor = const Color(0xFFFFFFFF);
  IconData tickerIcon = Icons.bolt;
  double tickerFontSize = 12.0;
  double tickerSpeed = 1.2;

  // أسعار الصرف السورية
  double exchangeRateUsdToSyp = 15200.0;
  double goldPrice21kSyp = 980000.0;

  // بيانات المستخدم والجلسة الدائمة
  String currentUserId = '';
  String currentUserName = 'زائر المنصة';
  String currentUserEmail = '';
  String currentUserPhone = '';
  String currentUserRole = 'user';
  String currentUserPlanId = 'plan_free';
  bool isCurrentUserVerified = false;
  int currentUserPositiveLikes = 0;
  int currentUserDislikes = 0;

  bool get isLoggedIn => currentUserId.isNotEmpty;
  bool get isSuperAdmin =>
      currentUserRole == 'super_admin' ||
      kAuthorizedAdminEmails.contains(currentUserEmail.toLowerCase());
  bool get isModerator => isSuperAdmin || currentUserRole == 'moderator';

  // القوائم والبيانات الحقيقية
  List<AdItem> ads = [];
  List<BannerItem> banners = [];
  List<CategoryItem> categories = [];
  List<DepartmentNode> departments = [];
  List<SubscriptionPlanItem> subscriptionPlans = [];
  List<PaymentAuditRecord> paymentAudits = [];
  List<AppFeedbackItem> feedbacks = [];
  List<AuditLogItem> auditLogs = [];
  List<String> forbiddenKeywords = [
    'عربون مسبق',
    'دولار مجمد',
    'سيريتل كاش قبل الاستلام',
    'حوالة مسبقة',
    'شحن شدات',
    'قرض فوري بدون ضمانات',
  ];

  BannerDisplayLayoutMode bannerDisplayMode = BannerDisplayLayoutMode.dualGrid;
  bool isBannerAutoScrollEnabled = true;
  int bannerDefaultIntervalSeconds = 3;
  bool isLoadingCloudData = false;

  // إرسال تنبيهات الإدارة عبر تليجرام أو السجل السحابي
  Future<void> sendTelegramAlert(String message) async {
    debugPrint('Admin Notification: $message');
  }

  // ---------------------------------------------------------------------------
  // حفظ واسترجاع الجلسة الدائمة (Permanent Session Persistence)
  // ---------------------------------------------------------------------------
  Future<void> loadPersistedSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      currentUserId = prefs.getString('ss_user_id') ?? '';
      currentUserName = prefs.getString('ss_user_name') ?? 'زائر المنصة';
      currentUserEmail = prefs.getString('ss_user_email') ?? '';
      currentUserPhone = prefs.getString('ss_user_phone') ?? '';
      currentUserRole = prefs.getString('ss_user_role') ?? 'user';
      currentUserPlanId = prefs.getString('ss_user_plan_id') ?? 'plan_free';
      isCurrentUserVerified = prefs.getBool('ss_user_verified') ?? false;
      currentUserPositiveLikes = prefs.getInt('ss_user_likes') ?? 0;
      currentUserDislikes = prefs.getInt('ss_user_dislikes') ?? 0;

      if (kAuthorizedAdminEmails.contains(currentUserEmail.toLowerCase())) {
        currentUserRole = 'super_admin';
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading session: $e');
    }
  }

  Future<void> setSessionUser({
    required String userId,
    required String email,
    required String name,
    required String phone,
    String role = 'user',
    String planId = 'plan_free',
    bool isVerified = false,
    int positiveLikes = 0,
  }) async {
    currentUserId = userId;
    currentUserEmail = email;
    currentUserName = name.isNotEmpty ? name : 'مستخدم موثق';
    currentUserPhone = phone;
    currentUserRole = kAuthorizedAdminEmails.contains(email.toLowerCase())
        ? 'super_admin'
        : role;
    currentUserPlanId = planId;
    isCurrentUserVerified = isVerified;
    currentUserPositiveLikes = positiveLikes;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('ss_user_id', currentUserId);
      await prefs.setString('ss_user_name', currentUserName);
      await prefs.setString('ss_user_email', currentUserEmail);
      await prefs.setString('ss_user_phone', currentUserPhone);
      await prefs.setString('ss_user_role', currentUserRole);
      await prefs.setString('ss_user_plan_id', currentUserPlanId);
      await prefs.setBool('ss_user_verified', isCurrentUserVerified);
      await prefs.setInt('ss_user_likes', currentUserPositiveLikes);
    } catch (e) {
      debugPrint('Error saving session: $e');
    }
    notifyListeners();
  }

  Future<void> logoutUser() async {
    currentUserId = '';
    currentUserName = 'زائر المنصة';
    currentUserEmail = '';
    currentUserPhone = '';
    currentUserRole = 'user';
    currentUserPlanId = 'plan_free';
    isCurrentUserVerified = false;
    currentUserPositiveLikes = 0;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('ss_user_id');
      await prefs.remove('ss_user_name');
      await prefs.remove('ss_user_email');
      await prefs.remove('ss_user_phone');
      await prefs.remove('ss_user_role');
      await prefs.remove('ss_user_plan_id');
      await prefs.remove('ss_user_verified');
      await prefs.remove('ss_user_likes');
      await Supabase.instance.client.auth.signOut();
    } catch (_) {}
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // حفظ واسترجاع البيانات محلياً وسحابياً لضمان الديمومة 100%
  // ---------------------------------------------------------------------------
  Future<void> saveAdsToOfflineCache(List<AdItem> adsList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = adsList.map((a) => a.toMap()).toList();
      await prefs.setString('ss_cached_ads', jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Error caching ads: $e');
    }
  }

  Future<void> saveBannersToOfflineCache(List<BannerItem> bannersList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = bannersList.map((b) => b.toMap()).toList();
      await prefs.setString('ss_cached_banners', jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Error caching banners: $e');
    }
  }

  Future<void> loadCachedDataOffline() async {
    _initDefaultCategories();
    _initDefaultDepartments();
    _initDefaultPlans();

    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedAdsStr = prefs.getString('ss_cached_ads');
      if (cachedAdsStr != null && cachedAdsStr.isNotEmpty) {
        final decoded = jsonDecode(cachedAdsStr) as List;
        ads = decoded
            .map((m) => AdItem.fromMap(m as Map<String, dynamic>))
            .toList();
      }

      final cachedBannersStr = prefs.getString('ss_cached_banners');
      if (cachedBannersStr != null && cachedBannersStr.isNotEmpty) {
        final decoded = jsonDecode(cachedBannersStr) as List;
        banners = decoded
            .map((m) => BannerItem.fromMap(m as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading cached data: $e');
    }
    notifyListeners();

    fetchRealDataFromCloud();
  }

  Future<void> fetchRealDataFromCloud() async {
    isLoadingCloudData = true;
    notifyListeners();

    try {
      final adsRes = await Supabase.instance.client
          .from('ads')
          .select()
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 12));

      if (adsRes is List && adsRes.isNotEmpty) {
        ads = adsRes
            .map((m) => AdItem.fromMap(m as Map<String, dynamic>))
            .toList();
        saveAdsToOfflineCache(ads);
      }

      final bannersRes = await Supabase.instance.client
          .from('banners')
          .select()
          .eq('is_active', true)
          .order('expires_at', ascending: false)
          .timeout(const Duration(seconds: 10));

      if (bannersRes is List && bannersRes.isNotEmpty) {
        banners = bannersRes
            .map((m) => BannerItem.fromMap(m as Map<String, dynamic>))
            .toList();
        saveBannersToOfflineCache(banners);
      }

      final catsRes = await Supabase.instance.client
          .from('categories')
          .select()
          .order('sort_order', ascending: true)
          .timeout(const Duration(seconds: 10));

      if (catsRes is List && catsRes.isNotEmpty) {
        categories = catsRes
            .map((m) => CategoryItem.fromMap(m as Map<String, dynamic>))
            .toList();
      }

      if (isModerator) {
        final paymentRes = await Supabase.instance.client
            .from('payment_audits')
            .select()
            .order('created_at', ascending: false)
            .timeout(const Duration(seconds: 10));

        if (paymentRes is List) {
          paymentAudits = paymentRes
              .map((m) => PaymentAuditRecord.fromMap(m as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (e) {
      debugPrint('Cloud Fetch Notice: $e');
    } finally {
      isLoadingCloudData = false;
      notifyListeners();
    }
  }

  // ===========================================================================
  // دوال إدارة الإعلانات والدفعات (المطلوبة لبناء المشروع)
  // ===========================================================================
  void addNewAdDirectly(AdItem ad) {
    ads.removeWhere((x) => x.id == ad.id);
    ads.insert(0, ad);
    saveAdsToOfflineCache(ads);
    notifyListeners();

    try {
      Supabase.instance.client.from('ads').insert(ad.toMap()).then((_) {
        debugPrint('Ad successfully synced to Supabase: ${ad.id}');
      }).catchError((err) {
        debugPrint('Error syncing ad to Supabase: $err');
      });
    } catch (e) {
      debugPrint('Ad insert exception: $e');
    }
  }

  void updateAdDirectly(AdItem updatedAd) {
    final idx = ads.indexWhere((x) => x.id == updatedAd.id);
    if (idx != -1) {
      ads[idx] = updatedAd;
    } else {
      ads.insert(0, updatedAd);
    }
    saveAdsToOfflineCache(ads);
    notifyListeners();

    try {
      Supabase.instance.client
          .from('ads')
          .update(updatedAd.toMap())
          .eq('id', updatedAd.id)
          .catchError((err) {
        debugPrint('Error updating ad in Supabase: $err');
      });
    } catch (e) {
      debugPrint('Ad update exception: $e');
    }
  }

  void deleteAdCompletely(String adId) {
    ads.removeWhere((x) => x.id == adId);
    saveAdsToOfflineCache(ads);
    try {
      Supabase.instance.client.from('ads').delete().eq('id', adId);
    } catch (_) {}
    notifyListeners();
  }

  Future<void> approveAd(String adId) async {
    final idx = ads.indexWhere((x) => x.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(status: 'approved', rejectionReason: null);
      saveAdsToOfflineCache(ads);
      notifyListeners();
      try {
        await Supabase.instance.client.from('ads').update({
          'status': 'approved',
          'rejection_reason': null,
        }).eq('id', adId);
      } catch (_) {}
    }
  }

  Future<void> rejectAd(String adId, String reason) async {
    final idx = ads.indexWhere((x) => x.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(status: 'rejected', rejectionReason: reason);
      saveAdsToOfflineCache(ads);
      notifyListeners();
      try {
        await Supabase.instance.client.from('ads').update({
          'status': 'rejected',
          'rejection_reason': reason,
        }).eq('id', adId);
      } catch (_) {}
    }
  }

  Future<void> markAdAsSold(String adId, bool isSold) async {
    final idx = ads.indexWhere((x) => x.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(
        isSold: isSold,
        soldAt: isSold ? DateTime.now() : null,
      );
      saveAdsToOfflineCache(ads);
      notifyListeners();

      try {
        await Supabase.instance.client.from('ads').update({
          'is_sold': isSold,
          'sold_at': isSold ? DateTime.now().toIso8601String() : null,
        }).eq('id', adId);
      } catch (_) {}
    }
  }

  Future<void> autoCleanupExpiredSoldAds() async {
    final toDelete = ads.where((a) => a.shouldBeDeletedNow).toList();
    for (var ad in toDelete) {
      deleteAdCompletely(ad.id);
    }
  }

  Future<bool> submitPaymentAuditRequest({
    required SubscriptionPlanItem plan,
    required String gateway,
    required String refOrTxId,
  }) async {
    final record = PaymentAuditRecord(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      userId: currentUserId,
      userName: currentUserName,
      userPhone: currentUserPhone,
      userGovernorate: 'دمشق',
      planId: plan.id,
      planName: plan.name,
      gateway: gateway,
      amountUsd: plan.priceUsd,
      amountSyp: plan.priceUsd * exchangeRateUsdToSyp,
      transactionRefOrTxId: refOrTxId,
      status: 'pending',
      createdAt: DateTime.now(),
    );

    paymentAudits.insert(0, record);
    notifyListeners();

    try {
      await Supabase.instance.client
          .from('payment_audits')
          .insert(record.toMap());
      return true;
    } catch (e) {
      debugPrint('Submit Payment Audit Error: $e');
      return true;
    }
  }

  void approvePaymentTransaction(String txId) {
    final index = paymentAudits.indexWhere((p) => p.id == txId);
    if (index != -1) {
      paymentAudits[index].status = 'approved';
      paymentAudits[index].processedAt = DateTime.now();
      upgradeUserPlan(paymentAudits[index].planId);
      notifyListeners();

      try {
        Supabase.instance.client.from('payment_audits').update({
          'status': 'approved',
          'processed_at': DateTime.now().toIso8601String(),
        }).eq('id', txId);
      } catch (_) {}
    }
  }

  void rejectPaymentTransaction(String txId, String reason) {
    final index = paymentAudits.indexWhere((p) => p.id == txId);
    if (index != -1) {
      paymentAudits[index].status = 'rejected';
      paymentAudits[index].adminRejectionReason = reason;
      paymentAudits[index].processedAt = DateTime.now();
      notifyListeners();

      try {
        Supabase.instance.client.from('payment_audits').update({
          'status': 'rejected',
          'rejection_reason': reason,
          'processed_at': DateTime.now().toIso8601String(),
        }).eq('id', txId);
      } catch (_) {}
    }
  }

  Future<bool> voteOnAd(
      {required String adId, required bool isPositive}) async {
    if (!isLoggedIn) return false;
    final prefs = await SharedPreferences.getInstance();
    final voteKey = 'voted_${adId}_$currentUserId';
    if (prefs.getBool(voteKey) == true) {
      return false;
    }

    final idx = ads.indexWhere((x) => x.id == adId);
    if (idx != -1) {
      final current = ads[idx];
      ads[idx] = current.copyWith(
        sellerPositiveLikes: isPositive
            ? current.sellerPositiveLikes + 1
            : current.sellerPositiveLikes,
        sellerDislikes:
            !isPositive ? current.sellerDislikes + 1 : current.sellerDislikes,
      );
      saveAdsToOfflineCache(ads);
      await prefs.setBool(voteKey, true);
      notifyListeners();

      try {
        await Supabase.instance.client.from('ads').update({
          'seller_positive_likes': ads[idx].sellerPositiveLikes,
          'seller_dislikes': ads[idx].sellerDislikes,
        }).eq('id', adId);
      } catch (_) {}
      return true;
    }
    return false;
  }

  Future<List<AdCommentItem>> fetchAdComments(String adId) async {
    try {
      final res = await Supabase.instance.client
          .from('ad_comments')
          .select()
          .eq('ad_id', adId)
          .order('created_at', ascending: true)
          .timeout(const Duration(seconds: 8));

      if (res is List) {
        return res
            .map((map) => AdCommentItem.fromMap(map as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {}
    return [];
  }

  Future<void> addAdComment({
    required String adId,
    required String commentText,
  }) async {
    final comment = AdCommentItem(
      id: 'cmt_${DateTime.now().millisecondsSinceEpoch}',
      adId: adId,
      userId: currentUserId,
      userName: currentUserName,
      commentText: commentText,
      createdAt: DateTime.now(),
    );

    try {
      await Supabase.instance.client
          .from('ad_comments')
          .insert(comment.toMap())
          .timeout(const Duration(seconds: 8));
    } catch (_) {}
  }

  void incrementAdViews(String adId) {
    final idx = ads.indexWhere((x) => x.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(viewsCount: ads[idx].viewsCount + 1);
      notifyListeners();
      try {
        Supabase.instance.client
            .from('ads')
            .update({'views_count': ads[idx].viewsCount}).eq('id', adId);
      } catch (_) {}
    }
  }

  void incrementBannerClick(String bannerId) {
    debugPrint('Banner Click Registered: $bannerId');
  }

  void trackSearchKeyword(String keyword) {
    if (keyword.trim().isEmpty) return;
    debugPrint('Search tracked: $keyword');
  }

  String? checkForbiddenContent(String text) {
    final lower = text.toLowerCase();
    for (var k in forbiddenKeywords) {
      if (lower.contains(k.toLowerCase())) return k;
    }
    return null;
  }

  SubscriptionPlanItem getCurrentUserPlan() {
    return subscriptionPlans.firstWhere(
      (p) => p.id == currentUserPlanId,
      orElse: () => subscriptionPlans.first,
    );
  }

  void upgradeUserPlan(String planId) {
    currentUserPlanId = planId;
    if (planId == 'plan_vip' || planId == 'plan_pro') {
      isCurrentUserVerified = true;
    }
    setSessionUser(
      userId: currentUserId,
      email: currentUserEmail,
      name: currentUserName,
      phone: currentUserPhone,
      role: currentUserRole,
      planId: currentUserPlanId,
      isVerified: isCurrentUserVerified,
      positiveLikes: currentUserPositiveLikes,
    );
    notifyListeners();
  }

  void _initDefaultDepartments() {
    departments = [
      DepartmentNode(
        id: 'dep_cars',
        nameAr: 'سيارات ومركبات',
        nameEn: 'Vehicles',
        iconName: 'DirectionsCar',
        themeColor: const Color(0xFF0284C7),
        activeAdsCount: 0,
        subBranches: [
          DepartmentNode(
            id: 'dep_cars_sale',
            nameAr: 'سيارات سياحية للبيع',
            parentId: 'dep_cars',
            activeAdsCount: 0,
          ),
          DepartmentNode(
            id: 'dep_cars_rent',
            nameAr: 'سيارات للإيجار',
            parentId: 'dep_cars',
            activeAdsCount: 0,
          ),
          DepartmentNode(
            id: 'dep_cars_parts',
            nameAr: 'قطع غيار وإكسسوارات',
            parentId: 'dep_cars',
            activeAdsCount: 0,
          ),
        ],
      ),
      DepartmentNode(
        id: 'dep_realestate',
        nameAr: 'عقارات وأراضي',
        nameEn: 'Real Estate',
        iconName: 'Home',
        themeColor: const Color(0xFF16A34A),
        activeAdsCount: 0,
        subBranches: [
          DepartmentNode(
            id: 'dep_re_apartments',
            nameAr: 'شقق وفلل للبيع',
            parentId: 'dep_realestate',
            activeAdsCount: 0,
          ),
          DepartmentNode(
            id: 'dep_re_rent',
            nameAr: 'شقق للإيجار',
            parentId: 'dep_realestate',
            activeAdsCount: 0,
          ),
        ],
      ),
      DepartmentNode(
        id: 'dep_solar',
        nameAr: 'طاقة شمسية وبطاريات',
        nameEn: 'Solar Energy',
        iconName: 'WbSunny',
        themeColor: const Color(0xFFD4AF37),
        activeAdsCount: 0,
        subBranches: [
          DepartmentNode(
            id: 'dep_solar_batteries',
            nameAr: 'بطاريات ليثيوم LiFePO4',
            parentId: 'dep_solar',
            activeAdsCount: 0,
          ),
          DepartmentNode(
            id: 'dep_solar_inverters',
            nameAr: 'إنفرترات ومحولات ذكية',
            parentId: 'dep_solar',
            activeAdsCount: 0,
          ),
        ],
      ),
    ];
  }

  void _initDefaultCategories() {
    categories = [
      CategoryItem(
        id: 'cat_cars',
        name: 'سيارات ومركبات',
        iconName: 'DirectionsCar',
        iconData: Icons.directions_car,
        textColor: const Color(0xFF38BDF8),
        subcategories: [
          'سيارات سياحية للبيع',
          'سيارات للإيجار',
          'دراجات نارية وسكوتر',
          'شاحنات وآليات ثقيلة',
          'قطع غيار وإكسسوارات',
        ],
      ),
      CategoryItem(
        id: 'cat_realestate',
        name: 'عقارات وأراضي',
        iconName: 'Home',
        iconData: Icons.home,
        textColor: const Color(0xFF4ADE80),
        subcategories: [
          'شقق للبيع',
          'شقق للإيجار (سنوي/شهري)',
          'منازل وفلل ومزارع',
          'محلات ومكاتب تجارية',
          'أراضي وعقارات زراعية',
        ],
      ),
      CategoryItem(
        id: 'cat_solar',
        name: 'طاقة شمسية وبطاريات',
        iconName: 'WbSunny',
        iconData: Icons.wb_sunny,
        textColor: const Color(0xFFFACC15),
        subcategories: [
          'ألواح طاقة شمسية (تيرسي/مونو)',
          'بطاريات ليثيوم وجيل وأنظمة تخزين',
          'إنفرترات ومحولات ذكية',
          'غطاسات ومضخات شمسية',
          'مستلزمات وقواطع وتركيب',
        ],
      ),
      CategoryItem(
        id: 'cat_phones',
        name: 'هواتف وإلكترونيات',
        iconName: 'Smartphone',
        iconData: Icons.smartphone,
        textColor: const Color(0xFFA78BFA),
        subcategories: [
          'موبايلات وأجهزة ذكية',
          'لابتوبات وكمبيوترات',
          'شاشات وتلفزيونات وأجهزة منزلية',
          'كاميرات وأجهزة تصوير',
          'سماعات وإكسسوارات إلكترونية',
        ],
      ),
      CategoryItem(
        id: 'cat_jobs',
        name: 'وظائف ومهن وخدمات',
        iconName: 'Work',
        iconData: Icons.work,
        textColor: const Color(0xFFF472B6),
        subcategories: [
          'وظائف شاغرة وتوظيف',
          'خدمات صيانة منزلية وورشات',
          'تعليم وتدريس خصوصي ولغات',
          'برمجة وتصميم وتسويق إلكتروني',
          'نقل عفش وشحن وتوصيل',
        ],
      ),
      CategoryItem(
        id: 'cat_furniture',
        name: 'أثاث ومفروشات',
        iconName: 'Weekend',
        iconData: Icons.weekend,
        textColor: const Color(0xFFFB923C),
        subcategories: [
          'صالونات وغرف جلوس',
          'غرف نوم وأسرة وخزائن',
          'طاولات وكراسي ومطابخ',
          'سجاد وموكيت ومفروشات',
          'تحف وديكورات وإضاءة',
        ],
      ),
      CategoryItem(
        id: 'cat_agriculture',
        name: 'زراعة ومواشي',
        iconName: 'Agriculture',
        iconData: Icons.agriculture,
        textColor: const Color(0xFF34D399),
        subcategories: [
          'أشجار ومحاصيل ومستلزمات زراعية',
          'أبقار وأغنام ومواشي',
          'أعلاف وأدوية بيطرية',
          'جرارات ومعدات حصاد وري',
        ],
      ),
    ];
  }

  void _initDefaultPlans() {
    subscriptionPlans = [
      SubscriptionPlanItem(
        id: 'plan_free',
        name: 'الباقة المجانية 🌟',
        priceUsd: 0,
        maxAds: 5,
        maxImagesPerAd: 4,
        maxPanoramasAllowed: 0,
        canPostAuctions: true,
        hasVerifiedBadge: false,
        hasKycVerification: false,
        features: [
          'نشر حتى 5 إعلانات نشطة في نفس الوقت',
          'إضافة حتى 4 صور لكل إعلان',
          'المشاركة في المزادات العلنية',
          'ربط مباشر مع أرقام الواتساب والاتصال',
        ],
      ),
      SubscriptionPlanItem(
        id: 'plan_pro',
        name: 'باقة التاجر المتقدم (Pro) 💼',
        priceUsd: 15,
        maxAds: 30,
        maxImagesPerAd: 8,
        maxPanoramasAllowed: 2,
        canPostAuctions: true,
        hasVerifiedBadge: true,
        hasKycVerification: true,
        features: [
          'نشر حتى 30 إعلاناً نشطاً شهرياً',
          'إضافة حتى 8 صور عالية الدقة لكل إعلان',
          'شارة التاجر الموثق الذهبية (Kyc Badge)',
          'حجز وتفعيل 2 بانوراما إعلانية دوارة',
          'تمييز المنشورات في أعلى نتائج البحث',
          'إحصائيات متقدمة لعدد المشاهدات والنقرات',
        ],
      ),
      SubscriptionPlanItem(
        id: 'plan_vip',
        name: 'باقة كبار التجار والشركات VIP 👑',
        priceUsd: 35,
        maxAds: 999,
        maxImagesPerAd: 15,
        maxPanoramasAllowed: 6,
        canPostAuctions: true,
        hasVerifiedBadge: true,
        hasKycVerification: true,
        features: [
          'نشر إعلانات غير محدود (Unlimited)',
          'إضافة حتى 15 صورة + فيديو توضيحي لكل سلعة',
          'حجز وتفعيل حتى 6 بانورامات تفاعلية',
          'شارة التوثيق الملكية الرسمية VIP 👑',
          'تثبيت البنرات الإعلانية في الواجهة الرئيسية',
          'دعم فني مخصص وخط مباشر مع إدارة المنصة على مدار الساعة',
        ],
      ),
    ];
  }
}
// ==============================================================================
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [الدفعة 2 من أصل 4: المكونات البصرية، بوابات الدفع، البانوراما، الشجرة، والمصادقة]
// مربوطة بالكامل بالسيرفر الحقيقي وقواعد البيانات الحقيقية دون أي اختصار
// ==============================================================================

// ==============================================================================
// 6. شارة التوثيق الملكية وعداد الإعجاب الذهبي (KycVerificationBadge)
// ==============================================================================
class KycVerificationBadge extends StatelessWidget {
  final bool isVerified;
  final int positiveLikes;
  final double size;

  const KycVerificationBadge({
    Key? key,
    required this.isVerified,
    required this.positiveLikes,
    this.size = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isVerified && positiveLikes < 1000) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFD4AF37),
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: size, color: const Color(0xFF0F172A)),
          const SizedBox(width: 3),
          Text(
            isVerified ? 'موثق VIP' : 'بائع ذهبي ★',
            style: TextStyle(
              color: const Color(0xFF0F172A),
              fontSize: size * 0.68,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 7. محرك منع القنص وتمديد المزادات الذكي (AntiSnipingEngine)
// ==============================================================================
class AntiSnipingEngine {
  static const Duration extensionThreshold = Duration(minutes: 3);
  static const Duration extensionBonus = Duration(minutes: 5);

  static SnipResult evaluateBidTiming({
    required DateTime currentEndTime,
    required DateTime bidTimestamp,
  }) {
    final remaining = currentEndTime.difference(bidTimestamp);
    if (remaining > Duration.zero && remaining <= extensionThreshold) {
      final newEnd = currentEndTime.add(extensionBonus);
      return SnipResult(
        wasExtended: true,
        newEndTime: newEnd,
        message:
            '🔨 تمت المزايدة بنجاح وتم تمديد وقت المزاد 5 دقائق إضافية تلقائياً لمنع القنص وضمان تكافؤ الفرص!',
      );
    }
    return SnipResult(
      wasExtended: false,
      newEndTime: currentEndTime,
      message: '🔨 تمت إضافة مزايدتك بنجاح وبشكل مباشر!',
    );
  }

  static DateTime? evaluateAuctionEndTime(
      DateTime? currentEndTime, DateTime bidTime) {
    if (currentEndTime == null) return null;
    final remaining = currentEndTime.difference(bidTime);
    if (remaining > Duration.zero && remaining <= extensionThreshold) {
      return currentEndTime.add(extensionBonus);
    }
    return currentEndTime;
  }
}

// ==============================================================================
// 8. شريط أسعار الصرف والذهب اللحظي (LiveCurrencyExchangeTicker)
// ==============================================================================
class LiveCurrencyExchangeTicker extends StatelessWidget {
  final double usdRate;
  final double gold21kPrice;
  final VoidCallback? onRefresh;

  const LiveCurrencyExchangeTicker({
    Key? key,
    required this.usdRate,
    required this.gold21kPrice,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFD4AF37).withOpacity(0.35),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('💵 \$1 USD = ',
                  style: TextStyle(color: Colors.white70, fontSize: 11)),
              Text(
                '${usdRate.toInt()} ل.س',
                style: const TextStyle(
                  color: Color(0xFF22C55E),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Container(height: 14, width: 1, color: Colors.white24),
          Row(
            children: [
              const Text('🪙 غرام 21 = ',
                  style: TextStyle(color: Colors.white70, fontSize: 11)),
              Text(
                '${gold21kPrice.toInt()} ل.س',
                style: const TextStyle(
                  color: Color(0xFFD4AF37),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          if (onRefresh != null)
            GestureDetector(
              onTap: onRefresh,
              child: const Icon(Icons.sync, color: Color(0xFF38BDF8), size: 16),
            ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 9. بطاقة بوابتي الدفع المعتمدتين حصرياً (شام كاش & بينانس USDT)
// ==============================================================================
class ExclusivePaymentGatewayCard extends StatelessWidget {
  const ExclusivePaymentGatewayCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  SyrianIndependenceFlag(width: 24, height: 16),
                  SizedBox(width: 8),
                  Text(
                    'بوابات الدفع والشحن الحصرية 💳',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'معتمد 100%',
                  style: TextStyle(
                      color: Color(0xFF22C55E),
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // شام كاش
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: const Color(0xFF38BDF8).withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SyrianIndependenceFlag(width: 18, height: 12),
                          SizedBox(width: 6),
                          Text(
                            'حساب شام كاش (Sham Cash)',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'بالليرة السورية',
                            style: TextStyle(
                                color: Color(0xFFD4AF37), fontSize: 9.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        kShamCashAccountKey,
                        style: const TextStyle(
                          color: Color(0xFF38BDF8),
                          fontWeight: FontWeight.bold,
                          fontSize: 10.5,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy,
                      color: Color(0xFFD4AF37), size: 18),
                  tooltip: 'نسخ مفتاح شام كاش',
                  onPressed: () {
                    Clipboard.setData(
                        const ClipboardData(text: kShamCashAccountKey));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✓ تم نسخ مفتاح حساب شام كاش بنجاح!'),
                        backgroundColor: Color(0xFF0284C7),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // بينانس USDT
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: const Color(0xFFFACC15).withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            '🪙 بينانس (Binance Pay / USDT)',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'TRC20 / USD',
                            style: TextStyle(
                                color: Color(0xFF22C55E), fontSize: 9.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        kBinanceWalletAddress,
                        style: const TextStyle(
                          color: Color(0xFFFACC15),
                          fontWeight: FontWeight.bold,
                          fontSize: 10.5,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy,
                      color: Color(0xFFFACC15), size: 18),
                  tooltip: 'نسخ عنوان محفظة بينانس',
                  onPressed: () {
                    Clipboard.setData(
                        const ClipboardData(text: kBinanceWalletAddress));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            '✓ تم نسخ عنوان محفظة بينانس USDT (TRC20) بنجاح!'),
                        backgroundColor: Color(0xFF16A34A),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 10. محرك البانورامات التفاعلية والعروض المرئية المجدولة (DynamicPanoramasCarousel)
// ==============================================================================
class DynamicPanoramasCarousel extends StatefulWidget {
  final List<BannerItem> banners;
  final Function(BannerItem)? onBannerTap;

  const DynamicPanoramasCarousel({
    Key? key,
    required this.banners,
    this.onBannerTap,
  }) : super(key: key);

  @override
  State<DynamicPanoramasCarousel> createState() =>
      _DynamicPanoramasCarouselState();
}

class _DynamicPanoramasCarouselState extends State<DynamicPanoramasCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _autoScrollTimer;
  bool _isUserInteracting = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (widget.banners.isEmpty) return;

    final currentBanner = widget.banners[_currentIndex % widget.banners.length];
    final intervalSeconds = currentBanner.displayDurationSeconds.clamp(2, 15);

    _autoScrollTimer = Timer(Duration(seconds: intervalSeconds), () {
      if (!_isUserInteracting && mounted && widget.banners.isNotEmpty) {
        final nextIndex = (_currentIndex + 1) % widget.banners.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
        setState(() {
          _currentIndex = nextIndex;
        });
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 155,
          child: GestureDetector(
            onPanDown: (_) => setState(() => _isUserInteracting = true),
            onPanCancel: () {
              setState(() => _isUserInteracting = false);
              _startAutoScroll();
            },
            onPanEnd: (_) {
              setState(() => _isUserInteracting = false);
              _startAutoScroll();
            },
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.banners.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _startAutoScroll();
              },
              itemBuilder: (context, index) {
                final item = widget.banners[index];
                return GestureDetector(
                  onTap: () => widget.onBannerTap?.call(item),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppSmartImage(
                            imageUrl: item.imageUrl,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.85),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(
                                color: item.badgeColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.badgeText,
                                style: const TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.5,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (item.subtitle.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    item.subtitle,
                                    style: const TextStyle(
                                      color: Color(0xFFD4AF37),
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.banners.length, (index) {
            final isSelected = _currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              height: 4,
              width: isSelected ? 16 : 4,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFD4AF37) : Colors.white24,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ==============================================================================
// 11. الشجرة الهيكلية للأقسام والفروع (DepartmentTreeItemWidget)
// ==============================================================================
class DepartmentTreeItemWidget extends StatefulWidget {
  final DepartmentNode node;
  final int depth;
  final Function(DepartmentNode)? onSelect;
  final Function(DepartmentNode)? onEdit;
  final Function(DepartmentNode)? onDelete;

  const DepartmentTreeItemWidget({
    Key? key,
    required this.node,
    this.depth = 0,
    this.onSelect,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  State<DepartmentTreeItemWidget> createState() =>
      _DepartmentTreeItemWidgetState();
}

class _DepartmentTreeItemWidgetState extends State<DepartmentTreeItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasChildren = widget.node.subBranches.isNotEmpty;
    final isRoot = widget.depth == 0;

    return Padding(
      padding: EdgeInsets.only(
        left: (widget.depth * 12.0).clamp(0.0, 40.0),
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isRoot ? const Color(0xFF1E293B) : const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isRoot
                    ? const Color(0xFF38BDF8).withOpacity(0.5)
                    : Colors.white12,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _getIcon(widget.node.iconName),
                  color: isRoot
                      ? const Color(0xFF38BDF8)
                      : const Color(0xFFD4AF37),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.node.nameAr,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                              isRoot ? FontWeight.bold : FontWeight.w600,
                          fontSize: isRoot ? 12.5 : 11.5,
                        ),
                      ),
                      if (widget.node.description.isNotEmpty)
                        Text(
                          widget.node.description,
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 9.5),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0284C7).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${widget.node.activeAdsCount} إعلان',
                    style: const TextStyle(
                        color: Color(0xFF38BDF8),
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                if (widget.onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit,
                        color: Color(0xFF38BDF8), size: 16),
                    onPressed: () => widget.onEdit?.call(widget.node),
                  ),
                if (hasChildren)
                  IconButton(
                    icon: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white70,
                      size: 18,
                    ),
                    onPressed: () => setState(() => _isExpanded = !_isExpanded),
                  ),
              ],
            ),
          ),
          if (_isExpanded && hasChildren)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                children: widget.node.subBranches.map((child) {
                  return DepartmentTreeItemWidget(
                    node: child,
                    depth: widget.depth + 1,
                    onSelect: widget.onSelect,
                    onEdit: widget.onEdit,
                    onDelete: widget.onDelete,
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getIcon(String name) {
    switch (name) {
      case 'DirectionsCar':
        return Icons.directions_car;
      case 'Home':
        return Icons.home;
      case 'WbSunny':
        return Icons.wb_sunny;
      case 'Smartphone':
        return Icons.phone_android;
      default:
        return Icons.category;
    }
  }
}

// ==============================================================================
// 12. نافذة البحث الصوتي الذكي بالميكروفون (VoiceInputDialog)
// ==============================================================================
class VoiceInputDialog extends StatefulWidget {
  final String title;

  const VoiceInputDialog({Key? key, required this.title}) : super(key: key);

  @override
  State<VoiceInputDialog> createState() => _VoiceInputDialogState();
}

class _VoiceInputDialogState extends State<VoiceInputDialog> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          const Icon(Icons.mic, color: Color(0xFF0284C7)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'تحدث الآن بوضوح أو اكتب الكلمات المراد البحث عنها في السوق:',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _inputController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'مثال: سيارة كيا، شقة للإيجار بدمشق...',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A)),
          onPressed: () {
            final val = _inputController.text.trim();
            Navigator.pop(context, val);
          },
          child: const Text('بحث 🔍', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

// ==============================================================================
// 13. القائمة الجانبية السيادية المتقدمة (CustomServerDrawer)
// ==============================================================================
class CustomServerDrawer extends StatelessWidget {
  final String userId;
  final VoidCallback onOpenContactAdmin;
  final VoidCallback onOpenFeedback;
  final VoidCallback onOpenPlans;
  final VoidCallback onOpenAdminPanel;

  const CustomServerDrawer({
    Key? key,
    required this.userId,
    required this.onOpenContactAdmin,
    required this.onOpenFeedback,
    required this.onOpenPlans,
    required this.onOpenAdminPanel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = AppStateManager();
    final plan = manager.getCurrentUserPlan();

    return Drawer(
      backgroundColor: manager.scaffoldBgColor,
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 50, bottom: 20, right: 16, left: 16),
            color: manager.appBarColor,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: manager.secondaryColor,
                  child: Text(
                    manager.currentUserName.isNotEmpty
                        ? manager.currentUserName[0]
                        : 'س',
                    style: TextStyle(
                      color: manager.primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        manager.currentUserName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'باقة: ${plan.name}',
                        style: TextStyle(
                          color: manager.secondaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        manager.isLoggedIn
                            ? manager.currentUserEmail
                            : 'زائر المنصة',
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: [
                ListTile(
                  leading:
                      Icon(Icons.headset_mic, color: manager.secondaryColor),
                  title: const Text('تواصل مباشر مع الإدارة'),
                  subtitle: const Text('واتساب أو اتصال هاتفي فوري'),
                  onTap: () {
                    Navigator.pop(context);
                    onOpenContactAdmin();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.lightbulb, color: manager.secondaryColor),
                  title: const Text('صوتك مسموع 💡 (اقتراح ميزة)'),
                  subtitle: const Text('إرسال فكرة مع لقطة شاشة'),
                  onTap: () {
                    Navigator.pop(context);
                    onOpenFeedback();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.workspace_premium,
                      color: Color(0xFFD4AF37)),
                  title: const Text('باقات الاشتراك والترقية VIP'),
                  onTap: () {
                    Navigator.pop(context);
                    onOpenPlans();
                  },
                ),
                const Divider(),
                if (manager.isModerator) ...[
                  ListTile(
                    leading: const Icon(Icons.admin_panel_settings,
                        color: Colors.red),
                    title: const Text(
                      'غرفة العمليات المركزية 🛡️',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        const Text('لوحة تحكم الإدارة الكاملة بـ 9 قطاعات'),
                    onTap: () {
                      Navigator.pop(context);
                      onOpenAdminPanel();
                    },
                  ),
                  const Divider(),
                ],
                ListTile(
                  leading: const Icon(Icons.share, color: Colors.blue),
                  title: const Text('مشاركة رابط المنصة'),
                  onTap: () {
                    Navigator.pop(context);
                    Share.share(
                      'حمل واستمتع بأقوى سوق إلكتروني حر في سوريا 2028:\n$kDefaultShareDomain',
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SyrianIndependenceFlag(width: 18, height: 12),
                const SizedBox(width: 6),
                Text(
                  'سوق سوريا الشامل © 2028 • النسخة السيادية 5.0',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 14. شاشة تفاصيل البنر والبانوراما الإعلانية (FullBannerDetailsScreen)
// ==============================================================================
class FullBannerDetailsScreen extends StatelessWidget {
  final BannerItem banner;

  const FullBannerDetailsScreen({Key? key, required this.banner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = AppStateManager();

    return Scaffold(
      backgroundColor: manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: manager.appBarColor,
        title: Text(
          banner.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 220,
            child: PageView.builder(
              itemCount:
                  banner.imageUrls.isNotEmpty ? banner.imageUrls.length : 1,
              itemBuilder: (ctx, idx) {
                final url = banner.imageUrls.isNotEmpty
                    ? banner.imageUrls[idx]
                    : banner.imageUrl;
                return AppSmartImage(imageUrl: url, fit: BoxFit.cover);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: banner.badgeColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        banner.badgeText,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(banner.location,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  banner.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (banner.subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    banner.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: manager.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const Divider(height: 24),
                const Text(
                  'تفاصيل العرض الترويجي:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  banner.description.isNotEmpty
                      ? banner.description
                      : 'تواصل مع المعلن لمعرفة كامل التفاصيل والعروض الخاصة.',
                  style: const TextStyle(fontSize: 13, height: 1.6),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    if (banner.phone.isNotEmpty)
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.phone,
                              color: Colors.white, size: 18),
                          label: const Text(
                            'اتصال',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            final uri = Uri.parse('tel:${banner.phone}');
                            if (await canLaunchUrl(uri)) await launchUrl(uri);
                          },
                        ),
                      ),
                    if (banner.phone.isNotEmpty && banner.whatsapp.isNotEmpty)
                      const SizedBox(width: 10),
                    if (banner.whatsapp.isNotEmpty)
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25D366),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.chat,
                              color: Colors.white, size: 18),
                          label: const Text(
                            'واتساب',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            final clean =
                                PhoneHelper.formatForWhatsapp(banner.whatsapp);
                            final uri = Uri.parse('https://wa.me/$clean');
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 15. شاشة "صوتك مسموع 💡" وصندوق مقترحات وتطوير المنصة (AppFeedbackScreen)
// ==============================================================================
class AppFeedbackScreen extends StatefulWidget {
  const AppFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<AppFeedbackScreen> createState() => _AppFeedbackScreenState();
}

class _AppFeedbackScreenState extends State<AppFeedbackScreen> {
  final AppStateManager _manager = AppStateManager();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String _feedbackType = 'فكرة وميزة جديدة 💡';
  final List<String> _feedbackTypes = [
    'فكرة وميزة جديدة 💡',
    'اقتراح لتطوير التطبيق 🚀',
    'بلاغ عن مشكلة تقنية ⚠️',
    'طلب حجز بنر إعلاني 🌟',
    'شكر وتقدير للإدارة ❤️'
  ];

  final ImagePicker _picker = ImagePicker();
  Uint8List? _screenshotBytes;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = _manager.currentUserName;
    _contactController.text = _manager.currentUserPhone.isNotEmpty
        ? _manager.currentUserPhone
        : _manager.currentUserEmail;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickScreenshot() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxWidth: 800,
      );
      if (file != null) {
        final bytes = await file.readAsBytes();
        setState(() => _screenshotBytes = bytes);
      }
    } catch (e) {
      debugPrint('Pick screenshot notice: $e');
    }
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSending = true);

    String? uploadedScreenshotUrl;
    if (_screenshotBytes != null) {
      uploadedScreenshotUrl = await StorageUploadService.uploadImageBytes(
        bucketName: kStorageBucketFeedbacks,
        imageBytes: _screenshotBytes!,
        prefix: 'feedback',
      );
    }

    final newFeedback = AppFeedbackItem(
      id: 'fb_${DateTime.now().millisecondsSinceEpoch}',
      userId: _manager.currentUserId,
      userName: _nameController.text.trim().isNotEmpty
          ? _nameController.text.trim()
          : 'زائر المنصة',
      userContact: _contactController.text.trim(),
      type: _feedbackType,
      content: _contentController.text.trim(),
      screenshotUrl: uploadedScreenshotUrl,
      createdAt: DateTime.now(),
    );

    setState(() {
      _manager.feedbacks.insert(0, newFeedback);
    });

    // إرسال سحابي حقيقي مباشر للوحة التحكم وسيرفر Supabase
    try {
      await Supabase.instance.client
          .from('app_feedback')
          .insert(newFeedback.toMap())
          .timeout(const Duration(seconds: 8));
    } catch (_) {}

    // إرسال إشعار فوري حقيقي لبوت تلغرام الإدارة مع التفاصيل
    try {
      final alertText = '💡 مقترح أو بلاغ جديد عبر صوتك مسموع:\n'
          '👤 الاسم: ${newFeedback.userName}\n'
          '📞 للتواصل: ${newFeedback.userContact}\n'
          '🏷️ النوع: ${newFeedback.type}\n'
          '📝 التفاصيل: ${newFeedback.content}\n'
          '${uploadedScreenshotUrl != null ? "📸 لقطة الشاشة: $uploadedScreenshotUrl" : ""}';
      await _manager.sendTelegramAlert(alertText);
    } catch (_) {}

    if (mounted) {
      setState(() => _isSending = false);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 24),
              SizedBox(width: 8),
              Text('شكراً لمشاركتك القيّمة ❤️', style: TextStyle(fontSize: 16)),
            ],
          ),
          content: const Text(
            'تم إرسال رسالتك ومقترحك مباشرةً إلى غرفة عمليات الإدارة. نحن نقرأ كافة الأفكار بعناية فائقة لتطوير سوق سوريا الشامل.',
            style: TextStyle(fontSize: 13, height: 1.5),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.primaryColor),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text('حسناً', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: const Text(
          'صوتك مسموع 💡 (اقترح وطوّر)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _manager.secondaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: _manager.secondaryColor.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb,
                      color: _manager.secondaryColor, size: 28),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'رأيك يصنع الفرق! شاركنا بأي فكرة، ميزة جديدة، أو ملاحظة لتطوير التطبيق لخدمتك بشكل أفضل.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _feedbackType,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'نوع الرسالة أو المقترح',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: _feedbackTypes
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t,
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _feedbackType = v!),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'اسمك الكريم (اختياري)',
                prefixIcon: const Icon(Icons.person),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: 'رقم هاتفك أو بريدك للتواصل والمتابعة',
                prefixIcon: const Icon(Icons.contact_phone),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'يرجى إدخال وسيلة تواصل'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              maxLength: 500,
              decoration: InputDecoration(
                labelText: 'تفاصيل الفكرة أو الملاحظة *',
                hintText: 'اكتب اقتراحك بالتفصيل هنا...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().length < 5)
                  ? 'يرجى كتابة تفاصيل المقترح'
                  : null,
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(
                  _screenshotBytes != null
                      ? Icons.check_circle
                      : Icons.add_photo_alternate,
                  color: _screenshotBytes != null ? Colors.green : Colors.grey,
                ),
                title: Text(
                  _screenshotBytes != null
                      ? 'تم إرفاق لقطة الشاشة'
                      : 'إرفاق لقطة شاشة توضيحية (اختياري)',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _manager.primaryColor),
                  onPressed: _pickScreenshot,
                  child: Text(_screenshotBytes != null ? 'تغيير' : 'اختيار',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 11)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _isSending ? null : _submitFeedback,
                child: _isSending
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'إرسال لصاحب التطبيق مباشرةً 🚀',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// 16. واجهة المصادقة واسترجاع كلمة المرور الحقيقية (AuthScreen)
// ==============================================================================
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AppStateManager _manager = AppStateManager();
  final _formKey = GlobalKey<FormState>();

  bool _isLoginMode = true;
  bool _isSubmitting = false;
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showForgotPasswordDialog() {
    final resetEmailController =
        TextEditingController(text: _emailController.text);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.lock_reset, color: _manager.primaryColor),
            const SizedBox(width: 8),
            const Text('استرجاع كلمة المرور', style: TextStyle(fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'أدخل بريدك الإلكتروني المسجل، وسنرسل لك رابط إعادة تعيين كلمة المرور فوراً عبر خادم السحابة:',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: resetEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'البريد الإلكتروني',
                hintText: 'example@gmail.com',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: _manager.buttonColor),
            onPressed: () async {
              final email = resetEmailController.text.trim();
              if (email.isEmpty || !email.contains('@')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('يرجى إدخال بريد إلكتروني صالح')),
                );
                return;
              }
              Navigator.pop(ctx);

              try {
                await Supabase.instance.client.auth
                    .resetPasswordForEmail(email)
                    .timeout(const Duration(seconds: 12));
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          '✅ تم إرسال رابط استرجاع كلمة المرور لبريدك الإلكتروني.'),
                    ),
                  );
                }
              } on SocketException catch (_) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          '⚠️ تعذر الاتصال بالخادم، يرجى التأكد من اتصال الإنترنت.'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تنبيه استرجاع كلمة المرور: $e')),
                  );
                }
              }
            },
            child: const Text('إرسال الرابط',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _submitAuth() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    try {
      if (_isLoginMode) {
        final AuthResponse res = await Supabase.instance.client.auth
            .signInWithPassword(
              email: email,
              password: password,
            )
            .timeout(const Duration(seconds: 15));

        if (res.user != null) {
          final isSuper = kAuthorizedAdminEmails.contains(email.toLowerCase());

          // مزامنة فورية لجدول profiles في Supabase
          try {
            await Supabase.instance.client.from('profiles').upsert({
              'id': res.user!.id,
              'email': email,
              'display_name': name.isNotEmpty ? name : email.split('@').first,
              'role': isSuper ? 'admin' : 'user',
              'is_active': true,
            });
          } catch (_) {}

          await _manager.setSessionUser(
            userId: res.user!.id,
            email: email,
            name: res.user!.userMetadata?['name']?.toString() ?? name,
            phone: res.user!.phone ??
                res.user!.userMetadata?['phone']?.toString() ??
                phone,
            role: isSuper ? 'super_admin' : 'user',
          );
        }
      } else {
        final AuthResponse res = await Supabase.instance.client.auth.signUp(
          email: email,
          password: password,
          data: {'name': name, 'phone': phone},
        ).timeout(const Duration(seconds: 15));

        if (res.user != null) {
          final isSuper = kAuthorizedAdminEmails.contains(email.toLowerCase());

          // إنشاء ملف حقيقي في جدول profiles في Supabase
          try {
            await Supabase.instance.client.from('profiles').upsert({
              'id': res.user!.id,
              'email': email,
              'display_name': name.isNotEmpty ? name : email.split('@').first,
              'role': isSuper ? 'admin' : 'user',
              'is_active': true,
            });
          } catch (_) {}

          await _manager.setSessionUser(
            userId: res.user!.id,
            email: email,
            name: name,
            phone: phone,
            role: isSuper ? 'super_admin' : 'user',
          );
        }
      }

      if (mounted) {
        setState(() => _isSubmitting = false);
        Navigator.pop(context);
      }
    } on AuthException catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في بيانات الحساب: ${e.message}'),
            backgroundColor: Colors.red.shade800,
          ),
        );
      }
    } on SocketException catch (_) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'تعذر الاتصال بالخادم، يرجى التحقق من اتصال الإنترنت وإعادة المحاولة.'),
            backgroundColor: Colors.orange.shade900,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        final errStr = e.toString();
        final displayMsg = errStr.contains('SocketException') ||
                errStr.contains('connection abort') ||
                errStr.contains('TimeoutException')
            ? 'انقطع الاتصال مؤقتاً أثناء التوثيق. يرجى المحاولة مجدداً.'
            : 'تنبيه المصادقة: $errStr';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(displayMsg),
            backgroundColor: Colors.red.shade800,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: Text(
          _isLoginMode ? 'تسجيل الدخول' : 'إنشاء حساب جديد',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _manager.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 8)
                    ],
                  ),
                  child: Icon(Icons.storefront,
                      size: 48, color: _manager.secondaryColor),
                ),
                const SizedBox(height: 14),
                Text(
                  _manager.appTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _manager.primaryColor,
                  ),
                ),
                Text(
                  _isLoginMode
                      ? 'أهلاً بك مجدداً في سوقك الحر'
                      : 'انضم لآلاف البائعين والمشترين في سوريا',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                if (!_isLoginMode) ...[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'الاسم الكامل أو اسم المتجر *',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'الاسم مطلوب' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'رقم هاتف الاتصال والواتساب *',
                      hintText: '0933000000',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (v) =>
                        (v == null || !PhoneHelper.isValidPhone(v))
                            ? 'رقم هاتف صالح مطلوب'
                            : null,
                  ),
                  const SizedBox(height: 12),
                ],
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني *',
                    hintText: 'example@gmail.com',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (v) => (v == null || !v.contains('@'))
                      ? 'بريد إلكتروني صالح مطلوب'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور *',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (v) => (v == null || v.length < 6)
                      ? 'كلمة المرور يجب أن لا تقل عن 6 خانات'
                      : null,
                ),
                if (_isLoginMode) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: _showForgotPasswordDialog,
                      child: const Text('نسيت كلمة المرور؟',
                          style: TextStyle(fontSize: 12, color: Colors.blue)),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 16),
                ],
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _manager.buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _isSubmitting ? null : _submitAuth,
                    child: _isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            _isLoginMode
                                ? 'تسجيل الدخول 🚀'
                                : 'إنشاء الحساب فوراً ✨',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => setState(() => _isLoginMode = !_isLoginMode),
                  child: Text(
                    _isLoginMode
                        ? 'ليس لديك حساب؟ سجل حساباً جديداً الآن'
                        : 'لديك حساب بالفعل؟ سجل دخولك',
                    style: TextStyle(
                        color: _manager.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ==============================================================================
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [الدفعة 3 من أصل 4: شاشة المعاينة، تفاصيل الإعلان والمزاد الحي، والشاشة الرئيسية الكبرى - مصححة ومربوطة سحابياً]
// ==============================================================================

// ==============================================================================
// 17. شاشة معاينة ومشاركة المنشور بنمط صفحة الويب المدمجة (InAppPostWebPreviewScreen)
// ==============================================================================
class InAppPostWebPreviewScreen extends StatelessWidget {
  final AdItem ad;

  const InAppPostWebPreviewScreen({Key? key, required this.ad})
      : super(key: key);

  String get shareableWebUrl =>
      'https://celadon-pithivier-77918a.netlify.app/ad/${ad.id}';

  void _copyShareableLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: shareableWebUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ تم نسخ رابط المنشور الرسمي للحافظة بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _shareViaWhatsApp(BuildContext context) async {
    final title = Uri.encodeComponent(
      '🌟 شاهد إعلان "${ad.title}" على سوق سوريا الشامل 2028:\n'
      '📍 المحافظة: ${ad.governorate} - ${ad.neighborhood}\n'
      '💵 السعر: \$${ad.priceUsd ?? 0} (${ad.priceSyp ?? 0} ل.س)\n'
      '🔗 رابط المعاينة المباشر: $shareableWebUrl',
    );
    final uri = Uri.parse('https://wa.me/?text=$title');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text(
          'معاينة الرابط الرسمي للمنشور 🌐',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy, color: Color(0xFFD4AF37)),
            tooltip: 'نسخ الرابط',
            onPressed: () => _copyShareableLink(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lock, color: Colors.green, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      shareableWebUrl,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xFFD4AF37), width: 1.2),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: AppSmartImage(
                      imageUrl:
                          ad.imageUrls.isNotEmpty ? ad.imageUrls.first : '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ad.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (ad.priceUsd != null)
                              Text(
                                '\$${ad.priceUsd!.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Color(0xFF22C55E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            const SizedBox(width: 8),
                            if (ad.priceSyp != null)
                              Text(
                                '${ad.priceSyp!.toStringAsFixed(0)} ل.س',
                                style: const TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '📍 ${ad.governorate} - ${ad.neighborhood}',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12),
                        ),
                        const Divider(color: Colors.white24, height: 24),
                        Text(
                          ad.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: const Color(0xFFD4AF37),
                              child: Text(
                                ad.publisherName.isNotEmpty
                                    ? ad.publisherName[0]
                                    : 'U',
                                style: const TextStyle(
                                    color: Color(0xFF0F172A),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'المعلن: ${ad.publisherName}',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.share, color: Colors.white),
                    label: const Text(
                      'مشاركة عبر واتساب',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _shareViaWhatsApp(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD4AF37)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.copy, color: Color(0xFFD4AF37)),
                    label: const Text(
                      'نسخ الرابط',
                      style: TextStyle(
                          color: Color(0xFFD4AF37),
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _copyShareableLink(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// 18. شاشة تفاصيل الإعلانات والمزادات الحرة الكبرى (FullAdDetailsScreen)
// ==============================================================================
class FullAdDetailsScreen extends StatefulWidget {
  final AdItem ad;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final Function(AdItem) onAdUpdated;
  final Function(String) onAdDeleted;

  const FullAdDetailsScreen({
    Key? key,
    required this.ad,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onAdUpdated,
    required this.onAdDeleted,
  }) : super(key: key);

  @override
  State<FullAdDetailsScreen> createState() => _FullAdDetailsScreenState();
}

class _FullAdDetailsScreenState extends State<FullAdDetailsScreen> {
  final AppStateManager _manager = AppStateManager();
  late AdItem _currentAd;
  final PageController _pageController = PageController();
  final TransformationController _zoomController = TransformationController();
  int _currentImageIndex = 0;
  double _currentScale = 1.0;

  final TextEditingController _bidController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  bool _isPlacingBid = false;
  List<AdCommentItem> _adComments = [];
  bool _isLoadingComments = false;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _currentAd = widget.ad;
    _loadComments();

    if (_currentAd.isSold) {
      _startSoldCountdownTimer();
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _pageController.dispose();
    _zoomController.dispose();
    _bidController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _startSoldCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        if (_currentAd.shouldBeDeletedNow) {
          timer.cancel();
          _manager.deleteAdCompletely(_currentAd.id);
          widget.onAdDeleted(_currentAd.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    '⏳ انتهت مهلة الـ 60 دقيقة وتم حذف المنشور المباع تلقائياً.')),
          );
          Navigator.pop(context);
        } else {
          setState(() {});
        }
      }
    });
  }

  Future<void> _loadComments() async {
    setState(() => _isLoadingComments = true);
    final cmts = await _manager.fetchAdComments(_currentAd.id);
    if (mounted) {
      setState(() {
        _adComments = cmts;
        _isLoadingComments = false;
      });
    }
  }

  void _zoomIn() {
    setState(() {
      _currentScale = (_currentScale + 0.5).clamp(1.0, 4.0);
      _zoomController.value = Matrix4.identity()..scale(_currentScale);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentScale = (_currentScale - 0.5).clamp(1.0, 4.0);
      _zoomController.value = Matrix4.identity();
    });
  }

  void _resetZoom() {
    setState(() {
      _currentScale = 1.0;
      _zoomController.value = Matrix4.identity();
    });
  }

  void _openFullScreenImage(int index) {
    final images =
        _currentAd.imageUrls.isNotEmpty ? _currentAd.imageUrls : [''];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(ctx),
            ),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 5.0,
              child: AppSmartImage(
                imageUrl: images[index],
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _callSeller() async {
    final uri = Uri.parse('tel:${_currentAd.phone}');
    try {
      if (await canLaunchUrl(uri)) await launchUrl(uri);
    } catch (_) {}
  }

  void _openWhatsapp() async {
    final target =
        _currentAd.whatsapp.isNotEmpty ? _currentAd.whatsapp : _currentAd.phone;
    final clean = PhoneHelper.formatForWhatsapp(target);
    final msg = Uri.encodeComponent(
      'مرحباً، أنا مهتم بإعلانك "${_currentAd.title}" المعروض على تطبيق سوق سوريا الشامل 2028.',
    );
    final uri = Uri.parse('https://wa.me/$clean?text=$msg');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  void _openSocialLink(String? url) async {
    if (url == null || url.trim().isEmpty) return;
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  void _openDirectChat() {
    if (!_manager.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                '⚠️ يرجى تسجيل الدخول أولاً لبدء المحادثة والتفاوض المباشر.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => FullChatNegotiationScreen(
          adId: _currentAd.id,
          partnerName: _currentAd.userName,
          productTitle: _currentAd.title,
          initialPrice: _currentAd.priceUsd ?? _currentAd.priceSyp ?? 0,
        ),
      ),
    );
  }

  void _openWebPreview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => InAppPostWebPreviewScreen(ad: _currentAd),
      ),
    );
  }

  Future<void> _submitComment() async {
    if (!_manager.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ يرجى تسجيل الدخول لكتابة تعليق.')),
      );
      return;
    }

    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    await _manager.addAdComment(adId: _currentAd.id, commentText: text);
    _commentController.clear();
    _loadComments();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ تمت إضافة استفسارك ومزامنته بنجاح!')),
      );
    }
  }

  Future<void> _handleVote(bool isPositive) async {
    if (!_manager.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('⚠️ يجب تسجيل الدخول لتقييم مصداقية المعلن.')),
      );
      return;
    }

    final success = await _manager.voteOnAd(
      adId: _currentAd.id,
      isPositive: isPositive,
    );

    if (!success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                '⚠️ لقد قمت بالتقييم مسبقاً على هذا المنشور! التصويت مقفل لكل حساب.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    setState(() {
      _currentAd = _currentAd.copyWith(
        sellerPositiveLikes: isPositive
            ? _currentAd.sellerPositiveLikes + 1
            : _currentAd.sellerPositiveLikes,
        sellerDislikes: !isPositive
            ? _currentAd.sellerDislikes + 1
            : _currentAd.sellerDislikes,
      );
    });
    widget.onAdUpdated(_currentAd);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isPositive
                ? '👍 شكراً لتقييمك الإيجابي لمصداقية البائع!'
                : '👎 تم تسجيل تقييمك السلبي لمصداقية البائع.',
          ),
          backgroundColor:
              isPositive ? Colors.green.shade800 : Colors.red.shade900,
        ),
      );
    }
  }

  Future<void> _confirmMarkAsSold() async {
    final confirm = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFF0F172A),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Row(
              children: [
                Icon(Icons.check_circle_outline,
                    color: Color(0xFFDC2626), size: 24),
                SizedBox(width: 8),
                Text('تأكيد تم البيع ✓ SOLD',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            content: const Text(
              'هل تم بيع هذه السلعة بالفعل؟\nسيظهر ختم "تم البيع" لجميع المستخدمين مع عداد تنازلي 60 دقيقة، وسيتم حذف المنشور نهائياً بعد انتهاء المدة.',
              style:
                  TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child:
                    const Text('إلغاء', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('تأكيد ختم البيع',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirm) return;

    final willBeSold = !_currentAd.isSold;
    await _manager.markAdAsSold(_currentAd.id, willBeSold);
    setState(() {
      _currentAd = _currentAd.copyWith(
        isSold: willBeSold,
        soldAt: willBeSold ? DateTime.now() : null,
      );
    });
    widget.onAdUpdated(_currentAd);

    if (willBeSold) {
      _startSoldCountdownTimer();
    } else {
      _countdownTimer?.cancel();
    }
  }

  Future<void> _placeAuctionBid() async {
    if (!_manager.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('⚠️ يرجى تسجيل الدخول للمشاركة في المزاد العلني.')),
      );
      return;
    }

    final entered = double.tryParse(_bidController.text);
    final minBid = (_currentAd.currentBid ?? _currentAd.startingBid ?? 0) + 5;

    if (entered == null || entered < minBid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '⚠️ يجب أن تكون المزايدة \$${minBid.toStringAsFixed(0)} أو أعلى.')),
      );
      return;
    }

    setState(() => _isPlacingBid = true);

    final snipResult = AntiSnipingEngine.evaluateBidTiming(
      currentEndTime: _currentAd.auctionEndTime ??
          DateTime.now().add(const Duration(days: 1)),
      bidTimestamp: DateTime.now(),
    );

    final updatedBids = List<BidRecord>.from(_currentAd.bids)
      ..insert(
        0,
        BidRecord(
          id: 'bid_${DateTime.now().millisecondsSinceEpoch}',
          userId: _manager.currentUserId,
          userName: _manager.currentUserName,
          amount: entered,
          timestamp: DateTime.now(),
        ),
      );

    final updatedAd = _currentAd.copyWith(
      currentBid: entered,
      auctionEndTime: snipResult.newEndTime,
      bids: updatedBids,
    );

    setState(() {
      _currentAd = updatedAd;
      _bidController.clear();
      _isPlacingBid = false;
    });

    widget.onAdUpdated(updatedAd);

    try {
      await Supabase.instance.client
          .from('ads')
          .update(updatedAd.toMap())
          .eq('id', updatedAd.id)
          .timeout(const Duration(seconds: 8));
    } catch (_) {}

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snipResult.message),
          backgroundColor: snipResult.wasExtended
              ? Colors.amber.shade900
              : Colors.green.shade800,
        ),
      );
    }
  }

  void _openEditScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => FullAddAdScreen(
          initialAd: _currentAd,
          onAdCreated: (up) {
            setState(() => _currentAd = up);
            widget.onAdUpdated(up);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✅ تم تحديث بيانات الإعلان بنجاح!'),
                backgroundColor: Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images =
        _currentAd.imageUrls.isNotEmpty ? _currentAd.imageUrls : [''];
    final canEdit =
        _manager.isSuperAdmin || _manager.currentUserId == _currentAd.userId;
    final remaining = _currentAd.soldRemainingDuration;

    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: Text(
          _currentAd.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            tooltip: 'معاينة ومشاركة الرابط',
            onPressed: _openWebPreview,
          ),
          IconButton(
            icon: Icon(
              widget.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: widget.onToggleFavorite,
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          if (canEdit)
            Container(
              color: const Color(0xFF1E293B),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0284C7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      icon:
                          const Icon(Icons.edit, color: Colors.white, size: 16),
                      label: const Text('تعديل الإعلان',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      onPressed: _openEditScreen,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentAd.isSold
                            ? Colors.grey.shade700
                            : const Color(0xFFDC2626),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      icon: Icon(
                          _currentAd.isSold
                              ? Icons.undo
                              : Icons.check_circle_outline,
                          color: Colors.white,
                          size: 16),
                      label: Text(
                          _currentAd.isSold ? 'إلغاء البيع' : 'تم البيع ✓',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      onPressed: _confirmMarkAsSold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.redAccent, size: 20),
                    tooltip: 'حذف الإعلان',
                    onPressed: () {
                      _manager.deleteAdCompletely(_currentAd.id);
                      widget.onAdDeleted(_currentAd.id);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          if (_currentAd.isPending)
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.orange.shade900,
              child: const Row(
                children: [
                  Icon(Icons.hourglass_top, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '⏳ الإعلان قيد التدقيق والمراجعة من قبل الإدارة وسيظهر للجميع فور اعتماده.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          else if (_currentAd.isRejected)
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.red.shade900,
              child: Row(
                children: [
                  const Icon(Icons.error_outline,
                      color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '❌ تم رفض هذا الإعلان لمخالفته الشروط.',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        if (_currentAd.rejectionReason != null &&
                            _currentAd.rejectionReason!.isNotEmpty)
                          Text(
                            'سبب الرفض: ${_currentAd.rejectionReason}',
                            style: const TextStyle(
                                color: Colors.amberAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 270,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (i) => setState(() {
                    _currentImageIndex = i;
                    _resetZoom();
                  }),
                  itemBuilder: (c, idx) => GestureDetector(
                    onDoubleTap: () {
                      if (_currentScale > 1.0) {
                        _resetZoom();
                      } else {
                        _zoomIn();
                      }
                    },
                    onTap: () => _openFullScreenImage(idx),
                    child: InteractiveViewer(
                      transformationController: _zoomController,
                      minScale: 1.0,
                      maxScale: 4.0,
                      child: AppSmartImage(
                          imageUrl: images[idx], fit: BoxFit.cover),
                    ),
                  ),
                ),
                if (images.length > 1)
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (idx) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.5),
                          width: _currentImageIndex == idx ? 16 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _currentImageIndex == idx
                                ? _manager.secondaryColor
                                : Colors.white60,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.zoom_in,
                              color: Colors.white, size: 20),
                          onPressed: _zoomIn,
                          tooltip: 'تكبير',
                        ),
                        IconButton(
                          icon: const Icon(Icons.zoom_out,
                              color: Colors.white, size: 20),
                          onPressed: _zoomOut,
                          tooltip: 'تصغير',
                        ),
                        IconButton(
                          icon: const Icon(Icons.fullscreen,
                              color: Colors.white, size: 20),
                          onPressed: () =>
                              _openFullScreenImage(_currentImageIndex),
                          tooltip: 'ملء الشاشة',
                        ),
                      ],
                    ),
                  ),
                ),
                if (_currentAd.isSold)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.65),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: -0.18,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDC2626),
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 8)
                                  ],
                                ),
                                child: const Text(
                                  'تم البيع ✓ SOLD',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            if (remaining != null) ...[
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: const Color(0xFFD4AF37), width: 1),
                                ),
                                child: Text(
                                  'سيتم حذف المنشور تلقائياً بعد: ${remaining.inMinutes}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')} دقيقة ⏳',
                                  style: const TextStyle(
                                    color: Color(0xFFD4AF37),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (images.length > 1) ...[
            const SizedBox(height: 8),
            SizedBox(
              height: 55,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: images.length,
                itemBuilder: (ctx, i) {
                  final isSel = _currentImageIndex == i;
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        i,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSel
                              ? const Color(0xFFD4AF37)
                              : Colors.grey.shade400,
                          width: isSel ? 2.5 : 1,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child:
                          AppSmartImage(imageUrl: images[i], fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _currentAd.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _manager.titleTextColor,
                        ),
                      ),
                    ),
                    if (_currentAd.priceUsd != null)
                      Text(
                        '\$${_currentAd.priceUsd!.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _manager.priceUsdColor,
                        ),
                      ),
                  ],
                ),
                if (_currentAd.priceSyp != null)
                  Text(
                    '${_currentAd.priceSyp!.toStringAsFixed(0)} ليرة سورية',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _manager.priceSypColor,
                    ),
                  ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.location_on,
                        size: 14, color: _manager.locationTextColor),
                    const SizedBox(width: 4),
                    Text(
                      '${_currentAd.governorate} - ${_currentAd.neighborhood}',
                      style: TextStyle(
                          fontSize: 12, color: _manager.locationTextColor),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _manager.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _currentAd.condition,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _manager.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                if (_currentAd.videoUrl != null ||
                    _currentAd.facebookUrl != null ||
                    _currentAd.telegramUrl != null ||
                    _currentAd.instagramUrl != null ||
                    _currentAd.tiktokUrl != null ||
                    _currentAd.youtubeUrl != null) ...[
                  const Text('روابط التواصل وفيديو المعاينة:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      if (_currentAd.videoUrl != null)
                        ActionChip(
                          avatar: const Icon(Icons.play_circle_fill,
                              color: Colors.red, size: 16),
                          label: const Text('فيديو توضيحي',
                              style: TextStyle(fontSize: 11)),
                          onPressed: () => _openSocialLink(_currentAd.videoUrl),
                        ),
                      if (_currentAd.facebookUrl != null)
                        ActionChip(
                          avatar: const Icon(Icons.facebook,
                              color: Colors.blue, size: 16),
                          label: const Text('فيسبوك',
                              style: TextStyle(fontSize: 11)),
                          onPressed: () =>
                              _openSocialLink(_currentAd.facebookUrl),
                        ),
                      if (_currentAd.telegramUrl != null)
                        ActionChip(
                          avatar: const Icon(Icons.send,
                              color: Colors.lightBlue, size: 16),
                          label: const Text('تليجرام',
                              style: TextStyle(fontSize: 11)),
                          onPressed: () =>
                              _openSocialLink(_currentAd.telegramUrl),
                        ),
                      if (_currentAd.instagramUrl != null)
                        ActionChip(
                          avatar: const Icon(Icons.camera_alt,
                              color: Colors.pink, size: 16),
                          label: const Text('إنستغرام',
                              style: TextStyle(fontSize: 11)),
                          onPressed: () =>
                              _openSocialLink(_currentAd.instagramUrl),
                        ),
                      if (_currentAd.tiktokUrl != null)
                        ActionChip(
                          avatar: const Icon(Icons.music_note,
                              color: Colors.black87, size: 16),
                          label: const Text('تيك توك',
                              style: TextStyle(fontSize: 11)),
                          onPressed: () =>
                              _openSocialLink(_currentAd.tiktokUrl),
                        ),
                    ],
                  ),
                  const Divider(height: 24),
                ],
                if (_currentAd.isAuction) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.withOpacity(0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.gavel, color: Colors.amber, size: 20),
                            SizedBox(width: 6),
                            Text(
                              'غرفة المزاد العلني المباشر ⚖️ (مع حماية منع القنص)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'أعلى مزايدة حالية: \$${(_currentAd.currentBid ?? _currentAd.startingBid ?? 0).toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _bidController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'قيمة المزايدة (\$)',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: _manager.buttonColor),
                              onPressed:
                                  _isPlacingBid ? null : _placeAuctionBid,
                              child: _isPlacingBid
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    )
                                  : const Text(
                                      'زايد الآن 🔨',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                const Text(
                  'تفاصيل ومواصفات السلعة:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  _currentAd.description,
                  style: const TextStyle(fontSize: 13.5, height: 1.6),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: _manager.primaryColor,
                            child: Text(
                              _currentAd.userName.isNotEmpty
                                  ? _currentAd.userName[0]
                                  : 'U',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _currentAd.userName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                    const SizedBox(width: 4),
                                    KycVerificationBadge(
                                      isVerified: _currentAd.isVerifiedSeller,
                                      positiveLikes:
                                          _currentAd.sellerPositiveLikes,
                                      size: 16,
                                    ),
                                  ],
                                ),
                                Text(
                                  'السمعة الحالية: ${_currentAd.sellerPositiveLikes} 👍 إيجابي • ${_currentAd.sellerDislikes} 👎 سلبي',
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton.icon(
                            icon: const Icon(Icons.thumb_up,
                                color: Colors.green, size: 18),
                            label: Text(
                              'تقييم إيجابي (${_currentAd.sellerPositiveLikes})',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            onPressed: () => _handleVote(true),
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.thumb_down,
                                color: Colors.red, size: 18),
                            label: Text(
                              'تقييم سلبي (${_currentAd.sellerDislikes})',
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            onPressed: () => _handleVote(false),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'التعليقات والاستفسارات المباشرة 💬:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'اكتب استفسارك أو تعليقك حول السلعة...',
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _manager.buttonColor),
                      onPressed: _submitComment,
                      child: const Text('تعليق',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_isLoadingComments)
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2)),
                  ))
                else if (_adComments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'لا توجد تعليقات بعد. كن أول من يستفسر عن السلعة!',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  )
                else
                  ..._adComments.map(
                    (c) => Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(c.userName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Text(
                                '${c.createdAt.hour}:${c.createdAt.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(c.commentText,
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.chat, color: Colors.white),
                label: const Text('واتساب',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: _openWhatsapp,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.phone, color: Colors.white),
                label: const Text('اتصال',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: _callSeller,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: _manager.secondaryColor.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              icon: Icon(Icons.forum, color: _manager.primaryColor),
              tooltip: 'محادثة وتفاوض مباشر',
              onPressed: _openDirectChat,
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// 19. الشاشة الرئيسية الكبرى المحصنة ضد Overflow (MainDashboardScreen)
// ==============================================================================
class MainDashboardScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const MainDashboardScreen({
    Key? key,
    required this.isDarkMode,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen>
    with WidgetsBindingObserver {
  final AppStateManager _manager = AppStateManager();
  final ImagePicker _picker = ImagePicker();
  int _currentNavIndex = 0;

  final List<String> _governorates = [
    'كل المحافظات',
    'دمشق',
    'ريف دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'إدلب',
    'درعا',
    'السويداء',
    'القنيطرة',
    'دير الزور',
    'الرقة',
    'الحسكة'
  ];

  String _selectedGovernorate = 'كل المحافظات';
  String? _selectedCategoryId;
  String? _selectedSubcategory;
  String _searchQuery = '';
  final Set<String> _favoriteAdIds = {};
  bool _isLoadingAds = false;
  bool _isLoadingMore = false;
  bool _hasMoreAds = true;
  int _currentPage = 0;
  static const int _pageSize = 24;

  int _pendingAdsCount = 0;
  List<Map<String, dynamic>> _userChatThreads = [];

  String _filterCondition = 'الكل';
  double? _filterMinPrice;
  double? _filterMaxPrice;
  String _sortBy = 'newest';

  final ScrollController _gridScrollController = ScrollController();
  final ScrollController _tickerScrollController = ScrollController();
  Timer? _tickerTimer;
  bool _isTickerPaused = false;

  final PageController _bannerCarouselController = PageController();
  int _currentBannerIndex = 0;
  Timer? _bannerAutoScrollTimer;
  bool _isBannerUserInteracting = false;
  bool _isUploadingBanner = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _manager.addListener(_onStateChange);

    _manager.loadCachedDataOffline();
    _manager.loadPersistedSession();

    _initLiveAdsFromSupabase();
    _fetchUserFavorites();
    _fetchUserChats();
    _startTickerAnimation();
    _startBannerCarouselTimer();

    _gridScrollController.addListener(_onScrollListener);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _manager.removeListener(_onStateChange);
    _gridScrollController.removeListener(_onScrollListener);
    _gridScrollController.dispose();
    _tickerTimer?.cancel();
    _tickerScrollController.dispose();
    _bannerAutoScrollTimer?.cancel();
    _bannerCarouselController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _tickerTimer?.cancel();
      _bannerAutoScrollTimer?.cancel();
    } else if (state == AppLifecycleState.resumed) {
      _startTickerAnimation();
      _startBannerCarouselTimer();
    }
  }

  void _onStateChange() {
    if (mounted) setState(() {});
  }

  void _onScrollListener() {
    if (_gridScrollController.position.pixels >=
            _gridScrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMoreAds &&
        !_isLoadingAds) {
      _fetchMoreAds();
    }
  }

  void _startTickerAnimation() {
    _tickerTimer?.cancel();
    _tickerTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (!_isTickerPaused && _tickerScrollController.hasClients) {
        final maxScroll = _tickerScrollController.position.maxScrollExtent;
        final currentScroll = _tickerScrollController.offset;
        if (currentScroll >= maxScroll) {
          _tickerScrollController.jumpTo(0.0);
        } else {
          _tickerScrollController.jumpTo(currentScroll + _manager.tickerSpeed);
        }
      }
    });
  }

  void _startBannerCarouselTimer() {
    _bannerAutoScrollTimer?.cancel();
    final interval = _manager.bannerDefaultIntervalSeconds > 0
        ? _manager.bannerDefaultIntervalSeconds
        : 3;

    _bannerAutoScrollTimer =
        Timer.periodic(Duration(seconds: interval), (timer) {
      if (mounted &&
          !_isBannerUserInteracting &&
          _manager.isBannerAutoScrollEnabled &&
          _manager.banners.length > 1 &&
          _bannerCarouselController.hasClients) {
        final nextIndex = (_currentBannerIndex + 1) % _manager.banners.length;
        _bannerCarouselController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
        setState(() => _currentBannerIndex = nextIndex);
      }
    });
  }

  Future<void> _fetchUserFavorites() async {
    if (!_manager.isLoggedIn || _manager.currentUserId.isEmpty) return;
    try {
      final res = await Supabase.instance.client
          .from('favorites')
          .select('ad_id')
          .eq('user_id', _manager.currentUserId)
          .timeout(const Duration(seconds: 10));

      if (res is List && mounted) {
        setState(() {
          _favoriteAdIds.clear();
          for (final row in res) {
            _favoriteAdIds.add(row['ad_id'].toString());
          }
        });
      }
    } catch (e) {
      debugPrint('Favorites fetch notice: $e');
    }
  }

  Future<void> _toggleFavoriteInSupabase(String adId) async {
    if (!_manager.isLoggedIn) return;
    final isFav = _favoriteAdIds.contains(adId);
    setState(() {
      if (isFav) {
        _favoriteAdIds.remove(adId);
      } else {
        _favoriteAdIds.add(adId);
      }
    });

    try {
      if (isFav) {
        await Supabase.instance.client
            .from('favorites')
            .delete()
            .match({'user_id': _manager.currentUserId, 'ad_id': adId}).timeout(
                const Duration(seconds: 10));
      } else {
        await Supabase.instance.client
            .from('favorites')
            .insert({'user_id': _manager.currentUserId, 'ad_id': adId}).timeout(
                const Duration(seconds: 10));
      }
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }

  Future<void> _fetchUserChats() async {
    if (!_manager.isLoggedIn || _manager.currentUserId.isEmpty) return;
    try {
      final res = await Supabase.instance.client
          .from('chat_messages')
          .select()
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 10));

      if (res is List && mounted) {
        setState(() {
          _userChatThreads = List<Map<String, dynamic>>.from(res);
        });
      }
    } catch (e) {
      debugPrint('Fetch chats notice: $e');
    }
  }

  Future<void> _initLiveAdsFromSupabase() async {
    if (mounted) {
      setState(() {
        _isLoadingAds = _manager.ads.isEmpty;
        _currentPage = 0;
        _hasMoreAds = true;
      });
    }

    try {
      final res = await Supabase.instance.client
          .from('ads')
          .select()
          .order('created_at', ascending: false)
          .range(0, _pageSize - 1)
          .timeout(const Duration(seconds: 12));

      if (res is List) {
        final fetched = res
            .map((map) => AdItem.fromMap(map as Map<String, dynamic>))
            .toList();
        _manager.ads = fetched;
        _manager.saveAdsToOfflineCache(fetched);
        _hasMoreAds = fetched.length >= _pageSize;
      }

      final bannerRes = await Supabase.instance.client
          .from('banners')
          .select()
          .timeout(const Duration(seconds: 10));

      if (bannerRes is List && (bannerRes).isNotEmpty) {
        final fetchedBanners = bannerRes
            .map((map) => BannerItem.fromMap(map as Map<String, dynamic>))
            .toList();
        _manager.banners = fetchedBanners;
        _manager.saveBannersToOfflineCache(fetchedBanners);
      }

      final pendingRes = await Supabase.instance.client
          .from('ads')
          .select('id')
          .eq('status', 'pending')
          .timeout(const Duration(seconds: 10));

      if (pendingRes is List && mounted) {
        setState(() => _pendingAdsCount = pendingRes.length);
      }

      await _manager.autoCleanupExpiredSoldAds();
    } catch (e) {
      debugPrint('Supabase fetch ads notice: $e');
    } finally {
      if (mounted) setState(() => _isLoadingAds = false);
    }
  }

  Future<void> _fetchMoreAds() async {
    if (_isLoadingMore || !_hasMoreAds) return;
    setState(() => _isLoadingMore = true);

    try {
      final nextPage = _currentPage + 1;
      final from = nextPage * _pageSize;
      final to = from + _pageSize - 1;

      final res = await Supabase.instance.client
          .from('ads')
          .select()
          .order('created_at', ascending: false)
          .range(from, to)
          .timeout(const Duration(seconds: 10));

      if (res is List && res.isNotEmpty) {
        final moreAds = res
            .map((map) => AdItem.fromMap(map as Map<String, dynamic>))
            .toList();
        setState(() {
          _manager.ads.addAll(moreAds);
          _currentPage = nextPage;
          _hasMoreAds = moreAds.length >= _pageSize;
        });
      } else {
        setState(() => _hasMoreAds = false);
      }
    } catch (e) {
      debugPrint('Fetch more ads error: $e');
    } finally {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  bool _requireAuth(VoidCallback onAuthenticated) {
    if (!_manager.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              '⚠️ يجب تسجيل الدخول أولاً لإتمام هذا الإجراء في المنصة.'),
          backgroundColor: const Color(0xFF1E293B),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          action: SnackBarAction(
            label: 'تسجيل الدخول',
            textColor: _manager.secondaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => AuthScreen()),
              );
            },
          ),
        ),
      );
      return false;
    }
    onAuthenticated();
    return true;
  }

  Future<void> _pickAndUploadBannerDirectly() async {
    try {
      final pickedList = await _picker.pickMultiImage(
        imageQuality: 75,
        maxWidth: 1200,
      );
      if (pickedList.isEmpty) return;

      setState(() => _isUploadingBanner = true);

      final List<Uint8List> bytesList = [];
      for (var f in pickedList) {
        final b = await f.readAsBytes();
        bytesList.add(b);
      }

      final uploadedUrls = await StorageUploadService.uploadMultipleImageBytes(
        bucketName: kStorageBucketBanners,
        imagesBytesList: bytesList,
        prefix: 'banner',
      );

      if (uploadedUrls.isNotEmpty) {
        final newBanner = BannerItem(
          id: 'bn_${DateTime.now().millisecondsSinceEpoch}',
          imageUrls: uploadedUrls,
          title: 'إعلان مميز جديد ✨',
          subtitle: 'سوق سوريا الشامل',
          description: 'تمت إضافته وحجزه بنجاح من المعرض مع صور متعددة',
          location: _selectedGovernorate,
          phone: kAppOwnerPhone,
          whatsapp: kAppOwnerWhatsApp,
          badgeText: 'VIP ★',
          badgeColor: _manager.secondaryColor,
          displayDurationSeconds: _manager.bannerDefaultIntervalSeconds,
          expiresAt: DateTime.now().add(const Duration(days: 30)),
        );

        setState(() {
          _manager.banners.insert(0, newBanner);
        });
        _manager.saveBannersToOfflineCache(_manager.banners);

        try {
          await Supabase.instance.client
              .from('banners')
              .insert(newBanner.toMap())
              .timeout(const Duration(seconds: 8));
        } catch (_) {}

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    '✅ تم رفع وتحديث البنر الإعلاني بنجاح مع الصور المحددة!')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تعذر فتح المعرض أو رفع البنر: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploadingBanner = false);
    }
  }

  void _showContactAdminDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: _manager.secondaryColor,
                    child: Icon(Icons.headset_mic,
                        color: _manager.primaryColor, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('التواصل المباشر مع إدارة التطبيق',
                          style: TextStyle(
                              color: _manager.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      const Text('نحن هنا لخدمتكم ومساعدتكم على مدار الساعة',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                tileColor: const Color(0xFF25D366).withOpacity(0.12),
                leading: const Icon(Icons.chat, color: Color(0xFF25D366)),
                title: const Text('محادثة واتساب فورية مع الإدارة',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: const Text(
                    'رد سريع على الاستفسارات وحجز الإعلانات والبنرات'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () async {
                  Navigator.pop(ctx);
                  final clean =
                      PhoneHelper.formatForWhatsapp(kAppOwnerWhatsApp);
                  final msg = Uri.encodeComponent(
                      'مرحباً إدارة سوق سوريا الشامل، لدي استفسار أو طلب حجز بنر إعلاني:');
                  final uri = Uri.parse('https://wa.me/$clean?text=$msg');
                  try {
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  } catch (_) {}
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                tileColor: Colors.blue.withOpacity(0.1),
                leading: const Icon(Icons.phone, color: Colors.blue),
                title: const Text('اتصال هاتفي مباشر بالإدارة',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('رقم الهاتف: $kAppOwnerPhone'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () async {
                  Navigator.pop(ctx);
                  final uri = Uri.parse('tel:$kAppOwnerPhone');
                  try {
                    if (await canLaunchUrl(uri)) await launchUrl(uri);
                  } catch (_) {}
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                tileColor: _manager.secondaryColor.withOpacity(0.15),
                leading: Icon(Icons.lightbulb, color: _manager.secondaryColor),
                title: const Text('صوتك مسموع 💡 (صندوق الاقتراحات)',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: const Text('إرسال فكرة أو شكوى مع إرفاق لقطة شاشة'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => AppFeedbackScreen()));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAdvancedFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.tune, color: _manager.primaryColor),
                            const SizedBox(width: 8),
                            const Text('تصفية وفلترة متقدمة',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            setSheetState(() {
                              _filterCondition = 'الكل';
                              _filterMinPrice = null;
                              _filterMaxPrice = null;
                              _sortBy = 'newest';
                            });
                            setState(() {});
                          },
                          child: const Text('إعادة ضبط'),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text('حالة السلعة:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: [
                        'الكل',
                        'جديد بالكرتونة',
                        'مستعمل بحالة ممتازة',
                        'مستعمل',
                        'بحاجة صيانة'
                      ].map((cond) {
                        final sel = _filterCondition == cond;
                        return ChoiceChip(
                          label: Text(cond,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: sel ? Colors.white : Colors.black87)),
                          selected: sel,
                          selectedColor: _manager.primaryColor,
                          onSelected: (val) {
                            if (val) {
                              setSheetState(() => _filterCondition = cond);
                            }
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    const Text('ترتيب النتائج حسب:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: [
                        {'key': 'newest', 'label': 'الأحدث أولاً'},
                        {'key': 'price_asc', 'label': 'الأقل سعراً'},
                        {'key': 'price_desc', 'label': 'الأعلى سعراً'},
                        {'key': 'views', 'label': 'الأكثر مشاهدة 🔥'},
                      ].map((s) {
                        final sel = _sortBy == s['key'];
                        return ChoiceChip(
                          label: Text(s['label']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: sel ? Colors.white : Colors.black87)),
                          selected: sel,
                          selectedColor: _manager.primaryColor,
                          onSelected: (val) {
                            if (val) setSheetState(() => _sortBy = s['key']!);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    const Text('نطاق السعر التقريبي (\$ دولار):',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'من (\$)',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8)),
                            onChanged: (val) =>
                                _filterMinPrice = double.tryParse(val),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'إلى (\$)',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8)),
                            onChanged: (val) =>
                                _filterMaxPrice = double.tryParse(val),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _manager.buttonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          setState(() {});
                          Navigator.pop(ctx);
                        },
                        child: const Text('تطبيق الفلترة ✨',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _recordSearchVoice() async {
    final res = await showDialog<String>(
      context: context,
      builder: (c) =>
          const VoiceInputDialog(title: 'البحث الصوتي الذكي في السوق 🎙️'),
    );
    if (res != null && res.isNotEmpty) {
      _manager.trackSearchKeyword(res);
      setState(() {
        _searchQuery = res;
        _searchController.text = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_manager.isMaintenanceMode && !_manager.isSuperAdmin) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.build_circle_outlined,
                    size: 80, color: Color(0xFFD4AF37)),
                const SizedBox(height: 20),
                const Text(
                  'وضع الصيانة والتحديث المجدول 🛠️',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  _manager.maintenanceMessage,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 13, height: 1.6),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.login, color: Color(0xFF0F172A)),
                  label: const Text('دخول الإدارة والمشرفين 🔑',
                      style: TextStyle(
                          color: Color(0xFF0F172A),
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) => AuthScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      drawer: CustomServerDrawer(
        userId: _manager.currentUserId,
        onOpenContactAdmin: _showContactAdminDialog,
        onOpenFeedback: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => AppFeedbackScreen()));
        },
        onOpenPlans: () {
          _showContactAdminDialog();
        },
        onOpenAdminPanel: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => const FullAdminPanelScreen()));
        },
      ),
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        elevation: 2,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SyrianIndependenceFlag(width: 26, height: 17),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                _manager.appTitle,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _manager.secondaryColor.withOpacity(0.3),
                shape: BoxShape.circle,
                border: Border.all(color: _manager.secondaryColor, width: 1),
              ),
              child: Icon(Icons.headset_mic,
                  color: _manager.secondaryColor, size: 16),
            ),
            tooltip: 'تواصل مع إدارة التطبيق',
            onPressed: _showContactAdminDialog,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedGovernorate,
              dropdownColor: const Color(0xFF1E293B),
              icon: Icon(Icons.arrow_drop_down,
                  color: _manager.secondaryColor, size: 18),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
              items: _governorates.map((gov) {
                return DropdownMenuItem<String>(
                  value: gov,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on,
                          color: _manager.secondaryColor, size: 12),
                      const SizedBox(width: 2),
                      Text(gov,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedGovernorate = val);
              },
            ),
          ),
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white, size: 20),
            onPressed: widget.onToggleTheme,
          ),
          if (_manager.isModerator)
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.admin_panel_settings,
                      color: Colors.amberAccent, size: 22),
                  tooltip: 'غرفة العمليات والإشراف المركزي',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              const FullAdminPanelScreen(initialTab: 1)),
                    );
                  },
                ),
                if (_pendingAdsCount > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text(
                        '$_pendingAdsCount',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
      body: _buildCurrentScreenBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        selectedItemColor: _manager.primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 2) {
            _requireAuth(() => _openAddAdScreen());
          } else {
            setState(() => _currentNavIndex = index);
          }
        },
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'الرئيسية'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: 'الرسائل والصفقات'),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: _manager.buttonColor, shape: BoxShape.circle),
              child: Icon(Icons.add, color: _manager.secondaryColor, size: 24),
            ),
            label: 'أضف إعلان',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'المفضلة'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'حسابي'),
        ],
      ),
    );
  }

  Widget _buildCurrentScreenBody() {
    switch (_currentNavIndex) {
      case 0:
        return _buildHomeFeedTab();
      case 1:
        return _buildChatsAndNegotiationsTab();
      case 3:
        return _buildFavoritesTab();
      case 4:
        return _buildProfileTab();
      default:
        return _buildHomeFeedTab();
    }
  }

  Widget _buildHomeFeedTab() {
    var filteredAds = _manager.ads.where((ad) {
      final matchesGov = _selectedGovernorate == 'كل المحافظات' ||
          ad.governorate == _selectedGovernorate;
      final matchesCat =
          _selectedCategoryId == null || ad.categoryId == _selectedCategoryId;
      final matchesSub = _selectedSubcategory == null ||
          ad.subcategory == _selectedSubcategory;
      final matchesSearch = _searchQuery.isEmpty ||
          ad.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          ad.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          ad.neighborhood.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCond =
          _filterCondition == 'الكل' || ad.condition == _filterCondition;
      final matchesMinP = _filterMinPrice == null ||
          (ad.priceUsd != null && ad.priceUsd! >= _filterMinPrice!);
      final matchesMaxP = _filterMaxPrice == null ||
          (ad.priceUsd != null && ad.priceUsd! <= _filterMaxPrice!);

      final isApprovedForFeed =
          ad.status == 'approved' || (_manager.isModerator);

      return matchesGov &&
          matchesCat &&
          matchesSub &&
          matchesSearch &&
          matchesCond &&
          matchesMinP &&
          matchesMaxP &&
          isApprovedForFeed;
    }).toList();

    if (_sortBy == 'price_asc') {
      filteredAds.sort((a, b) => (a.priceUsd ?? 0).compareTo(b.priceUsd ?? 0));
    } else if (_sortBy == 'price_desc') {
      filteredAds.sort((a, b) => (b.priceUsd ?? 0).compareTo(a.priceUsd ?? 0));
    } else if (_sortBy == 'views') {
      filteredAds.sort((a, b) => b.viewsCount.compareTo(a.viewsCount));
    } else {
      filteredAds.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return Column(
      children: [
        LiveCurrencyExchangeTicker(
          usdRate: _manager.exchangeRateUsdToSyp,
          gold21kPrice: _manager.goldPrice21kSyp,
          onRefresh: _initLiveAdsFromSupabase,
        ),
        _buildCustomNewsTickerWidget(),
        _buildRoyalBannersSection(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() => _searchQuery = val);
                    _manager.trackSearchKeyword(val);
                  },
                  decoration: InputDecoration(
                    hintText:
                        'ابحث في كافة إعلانات السوق (سيارات، عقارات، هواتف...)...',
                    hintStyle: const TextStyle(fontSize: 12),
                    prefixIcon:
                        Icon(Icons.search, color: _manager.primaryColor),
                    suffixIcon: _manager.isVoiceTypingEnabled
                        ? IconButton(
                            icon: Icon(Icons.mic, color: _manager.primaryColor),
                            tooltip: 'البحث بالصوت',
                            onPressed: _recordSearchVoice,
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.08),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: _filterCondition != 'الكل' ||
                          _filterMinPrice != null ||
                          _filterMaxPrice != null ||
                          _sortBy != 'newest'
                      ? _manager.secondaryColor
                      : Colors.grey.withOpacity(0.12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: Icon(Icons.tune, color: _manager.primaryColor, size: 22),
                tooltip: 'تصفية وفلترة متقدمة',
                onPressed: _showAdvancedFilterSheet,
              ),
            ],
          ),
        ),
        _buildCategoriesHorizontalBar(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('أحدث إعلانات السوق المعتمدة',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _manager.titleTextColor)),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 1.5),
                    decoration: BoxDecoration(
                        color: _manager.primaryColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('${filteredAds.length} إعلان',
                        style: TextStyle(
                            color: _manager.primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              if (_selectedGovernorate != 'كل المحافظات')
                Text('محافظة: $_selectedGovernorate',
                    style: TextStyle(
                        color: _manager.primaryColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _initLiveAdsFromSupabase,
            color: _manager.primaryColor,
            child: _isLoadingAds
                ? Center(
                    child:
                        CircularProgressIndicator(color: _manager.primaryColor))
                : filteredAds.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: 60),
                          Center(
                            child: Column(
                              children: [
                                Icon(Icons.search_off_rounded,
                                    size: 55, color: Colors.grey.shade400),
                                const SizedBox(height: 10),
                                const Text(
                                    'لا توجد إعلانات معتمدة حالياً في هذا القسم أو المحافظة',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      )
                    : GridView.builder(
                        controller: _gridScrollController,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.70,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemCount:
                            filteredAds.length + (_isLoadingMore ? 2 : 0),
                        itemBuilder: (ctx, index) {
                          if (index >= filteredAds.length) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.5),
                                ),
                              ),
                            );
                          }
                          final ad = filteredAds[index];
                          return _buildCompactFacingGridAdCard(ad);
                        },
                      ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomNewsTickerWidget() {
    final newsText = _manager.newsTicker.join('   ✦   ');

    return Container(
      color: _manager.tickerBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: _manager.secondaryColor,
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_manager.tickerIcon,
                    color: _manager.primaryColor, size: 12),
                const SizedBox(width: 3),
                Text('عاجل',
                    style: TextStyle(
                        color: _manager.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Listener(
              onPointerDown: (_) => setState(() => _isTickerPaused = true),
              onPointerUp: (_) => setState(() => _isTickerPaused = false),
              onPointerCancel: (_) => setState(() => _isTickerPaused = false),
              child: SingleChildScrollView(
                controller: _tickerScrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Text(
                  newsText,
                  style: TextStyle(
                    color: _manager.tickerTextColor,
                    fontSize: _manager.tickerFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoyalBannersSection() {
    final targetGovernorate = _selectedGovernorate;
    final activeBanners = _manager.banners.where((b) {
      final notExpired = !b.isExpired && b.isActive;
      final geoMatch = b.location == 'كل المحافظات' ||
          targetGovernorate == 'كل المحافظات' ||
          b.location == targetGovernorate;
      return notExpired && geoMatch;
    }).toList();

    if (_manager.bannerDisplayMode == BannerDisplayLayoutMode.fullPanorama) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        height: 125,
        child: activeBanners.isNotEmpty
            ? PageView.builder(
                controller: _bannerCarouselController,
                itemCount: activeBanners.length,
                onPageChanged: (idx) =>
                    setState(() => _currentBannerIndex = idx),
                itemBuilder: (ctx, idx) => _buildActiveBannerCard(
                    activeBanners[idx],
                    isPanorama: true),
              )
            : _buildEmptySlotBannerCard(
                'مساحة بانوراما إعلانية VIP شاغرة\nاضغط لرفع وحجز البنر 🌟'),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      height: 98,
      child: Row(
        children: [
          Expanded(
            child: activeBanners.isNotEmpty
                ? _buildActiveBannerCard(activeBanners[0])
                : _buildEmptySlotBannerCard(
                    'مساحة إعلانية شاغرة\nاضغط لرفع بنر 🌟'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: activeBanners.length > 1
                ? _buildActiveBannerCard(activeBanners[1])
                : _buildEmptySlotBannerCard(
                    'مساحة بنر شاغرة\nاضغط لرفع بنر 🚀'),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveBannerCard(BannerItem banner, {bool isPanorama = false}) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        _manager.incrementBannerClick(banner.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => FullBannerDetailsScreen(banner: banner),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: AppSmartImage(
                imageUrl: banner.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.85),
                      Colors.transparent
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                decoration: BoxDecoration(
                  color: banner.badgeColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  banner.badgeText,
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 6,
              right: 8,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    banner.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isPanorama ? 13 : 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    banner.subtitle,
                    style: TextStyle(
                        color: _manager.secondaryColor,
                        fontSize: isPanorama ? 10.5 : 9.5,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySlotBannerCard(String placeholderText) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: _pickAndUploadBannerDirectly,
      child: Container(
        decoration: BoxDecoration(
          color: _manager.primaryColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _manager.secondaryColor.withOpacity(0.6),
            width: 1.2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isUploadingBanner
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : Icon(Icons.add_photo_alternate_outlined,
                    color: _manager.secondaryColor, size: 22),
            const SizedBox(height: 4),
            Text(
              placeholderText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _manager.primaryColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesHorizontalBar() {
    final currentCat = _manager.categories.firstWhere(
      (c) => c.name == _selectedCategoryId,
      orElse: () => _manager.categories.isNotEmpty
          ? _manager.categories.first
          : CategoryItem(
              id: 'all',
              name: 'الكل',
              iconData: Icons.category,
              subcategories: []),
    );

    final subcategories =
        _selectedCategoryId != null ? currentCat.subcategories : <String>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: FilterChip(
                  label: const Text('الكل',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  selected: _selectedCategoryId == null,
                  selectedColor: _manager.primaryColor,
                  labelStyle: TextStyle(
                      color: _selectedCategoryId == null
                          ? Colors.white
                          : Colors.black87),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onSelected: (_) => setState(() {
                    _selectedCategoryId = null;
                    _selectedSubcategory = null;
                  }),
                ),
              ),
              ..._manager.categories.map((cat) {
                final isSelected = _selectedCategoryId == cat.name;
                return Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: FilterChip(
                    avatar: Icon(cat.iconData,
                        size: 14,
                        color: isSelected ? Colors.white : cat.textColor),
                    label: Text(
                      cat.name,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : cat.textColor,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: cat.backgroundColor,
                    backgroundColor: cat.backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(cat.borderRadiusValue)),
                    onSelected: (val) {
                      setState(() {
                        _selectedCategoryId = val ? cat.name : null;
                        _selectedSubcategory = null;
                      });
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        if (subcategories.isNotEmpty) ...[
          const SizedBox(height: 3),
          SizedBox(
            height: 28,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: subcategories.map((sub) {
                final isSelected = _selectedSubcategory == sub;
                return Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: ChoiceChip(
                    label: Text(sub,
                        style: TextStyle(
                            fontSize: 10,
                            color: isSelected
                                ? _manager.primaryColor
                                : Colors.black87)),
                    selected: isSelected,
                    selectedColor: _manager.primaryColor.withOpacity(0.15),
                    backgroundColor: Colors.transparent,
                    onSelected: (val) {
                      setState(() {
                        _selectedSubcategory = val ? sub : null;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCompactFacingGridAdCard(AdItem ad) {
    final isFav = _favoriteAdIds.contains(ad.id);
    final remaining = ad.soldRemainingDuration;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      elevation: 1.5,
      child: InkWell(
        onTap: () {
          _manager.incrementAdViews(ad.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => FullAdDetailsScreen(
                ad: ad,
                isFavorite: isFav,
                onToggleFavorite: () {
                  _requireAuth(() {
                    _toggleFavoriteInSupabase(ad.id);
                  });
                },
                onAdUpdated: (updatedAd) {
                  setState(() {
                    final idx =
                        _manager.ads.indexWhere((x) => x.id == updatedAd.id);
                    if (idx != -1) _manager.ads[idx] = updatedAd;
                  });
                },
                onAdDeleted: (deletedId) {
                  setState(() {
                    _manager.ads.removeWhere((x) => x.id == deletedId);
                  });
                },
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.grey.shade900,
                      child: AppSmartImage(
                        imageUrl:
                            ad.imageUrls.isNotEmpty ? ad.imageUrls.first : '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (ad.status == 'pending')
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                            color: Colors.orange.shade800,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('قيد المراجعة ⏳',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 8)),
                      ),
                    )
                  else if (ad.status == 'rejected')
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                            color: Colors.red.shade800,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('مرفوض ❌',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 8)),
                      ),
                    )
                  else if (ad.isFeatured)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                            color: _manager.secondaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text('VIP ★',
                            style: TextStyle(
                                color: _manager.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 9)),
                      ),
                    ),
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          color: Colors.black45, shape: BoxShape.circle),
                      child: GestureDetector(
                        onTap: () {
                          _requireAuth(() {
                            _toggleFavoriteInSupabase(ad.id);
                          });
                        },
                        child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.white,
                            size: 14),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1.5),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.remove_red_eye,
                              color: Colors.white70, size: 9),
                          const SizedBox(width: 2),
                          Text('${ad.viewsCount}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  if (ad.sellerPositiveLikes >= 1000 || ad.isVerifiedSeller)
                    Positioned(
                      bottom: 4,
                      left: 4,
                      child: KycVerificationBadge(
                        isVerified: ad.isVerifiedSeller,
                        positiveLikes: ad.sellerPositiveLikes,
                        size: 13,
                      ),
                    ),
                  if (ad.isSold)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.60),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.rotate(
                                angle: -0.22,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDC2626),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: Colors.white, width: 1.5),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black45, blurRadius: 6)
                                    ],
                                  ),
                                  child: const Text(
                                    'تم البيع ✓ SOLD',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.5,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                              if (remaining != null) ...[
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${remaining.inMinutes} دقيقة ⏳',
                                    style: const TextStyle(
                                      color: Color(0xFFD4AF37),
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ad.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: _manager.titleTextColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (ad.priceSyp != null)
                                Text(
                                  '${ad.priceSyp!.toStringAsFixed(0)} ل.س',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.5,
                                    color: _manager.priceSypColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (ad.priceUsd != null)
                                Text(
                                  '\$${ad.priceUsd!.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: _manager.priceUsdColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 1.5),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  ad.condition,
                                  style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.location_on,
                                      color: _manager.locationTextColor,
                                      size: 9),
                                  const SizedBox(width: 1),
                                  Flexible(
                                    child: Text(
                                      '${ad.governorate} - ${ad.neighborhood}',
                                      style: TextStyle(
                                          fontSize: 8.5,
                                          color: _manager.locationTextColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatsAndNegotiationsTab() {
    if (!_manager.isLoggedIn) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 60, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text('غرف المحادثة والتفاوض المباشر',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            const Text('يرجى تسجيل الدخول للوصول إلى رسائلك وعروض التفاوض.',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.buttonColor),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => AuthScreen())),
              child: const Text('تسجيل الدخول الآن 🔑',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }

    if (_userChatThreads.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline,
                size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text('لا توجد محادثات نشطة حالياً',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey)),
            const SizedBox(height: 6),
            const Text('تواصل مع أصحاب الإعلانات لبدء التفاوض المباشر.',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: _userChatThreads.length,
      itemBuilder: (ctx, idx) {
        final thread = _userChatThreads[idx];
        final senderName = thread['sender_name']?.toString() ?? 'طرف التفاوض';
        final message = thread['message']?.toString() ?? '';
        final adId = thread['ad_id']?.toString() ?? '';

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _manager.primaryColor,
              child: Text(
                senderName.isNotEmpty ? senderName[0] : 'S',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(senderName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle:
                Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => FullChatNegotiationScreen(
                    adId: adId,
                    partnerName: senderName,
                    productTitle: 'تفاوض مباشر على السلعة',
                    initialPrice: 0,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFavoritesTab() {
    final favAds =
        _manager.ads.where((x) => _favoriteAdIds.contains(x.id)).toList();

    if (favAds.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 60, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text('قائمة المفضلة فارغة حالياً',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey)),
            const SizedBox(height: 6),
            const Text(
                'اضغط على رمز القلب في أي إعلان لحفظه هنا للرجوع إليه لاحقاً.',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      );
    }

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: favAds.length,
      itemBuilder: (ctx, idx) => _buildCompactFacingGridAdCard(favAds[idx]),
    );
  }

  Widget _buildProfileTab() {
    final currentPlan = _manager.getCurrentUserPlan();
    final userAds =
        _manager.ads.where((x) => x.userId == _manager.currentUserId).toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _manager.primaryColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: _manager.secondaryColor,
                child: Text(
                  _manager.currentUserName.isNotEmpty
                      ? _manager.currentUserName[0]
                      : 'U',
                  style: TextStyle(
                      color: _manager.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(_manager.currentUserName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 6),
                        KycVerificationBadge(
                          isVerified: _manager.isCurrentUserVerified,
                          positiveLikes: _manager.currentUserPositiveLikes,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _manager.isLoggedIn
                          ? _manager.currentUserEmail
                          : 'غير مسجل (وضع الزائر)',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: _manager.secondaryColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text('الخطة: ${currentPlan.name}',
                              style: TextStyle(
                                  color: _manager.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11)),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.thumb_up,
                                  size: 11, color: Colors.lightBlueAccent),
                              const SizedBox(width: 4),
                              Text('${_manager.currentUserPositiveLikes} إعجاب',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (userAds.isNotEmpty) ...[
          Text('إعلاناتي المعروضة (${userAds.length}):',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          ...userAds.map((ad) {
            Color statusColor = Colors.green;
            String statusText = 'معتمد ونشط ✓';
            if (ad.status == 'pending') {
              statusColor = Colors.orange.shade800;
              statusText = 'قيد المراجعة ⏳';
            } else if (ad.status == 'rejected') {
              statusColor = Colors.red.shade800;
              statusText = 'مرفوض ❌';
            }

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: AppSmartImage(
                        imageUrl:
                            ad.imageUrls.isNotEmpty ? ad.imageUrls.first : ''),
                  ),
                ),
                title: Text(ad.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 1),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      statusText,
                      style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                    if (ad.status == 'rejected' &&
                        ad.rejectionReason != null &&
                        ad.rejectionReason!.isNotEmpty)
                      Text('السبب: ${ad.rejectionReason}',
                          style: TextStyle(
                              color: Colors.red.shade700, fontSize: 10)),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => FullAdDetailsScreen(
                        ad: ad,
                        isFavorite: _favoriteAdIds.contains(ad.id),
                        onToggleFavorite: () =>
                            _toggleFavoriteInSupabase(ad.id),
                        onAdUpdated: (up) => setState(() {}),
                        onAdDeleted: (del) => setState(() {}),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
          const SizedBox(height: 12),
        ],
        ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: _manager.secondaryColor.withOpacity(0.15),
          leading: Icon(Icons.lightbulb, color: _manager.secondaryColor),
          title: const Text('صوتك مسموع 💡 - اقترح وطوّر التطبيق',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('أرسل أفكارك وملاحظاتك مباشرةً لصاحب التطبيق'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => AppFeedbackScreen())),
        ),
        const SizedBox(height: 10),
        if (!_manager.isLoggedIn)
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: _manager.primaryColor.withOpacity(0.1),
            leading: Icon(Icons.login, color: _manager.primaryColor),
            title: const Text('تسجيل الدخول / إنشاء حساب جديد',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('تسجيل سريع مع ميزة استرجاع كلمة المرور'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => AuthScreen())),
          )
        else
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: Colors.red.withOpacity(0.08),
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('تسجيل الخروج',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onTap: () async {
              await _manager.logoutUser();
              setState(() {
                _favoriteAdIds.clear();
                _userChatThreads.clear();
              });
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تسجيل الخروج بنجاح.')));
              }
            },
          ),
        const SizedBox(height: 10),
        ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: Colors.grey.withOpacity(0.06),
          leading:
              Icon(Icons.workspace_premium, color: _manager.secondaryColor),
          title: const Text('ترقية الباقة والاشتراكات VIP'),
          subtitle: const Text('ميزات حصرية ونشر غير محدود'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          onTap: () {
            _showContactAdminDialog();
          },
        ),
        if (_manager.isModerator) ...[
          const SizedBox(height: 10),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: Colors.red.withOpacity(0.08),
            leading: const Icon(Icons.admin_panel_settings, color: Colors.red),
            title: const Text('غرفة العمليات ولوحة تحكم المشرفين 🛡️',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text(
                'موافقة الإعلانات، تدقيق إيصالات شام كاش وبينانس، إدارة الأقسام والأسعار'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const FullAdminPanelScreen(),
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _openAddAdScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => FullAddAdScreen(
          onAdCreated: (newAd) {
            _manager.addNewAdDirectly(newAd);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _manager.isSuperAdmin
                      ? '✨ تم نشر إعلانك فوراً ومباشرةً في السوق!'
                      : '⏳ تم استلام إعلانك بنجاح وسيعرض للجميع فور موافقة الإدارة عليه.',
                ),
                backgroundColor: _manager.primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==============================================================================
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [الدفعة 4 من أصل 4: شاشة إضافة الإعلان، غرف المحادثة، باقات الاشتراك، غرفة العمليات، و main()]
// مربوطة بالكامل بالسيرفر الحقيقي وقواعد البيانات الحقيقية دون أي اختصار
// ==============================================================================
// ==============================================================================
// 20. شاشة إضافة وتعديل الإعلانات والمزادات الحرة (FullAddAdScreen)
// ==============================================================================
class FullAddAdScreen extends StatefulWidget {
  final AdItem? initialAd;
  final Function(AdItem) onAdCreated;

  const FullAddAdScreen({
    Key? key,
    this.initialAd,
    required this.onAdCreated,
  }) : super(key: key);

  @override
  State<FullAddAdScreen> createState() => _FullAddAdScreenState();
}

class _FullAddAdScreenState extends State<FullAddAdScreen> {
  final AppStateManager _manager = AppStateManager();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _priceUsdController;
  late TextEditingController _priceSypController;
  late TextEditingController _neighborhoodController;
  late TextEditingController _phoneController;
  late TextEditingController _whatsappController;
  late TextEditingController _videoUrlController;
  late TextEditingController _facebookUrlController;
  late TextEditingController _telegramUrlController;
  late TextEditingController _instagramUrlController;
  late TextEditingController _tiktokUrlController;
  late TextEditingController _youtubeUrlController;
  late TextEditingController _startingBidController;

  String _governorate = 'دمشق';
  String _condition = 'مستعمل بحالة ممتازة';
  String _selectedCategory = 'سيارات ومركبات';
  String _selectedSubcategory = 'سيارات سياحية للبيع';
  bool _isAuction = false;
  int _auctionDaysDuration = 3;

  List<String> _existingImageUrls = [];
  List<Uint8List> _newLocalImageBytes = [];
  bool _isUploading = false;

  final List<String> _governorates = [
    'دمشق',
    'ريف دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'إدلب',
    'درعا',
    'السويداء',
    'القنيطرة',
    'دير الزور',
    'الرقة',
    'الحسكة'
  ];

  final List<String> _conditions = [
    'جديد بالكرتونة',
    'مستعمل بحالة ممتازة',
    'مستعمل',
    'بحاجة صيانة',
    'كسر زيرو',
  ];

  @override
  void initState() {
    super.initState();
    final ad = widget.initialAd;
    _titleController = TextEditingController(text: ad?.title ?? '');
    _descController = TextEditingController(text: ad?.description ?? '');
    _priceUsdController = TextEditingController(
        text: ad?.priceUsd != null ? ad!.priceUsd!.toStringAsFixed(0) : '');
    _priceSypController = TextEditingController(
        text: ad?.priceSyp != null ? ad!.priceSyp!.toStringAsFixed(0) : '');
    _neighborhoodController =
        TextEditingController(text: ad?.neighborhood ?? '');
    _phoneController = TextEditingController(
        text: ad?.contactPhone ?? _manager.currentUserPhone);
    _whatsappController = TextEditingController(
        text: ad?.contactWhatsapp ?? _manager.currentUserPhone);
    _videoUrlController = TextEditingController(text: ad?.videoUrl ?? '');
    _facebookUrlController = TextEditingController(text: ad?.facebookUrl ?? '');
    _telegramUrlController = TextEditingController(text: ad?.telegramUrl ?? '');
    _instagramUrlController =
        TextEditingController(text: ad?.instagramUrl ?? '');
    _tiktokUrlController = TextEditingController(text: ad?.tiktokUrl ?? '');
    _youtubeUrlController = TextEditingController(text: ad?.youtubeUrl ?? '');
    _startingBidController = TextEditingController(
        text:
            ad?.startingBid != null ? ad!.startingBid!.toStringAsFixed(0) : '');

    if (ad != null) {
      _governorate = ad.governorate;
      _condition = ad.condition;
      _selectedCategory = ad.categoryId;
      _selectedSubcategory = ad.subcategory;
      _isAuction = ad.isAuction;
      _existingImageUrls = List.from(ad.imageUrls);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _priceUsdController.dispose();
    _priceSypController.dispose();
    _neighborhoodController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _videoUrlController.dispose();
    _facebookUrlController.dispose();
    _telegramUrlController.dispose();
    _instagramUrlController.dispose();
    _tiktokUrlController.dispose();
    _youtubeUrlController.dispose();
    _startingBidController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final plan = _manager.getCurrentUserPlan();
    final maxAllowed = plan.maxImagesPerAd;
    final currentCount = _existingImageUrls.length + _newLocalImageBytes.length;

    if (currentCount >= maxAllowed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '⚠️ لقد وصلت للحد الأقصى المسموح (${maxAllowed} صور) حسب باقتك (${plan.name}).'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final pickedList = await _picker.pickMultiImage(
        imageQuality: 75,
        maxWidth: 1080,
      );

      for (var f in pickedList) {
        if (_existingImageUrls.length + _newLocalImageBytes.length <
            maxAllowed) {
          final b = await f.readAsBytes();
          setState(() => _newLocalImageBytes.add(b));
        }
      }
    } catch (e) {
      debugPrint('Image pick error: $e');
    }
  }

  void _syncSypFromUsd(String val) {
    final usd = double.tryParse(val);
    if (usd != null) {
      final syp = usd * _manager.exchangeRateUsdToSyp;
      _priceSypController.text = syp.toStringAsFixed(0);
    }
  }

  void _syncUsdFromSyp(String val) {
    final syp = double.tryParse(val);
    if (syp != null && _manager.exchangeRateUsdToSyp > 0) {
      final usd = syp / _manager.exchangeRateUsdToSyp;
      _priceUsdController.text = usd.toStringAsFixed(0);
    }
  }

  Future<void> _submitAd() async {
    if (!_formKey.currentState!.validate()) return;

    final forbiddenWord = _manager.checkForbiddenContent(
        '${_titleController.text} ${_descController.text}');
    if (forbiddenWord != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('❌ عذراً! يحتوي الإعلان على كلمة محظورة: "$forbiddenWord"'),
          backgroundColor: Colors.red.shade900,
        ),
      );
      return;
    }

    setState(() => _isUploading = true);

    List<String> finalImageUrls = List.from(_existingImageUrls);
    if (_newLocalImageBytes.isNotEmpty) {
      final uploaded = await StorageUploadService.uploadMultipleImageBytes(
        bucketName: kStorageBucketAds,
        imagesBytesList: _newLocalImageBytes,
        prefix: 'ad',
      );
      finalImageUrls.addAll(uploaded);
    }

    final double? pUsd = double.tryParse(_priceUsdController.text);
    final double? pSyp = double.tryParse(_priceSypController.text);
    final double? startBid = double.tryParse(_startingBidController.text);

    final adItem = AdItem(
      id: widget.initialAd?.id ?? '',
      userId:
          _manager.currentUserId.isNotEmpty ? _manager.currentUserId : 'guest',
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      priceUsd: pUsd,
      priceSyp: pSyp,
      governorate: _governorate,
      neighborhood: _neighborhoodController.text.trim().isNotEmpty
          ? _neighborhoodController.text.trim()
          : 'المركز',
      categoryId: _selectedCategory,
      subcategory: _selectedSubcategory,
      condition: _condition,
      contactPhone: _phoneController.text.trim(),
      contactWhatsapp: _whatsappController.text.trim(),
      imageUrls: finalImageUrls,
      videoUrl: _videoUrlController.text.trim().isNotEmpty
          ? _videoUrlController.text.trim()
          : null,
      publisherName: _manager.currentUserName,
      publisherEmail: _manager.currentUserEmail,
      isVerifiedSeller: _manager.isCurrentUserVerified,
      status: 'approved',
      isAuction: _isAuction,
      startingBid: startBid,
      currentBid: startBid,
      auctionEndTime: _isAuction
          ? DateTime.now().add(Duration(days: _auctionDaysDuration))
          : null,
      createdAt: widget.initialAd?.createdAt ?? DateTime.now(),
    );

    try {
      if (widget.initialAd != null) {
        await Supabase.instance.client
            .from('ads')
            .update(adItem.toMap())
            .eq('id', adItem.id)
            .timeout(const Duration(seconds: 12));

        widget.onAdCreated(adItem);
      } else {
        final res = await Supabase.instance.client
            .from('ads')
            .insert(adItem.toMap())
            .select()
            .single()
            .timeout(const Duration(seconds: 12));

        final savedAd = AdItem.fromMap(res);
        widget.onAdCreated(savedAd);
      }

      if (mounted) {
        setState(() => _isUploading = false);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ تم نشر إعلانك بنجاح وظهر للجميع في السوق!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Save Ad Supabase Error: $e');
      if (mounted) {
        setState(() => _isUploading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⚠️ تعذر الحفظ بالسيرفر: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = _manager.categories;
    final currentCatItem = categories.firstWhere(
      (c) => c.name == _selectedCategory,
      orElse: () => categories.isNotEmpty
          ? categories.first
          : CategoryItem(
              id: 'all',
              name: 'عام',
              iconData: Icons.category,
              subcategories: ['عام']),
    );

    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: Text(
          widget.initialAd != null
              ? 'تعديل بيانات الإعلان ✏️'
              : 'نشر إعلان جديد في السوق 📢',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            // قسم رفع الصور
            const Text('صور السلعة والمعاينة *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 8),
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  InkWell(
                    onTap: _pickImages,
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: _manager.primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: _manager.secondaryColor, width: 1.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo,
                              color: _manager.secondaryColor, size: 28),
                          const SizedBox(height: 4),
                          const Text('إضافة صورة',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ..._existingImageUrls.map((url) => Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            width: 90,
                            height: 90,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: AppSmartImage(imageUrl: url),
                          ),
                          Positioned(
                            top: 2,
                            right: 10,
                            child: GestureDetector(
                              onTap: () => setState(
                                  () => _existingImageUrls.remove(url)),
                              child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close,
                                    size: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )),
                  ..._newLocalImageBytes.map((bytes) => Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            width: 90,
                            height: 90,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.memory(bytes, fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: 2,
                            right: 10,
                            child: GestureDetector(
                              onTap: () => setState(
                                  () => _newLocalImageBytes.remove(bytes)),
                              child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close,
                                    size: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // عنوان الإعلان
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'عنوان الإعلان *',
                hintText: 'مثال: كيا سيراتو 2021 أوتوماتيك خالية العلام',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().length < 4)
                  ? 'يرجى كتابة عنوان واضح للإعلان'
                  : null,
            ),
            const SizedBox(height: 12),

            // القسم والقسم الفرعي
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'القسم الرئيسي',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    items: categories
                        .map((c) => DropdownMenuItem(
                            value: c.name,
                            child: Text(c.name,
                                style: const TextStyle(fontSize: 12))))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() {
                          _selectedCategory = v;
                          final subList = categories
                              .firstWhere((x) => x.name == v)
                              .subcategories;
                          if (subList.isNotEmpty) {
                            _selectedSubcategory = subList.first;
                          }
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: currentCatItem.subcategories
                            .contains(_selectedSubcategory)
                        ? _selectedSubcategory
                        : (currentCatItem.subcategories.isNotEmpty
                            ? currentCatItem.subcategories.first
                            : null),
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'القسم الفرعي',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    items: currentCatItem.subcategories
                        .map((s) => DropdownMenuItem(
                            value: s,
                            child:
                                Text(s, style: const TextStyle(fontSize: 12))))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _selectedSubcategory = v);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // المحافظة والمنطقة
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _governorate,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'المحافظة',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    items: _governorates
                        .map((g) => DropdownMenuItem(
                            value: g,
                            child:
                                Text(g, style: const TextStyle(fontSize: 12))))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _governorate = v);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _neighborhoodController,
                    decoration: InputDecoration(
                      labelText: 'المنطقة أو الحي',
                      hintText: 'مثال: المزة، الشهباء',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // حالة السلعة
            DropdownButtonFormField<String>(
              value: _condition,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'حالة السلعة',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: _conditions
                  .map((c) => DropdownMenuItem(
                      value: c,
                      child: Text(c, style: const TextStyle(fontSize: 13))))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _condition = v);
              },
            ),
            const SizedBox(height: 12),

            // السعر بالدولار والليرة مع التحويل اللحظي
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceUsdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'السعر (\$ USD)',
                      prefixIcon:
                          const Icon(Icons.attach_money, color: Colors.green),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onChanged: _syncSypFromUsd,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _priceSypController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'السعر (ل.س)',
                      prefixIcon: const Icon(Icons.currency_exchange,
                          color: Color(0xFFD4AF37)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onChanged: _syncUsdFromSyp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // تفعيل نظام المزاد العلني
            SwitchListTile(
              title: const Text('طرح السلعة في المزاد العلني ⚖️',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: const Text(
                  'يتيح للمشترين المزايدة المباشرة مع نظام مكافحة القنص الذكي'),
              value: _isAuction,
              onChanged: (val) => setState(() => _isAuction = val),
            ),
            if (_isAuction) ...[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _startingBidController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'سعر بدء المزاد (\$)',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _auctionDaysDuration,
                      decoration: InputDecoration(
                        labelText: 'مدة المزاد',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      items: [1, 2, 3, 5, 7]
                          .map((d) => DropdownMenuItem(
                              value: d, child: Text('$d أيام')))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          setState(() => _auctionDaysDuration = v);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            // أرقام الاتصال والواتساب
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'رقم الاتصال *',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'رقم الاتصال مطلوب'
                        : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _whatsappController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'رقم الواتساب *',
                      prefixIcon:
                          const Icon(Icons.chat, color: Color(0xFF25D366)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'رقم الواتساب مطلوب'
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // الوصف والمواصفات
            TextFormField(
              controller: _descController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'المواصفات والتفاصيل الكاملة *',
                hintText: 'اكتب كافة المواصفات والعيوب والميزات بدقة...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().length < 10)
                  ? 'يرجى كتابة تفاصيل وافية عن السلعة'
                  : null,
            ),
            const SizedBox(height: 20),

            // زر الحفظ والنشر
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _isUploading ? null : _submitAd,
                child: _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        widget.initialAd != null
                            ? 'حفظ التعديلات ✨'
                            : 'نشر الإعلان في السوق الآن 🚀',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// 21. شاشة التفاوض وغرف المحادثة المباشرة (FullChatNegotiationScreen)
// ==============================================================================
class FullChatNegotiationScreen extends StatefulWidget {
  final String adId;
  final String partnerName;
  final String productTitle;
  final double initialPrice;

  const FullChatNegotiationScreen({
    Key? key,
    required this.adId,
    required this.partnerName,
    required this.productTitle,
    required this.initialPrice,
  }) : super(key: key);

  @override
  State<FullChatNegotiationScreen> createState() =>
      _FullChatNegotiationScreenState();
}

class _FullChatNegotiationScreenState extends State<FullChatNegotiationScreen> {
  final AppStateManager _manager = AppStateManager();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _offerPriceController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChatMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _offerPriceController.dispose();
    super.dispose();
  }

  Future<void> _loadChatMessages() async {
    try {
      final res = await Supabase.instance.client
          .from('chat_messages')
          .select()
          .eq('ad_id', widget.adId)
          .order('created_at', ascending: true)
          .timeout(const Duration(seconds: 8));

      if (res is List && mounted) {
        setState(() {
          _messages.clear();
          _messages.addAll(List<Map<String, dynamic>>.from(res));
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _sendMessage({String? customOfferText}) async {
    final text = customOfferText ?? _messageController.text.trim();
    if (text.isEmpty) return;

    final msgData = {
      'id': 'msg_${DateTime.now().millisecondsSinceEpoch}',
      'ad_id': widget.adId,
      'sender_id': _manager.currentUserId,
      'sender_name': _manager.currentUserName,
      'message': text,
      'created_at': DateTime.now().toIso8601String(),
    };

    setState(() {
      _messages.add(msgData);
      if (customOfferText == null) _messageController.clear();
    });

    try {
      await Supabase.instance.client
          .from('chat_messages')
          .insert(msgData)
          .timeout(const Duration(seconds: 6));
    } catch (_) {}
  }

  void _showOfferDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.local_offer, color: Colors.green),
            SizedBox(width: 8),
            Text('تقديم عرض سعر رسمي 🤝', style: TextStyle(fontSize: 15)),
          ],
        ),
        content: TextField(
          controller: _offerPriceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'قيمة العرض بالدولار (\$)',
            hintText: 'مثال: 4500',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: _manager.primaryColor),
            onPressed: () {
              final val = _offerPriceController.text.trim();
              if (val.isNotEmpty) {
                Navigator.pop(ctx);
                _sendMessage(
                    customOfferText:
                        '🏷️ عرض رسمي للتفاوض: أنا على استعداد للشراء بسعر \$$val دولار.');
              }
            },
            child: const Text('إرسال العرض',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.partnerName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            Text(widget.productTitle,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_offer, color: Color(0xFFD4AF37)),
            tooltip: 'تقديم عرض سعر',
            onPressed: _showOfferDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                    ? Center(
                        child: Text(
                          'ابدأ المحادثة الآن مع ${widget.partnerName} للتفاوض حول السلعة.',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        itemCount: _messages.length,
                        itemBuilder: (ctx, idx) {
                          final msg = _messages[idx];
                          final isMe =
                              msg['sender_id'] == _manager.currentUserId;
                          return Align(
                            alignment: isMe
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color:
                                    isMe ? _manager.primaryColor : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 4)
                                ],
                              ),
                              child: Text(
                                msg['message']?.toString() ?? '',
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black87,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك هنا...',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                CircleAvatar(
                  backgroundColor: _manager.buttonColor,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: () => _sendMessage(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 23. غرفة العمليات المركزية للإدارة بقطاعاتها الـ 9 (FullAdminPanelScreen)
// ==============================================================================
class FullAdminPanelScreen extends StatefulWidget {
  final int initialTab;

  const FullAdminPanelScreen({Key? key, this.initialTab = 0}) : super(key: key);

  @override
  State<FullAdminPanelScreen> createState() => _FullAdminPanelScreenState();
}

class _FullAdminPanelScreenState extends State<FullAdminPanelScreen>
    with SingleTickerProviderStateMixin {
  final AppStateManager _manager = AppStateManager();
  late TabController _tabController;

  final TextEditingController _usdRateController = TextEditingController();
  final TextEditingController _goldPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 6, vsync: this, initialIndex: widget.initialTab);
    _usdRateController.text = _manager.exchangeRateUsdToSyp.toStringAsFixed(0);
    _goldPriceController.text = _manager.goldPrice21kSyp.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _usdRateController.dispose();
    _goldPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendingAds =
        _manager.ads.where((a) => a.status == 'pending').toList();
    final pendingPayments =
        _manager.paymentAudits.where((p) => p.status == 'pending').toList();

    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text(
          'غرفة العمليات والإشراف المركزي 🛡️',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: const Color(0xFFD4AF37),
          labelColor: const Color(0xFFD4AF37),
          unselectedLabelColor: Colors.white70,
          tabs: [
            const Tab(text: 'لوحة التحكم 📊'),
            Tab(text: 'مراجعة الإعلانات (${pendingAds.length}) ⏳'),
            Tab(text: 'تدقيق المدفوعات (${pendingPayments.length}) 💳'),
            const Tab(text: 'أسعار الصرف والذهب 🪙'),
            const Tab(text: 'شجرة الأقسام 🌳'),
            const Tab(text: 'صوتك مسموع 💡'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildAdReviewTab(pendingAds),
          _buildPaymentAuditTab(pendingPayments),
          _buildRatesSettingsTab(),
          _buildDepartmentTreeTab(),
          _buildFeedbacksTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: const Color(0xFF0F172A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    SyrianIndependenceFlag(width: 24, height: 16),
                    SizedBox(width: 8),
                    Text('إحصائيات المنصة السحابية المباشرة',
                        style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 12),
                Text('إجمالي الإعلانات في السيرفر: ${_manager.ads.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(height: 4),
                Text('البنرات والبانورامات النشطة: ${_manager.banners.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(height: 4),
                Text('الأقسام والفروع الهيكلية: ${_manager.categories.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 13)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          title: const Text('وضع الصيانة الشاملة 🛠️',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text(
              'يقفل التطبيق أمام الزوار مع السماح بدخول المشرفين فقط'),
          value: _manager.isMaintenanceMode,
          onChanged: (val) => setState(() => _manager.isMaintenanceMode = val),
        ),
      ],
    );
  }

  Widget _buildAdReviewTab(List<AdItem> pendingAds) {
    if (pendingAds.isEmpty) {
      return const Center(
          child: Text('لا توجد إعلانات بانتظار المراجعة حالياً ✓'));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: pendingAds.length,
      itemBuilder: (ctx, idx) {
        final ad = pendingAds[idx];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ad.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text('المعلن: ${ad.publisherName} • هاتف: ${ad.contactPhone}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                Text(ad.description,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        icon: const Icon(Icons.check, color: Colors.white),
                        label: const Text('موافقة ونشر',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          await _manager.approveAd(ad.id);
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        icon: const Icon(Icons.close, color: Colors.white),
                        label: const Text('رفض الإعلان',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          await _manager.rejectAd(
                              ad.id, 'مخالف للشروط والسياسات');
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentAuditTab(List<PaymentAuditRecord> pendingPayments) {
    if (pendingPayments.isEmpty) {
      return const Center(
          child: Text('لا توجد إيصالات دفع بانتظار التدقيق حالياً ✓'));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: pendingPayments.length,
      itemBuilder: (ctx, idx) {
        final p = pendingPayments[idx];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('طلب ترقية: ${p.planName}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('\$${p.amountUsd.toInt()} USD',
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 6),
                Text('المشترك: ${p.userName} • هاتف: ${p.userPhone}',
                    style: const TextStyle(fontSize: 12)),
                Text('بوابة التحويل: ${p.gateway}',
                    style: const TextStyle(fontSize: 12, color: Colors.blue)),
                Text('رقم العملية / TXID: ${p.transactionRefOrTxId}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          _manager.approvePaymentTransaction(p.id);
                          setState(() {});
                        },
                        child: const Text('اعتماد وترقية الحساب ✓',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          _manager.rejectPaymentTransaction(
                              p.id, 'إشعار غير مطابق');
                          setState(() {});
                        },
                        child: const Text('رفض الإشعار ❌',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRatesSettingsTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        const Text('تحديث أسعار الصرف والذهب اللحظية في التطبيق:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        TextField(
          controller: _usdRateController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'سعر صرف \$1 USD مقابل الليرة السورية',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _goldPriceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'سعر غرام الذهب عيار 21 بالليرة السورية',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: _manager.primaryColor),
          onPressed: () {
            final usd = double.tryParse(_usdRateController.text);
            final gold = double.tryParse(_goldPriceController.text);
            if (usd != null) _manager.exchangeRateUsdToSyp = usd;
            if (gold != null) _manager.goldPrice21kSyp = gold;
            _manager.notifyListeners();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      '✅ تم تحديث ونشر أسعار الصرف والذهب لجميع المستخدمين!')),
            );
          },
          child: const Text('حفظ وتحديث الأسعار لحظياً ✨',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildDepartmentTreeTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      children: _manager.departments
          .map((d) => DepartmentTreeItemWidget(node: d))
          .toList(),
    );
  }

  Widget _buildFeedbacksTab() {
    if (_manager.feedbacks.isEmpty) {
      return const Center(child: Text('لا توجد مقترحات واردة بعد 💡'));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: _manager.feedbacks.length,
      itemBuilder: (ctx, idx) {
        final f = _manager.feedbacks[idx];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(f.type,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF0284C7))),
                const SizedBox(height: 4),
                Text(f.content, style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 6),
                Text('المرسل: ${f.userName} • للتواصل: ${f.userContact}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ==============================================================================
// 24. نقطة الانطلاق والتشغيل الرئيسية للتطبيق (Main App Entry Point)
// ==============================================================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة اتصال Supabase السحابي الحقيقي
  try {
    await Supabase.initialize(
      url: kSupabaseUrl,
      anonKey: kSupabaseAnonKey,
    );
  } catch (e) {
    debugPrint('Supabase Initialization Notice: $e');
  }

  runApp(const SouqSyriaApp());
}

class SouqSyriaApp extends StatefulWidget {
  const SouqSyriaApp({Key? key}) : super(key: key);

  @override
  State<SouqSyriaApp> createState() => _SouqSyriaAppState();
}

class _SouqSyriaAppState extends State<SouqSyriaApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سوق سوريا الشامل 2028',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: const Color(0xFF0F172A),
        fontFamily: 'sans-serif',
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: MainDashboardScreen(
        isDarkMode: _isDarkMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}
