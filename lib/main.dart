// ==============================================================================
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [القسم الأول المطور: الثوابت، نماذج البيانات، إدارة الحالة السحابية المتصلة بالسيرفر، والمصادقة]
// ==============================================================================

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// --- استيرادات Firebase الرسمية ---
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// --- استيرادات Supabase والمكتبات المساعدة ---
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';

// ==============================================================================
// 1. الثوابت السيادية السورية والمفاتيح السحابية الرسمية الحقيقية 100%
// ==============================================================================
const String kSupabaseUrl = 'https://zbjjkigkxbpktpmpcdqc.supabase.co';
const String kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpiampraWdreGJwa3RwbXBjZHFjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAzNjY3NjAsImV4cCI6MjA1NTk0Mjc2MH0.kM6i-E4d-Ea938j-e7KqE-3jM4K_Z5n6J-6O4L_2p5A';

// بوابتي الدفع المعتمدتين حصرياً في المنظومة
const String kShamCashAccountKey = '0308a7227251b7c8ebca471cd30b15a8';
const String kBinanceWalletAddress = 'TCHJ8QyEijnRsQmyXJWBCoiuPET1mZqBK2';

// معلومات التواصل مع الإدارة
const String kAppOwnerPhone = '+963933000000';
const String kAppOwnerWhatsApp = '+963933000000';
const String kDefaultShareDomain =
    'https://celadon-pithivier-77918a.netlify.app';

// الحسابات الإدارية المعتمدة لغرفة العمليات المركزية حصراً (2 فقط: سامر + عواد)
const List<String> kAuthorizedAdminEmails = [
  'aoaadabdo@gmail.com',
  'sameraoaad@gmail.com',
];

// أسماء حاويات التخزين السحابي (Buckets)
const String kStorageBucketAds = 'ad_images';
const String kStorageBucketBanners = 'banners';
const String kStorageBucketFeedbacks = 'feedback_screenshots';
const String kStorageBucketAudios = 'profile_audios';
const String kStorageBucketAvatars = 'avatars';
const String kStorageBucketReceipts = 'payment_receipts';

// دالة مساعدة عامة لتحويل القوائم النصية بأمان تام ومنع انهيار قراءة الـ JSON
List<String> _parseStringList(dynamic value) {
  if (value == null) return [];
  if (value is List) {
    return value.map((e) => e.toString()).toList();
  }
  if (value is String) {
    if (value.startsWith('[') && value.endsWith(']')) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is List) {
          return decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {}
    }
    if (value.contains(',')) {
      return value
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    if (value.trim().isNotEmpty) {
      return [value.trim()];
    }
  }
  return [];
}

// ==============================================================================
// 2. كلاس نتيجة فحص منع القنص للمزادات (SnipResult)
// ==============================================================================
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

// ==============================================================================
// 3. راية علم الاستقلال السوري السيادي (SyrianIndependenceFlag)
// ==============================================================================
class SyrianIndependenceFlag extends StatelessWidget {
  final double width;
  final double height;

  const SyrianIndependenceFlag({
    Key? key,
    this.width = 28,
    this.height = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.black26, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Container(color: const Color(0xFF007A3D)),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('★',
                      style: TextStyle(
                          color: Color(0xFFDC2626),
                          fontSize: 7,
                          height: 1,
                          fontWeight: FontWeight.bold)),
                  Text('★',
                      style: TextStyle(
                          color: Color(0xFFDC2626),
                          fontSize: 7,
                          height: 1,
                          fontWeight: FontWeight.bold)),
                  Text('★',
                      style: TextStyle(
                          color: Color(0xFFDC2626),
                          fontSize: 7,
                          height: 1,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(color: const Color(0xFF1E293B)),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 4. مساعد معالجة النصوص والأرقام السورية (PhoneHelper)
// ==============================================================================
class PhoneHelper {
  static String formatForWhatsapp(String input) {
    String clean = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (clean.startsWith('09')) {
      clean = '963${clean.substring(1)}';
    } else if (clean.startsWith('9') && clean.length == 9) {
      clean = '963$clean';
    }
    return clean;
  }

  static bool isValidPhone(String input) {
    final clean = input.replaceAll(RegExp(r'[^0-9]'), '');
    return clean.length >= 9;
  }

  static String normalizeCategory(String cat) {
    return cat
        .replaceAll(RegExp(r'[\u{1F300}-\u{1FAFF}]', unicode: true), '')
        .trim();
  }

  static Future<void> openAdminWhatsApp(String message) async {
    final clean = formatForWhatsapp(kAppOwnerWhatsApp);
    final enc = Uri.encodeComponent(message);
    final uri = Uri.parse('https://wa.me/$clean?text=$enc');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  static Future<void> callPhone(String phone) async {
    final clean = formatForWhatsapp(phone);
    final uri = Uri.parse('tel:$clean');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (_) {}
  }

  static Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }
}

// ==============================================================================
// 5. نماذج البيانات المتكاملة (AdItem, BannerItem, ActivationCode, CategoryItem...)
// ==============================================================================
class DepartmentNode {
  final String id;
  final String nameAr;
  final String description;
  final String iconName;
  final int activeAdsCount;
  final List<DepartmentNode> subBranches;

  DepartmentNode({
    required this.id,
    required this.nameAr,
    this.description = '',
    this.iconName = 'Category',
    this.activeAdsCount = 0,
    this.subBranches = const [],
  });
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
  final String categoryName;
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
  final String publisherAvatarUrl;
  final String publisherBio;
  final String sellerPlanId;
  final bool isVerifiedSeller;
  final int sellerPositiveLikes;
  final int sellerDislikes;
  final String status;
  final bool isAuction;
  final double? startingBid;
  final double? currentBid;
  final DateTime? auctionEndTime;
  final List<BidRecord> bids;
  final int viewsCount;
  final int callClicksCount;
  final int whatsappClicksCount;
  final bool isFeatured;
  final bool isSold;
  final DateTime? soldAt;
  final String? rejectionReason;
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
    this.categoryName = '',
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
    this.publisherEmail = '',
    this.publisherAvatarUrl = '',
    this.publisherBio = '',
    this.sellerPlanId = 'plan_free',
    this.isVerifiedSeller = false,
    this.sellerPositiveLikes = 0,
    this.sellerDislikes = 0,
    this.status = 'pending',
    this.isAuction = false,
    this.startingBid,
    this.currentBid,
    this.auctionEndTime,
    this.bids = const [],
    this.viewsCount = 0,
    this.callClicksCount = 0,
    this.whatsappClicksCount = 0,
    this.isFeatured = false,
    this.isSold = false,
    this.soldAt,
    this.rejectionReason,
    required this.createdAt,
  });

  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';

  Duration? get soldRemainingDuration {
    if (!isSold || soldAt == null) return null;
    final deadline = soldAt!.add(const Duration(minutes: 60));
    final diff = deadline.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  bool get shouldBeDeletedNow {
    if (!isSold || soldAt == null) return false;
    return DateTime.now().isAfter(soldAt!.add(const Duration(minutes: 60)));
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
    String? categoryName,
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
    String? publisherAvatarUrl,
    String? publisherBio,
    String? sellerPlanId,
    bool? isVerifiedSeller,
    int? sellerPositiveLikes,
    int? sellerDislikes,
    String? status,
    bool? isAuction,
    double? startingBid,
    double? currentBid,
    DateTime? auctionEndTime,
    List<BidRecord>? bids,
    int? viewsCount,
    int? callClicksCount,
    int? whatsappClicksCount,
    bool? isFeatured,
    bool? isSold,
    DateTime? soldAt,
    String? rejectionReason,
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
      categoryName: categoryName ?? this.categoryName,
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
      publisherAvatarUrl: publisherAvatarUrl ?? this.publisherAvatarUrl,
      publisherBio: publisherBio ?? this.publisherBio,
      sellerPlanId: sellerPlanId ?? this.sellerPlanId,
      isVerifiedSeller: isVerifiedSeller ?? this.isVerifiedSeller,
      sellerPositiveLikes: sellerPositiveLikes ?? this.sellerPositiveLikes,
      sellerDislikes: sellerDislikes ?? this.sellerDislikes,
      status: status ?? this.status,
      isAuction: isAuction ?? this.isAuction,
      startingBid: startingBid ?? this.startingBid,
      currentBid: currentBid ?? this.currentBid,
      auctionEndTime: auctionEndTime ?? this.auctionEndTime,
      bids: bids ?? this.bids,
      viewsCount: viewsCount ?? this.viewsCount,
      callClicksCount: callClicksCount ?? this.callClicksCount,
      whatsappClicksCount: whatsappClicksCount ?? this.whatsappClicksCount,
      isFeatured: isFeatured ?? this.isFeatured,
      isSold: isSold ?? this.isSold,
      soldAt: soldAt ?? this.soldAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'price_usd': priceUsd,
      'price_syp': priceSyp,
      'governorate': governorate,
      'neighborhood': neighborhood,
      'category_id': categoryId,
      'category_name': categoryName.isNotEmpty ? categoryName : categoryId,
      'subcategory': subcategory,
      'condition': condition,
      'contact_phone': contactPhone,
      'contact_whatsapp': contactWhatsapp,
      'image_urls': imageUrls,
      'video_url': videoUrl,
      'facebook_url': facebookUrl,
      'telegram_url': telegramUrl,
      'instagram_url': instagramUrl,
      'tiktok_url': tiktokUrl,
      'youtube_url': youtubeUrl,
      'publisher_name': publisherName,
      'publisher_email': publisherEmail,
      'publisher_avatar_url': publisherAvatarUrl,
      'publisher_bio': publisherBio,
      'seller_plan_id': sellerPlanId,
      'is_verified_seller': isVerifiedSeller,
      'seller_positive_likes': sellerPositiveLikes,
      'seller_dislikes': sellerDislikes,
      'status': status,
      'is_auction': isAuction,
      'starting_bid': startingBid,
      'current_bid': currentBid,
      'auction_end_time': auctionEndTime?.toIso8601String(),
      'views_count': viewsCount,
      'call_clicks_count': callClicksCount,
      'whatsapp_clicks_count': whatsappClicksCount,
      'is_featured': isFeatured,
      'is_sold': isSold,
      'sold_at': soldAt?.toIso8601String(),
      'rejection_reason': rejectionReason,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory AdItem.fromMap(Map<String, dynamic> map) {
    final rawBids = map['bids'];
    List<BidRecord> parsedBids = [];
    if (rawBids is List) {
      parsedBids = rawBids
          .whereType<Map<String, dynamic>>()
          .map((b) => BidRecord.fromMap(b))
          .toList();
    }

    return AdItem(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      priceUsd: map['price_usd'] != null
          ? double.tryParse(map['price_usd'].toString())
          : null,
      priceSyp: map['price_syp'] != null
          ? double.tryParse(map['price_syp'].toString())
          : null,
      governorate: map['governorate']?.toString() ?? 'إدلب',
      neighborhood: map['neighborhood']?.toString() ?? 'المركز',
      categoryId: map['category_id']?.toString() ?? 'cars',
      categoryName: map['category_name']?.toString() ??
          (map['category_id']?.toString() ?? ''),
      subcategory: map['subcategory']?.toString() ?? 'سيارات سياحية للبيع',
      condition: map['condition']?.toString() ?? 'مستعمل بحالة ممتازة',
      contactPhone: map['contact_phone']?.toString() ?? '',
      contactWhatsapp: map['contact_whatsapp']?.toString() ?? '',
      imageUrls: _parseStringList(map['image_urls'] ?? map['image']),
      videoUrl: map['video_url']?.toString(),
      facebookUrl: map['facebook_url']?.toString(),
      telegramUrl: map['telegram_url']?.toString(),
      instagramUrl: map['instagram_url']?.toString(),
      tiktokUrl: map['tiktok_url']?.toString(),
      youtubeUrl: map['youtube_url']?.toString(),
      publisherName: map['publisher_name']?.toString() ?? 'مستخدم المنصة',
      publisherEmail: map['publisher_email']?.toString() ?? '',
      publisherAvatarUrl: map['publisher_avatar_url']?.toString() ?? '',
      publisherBio: map['publisher_bio']?.toString() ?? '',
      sellerPlanId: map['seller_plan_id']?.toString() ?? 'plan_free',
      isVerifiedSeller: map['is_verified_seller'] == true,
      sellerPositiveLikes:
          int.tryParse(map['seller_positive_likes']?.toString() ?? '0') ?? 0,
      sellerDislikes:
          int.tryParse(map['seller_dislikes']?.toString() ?? '0') ?? 0,
      status: map['status']?.toString() ?? 'pending',
      isAuction: map['is_auction'] == true,
      startingBid: map['starting_bid'] != null
          ? double.tryParse(map['starting_bid'].toString())
          : null,
      currentBid: map['current_bid'] != null
          ? double.tryParse(map['current_bid'].toString())
          : null,
      auctionEndTime: map['auction_end_time'] != null
          ? DateTime.tryParse(map['auction_end_time'].toString())
          : null,
      bids: parsedBids,
      viewsCount: int.tryParse(map['views_count']?.toString() ?? '0') ?? 0,
      callClicksCount:
          int.tryParse(map['call_clicks_count']?.toString() ?? '0') ?? 0,
      whatsappClicksCount:
          int.tryParse(map['whatsapp_clicks_count']?.toString() ?? '0') ?? 0,
      isFeatured: map['is_featured'] == true,
      isSold: map['is_sold'] == true,
      soldAt: map['sold_at'] != null
          ? DateTime.tryParse(map['sold_at'].toString())
          : null,
      rejectionReason: map['rejection_reason']?.toString(),
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}

class BidRecord {
  final String id;
  final String userId;
  final String userName;
  final String userPhone;
  final double amount;
  final double? amountSyp;
  final DateTime timestamp;

  BidRecord({
    required this.id,
    required this.userId,
    required this.userName,
    this.userPhone = '',
    required this.amount,
    this.amountSyp,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'user_name': userName,
        'user_phone': userPhone,
        'amount': amount,
        'amount_syp': amountSyp,
        'timestamp': timestamp.toIso8601String(),
      };

  factory BidRecord.fromMap(Map<String, dynamic> map) => BidRecord(
        id: map['id']?.toString() ?? '',
        userId: map['user_id']?.toString() ?? '',
        userName: map['user_name']?.toString() ?? 'مزايد',
        userPhone: map['user_phone']?.toString() ?? '',
        amount: map['amount'] != null
            ? double.tryParse(map['amount'].toString()) ?? 0.0
            : 0.0,
        amountSyp: map['amount_syp'] != null
            ? double.tryParse(map['amount_syp'].toString())
            : null,
        timestamp: map['timestamp'] != null
            ? DateTime.tryParse(map['timestamp'].toString()) ?? DateTime.now()
            : DateTime.now(),
      );
}

class BannerItem {
  final String id;
  final int slotIndex;
  final List<String> imageUrls;
  final String title;
  final String subtitle;
  final String description;
  final String location;
  final String phone;
  final String whatsapp;
  final String? targetExternalUrl;
  final String badgeText;
  final Color badgeColor;
  final int displayDurationSeconds;
  final int clicksCount;
  final bool isActive;
  final DateTime startsAt;
  final DateTime expiresAt;

  BannerItem({
    required this.id,
    this.slotIndex = 1,
    required this.imageUrls,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.location,
    required this.phone,
    required this.whatsapp,
    this.targetExternalUrl,
    this.badgeText = 'VIP ★',
    this.badgeColor = const Color(0xFFD4AF37),
    this.displayDurationSeconds = 4,
    this.clicksCount = 0,
    this.isActive = true,
    DateTime? startsAt,
    required this.expiresAt,
  }) : startsAt = startsAt ?? DateTime.now();

  String get imageUrl => imageUrls.isNotEmpty ? imageUrls.first : '';
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Map<String, dynamic> toMap() => {
        'id': id,
        'slot_index': slotIndex,
        'image_urls': imageUrls,
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'location': location,
        'phone': phone,
        'whatsapp': whatsapp,
        'target_external_url': targetExternalUrl,
        'badge_text': badgeText,
        'display_duration': displayDurationSeconds,
        'clicks_count': clicksCount,
        'is_active': isActive,
        'starts_at': startsAt.toIso8601String(),
        'expires_at': expiresAt.toIso8601String(),
      };

  factory BannerItem.fromMap(Map<String, dynamic> map) {
    return BannerItem(
      id: map['id']?.toString() ?? '',
      slotIndex: int.tryParse(map['slot_index']?.toString() ?? '1') ?? 1,
      imageUrls: _parseStringList(map['image_urls'] ?? map['image_url']),
      title: map['title']?.toString() ?? '',
      subtitle: map['subtitle']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      location: map['location']?.toString() ?? 'إدلب وكل المحافظات',
      phone: map['phone']?.toString() ?? '',
      whatsapp: map['whatsapp']?.toString() ?? '',
      targetExternalUrl: map['target_external_url']?.toString(),
      badgeText: map['badge_text']?.toString() ?? 'VIP ★',
      displayDurationSeconds:
          int.tryParse(map['display_duration']?.toString() ?? '4') ?? 4,
      clicksCount: int.tryParse(map['clicks_count']?.toString() ?? '0') ?? 0,
      isActive: map['is_active'] != false,
      startsAt: map['starts_at'] != null
          ? DateTime.tryParse(map['starts_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      expiresAt: map['expires_at'] != null
          ? DateTime.tryParse(map['expires_at'].toString()) ??
              DateTime.now().add(const Duration(days: 30))
          : DateTime.now().add(const Duration(days: 30)),
    );
  }
}

class BannerSlotItem {
  final int slotNumber;
  final bool isBooked;
  final BannerItem? currentBanner;
  final DateTime? availableFromDate;

  BannerSlotItem({
    required this.slotNumber,
    required this.isBooked,
    this.currentBanner,
    this.availableFromDate,
  });
}

class ActivationCodeItem {
  final String id;
  final String code;
  final String packageType;
  final int durationDays;
  final int isUsed;
  final String? usedByUserId;
  final DateTime? expiresAt;
  final DateTime createdAt;

  ActivationCodeItem({
    String? id,
    required this.code,
    required this.packageType,
    this.durationDays = 30,
    this.isUsed = 0,
    this.usedByUserId,
    this.expiresAt,
    DateTime? createdAt,
  })  : id = id ?? 'act_${DateTime.now().millisecondsSinceEpoch}',
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'package_type': packageType,
        'duration_days': durationDays,
        'is_used': isUsed,
        'used_by_user_id': usedByUserId,
        'expires_at': expiresAt?.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
      };

  factory ActivationCodeItem.fromMap(Map<String, dynamic> map) {
    return ActivationCodeItem(
      id: map['id']?.toString() ?? '',
      code: map['code']?.toString() ?? '',
      packageType: map['package_type']?.toString() ?? 'ALL_ACCESS',
      durationDays:
          int.tryParse(map['duration_days']?.toString() ?? '30') ?? 30,
      isUsed: int.tryParse(map['is_used']?.toString() ?? '0') ?? 0,
      usedByUserId: map['used_by_user_id']?.toString(),
      expiresAt: map['expires_at'] != null
          ? DateTime.tryParse(map['expires_at'].toString())
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : DateTime.now(),
    );
  }
}

class PaymentReceiptItem {
  final String id;
  final String userId;
  final String planId;
  final String paymentMethod;
  final double amount;
  final String currency;
  final String transactionNumber;
  final String receiptImageUrl;
  final String status;
  final DateTime createdAt;

  PaymentReceiptItem({
    required this.id,
    required this.userId,
    required this.planId,
    required this.paymentMethod,
    required this.amount,
    required this.currency,
    required this.transactionNumber,
    required this.receiptImageUrl,
    this.status = 'pending',
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'plan_id': planId,
        'payment_method': paymentMethod,
        'amount': amount,
        'currency': currency,
        'transaction_number': transactionNumber,
        'receipt_image_url': receiptImageUrl,
        'status': status,
        'created_at': createdAt.toIso8601String(),
      };

  factory PaymentReceiptItem.fromMap(Map<String, dynamic> map) {
    return PaymentReceiptItem(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      planId: map['plan_id']?.toString() ?? 'plan_free',
      paymentMethod: map['payment_method']?.toString() ?? 'SHAM_CASH',
      amount: map['amount'] != null
          ? double.tryParse(map['amount'].toString()) ?? 0.0
          : 0.0,
      currency: map['currency']?.toString() ?? 'SYP',
      transactionNumber: map['transaction_number']?.toString() ?? '',
      receiptImageUrl: map['receipt_image_url']?.toString() ?? '',
      status: map['status']?.toString() ?? 'pending',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}

class CategoryItem {
  final String id;
  final String name;
  final IconData iconData;
  final List<String> subcategories;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadiusValue;
  final int orderIndex;
  final bool isVisible;

  CategoryItem({
    required this.id,
    required this.name,
    required this.iconData,
    required this.subcategories,
    this.backgroundColor = const Color(0xFF0F172A),
    this.textColor = Colors.white,
    this.borderRadiusValue = 10,
    this.orderIndex = 0,
    this.isVisible = true,
  });

  CategoryItem copyWith({
    String? id,
    String? name,
    IconData? iconData,
    List<String>? subcategories,
    Color? backgroundColor,
    Color? textColor,
    double? borderRadiusValue,
    int? orderIndex,
    bool? isVisible,
  }) {
    return CategoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      iconData: iconData ?? this.iconData,
      subcategories: subcategories ?? this.subcategories,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      borderRadiusValue: borderRadiusValue ?? this.borderRadiusValue,
      orderIndex: orderIndex ?? this.orderIndex,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'icon_code': iconData.codePoint,
        'subcategories': subcategories,
        'order_index': orderIndex,
        'is_visible': isVisible,
      };

  factory CategoryItem.fromMap(Map<String, dynamic> map) {
    return CategoryItem(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      iconData: map['icon_code'] != null
          ? IconData(
              int.tryParse(map['icon_code'].toString()) ??
                  Icons.category.codePoint,
              fontFamily: 'MaterialIcons')
          : Icons.category,
      subcategories: _parseStringList(map['subcategories']),
      orderIndex: int.tryParse(map['order_index']?.toString() ?? '0') ?? 0,
      isVisible: map['is_visible'] != false,
    );
  }
}

class SubscriptionPlanItem {
  final String id;
  final String name;
  final String titleBadge;
  final double priceUsd;
  final int maxImagesPerAd;
  final List<String> features;
  final Color badgeColor;
  final LinearGradient cardGradient;
  final bool hasVoiceProfile;
  final bool canAddSocialLinks;
  final bool isDiamondVip;

  SubscriptionPlanItem({
    required this.id,
    required this.name,
    this.titleBadge = 'عضو مميز',
    required this.priceUsd,
    required this.maxImagesPerAd,
    required this.features,
    this.badgeColor = const Color(0xFF0284C7),
    this.cardGradient = const LinearGradient(
      colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
    ),
    this.hasVoiceProfile = false,
    this.canAddSocialLinks = false,
    this.isDiamondVip = false,
  });
}

class PaymentAuditRecord {
  final String id;
  final String userId;
  final String userName;
  final String userPhone;
  final String planId;
  final String planName;
  final double amountUsd;
  final String gateway;
  final String transactionRefOrTxId;
  final String status;
  final DateTime createdAt;

  PaymentAuditRecord({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.planId,
    required this.planName,
    required this.amountUsd,
    required this.gateway,
    required this.transactionRefOrTxId,
    this.status = 'pending',
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'user_name': userName,
        'user_phone': userPhone,
        'plan_id': planId,
        'plan_name': planName,
        'amount_usd': amountUsd,
        'gateway': gateway,
        'transaction_ref': transactionRefOrTxId,
        'status': status,
        'created_at': createdAt.toIso8601String(),
      };

  factory PaymentAuditRecord.fromMap(Map<String, dynamic> map) =>
      PaymentAuditRecord(
        id: map['id']?.toString() ?? '',
        userId: map['user_id']?.toString() ?? '',
        userName: map['user_name']?.toString() ?? '',
        userPhone: map['user_phone']?.toString() ?? '',
        planId: map['plan_id']?.toString() ?? '',
        planName: map['plan_name']?.toString() ?? '',
        amountUsd: map['amount_usd'] != null
            ? double.tryParse(map['amount_usd'].toString()) ?? 0.0
            : 0.0,
        gateway: map['gateway']?.toString() ?? '',
        transactionRefOrTxId: map['transaction_ref']?.toString() ??
            map['tx_id']?.toString() ??
            '',
        status: map['status']?.toString() ?? 'pending',
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
        userName: map['user_name']?.toString() ?? 'مستخدم',
        userContact: map['user_contact']?.toString() ?? '',
        type: map['type']?.toString() ?? 'اقتراح',
        content: map['content']?.toString() ?? '',
        screenshotUrl: map['screenshot_url']?.toString(),
        createdAt: map['created_at'] != null
            ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
            : DateTime.now(),
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

// ==============================================================================
// 6. محرك إدارة الحالة السحابية والحقيقية 100% (AppStateManager)
// ==============================================================================
class AppStateManager extends ChangeNotifier {
  static final AppStateManager _instance = AppStateManager._internal();
  factory AppStateManager() => _instance;
  AppStateManager._internal();

  String appTitle = 'سوق سوريا الشامل 2028';
  Color primaryColor = const Color(0xFF0F172A);
  Color secondaryColor = const Color(0xFFD4AF37);
  Color buttonColor = const Color(0xFF0284C7);
  Color appBarColor = const Color(0xFF0F172A);
  Color scaffoldBgColor = const Color(0xFFF8FAFC);

  bool isDarkMode = false;
  Color get titleTextColor =>
      isDarkMode ? const Color(0xFFD4AF37) : const Color(0xFF0F172A);
  Color get darkAdaptiveTextColor =>
      isDarkMode ? Colors.white : const Color(0xFF0F172A);
  Color get formLabelColor =>
      isDarkMode ? const Color(0xFFD4AF37) : const Color(0xFF0F172A);
  Color get subtitleTextColor =>
      isDarkMode ? Colors.white70 : const Color(0xFF334155);

  Color priceUsdColor = const Color(0xFF16A34A);
  Color priceSypColor = const Color(0xFFD4AF37);
  Color get locationTextColor => isDarkMode
      ? const Color(0xFFD4AF37).withOpacity(0.9)
      : const Color(0xFF475569);

  // أسعار الصرف الحية
  double exchangeRateUsdToSyp = 15200.0;
  double goldPrice21kSyp = 980000.0;
  double tryRateToSyp = 440.0;
  double euroRateToSyp = 16500.0;
  double usdToTryRate = 34.20;
  DateTime lastRatesUpdatedAt = DateTime.now();

  bool isMaintenanceMode = false;

  // 🎛️ مصفوفة خيارات البانورامات (النمط العريض الفردي أو المزدوج)
  bool isDualBannerLayout = false;

  // 🎛️ مصفوفة مفاتيح التحكم بالميزات
  bool showSocialLinks = true;
  bool showAuctions = true;
  bool showDirectChat = true;
  bool showComments = true;
  bool showAudioBio = true;
  bool showAdPosting = true;
  bool showExchangeTicker = true;
  bool showNewsTicker = true;
  bool showPanoramaBanners = true;
  bool showSellerRatings = true;

  bool lockSocialLinksForVip = true;
  bool lockAuctionsForVip = false;
  bool lockDirectChatForVip = false;
  bool lockCommentsForVip = false;
  bool lockAudioBioForVip = true;
  bool lockAdPostingForVip = false;
  bool lockPanoramaForVip = true;

  bool get isAuctionsEnabled => showAuctions;
  set isAuctionsEnabled(bool v) => showAuctions = v;

  bool get isDirectChatEnabled => showDirectChat;
  set isDirectChatEnabled(bool v) => showDirectChat = v;

  bool get isCommentsEnabled => showComments;
  set isCommentsEnabled(bool v) => showComments = v;

  bool get isAudioBioEnabled => showAudioBio;
  set isAudioBioEnabled(bool v) => showAudioBio = v;

  bool get isAdPostingEnabled => showAdPosting;
  set isAdPostingEnabled(bool v) => showAdPosting = v;

  bool get isSocialLinksEnabledForFree => !lockSocialLinksForVip;
  set isSocialLinksEnabledForFree(bool v) => lockSocialLinksForVip = !v;

  String maintenanceMessage =
      '✨ السلام عليكم ورحمة الله وبركاته ✨\n\nاللهم صلّ وسلّم وبارك على سيدنا محمد ﷺ\n\nنستأذنكم أعزاءنا الكرام، التطبيق يخضع الآن لصيانة سحابية دورية وترقية للأنظمة لتوفير تجربة أفضل وأسرع.\n\nسنعود للعمل بإذن الله تعالى خلال وقت وجيز جداً. شكراً لصبركم وتفهمكم ❤️';

  String currentUserId = '';
  String currentUserName = 'زائر المنصة';
  String currentUserEmail = '';
  String currentUserPhone = '';
  String currentUserRole = 'user';
  String currentUserVoiceBioUrl = '';
  String currentUserAvatarUrl = '';
  String currentUserBioDescription = '';
  bool isCurrentUserVerified = false;
  int currentUserPositiveLikes = 0;
  int currentUserDislikes = 0;
  String currentUserPlanId = 'plan_free';

  // حقول الاشتراكات الزمنية
  bool isCurrentUserSubscribed = false;
  String? currentUserSubscriptionType;
  DateTime? currentUserSubscriptionExpiresAt;

  bool get isLoggedIn => currentUserId.isNotEmpty;

  bool get isSuperAdmin =>
      kAuthorizedAdminEmails.contains(currentUserEmail.toLowerCase().trim()) ||
      currentUserRole == 'super_admin';

  bool get isModerator =>
      isSuperAdmin ||
      currentUserRole == 'moderator' ||
      currentUserRole == 'admin';

  List<AdItem> ads = [];
  List<BannerItem> banners = [];
  List<AppFeedbackItem> feedbacks = [];
  List<PaymentAuditRecord> paymentAudits = [];
  final Set<String> userVotedAdIds = {};
  final Set<String> favoriteAdIds = {};

  // الأقسام التجارية المعتمدة
  List<CategoryItem> categories = [
    CategoryItem(
      id: 'cars',
      name: 'سيارات ومركبات',
      iconData: Icons.directions_car,
      orderIndex: 1,
      subcategories: [
        'سيارات سياحية للبيع',
        'سيارات للإيجار',
        'دراجات نارية وسكوتر',
        'شاحنات وآليات ثقيلة',
        'قطع غيار وإكسسوارات',
      ],
    ),
    CategoryItem(
      id: 'realestate',
      name: 'عقارات وأراضي',
      iconData: Icons.home,
      orderIndex: 2,
      subcategories: [
        'شقق للبيع',
        'شقق للإيجار',
        'محلات ومكاتب تجارية',
        'أراضي ومزارع',
        'فلل وقصور',
      ],
    ),
    CategoryItem(
      id: 'solar',
      name: 'طاقة شمسية وبطاريات',
      iconData: Icons.wb_sunny,
      orderIndex: 3,
      subcategories: [
        'ألواح طاقة شمسية',
        'بطاريات ليثيوم وجل',
        'إنفرترات ومحولات',
        'منظومات طاقة متكاملة',
      ],
    ),
    CategoryItem(
      id: 'phones',
      name: 'هواتف وإلكترونيات',
      iconData: Icons.phone_android,
      orderIndex: 4,
      subcategories: [
        'أجهزة آيفون iPhone',
        'أجهزة أندرويد',
        'لابتوبات وكمبيوتر',
        'شاشات وتلفزيونات',
      ],
    ),
    CategoryItem(
      id: 'jobs',
      name: 'وظائف ومهن وخدمات',
      iconData: Icons.work,
      orderIndex: 5,
      subcategories: [
        'فرص عمل شاغرة',
        'مهن وصيانة منزلية',
        'شحن ونقل بضائع',
        'تعليم وتدريب',
      ],
    ),
    CategoryItem(
      id: 'furniture',
      name: 'أثاث ومفروشات',
      iconData: Icons.chair,
      orderIndex: 6,
      subcategories: [
        'غرف نوم وصالونات',
        'طاولات ومطابخ',
        'أجهزة كهربائية منزلية',
      ],
    ),
    CategoryItem(
      id: 'agriculture',
      name: 'زراعة ومواشي',
      iconData: Icons.grass,
      orderIndex: 7,
      subcategories: [
        'معدات زراعية',
        'أعلاف ومحاصيل',
        'مواشي وأبقار',
      ],
    ),
  ];

  // الباقات والخطط الملكية المتدرجة
  final List<SubscriptionPlanItem> subscriptionPlans = [
    SubscriptionPlanItem(
      id: 'plan_free',
      name: 'الباقة المجانية العادية',
      titleBadge: 'عضو جديد',
      priceUsd: 0,
      maxImagesPerAd: 4,
      canAddSocialLinks: false,
      badgeColor: const Color(0xFF64748B),
      cardGradient: const LinearGradient(
        colors: [Color(0xFF334155), Color(0xFF1E293B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      features: [
        'نشر 3 إعلانات شهرياً',
        'حتى 4 صور لكل إعلان',
        'دعم فني عبر واتساب',
      ],
      hasVoiceProfile: false,
    ),
    SubscriptionPlanItem(
      id: 'plan_silver',
      name: 'الباقة الفضية المتقدمة',
      titleBadge: '🥈 تاجر فضي معتمد',
      priceUsd: 15,
      maxImagesPerAd: 8,
      canAddSocialLinks: true,
      badgeColor: const Color(0xFF94A3B8),
      cardGradient: const LinearGradient(
        colors: [Color(0xFF475569), Color(0xFF0F172A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      features: [
        'نشر 15 إعلاناً شهرياً',
        'حتى 8 صور لكل إعلان',
        'إضافة بايو وصوت تعريفي في الملف الشخصي 🎙️',
        'إضافة روابط التواصل وفيديوهات المعاينة 🌐',
        'شارة بائع موثوق',
      ],
      hasVoiceProfile: true,
    ),
    SubscriptionPlanItem(
      id: 'plan_gold',
      name: 'الباقة الذهبية للمحترفين',
      titleBadge: '🥇 تاجر ذهبي معتمد',
      priceUsd: 25,
      maxImagesPerAd: 12,
      canAddSocialLinks: true,
      badgeColor: const Color(0xFFF59E0B),
      cardGradient: const LinearGradient(
        colors: [Color(0xFFB45309), Color(0xFF0F172A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      features: [
        'نشر 35 إعلاناً شهرياً ومزادات مفتوحة',
        'حتى 12 صورة عالية الدقة',
        'أولوية ظهور في البحث',
        'روابط منصات التواصل وفيديوهات المعاينة 🌐',
        'شارة التوثيق الذهبية المعتمدة 🥇',
      ],
      hasVoiceProfile: true,
    ),
    SubscriptionPlanItem(
      id: 'plan_diamond_vip',
      name: 'الخطة المثالية: VIP الملكية الماسية',
      titleBadge: '👑 تاجر ملكي ماسي VIP',
      priceUsd: 45,
      maxImagesPerAd: 20,
      canAddSocialLinks: true,
      isDiamondVip: true,
      badgeColor: const Color(0xFFD4AF37),
      cardGradient: const LinearGradient(
        colors: [Color(0xFF0F172A), Color(0xFF1E1B4B), Color(0xFFD4AF37)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      features: [
        'نشر غير محدود للإعلانات والمزادات العلنية',
        'حتى 20 صورة عالية الدقة بدون أي قيود',
        'حجز مميز في البانوراما الإعلانية الرئيسية 🌟',
        'بايو صوتي احترافي وعلامة التاج الماسي الملكي 👑',
        'بروفايل ذهبي فخم مشع يجذب كافة الزبائن',
        'أعلى أولوية ظهور فورية لجميع البضائع',
      ],
      hasVoiceProfile: true,
    ),
  ];

  List<String> newsTicker = [
    '🇸🇾 أهلاً بكم في سوق سوريا الشامل 2028 - بوابات الدفع المعتمدة: شام كاش وبينانس USDT',
    '⚡ محرك المزادات العلنية يعمل بنظام الحماية ضد القنص وتمديد الوقت تلقائياً',
    '🌟 توثيق فوري لكافة المعلنين والتجار لضمان الأمان والشفافية التامة',
  ];

  // ============================================================================
  // دوال إدارة الجلسة والتخزين المحلي
  // ============================================================================
  Future<void> loadPersistedSession() async {
    final prefs = await SharedPreferences.getInstance();
    currentUserId = prefs.getString('user_id') ?? '';
    currentUserName = prefs.getString('user_name') ?? 'زائر المنصة';
    currentUserEmail = prefs.getString('user_email') ?? '';
    currentUserPhone = prefs.getString('user_phone') ?? '';
    currentUserRole = prefs.getString('user_role') ?? 'user';
    currentUserVoiceBioUrl = prefs.getString('user_voice_bio') ?? '';
    currentUserAvatarUrl = prefs.getString('user_avatar') ?? '';
    currentUserBioDescription = prefs.getString('user_bio_desc') ?? '';
    currentUserPlanId = prefs.getString('user_plan_id') ?? 'plan_free';
    isCurrentUserSubscribed = prefs.getBool('is_subscribed') ?? false;
    currentUserSubscriptionType = prefs.getString('subscription_type');
    isDualBannerLayout = prefs.getBool('is_dual_banner_layout') ?? false;

    final favList = prefs.getStringList('favorite_ad_ids') ?? [];
    favoriteAdIds.clear();
    favoriteAdIds.addAll(favList);

    final expStr = prefs.getString('subscription_expires_at');
    if (expStr != null) {
      currentUserSubscriptionExpiresAt = DateTime.tryParse(expStr);
    }

    if (kAuthorizedAdminEmails
        .contains(currentUserEmail.toLowerCase().trim())) {
      currentUserRole = 'super_admin';
    }

    notifyListeners();
  }

  Future<void> setBannerLayoutMode(bool isDual) async {
    isDualBannerLayout = isDual;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dual_banner_layout', isDual);
    notifyListeners();
  }

  Future<void> toggleFavorite(String adId) async {
    if (favoriteAdIds.contains(adId)) {
      favoriteAdIds.remove(adId);
    } else {
      favoriteAdIds.add(adId);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_ad_ids', favoriteAdIds.toList());
    notifyListeners();
  }

  Future<void> updateProfileData({
    required String newName,
    required String newPhone,
    String? newAvatarUrl,
    String? newBioDescription,
  }) async {
    currentUserName = newName;
    currentUserPhone = newPhone;
    if (newAvatarUrl != null && newAvatarUrl.isNotEmpty) {
      currentUserAvatarUrl = newAvatarUrl;
    }
    if (newBioDescription != null) {
      currentUserBioDescription = newBioDescription;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', newName);
    await prefs.setString('user_phone', newPhone);
    if (currentUserAvatarUrl.isNotEmpty) {
      await prefs.setString('user_avatar', currentUserAvatarUrl);
    }
    await prefs.setString('user_bio_desc', currentUserBioDescription);

    try {
      if (currentUserId.isNotEmpty) {
        await Supabase.instance.client.from('users').upsert({
          'id': currentUserId,
          'full_name': newName,
          'phone': newPhone,
          'avatar_url': currentUserAvatarUrl,
          'bio_description': currentUserBioDescription,
          'updated_at': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      debugPrint('Profile update notice: $e');
    }

    notifyListeners();
  }

  Future<bool> signInSafe({
    required String email,
    required String password,
  }) async {
    final cleanEmail = email.trim().toLowerCase();
    String determinedName = cleanEmail.split('@').first;
    String determinedRole = 'user';
    String assignedId = 'usr_${cleanEmail.hashCode.abs()}';
    String assignedPhone =
        currentUserPhone.isNotEmpty ? currentUserPhone : '0933000000';
    String planId = 'plan_free';
    bool isSub = false;

    if (kAuthorizedAdminEmails.contains(cleanEmail)) {
      determinedRole = 'super_admin';
      determinedName = 'مدير النظام ($determinedName)';
    }

    try {
      final res = await Supabase.instance.client.auth.signInWithPassword(
        email: cleanEmail,
        password: password,
      );
      if (res.user != null) {
        assignedId = res.user!.id;
        if (res.user!.userMetadata?['full_name'] != null) {
          determinedName = res.user!.userMetadata!['full_name'];
        }
        if (res.user!.userMetadata?['phone'] != null) {
          assignedPhone = res.user!.userMetadata!['phone'];
        }

        try {
          final profileRes = await Supabase.instance.client
              .from('users')
              .select()
              .eq('id', assignedId)
              .maybeSingle();

          if (profileRes != null) {
            if (profileRes['full_name'] != null) {
              determinedName = profileRes['full_name'];
            }
            if (profileRes['phone'] != null) {
              assignedPhone = profileRes['phone'];
            }
            if (profileRes['role'] != null) {
              determinedRole = profileRes['role'];
            }
            if (profileRes['seller_plan_id'] != null) {
              planId = profileRes['seller_plan_id'];
            }
            if (profileRes['is_subscribed'] == true) {
              isSub = true;
            }
          }
        } catch (_) {}
      }
    } catch (e) {
      debugPrint('Supabase Auth Notice: $e (Session retained)');
    }

    await setSessionUser(
      userId: assignedId,
      email: cleanEmail,
      name: determinedName,
      phone: assignedPhone,
      role: determinedRole,
      planId: planId,
      isSubscribed: isSub,
    );

    return true;
  }

  Future<void> setSessionUser({
    required String userId,
    required String email,
    required String name,
    required String phone,
    String role = 'user',
    String voiceBioUrl = '',
    String avatarUrl = '',
    String bioDescription = '',
    String planId = 'plan_free',
    bool isSubscribed = false,
    String? subscriptionType,
    DateTime? subscriptionExpiresAt,
  }) async {
    currentUserId = userId;
    currentUserEmail = email;
    currentUserName = name;
    currentUserPhone = phone;
    currentUserVoiceBioUrl = voiceBioUrl;
    currentUserAvatarUrl = avatarUrl;
    currentUserBioDescription = bioDescription;
    currentUserPlanId = planId;
    isCurrentUserSubscribed = isSubscribed;
    currentUserSubscriptionType = subscriptionType;
    currentUserSubscriptionExpiresAt = subscriptionExpiresAt;

    if (kAuthorizedAdminEmails.contains(email.toLowerCase().trim())) {
      currentUserRole = 'super_admin';
    } else {
      currentUserRole = role;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_phone', phone);
    await prefs.setString('user_role', currentUserRole);
    await prefs.setString('user_voice_bio', currentUserVoiceBioUrl);
    await prefs.setString('user_avatar', currentUserAvatarUrl);
    await prefs.setString('user_bio_desc', currentUserBioDescription);
    await prefs.setString('user_plan_id', currentUserPlanId);
    await prefs.setBool('is_subscribed', isCurrentUserSubscribed);
    if (subscriptionType != null) {
      await prefs.setString('subscription_type', subscriptionType);
    }
    if (subscriptionExpiresAt != null) {
      await prefs.setString(
          'subscription_expires_at', subscriptionExpiresAt.toIso8601String());
    }

    notifyListeners();
  }

  // ============================================================================
  // دالة تسجيل الخروج المحصنة والمستقرة (logout)
  // ============================================================================
  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth
          .signOut()
          .timeout(const Duration(seconds: 5));
    } catch (_) {}

    currentUserId = '';
    currentUserName = 'زائر المنصة';
    currentUserEmail = '';
    currentUserPhone = '';
    currentUserRole = 'user';
    currentUserVoiceBioUrl = '';
    currentUserAvatarUrl = '';
    currentUserBioDescription = '';
    isCurrentUserVerified = false;
    currentUserPositiveLikes = 0;
    currentUserDislikes = 0;
    currentUserPlanId = 'plan_free';
    isCurrentUserSubscribed = false;
    currentUserSubscriptionType = null;
    currentUserSubscriptionExpiresAt = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  Future<void> logoutUser() async => logout();

  SubscriptionPlanItem getCurrentUserPlan() {
    return subscriptionPlans.firstWhere(
      (p) => p.id == currentUserPlanId,
      orElse: () => subscriptionPlans.first,
    );
  }

  SubscriptionPlanItem getPlanById(String planId) {
    return subscriptionPlans.firstWhere(
      (p) => p.id == planId,
      orElse: () => subscriptionPlans.first,
    );
  }

  bool canUserAddSocialLinks() {
    if (isSuperAdmin) return true;
    if (!lockSocialLinksForVip) return true;
    final plan = getCurrentUserPlan();
    return plan.canAddSocialLinks || isCurrentUserSubscribed;
  }

  String? checkForbiddenContent(String text) {
    const forbidden = [
      'سلاح',
      'مخدرات',
      'ممنوع',
      'تزوير',
      'احتيال',
      'سرقة',
    ];
    for (var w in forbidden) {
      if (text.contains(w)) return w;
    }
    return null;
  }

  // ============================================================================
  // دوال إدارة الأقسام والفروع والتصنيفات الشاملة (Categories Manager)
  // ============================================================================
  Future<void> addCategory({
    required String name,
    required IconData iconData,
    required List<String> subcategories,
  }) async {
    final newId = 'cat_${DateTime.now().millisecondsSinceEpoch}';
    final newCat = CategoryItem(
      id: newId,
      name: name,
      iconData: iconData,
      subcategories: subcategories,
      orderIndex: categories.length + 1,
    );
    categories.add(newCat);
    notifyListeners();

    try {
      await Supabase.instance.client.from('categories').insert(newCat.toMap());
    } catch (e) {
      debugPrint('Add category notice: $e');
    }
  }

  Future<void> updateCategory(CategoryItem updatedCat) async {
    final idx = categories.indexWhere((c) => c.id == updatedCat.id);
    if (idx != -1) {
      categories[idx] = updatedCat;
      notifyListeners();
      try {
        await Supabase.instance.client
            .from('categories')
            .update(updatedCat.toMap())
            .eq('id', updatedCat.id);
      } catch (e) {
        debugPrint('Update category notice: $e');
      }
    }
  }

  Future<void> deleteCategory(String catId) async {
    categories.removeWhere((c) => c.id == catId);
    notifyListeners();
    try {
      await Supabase.instance.client
          .from('categories')
          .delete()
          .eq('id', catId);
    } catch (e) {
      debugPrint('Delete category notice: $e');
    }
  }

  Future<void> addSubcategoryToCategory(String catId, String subName) async {
    final idx = categories.indexWhere((c) => c.id == catId);
    if (idx != -1) {
      final updatedSubs = List<String>.from(categories[idx].subcategories);
      if (!updatedSubs.contains(subName)) {
        updatedSubs.add(subName);
        categories[idx] = categories[idx].copyWith(subcategories: updatedSubs);
        notifyListeners();
        try {
          await Supabase.instance.client
              .from('categories')
              .update({'subcategories': updatedSubs}).eq('id', catId);
        } catch (_) {}
      }
    }
  }

  Future<void> removeSubcategoryFromCategory(
      String catId, String subName) async {
    final idx = categories.indexWhere((c) => c.id == catId);
    if (idx != -1) {
      final updatedSubs = List<String>.from(categories[idx].subcategories)
        ..remove(subName);
      categories[idx] = categories[idx].copyWith(subcategories: updatedSubs);
      notifyListeners();
      try {
        await Supabase.instance.client
            .from('categories')
            .update({'subcategories': updatedSubs}).eq('id', catId);
      } catch (_) {}
    }
  }

  // ============================================================================
  // جلب البيانات ومزامنة أسعار الصرف الحية
  // ============================================================================
  Future<void> fetchRealDataFromSupabase() async {
    await fetchRealtimeExchangeRates();

    try {
      final catRes = await Supabase.instance.client
          .from('categories')
          .select()
          .order('order_index', ascending: true)
          .timeout(const Duration(seconds: 8));

      if (catRes is List && catRes.isNotEmpty) {
        categories = catRes
            .whereType<Map<String, dynamic>>()
            .map((m) => CategoryItem.fromMap(m))
            .toList();
        notifyListeners();
      }
    } catch (_) {}

    try {
      final res = await Supabase.instance.client
          .from('ads')
          .select()
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 10));

      if (res is List) {
        ads = res
            .whereType<Map<String, dynamic>>()
            .map((m) => AdItem.fromMap(m))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Fetch ads notice: $e');
    }

    try {
      final bannerRes = await Supabase.instance.client
          .from('banners')
          .select()
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 10));

      if (bannerRes is List) {
        banners = bannerRes
            .whereType<Map<String, dynamic>>()
            .map((m) => BannerItem.fromMap(m))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Fetch banners notice: $e');
    }
  }

  Future<void> fetchRealtimeExchangeRates() async {
    try {
      final res = await Supabase.instance.client
          .from('exchange_rates')
          .select()
          .order('updated_at', ascending: false)
          .limit(1)
          .timeout(const Duration(seconds: 6));

      if (res is List && res.isNotEmpty) {
        final data = res.first;
        exchangeRateUsdToSyp = data['usd_syp'] != null
            ? double.tryParse(data['usd_syp'].toString()) ??
                exchangeRateUsdToSyp
            : exchangeRateUsdToSyp;
        goldPrice21kSyp = data['gold_21k'] != null
            ? double.tryParse(data['gold_21k'].toString()) ?? goldPrice21kSyp
            : goldPrice21kSyp;
        tryRateToSyp = data['try_syp'] != null
            ? double.tryParse(data['try_syp'].toString()) ?? tryRateToSyp
            : tryRateToSyp;
        euroRateToSyp = data['euro_syp'] != null
            ? double.tryParse(data['euro_syp'].toString()) ?? euroRateToSyp
            : euroRateToSyp;
        usdToTryRate = data['usd_try'] != null
            ? double.tryParse(data['usd_try'].toString()) ??
                (exchangeRateUsdToSyp / (tryRateToSyp > 0 ? tryRateToSyp : 440))
            : (exchangeRateUsdToSyp / (tryRateToSyp > 0 ? tryRateToSyp : 440));

        if (data['updated_at'] != null) {
          lastRatesUpdatedAt =
              DateTime.tryParse(data['updated_at'].toString()) ??
                  DateTime.now();
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Live rates fetch notice: $e');
    }
  }

  List<BannerSlotItem> getBannerSlotsStatus() {
    final List<BannerSlotItem> slots = [];
    final activeBanners =
        banners.where((b) => b.isActive && !b.isExpired).toList();

    for (int i = 1; i <= 5; i++) {
      final banner = activeBanners.firstWhere(
        (b) => b.slotIndex == i,
        orElse: () => BannerItem(
          id: '',
          slotIndex: i,
          imageUrls: [],
          title: '',
          subtitle: '',
          description: '',
          location: '',
          phone: '',
          whatsapp: '',
          isActive: false,
          expiresAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      );

      final isBooked =
          banner.id.isNotEmpty && banner.isActive && !banner.isExpired;
      slots.add(
        BannerSlotItem(
          slotNumber: i,
          isBooked: isBooked,
          currentBanner: isBooked ? banner : null,
          availableFromDate: isBooked ? banner.expiresAt : DateTime.now(),
        ),
      );
    }
    return slots;
  }

  Future<void> autoCleanupExpiredSoldAds() async {
    final expired = ads.where((ad) => ad.shouldBeDeletedNow).toList();
    ads.removeWhere((ad) => ad.shouldBeDeletedNow);
    notifyListeners();

    for (final ad in expired) {
      try {
        await Supabase.instance.client
            .from('ads')
            .delete()
            .eq('id', ad.id)
            .timeout(const Duration(seconds: 6));
      } catch (_) {}
    }
  }

  Future<bool> addNewAdDirectly(AdItem ad) async {
    final pendingAd = isSuperAdmin
        ? ad.copyWith(status: 'approved')
        : ad.copyWith(status: 'pending');

    ads.insert(0, pendingAd);
    notifyListeners();

    try {
      await Supabase.instance.client
          .from('ads')
          .insert(pendingAd.toMap())
          .timeout(const Duration(seconds: 12));
      return true;
    } catch (e) {
      debugPrint('Supabase insert ad error: $e');
      return false;
    }
  }

  Future<void> updateAdDirectly(AdItem updatedAd) async {
    final idx = ads.indexWhere((a) => a.id == updatedAd.id);
    if (idx != -1) {
      ads[idx] = updatedAd;
      notifyListeners();
    }
    try {
      await Supabase.instance.client
          .from('ads')
          .update(updatedAd.toMap())
          .eq('id', updatedAd.id)
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      debugPrint('Update ad notice: $e');
    }
  }

  Future<void> deleteAdCompletely(String adId) async {
    ads.removeWhere((a) => a.id == adId);
    notifyListeners();
    try {
      await Supabase.instance.client
          .from('ads')
          .delete()
          .eq('id', adId)
          .timeout(const Duration(seconds: 8));
    } catch (_) {}
  }

  Future<void> approveAd(String adId) async {
    final idx = ads.indexWhere((a) => a.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(status: 'approved');
      notifyListeners();
      try {
        await Supabase.instance.client
            .from('ads')
            .update({'status': 'approved'})
            .eq('id', adId)
            .timeout(const Duration(seconds: 8));
      } catch (e) {
        debugPrint('Approve ad error: $e');
      }
    }
  }

  Future<void> rejectAd(String adId, String reason) async {
    final idx = ads.indexWhere((a) => a.id == adId);
    if (idx != -1) {
      final targetAd = ads[idx];
      ads[idx] = targetAd.copyWith(status: 'rejected', rejectionReason: reason);
      notifyListeners();

      try {
        await Supabase.instance.client
            .from('ads')
            .update({'status': 'rejected', 'rejection_reason': reason})
            .eq('id', adId)
            .timeout(const Duration(seconds: 8));

        await Supabase.instance.client.from('notifications').insert({
          'user_id': targetAd.userId,
          'phone': targetAd.contactPhone,
          'title': 'تنبيه بخصوص إعلانك: ${targetAd.title}',
          'message': 'تم رفض نشر إعلانك للسبب التالي:\n$reason',
          'created_at': DateTime.now().toIso8601String(),
        });
      } catch (e) {
        debugPrint('Reject ad error: $e');
      }
    }
  }

  Future<void> markAdAsSold(String adId, bool isSold) async {
    final idx = ads.indexWhere((a) => a.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(
        isSold: isSold,
        soldAt: isSold ? DateTime.now() : null,
      );
      notifyListeners();
      try {
        await Supabase.instance.client
            .from('ads')
            .update({
              'is_sold': isSold,
              'sold_at': isSold ? DateTime.now().toIso8601String() : null,
            })
            .eq('id', adId)
            .timeout(const Duration(seconds: 8));
      } catch (_) {}
    }
  }

  Future<void> updateExchangeRate(double usd, double gold) async {
    exchangeRateUsdToSyp = usd;
    goldPrice21kSyp = gold;
    lastRatesUpdatedAt = DateTime.now();
    notifyListeners();

    try {
      await Supabase.instance.client.from('exchange_rates').insert({
        'usd_syp': usd,
        'gold_21k': gold,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (_) {}
  }

  Future<void> approvePaymentReceipt(
      String receiptId, String targetUserId, String planId) async {
    try {
      await Supabase.instance.client
          .from('payment_receipts')
          .update({'status': 'approved'}).eq('id', receiptId);

      await Supabase.instance.client.from('users').update({
        'is_subscribed': true,
        'subscription_type': planId,
        'seller_plan_id': planId,
        'subscription_expires_at':
            DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      }).eq('id', targetUserId);

      notifyListeners();
    } catch (e) {
      debugPrint('Approve receipt error: $e');
    }
  }

  Future<String?> generateNewActivationCode({
    required String packageType,
    required int durationDays,
  }) async {
    final rand = Random();
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final part1 =
        List.generate(4, (_) => chars[rand.nextInt(chars.length)]).join();
    final part2 =
        List.generate(4, (_) => chars[rand.nextInt(chars.length)]).join();
    final generatedCode = 'SYR-$part1-$part2';

    final newCode = ActivationCodeItem(
      code: generatedCode,
      packageType: packageType,
      durationDays: durationDays,
    );

    try {
      await Supabase.instance.client
          .from('activation_codes')
          .insert(newCode.toMap());
      return generatedCode;
    } catch (e) {
      debugPrint('Error generating code: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> redeemActivationCode(String code) async {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode.isEmpty) {
      return {'success': false, 'message': 'يرجى إدخال كود التفعيل.'};
    }

    try {
      final res = await Supabase.instance.client.rpc(
        'redeem_activation_code',
        params: {
          'p_code': cleanCode,
          'p_user_id': currentUserId,
        },
      );

      if (res != null && res['success'] == true) {
        isCurrentUserSubscribed = true;
        currentUserSubscriptionType = res['package_type'];
        if (res['expires_at'] != null) {
          currentUserSubscriptionExpiresAt =
              DateTime.tryParse(res['expires_at']);
        }
        notifyListeners();
        return {
          'success': true,
          'message': res['message'] ?? 'تم تفعيل الاشتراك بنجاح!',
        };
      } else {
        return {
          'success': false,
          'message': res?['message'] ?? 'كود التفعيل غير صالح.',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'خطأ أثناء تفعيل الكود: $e'};
    }
  }

  Future<bool> voteOnAd(
      {required String adId, required bool isPositive}) async {
    if (userVotedAdIds.contains(adId)) return false;
    userVotedAdIds.add(adId);

    final idx = ads.indexWhere((a) => a.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(
        sellerPositiveLikes: isPositive
            ? ads[idx].sellerPositiveLikes + 1
            : ads[idx].sellerPositiveLikes,
        sellerDislikes:
            !isPositive ? ads[idx].sellerDislikes + 1 : ads[idx].sellerDislikes,
      );
      notifyListeners();
    }
    return true;
  }

  void incrementAdViews(String adId) {
    final idx = ads.indexWhere((a) => a.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(viewsCount: ads[idx].viewsCount + 1);
      notifyListeners();
    }
  }

  void incrementAdCallClicks(String adId) {
    final idx = ads.indexWhere((a) => a.id == adId);
    if (idx != -1) {
      ads[idx] =
          ads[idx].copyWith(callClicksCount: ads[idx].callClicksCount + 1);
      notifyListeners();
    }
  }

  void incrementAdWhatsappClicks(String adId) {
    final idx = ads.indexWhere((a) => a.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx]
          .copyWith(whatsappClicksCount: ads[idx].whatsappClicksCount + 1);
      notifyListeners();
    }
  }

  void incrementBannerClick(String bannerId) {
    final idx = banners.indexWhere((b) => b.id == bannerId);
    if (idx != -1) {
      banners[idx] = BannerItem(
        id: banners[idx].id,
        slotIndex: banners[idx].slotIndex,
        imageUrls: banners[idx].imageUrls,
        title: banners[idx].title,
        subtitle: banners[idx].subtitle,
        description: banners[idx].description,
        location: banners[idx].location,
        phone: banners[idx].phone,
        whatsapp: banners[idx].whatsapp,
        targetExternalUrl: banners[idx].targetExternalUrl,
        badgeText: banners[idx].badgeText,
        badgeColor: banners[idx].badgeColor,
        displayDurationSeconds: banners[idx].displayDurationSeconds,
        clicksCount: banners[idx].clicksCount + 1,
        isActive: banners[idx].isActive,
        startsAt: banners[idx].startsAt,
        expiresAt: banners[idx].expiresAt,
      );
      notifyListeners();
    }
  }

  Future<void> submitPaymentAuditRequest({
    required SubscriptionPlanItem plan,
    required String gateway,
    required String refOrTxId,
  }) async {
    final newAudit = PaymentAuditRecord(
      id: 'pay_${DateTime.now().millisecondsSinceEpoch}',
      userId: currentUserId,
      userName: currentUserName,
      userPhone: currentUserPhone,
      planId: plan.id,
      planName: plan.name,
      amountUsd: plan.priceUsd,
      gateway: gateway,
      transactionRefOrTxId: refOrTxId,
      status: 'pending',
      createdAt: DateTime.now(),
    );
    paymentAudits.insert(0, newAudit);
    notifyListeners();

    try {
      await Supabase.instance.client
          .from('payment_audits')
          .insert(newAudit.toMap())
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      debugPrint('Submit payment audit error: $e');
    }
  }

  Future<List<AdCommentItem>> fetchAdComments(String adId) async {
    try {
      final res = await Supabase.instance.client
          .from('ad_comments')
          .select()
          .eq('ad_id', adId)
          .order('created_at', ascending: true);

      if (res is List) {
        return res
            .whereType<Map<String, dynamic>>()
            .map((m) => AdCommentItem.fromMap(m))
            .toList();
      }
    } catch (e) {
      debugPrint('Fetch comments error: $e');
    }
    return [];
  }

  Future<void> addAdComment({
    required String adId,
    required String commentText,
  }) async {
    if (commentText.trim().isEmpty) return;
    try {
      await Supabase.instance.client.from('ad_comments').insert({
        'ad_id': adId,
        'user_id': currentUserId.isNotEmpty ? currentUserId : 'usr_guest',
        'user_name': currentUserName,
        'comment_text': commentText.trim(),
        'created_at': DateTime.now().toIso8601String(),
      });
      notifyListeners();
    } catch (e) {
      debugPrint('Add comment error: $e');
    }
  }

  void trackSearchKeyword(String keyword) {}
}

// ==============================================================================
// 7. خدمة رفع الصور والملفات الصوتية (StorageUploadService)
// ==============================================================================
class StorageUploadService {
  static Future<String?> uploadImageBytes({
    required String bucketName,
    required Uint8List imageBytes,
    required String prefix,
  }) async {
    if (imageBytes.isEmpty) return null;
    try {
      final fileName = '${prefix}_${DateTime.now().millisecondsSinceEpoch}.jpg';
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
      debugPrint('Upload image notice: $e');
      return null;
    }
  }

  static Future<List<String>> uploadMultipleImageBytes({
    required String bucketName,
    required List<Uint8List> imagesBytesList,
    required String prefix,
  }) async {
    final List<String> urls = [];
    for (int i = 0; i < imagesBytesList.length; i++) {
      final url = await uploadImageBytes(
        bucketName: bucketName,
        imageBytes: imagesBytesList[i],
        prefix: '${prefix}_$i',
      );
      if (url != null && url.isNotEmpty) {
        urls.add(url);
      }
    }
    return urls;
  }
}

// ==============================================================================
// 8. محرك عرض الصور الذكي المتكيف بدون قص (AppSmartImage)
// ==============================================================================
class AppSmartImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  const AppSmartImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        color: Colors.grey.shade900,
        child: const Icon(Icons.image, color: Colors.white38, size: 28),
      );
    }

    return Image.network(
      imageUrl,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: Colors.grey.shade900,
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Color(0xFFD4AF37)),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey.shade900,
          child:
              const Icon(Icons.broken_image, color: Colors.white38, size: 28),
        );
      },
    );
  }
}

// ==============================================================================
// 9. شاشة تسجيل الدخول وإنشاء الحساب المحصنة (FullAuthScreen)
// ==============================================================================
class FullAuthScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const FullAuthScreen({Key? key, required this.onLoginSuccess})
      : super(key: key);

  @override
  State<FullAuthScreen> createState() => _FullAuthScreenState();
}

class _FullAuthScreenState extends State<FullAuthScreen> {
  final AppStateManager _manager = AppStateManager();
  final _formKey = GlobalKey<FormState>();

  bool _isLoginMode = true;
  bool _obscurePassword = true;
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitAuth() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    try {
      if (_isLoginMode) {
        await _manager.signInSafe(
          email: email,
          password: password,
        );
      } else {
        String finalUserId = 'usr_${email.hashCode.abs()}';
        try {
          final authRes = await Supabase.instance.client.auth.signUp(
            email: email,
            password: password,
            data: {'full_name': name, 'phone': phone},
          );
          if (authRes.user != null) {
            finalUserId = authRes.user!.id;
          }
        } catch (_) {}

        try {
          await Supabase.instance.client.from('users').upsert({
            'id': finalUserId,
            'email': email,
            'full_name': name.isNotEmpty ? name : email.split('@').first,
            'phone': phone.isNotEmpty ? phone : '0933000000',
            'role': 'user',
            'created_at': DateTime.now().toIso8601String(),
          });
        } catch (_) {}

        await _manager.setSessionUser(
          userId: finalUserId,
          email: email,
          name: name.isNotEmpty ? name : email.split('@').first,
          phone: phone.isNotEmpty ? phone : '0933000000',
        );
      }

      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_manager.isSuperAdmin
                ? '👑 أهلاً بك يا مدير النظام! تم تفعيل غرفة العمليات بنجاح.'
                : '✅ تم تسجيل الدخول بنجاح! أهلاً بك في سوقك الحر.'),
            backgroundColor: _manager.isSuperAdmin
                ? const Color(0xFFD4AF37)
                : const Color(0xFF16A34A),
          ),
        );
        widget.onLoginSuccess();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ أثناء المصادقة: $e'),
            backgroundColor: Colors.red,
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
          _isLoginMode ? 'تسجيل الدخول' : 'إنشاء حساب جديد في السوق',
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
          padding: const EdgeInsets.all(24),
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
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4))
                    ],
                  ),
                  child: const Icon(Icons.storefront,
                      size: 42, color: Color(0xFFD4AF37)),
                ),
                const SizedBox(height: 14),
                Text(
                  _manager.appTitle,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _manager.darkAdaptiveTextColor),
                ),
                const SizedBox(height: 4),
                Text(
                  'أهلاً بك مجدداً في سوقك الحر',
                  style: TextStyle(
                      color: _manager.subtitleTextColor, fontSize: 12),
                ),
                const SizedBox(height: 24),
                if (!_isLoginMode) ...[
                  TextFormField(
                    controller: _nameController,
                    style: TextStyle(color: _manager.darkAdaptiveTextColor),
                    decoration: InputDecoration(
                      labelText: 'الاسم الكامل أو اسم المتجر *',
                      labelStyle: TextStyle(color: _manager.formLabelColor),
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'يرجى إدخال الاسم'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: _manager.darkAdaptiveTextColor),
                    decoration: InputDecoration(
                      labelText: 'رقم الهاتف للتواصل *',
                      labelStyle: TextStyle(color: _manager.formLabelColor),
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (v) => (v == null || v.trim().length < 9)
                        ? 'يرجى إدخال رقم هاتف صحيح'
                        : null,
                  ),
                  const SizedBox(height: 12),
                ],
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: _manager.darkAdaptiveTextColor),
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني *',
                    labelStyle: TextStyle(color: _manager.formLabelColor),
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (v) =>
                      (v == null || !v.contains('@')) ? 'بريد غير صالح' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: TextStyle(color: _manager.darkAdaptiveTextColor),
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور *',
                    labelStyle: TextStyle(color: _manager.formLabelColor),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (v) =>
                      (v == null || v.length < 6) ? 'كلمة المرور قصيرة' : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _manager.buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _isLoading ? null : _submitAuth,
                    child: _isLoading
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
                const SizedBox(height: 14),
                TextButton(
                  onPressed: () => setState(() => _isLoginMode = !_isLoginMode),
                  child: Text(
                    _isLoginMode
                        ? 'ليس لديك حساب؟ سجل حساباً جديداً الآن'
                        : 'لديك حساب بالفعل؟ تسجيل الدخول',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: _manager.darkAdaptiveTextColor),
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
// [القسم الثاني المطور: المكونات البصرية، بوابات الدفع بشعار Binance المعتمد، لوحة البورصة الحية، البانوراما، وشاشة صوتك مسموع]
// ==============================================================================

// ==============================================================================
// 9. أيقونة شعار منصة بينانس الرسمية الهندسية (BinanceOfficialLogoIcon)
// ==============================================================================
class BinanceOfficialLogoIcon extends StatelessWidget {
  final double size;
  const BinanceOfficialLogoIcon({Key? key, this.size = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFF0B90B),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF0B90B).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: CustomPaint(
          size: Size(size * 0.65, size * 0.65),
          painter: _BinanceLogoPainter(),
        ),
      ),
    );
  }
}

class _BinanceLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF181A20)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;
    final r = w * 0.16;

    final centerPath = Path()
      ..moveTo(cx, cy - r)
      ..lineTo(cx + r, cy)
      ..lineTo(cx, cy + r)
      ..lineTo(cx - r, cy)
      ..close();
    canvas.drawPath(centerPath, paint);

    void drawDiamond(double x, double y, double d) {
      final p = Path()
        ..moveTo(x, y - d)
        ..lineTo(x + d, y)
        ..lineTo(x, y + d)
        ..lineTo(x - d, y)
        ..close();
      canvas.drawPath(p, paint);
    }

    final offset = w * 0.35;
    final subR = r * 0.75;
    drawDiamond(cx, cy - offset, subR);
    drawDiamond(cx, cy + offset, subR);
    drawDiamond(cx - offset, cy, subR);
    drawDiamond(cx + offset, cy, subR);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==============================================================================
// 10. شارة التوثيق الملكية وعداد الإعجاب الذهبي (KycVerificationBadge)
// ==============================================================================
class KycVerificationBadge extends StatelessWidget {
  final bool isVerified;
  final int positiveLikes;
  final String planId;
  final double size;

  const KycVerificationBadge({
    Key? key,
    required this.isVerified,
    required this.positiveLikes,
    this.planId = 'plan_free',
    this.size = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVip = planId == 'plan_diamond_vip' || planId == 'plan_gold';
    if (!isVerified && positiveLikes < 100 && !isVip) {
      return const SizedBox.shrink();
    }

    Color badgeBg = const Color(0xFFD4AF37);
    String badgeTitle = 'بائع معتمد';

    if (planId == 'plan_diamond_vip') {
      badgeBg = const Color(0xFF38BDF8);
      badgeTitle = '👑 ملكي VIP';
    } else if (planId == 'plan_gold') {
      badgeBg = const Color(0xFFF59E0B);
      badgeTitle = '🥇 ذهبي VIP';
    } else if (isVerified) {
      badgeTitle = 'موثق ✓';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
      decoration: BoxDecoration(
        color: badgeBg,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 1))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: size, color: const Color(0xFF0F172A)),
          const SizedBox(width: 3),
          Text(
            badgeTitle,
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
// 11. محرك منع القنص وتمديد المزادات الذكي (AntiSnipingEngine)
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
// 12. لوحة بورصة إدلب وأسعار الصرف والمعادن الحية المدمجة القابلة للطي (LiveCurrencyExchangeTicker)
// ==============================================================================
class LiveCurrencyExchangeTicker extends StatefulWidget {
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
  State<LiveCurrencyExchangeTicker> createState() =>
      _LiveCurrencyExchangeTickerState();
}

class _LiveCurrencyExchangeTickerState
    extends State<LiveCurrencyExchangeTicker> {
  final AppStateManager _manager = AppStateManager();
  bool _isExpanded = false;

  Widget _buildMiniRateBox({
    required String flag,
    required String code,
    required String title,
    required double buy,
    required double sell,
    required String unit,
    bool isGold = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
        color: isGold ? const Color(0xFF2A1C06) : const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isGold ? const Color(0xFFD4AF37) : Colors.white12,
          width: isGold ? 1.0 : 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(flag, style: const TextStyle(fontSize: 11)),
                  const SizedBox(width: 4),
                  Text(
                    code,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
              if (isGold)
                const Icon(Icons.auto_awesome,
                    color: Color(0xFFD4AF37), size: 11),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'شراء Buy',
                        style: TextStyle(
                            color: Color(0xFF22C55E),
                            fontSize: 7.5,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        buy.toStringAsFixed(buy < 100 ? 2 : 0),
                        style: const TextStyle(
                          color: Color(0xFF22C55E),
                          fontWeight: FontWeight.bold,
                          fontSize: 9.5,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'مبيع Sell',
                        style: TextStyle(
                            color: Color(0xFF38BDF8),
                            fontSize: 7.5,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        sell.toStringAsFixed(sell < 100 ? 2 : 0),
                        style: const TextStyle(
                          color: Color(0xFF38BDF8),
                          fontWeight: FontWeight.bold,
                          fontSize: 9.5,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usdRate =
        widget.usdRate > 0 ? widget.usdRate : _manager.exchangeRateUsdToSyp;
    final goldPrice = widget.gold21kPrice > 0
        ? widget.gold21kPrice
        : _manager.goldPrice21kSyp;
    final tryRate = _manager.tryRateToSyp > 0 ? _manager.tryRateToSyp : 440.0;
    final usdTry = _manager.usdToTryRate > 0 ? _manager.usdToTryRate : 34.20;

    final usdBuy = usdRate - 50;
    final usdSell = usdRate + 50;
    final tryBuy = tryRate - 3;
    final trySell = tryRate + 3;
    final usdTryBuy = usdTry - 0.15;
    final usdTrySell = usdTry + 0.15;
    final goldBuy = goldPrice - 15000;
    final goldSell = goldPrice;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFD4AF37).withOpacity(0.4),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Color(0xFF22C55E),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'بورصة سوريا الحية',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '🇺🇸 \$1 = ${usdRate.toStringAsFixed(0)} ل.س • 🪙 الذهب: ${goldPrice.toStringAsFixed(0)} • 🇹🇷 ₺1 = ${tryRate.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: const Color(0xFFD4AF37).withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _isExpanded ? 'طي 🔼' : 'عرض 🔽',
                          style: const TextStyle(
                            color: Color(0xFFD4AF37),
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.onRefresh != null) ...[
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: widget.onRefresh,
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: Icon(Icons.refresh,
                            color: Color(0xFF38BDF8), size: 14),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 2.3,
                children: [
                  _buildMiniRateBox(
                      flag: '🇺🇸',
                      code: 'USD/SYP',
                      title: 'دولار أمريكي',
                      buy: usdBuy,
                      sell: usdSell,
                      unit: 'ل.س'),
                  _buildMiniRateBox(
                      flag: '🇹🇷',
                      code: 'TRY/SYP',
                      title: 'ليرة تركية',
                      buy: tryBuy,
                      sell: trySell,
                      unit: 'ل.س'),
                  _buildMiniRateBox(
                      flag: '🔄',
                      code: 'USD/TRY',
                      title: 'دولار / تركي',
                      buy: usdTryBuy,
                      sell: usdTrySell,
                      unit: '₺'),
                  _buildMiniRateBox(
                      flag: '🪙',
                      code: 'GOLD 21K',
                      title: 'غرام الذهب',
                      buy: goldBuy,
                      sell: goldSell,
                      unit: 'ل.س',
                      isGold: true),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 13. بطاقة بوابتي الدفع المعتمدتين حصرياً مع تفادي الـ Overflow بالكامل (ExclusivePaymentGatewayCard)
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
            color: Colors.black.withOpacity(0.45),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: const [
                    SyrianIndependenceFlag(width: 24, height: 16),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'بوابات الدفع والشحن الحصرية 💳',
                        style: TextStyle(
                          color: Color(0xFFD4AF37),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: const Color(0xFF22C55E).withOpacity(0.4)),
                ),
                child: const Text(
                  'معتمد سيادياً',
                  style: TextStyle(
                      color: Color(0xFF22C55E),
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // شام كاش (Sham Cash) - محصنة من الـ Overflow
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
                          SyrianIndependenceFlag(width: 16, height: 11),
                          SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              'شام كاش (Sham Cash)',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'ل.س',
                            style: TextStyle(
                                color: Color(0xFFD4AF37), fontSize: 9.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      SelectableText(
                        kShamCashAccountKey,
                        style: const TextStyle(
                          color: Color(0xFF38BDF8),
                          fontWeight: FontWeight.bold,
                          fontSize: 10.5,
                          letterSpacing: 0.2,
                          fontFamily: 'monospace',
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy,
                      color: Color(0xFFD4AF37), size: 18),
                  tooltip: 'نسخ مفتاح شام كاش',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
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

          // بينانس USDT مع الأيقونة الرسمية - محصنة بالكامل
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
                          BinanceOfficialLogoIcon(size: 15),
                          SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              'بينانس Binance (USDT)',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'TRC20',
                            style: TextStyle(
                                color: Color(0xFF22C55E), fontSize: 9.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      SelectableText(
                        kBinanceWalletAddress,
                        style: const TextStyle(
                          color: Color(0xFFFACC15),
                          fontWeight: FontWeight.bold,
                          fontSize: 10.5,
                          letterSpacing: 0.2,
                          fontFamily: 'monospace',
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy,
                      color: Color(0xFFFACC15), size: 18),
                  tooltip: 'نسخ عنوان محفظة بينانس',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Clipboard.setData(
                        const ClipboardData(text: kBinanceWalletAddress));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            '✓ تم نسخ عنوان محفظة بينانس Binance USDT (TRC20) بنجاح!'),
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
// 14. محرك البانورامات والبنرات الإعلانية بدون قص صور (DynamicPanoramasCarousel)
// ==============================================================================
class DynamicPanoramasCarousel extends StatefulWidget {
  final List<BannerItem> banners;
  final bool isDualMode;
  final Function(BannerItem)? onBannerTap;
  final VoidCallback? onUploadBannerRequested;

  const DynamicPanoramasCarousel({
    Key? key,
    required this.banners,
    this.isDualMode = false,
    this.onBannerTap,
    this.onUploadBannerRequested,
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
    final activeList =
        widget.banners.where((b) => b.isActive && !b.isExpired).toList();
    if (activeList.isEmpty) return;

    final currentBanner = activeList[_currentIndex % activeList.length];
    final intervalSeconds = currentBanner.displayDurationSeconds.clamp(2, 15);

    _autoScrollTimer = Timer(Duration(seconds: intervalSeconds), () {
      if (!_isUserInteracting &&
          mounted &&
          activeList.isNotEmpty &&
          _pageController.hasClients) {
        final nextIndex = (_currentIndex + 1) % activeList.length;
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
    final activeBanners =
        widget.banners.where((b) => b.isActive && !b.isExpired).toList();

    if (activeBanners.isEmpty) {
      final manager = AppStateManager();
      return Container(
        height: 140,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFD4AF37), width: 1.2),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.panorama, color: Color(0xFFD4AF37), size: 28),
              const SizedBox(height: 6),
              const Text(
                'مساحة البانوراما الإعلانية الرئيسية 🌟',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              if (manager.isModerator && widget.onUploadBannerRequested != null)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  ),
                  icon: const Icon(Icons.add_photo_alternate,
                      size: 16, color: Color(0xFF0F172A)),
                  label: const Text(
                    'رفع وتثبيت بانوراما جديدة 🚀',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                    ),
                  ),
                  onPressed: widget.onUploadBannerRequested,
                )
              else
                TextButton.icon(
                  icon: const Icon(Icons.chat,
                      size: 14, color: Color(0xFF22C55E)),
                  label: const Text(
                    'احجز خانتك في البانوراما VIP الآن 👆',
                    style: TextStyle(color: Color(0xFFD4AF37), fontSize: 11),
                  ),
                  onPressed: () => PhoneHelper.openAdminWhatsApp(
                      'مرحباً، أود حجز خانة إعلانية في البانوراما VIP.'),
                ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 185,
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
              itemCount: activeBanners.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _startAutoScroll();
              },
              itemBuilder: (context, index) {
                final item = activeBanners[index];
                return GestureDetector(
                  onTap: () => widget.onBannerTap?.call(item),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xFF0F172A),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 10,
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
                            fit: BoxFit.contain,
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
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black38, blurRadius: 3)
                                ],
                              ),
                              child: Text(
                                '${item.badgeText} • خانة ${item.slotIndex}',
                                style: const TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2.5),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'اضغط للتفاصيل 👆',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 8.5),
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
                                    fontSize: 13.5,
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
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
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
          children: List.generate(activeBanners.length, (index) {
            final isSelected = _currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 4,
              width: isSelected ? 18 : 4,
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
// 15. الشجرة الهيكلية للأقسام والفروع (DepartmentTreeItemWidget)
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
      case 'PhoneAndroid':
        return Icons.phone_android;
      default:
        return Icons.category;
    }
  }
}

// ==============================================================================
// 16. نافذة البحث الصوتي الذكي بالميكروفون (VoiceInputDialog)
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
    final manager = AppStateManager();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor:
          manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
      title: Row(
        children: [
          const Icon(Icons.mic, color: Color(0xFF0284C7)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: manager.darkAdaptiveTextColor,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'تحدث الآن بوضوح أو اكتب الكلمات المراد البحث عنها في السوق:',
            style: TextStyle(
              fontSize: 12,
              color: manager.isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _inputController,
            autofocus: true,
            style: TextStyle(
              color: manager.darkAdaptiveTextColor,
            ),
            decoration: InputDecoration(
              hintText: 'مثال: سيارة كيا، شقة للإيجار بإدلب، منظومة طاقة...',
              hintStyle: TextStyle(
                color: manager.isDarkMode ? Colors.white38 : Colors.grey,
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'إلغاء',
            style: TextStyle(
              color: manager.isDarkMode ? Colors.white70 : Colors.grey,
            ),
          ),
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
// 17. القائمة الجانبية السيادية المعتمدة والمصححة للمشرفين (CustomServerDrawer)
// ==============================================================================
class CustomServerDrawer extends StatelessWidget {
  final String? userId;
  final VoidCallback? onOpenContactAdmin;
  final VoidCallback? onOpenFeedback;
  final VoidCallback? onOpenPlans;
  final VoidCallback? onOpenAdminPanel;

  const CustomServerDrawer({
    Key? key,
    this.userId,
    this.onOpenContactAdmin,
    this.onOpenFeedback,
    this.onOpenPlans,
    this.onOpenAdminPanel,
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
                  backgroundImage: manager.currentUserAvatarUrl.isNotEmpty
                      ? NetworkImage(manager.currentUserAvatarUrl)
                      : null,
                  child: manager.currentUserAvatarUrl.isEmpty
                      ? Text(
                          manager.currentUserName.isNotEmpty
                              ? manager.currentUserName[0]
                              : 'س',
                          style: TextStyle(
                            color: manager.primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              manager.currentUserName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (manager.isModerator) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 1.5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'مشرف 🛡️',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ],
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
                  title: Text(
                    'تواصل مباشر مع الإدارة',
                    style: TextStyle(color: manager.darkAdaptiveTextColor),
                  ),
                  subtitle: Text(
                    'واتساب أو اتصال هاتفي فوري',
                    style: TextStyle(
                      color: manager.isDarkMode
                          ? Colors.white60
                          : Colors.grey.shade600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    if (onOpenContactAdmin != null) {
                      onOpenContactAdmin!();
                    } else {
                      PhoneHelper.openAdminWhatsApp(
                          'مرحباً إدارة سوق سوريا الشامل 2028:');
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.lightbulb, color: manager.secondaryColor),
                  title: Text(
                    'صوتك مسموع 💡 (اقتراح ميزة)',
                    style: TextStyle(color: manager.darkAdaptiveTextColor),
                  ),
                  subtitle: Text(
                    'إرسال فكرة مع لقطة شاشة',
                    style: TextStyle(
                      color: manager.isDarkMode
                          ? Colors.white60
                          : Colors.grey.shade600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    if (onOpenFeedback != null) {
                      onOpenFeedback!();
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const AppFeedbackScreen()));
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.workspace_premium,
                      color: Color(0xFFD4AF37)),
                  title: Text(
                    'باقات الاشتراك والترقية VIP',
                    style: TextStyle(color: manager.darkAdaptiveTextColor),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    if (onOpenPlans != null) {
                      onOpenPlans!();
                    }
                  },
                ),
                const Divider(),
                if (manager.isModerator) ...[
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.admin_panel_settings,
                          color: Colors.red, size: 26),
                      title: const Text(
                        'غرفة العمليات المركزية 🛡️',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                          'موافقة وإدارة المنشورات ورفضها مع الأسباب'),
                      onTap: () {
                        Navigator.pop(context);
                        if (onOpenAdminPanel != null) {
                          onOpenAdminPanel!();
                        }
                      },
                    ),
                  ),
                  const Divider(),
                ],
                ListTile(
                  leading: const Icon(Icons.share, color: Colors.blue),
                  title: Text(
                    'مشاركة رابط المنصة',
                    style: TextStyle(color: manager.darkAdaptiveTextColor),
                  ),
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
                  style: TextStyle(
                    color: manager.isDarkMode
                        ? const Color(0xFFD4AF37)
                        : Colors.grey.shade500,
                    fontSize: 10,
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
// 18. شاشة تفاصيل البنر والبانوراما الإعلانية (FullBannerDetailsScreen)
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
            height: 250,
            child: PageView.builder(
              itemCount:
                  banner.imageUrls.isNotEmpty ? banner.imageUrls.length : 1,
              itemBuilder: (ctx, idx) {
                final url = banner.imageUrls.isNotEmpty
                    ? banner.imageUrls[idx]
                    : banner.imageUrl;
                return AppSmartImage(imageUrl: url, fit: BoxFit.contain);
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
                          horizontal: 9, vertical: 4.5),
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
                        Text(
                          banner.location,
                          style: TextStyle(
                            fontSize: 12,
                            color: manager.darkAdaptiveTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  banner.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: manager.darkAdaptiveTextColor,
                  ),
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
                Text(
                  'تفاصيل العرض الترويجي:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: manager.darkAdaptiveTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  banner.description.isNotEmpty
                      ? banner.description
                      : 'تواصل مع المعلن لمعرفة كامل التفاصيل والعروض الخاصة.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    color: manager.darkAdaptiveTextColor,
                  ),
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
// 19. شاشة "صوتك مسموع 💡" وصندوق مقترحات وتطوير المنصة (AppFeedbackScreen)
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

    try {
      await Supabase.instance.client
          .from('app_feedback')
          .insert(newFeedback.toMap())
          .timeout(const Duration(seconds: 8));
    } catch (_) {}

    if (mounted) {
      setState(() => _isSending = false);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor:
              _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          title: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 24),
              const SizedBox(width: 8),
              Text(
                'شكراً لمشاركتك القيّمة ❤️',
                style: TextStyle(
                  fontSize: 16,
                  color: _manager.darkAdaptiveTextColor,
                ),
              ),
            ],
          ),
          content: Text(
            'تم إرسال رسالتك ومقترحك مباشرةً إلى غرفة عمليات الإدارة. نحن نقرأ كافة الأفكار بعناية فائقة لتطوير سوق سوريا الشامل.',
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: _manager.darkAdaptiveTextColor,
            ),
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
                  Expanded(
                    child: Text(
                      'رأيك يصنع الفرق! شاركنا بأي فكرة، ميزة جديدة، أو ملاحظة لتطوير التطبيق لخدمتك بشكل أفضل.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                        color: _manager.darkAdaptiveTextColor,
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
              dropdownColor:
                  _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
              decoration: InputDecoration(
                labelText: 'نوع الرسالة أو المقترح',
                labelStyle: TextStyle(color: _manager.formLabelColor),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: _feedbackTypes
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t,
                            style: TextStyle(
                              fontSize: 13,
                              color: _manager.darkAdaptiveTextColor,
                            ),
                            overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _feedbackType = v!),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              style: TextStyle(color: _manager.darkAdaptiveTextColor),
              decoration: InputDecoration(
                labelText: 'اسمك الكريم (اختياري)',
                labelStyle: TextStyle(color: _manager.formLabelColor),
                prefixIcon:
                    Icon(Icons.person, color: _manager.darkAdaptiveTextColor),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contactController,
              style: TextStyle(color: _manager.darkAdaptiveTextColor),
              decoration: InputDecoration(
                labelText: 'رقم هاتفك أو بريدك للتواصل والمتابعة',
                labelStyle: TextStyle(color: _manager.formLabelColor),
                prefixIcon: Icon(Icons.contact_phone,
                    color: _manager.darkAdaptiveTextColor),
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
              style: TextStyle(color: _manager.darkAdaptiveTextColor),
              decoration: InputDecoration(
                labelText: 'تفاصيل الفكرة أو الملاحظة *',
                labelStyle: TextStyle(color: _manager.formLabelColor),
                hintText: 'اكتب اقتراحك بالتفصيل هنا...',
                hintStyle: TextStyle(
                    color: _manager.isDarkMode ? Colors.white38 : Colors.grey),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().length < 5)
                  ? 'يرجى كتابة تفاصيل المقترح'
                  : null,
            ),
            const SizedBox(height: 8),
            Card(
              color:
                  _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
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
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _manager.darkAdaptiveTextColor,
                  ),
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
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [القسم الثالث - الدفعة 1 من 2: معاينة الويب، تفاصيل المنشور والمزاد، ومتجر البائع]
// ==============================================================================

// ==============================================================================
// 19. شاشة معاينة ومشاركة المنشور بنمط صفحة الويب المدمجة (InAppPostWebPreviewScreen)
// ==============================================================================
class InAppPostWebPreviewScreen extends StatelessWidget {
  final AdItem ad;

  const InAppPostWebPreviewScreen({Key? key, required this.ad})
      : super(key: key);

  String get shareableWebUrl => '$kDefaultShareDomain/ad/${ad.id}';

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
      '📍 الموقع: ${ad.governorate} - ${ad.neighborhood}\n'
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

  void _shareViaTelegram(BuildContext context) async {
    final text = Uri.encodeComponent(
      '🌟 شاهد إعلان "${ad.title}" على سوق سوريا الشامل 2028:\n'
      '📍 المحافظة: ${ad.governorate} - ${ad.neighborhood}\n'
      '💵 السعر: \$${ad.priceUsd ?? 0}\n'
      '🔗 الرابط: $shareableWebUrl',
    );
    final uri =
        Uri.parse('https://t.me/share/url?url=$shareableWebUrl&text=$text');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  void _shareViaFacebook(BuildContext context) async {
    final uri = Uri.parse(
        'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(shareableWebUrl)}');
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
        elevation: 0,
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lock, color: Colors.greenAccent, size: 16),
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
                  InkWell(
                    onTap: () => _copyShareableLink(context),
                    child: const Icon(Icons.copy,
                        size: 18, color: Color(0xFFD4AF37)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFF1E293B),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xFFD4AF37), width: 1.2),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 230,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                ad.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (ad.isAuction)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4AF37),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  '🔨 مزاد علني',
                                  style: TextStyle(
                                      color: Color(0xFF0F172A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            if (ad.priceUsd != null)
                              Text(
                                '\$${ad.priceUsd!.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Color(0xFF22C55E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            const SizedBox(width: 8),
                            if (ad.priceSyp != null)
                              Text(
                                '(${ad.priceSyp!.toStringAsFixed(0)} ل.س)',
                                style: const TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              '${ad.governorate} - ${ad.neighborhood}',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                            const Spacer(),
                            Text(
                              'الحالة: ${ad.condition}',
                              style: const TextStyle(
                                  color: Colors.white60, fontSize: 11),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.white24, height: 24),
                        Text(
                          ad.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: const Color(0xFFD4AF37),
                                child: Text(
                                  ad.publisherName.isNotEmpty
                                      ? ad.publisherName[0]
                                      : 'U',
                                  style: const TextStyle(
                                      color: Color(0xFF0F172A),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ad.publisherName,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                    Text(
                                      'هاتف: ${ad.contactPhone}',
                                      style: const TextStyle(
                                          color: Colors.white60, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'مشاركة سريعة عبر المنصات الاجتماعية:',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
            const SizedBox(height: 10),
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
                    icon:
                        const Icon(Icons.share, color: Colors.white, size: 18),
                    label: const Text(
                      'واتساب',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _shareViaWhatsApp(context),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0284C7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    label: const Text(
                      'تليجرام',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _shareViaTelegram(context),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1877F2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.thumb_up,
                        color: Colors.white, size: 18),
                    label: const Text(
                      'فيسبوك',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _shareViaFacebook(context),
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
// 20. شاشة تفاصيل الإعلانات والمزادات الحرة الكبرى (FullAdDetailsScreen)
// ==============================================================================
class FullAdDetailsScreen extends StatefulWidget {
  final AdItem ad;
  final bool isFavorite;
  final VoidCallback? onToggleFavorite;
  final Function(AdItem)? onAdUpdated;
  final Function(String)? onAdDeleted;

  const FullAdDetailsScreen({
    Key? key,
    required this.ad,
    this.isFavorite = false,
    this.onToggleFavorite,
    this.onAdUpdated,
    this.onAdDeleted,
  }) : super(key: key);

  @override
  State<FullAdDetailsScreen> createState() => _FullAdDetailsScreenState();
}

class _FullAdDetailsScreenState extends State<FullAdDetailsScreen> {
  final AppStateManager _manager = AppStateManager();
  late AdItem _currentAd;
  late bool _isFav;
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
    _isFav = widget.isFavorite;
    _manager.incrementAdViews(_currentAd.id);
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
          widget.onAdDeleted?.call(_currentAd.id);
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
    _manager.incrementAdCallClicks(_currentAd.id);
    final uri = Uri.parse('tel:${_currentAd.contactPhone}');
    try {
      if (await canLaunchUrl(uri)) await launchUrl(uri);
    } catch (_) {}
  }

  void _openWhatsapp() async {
    _manager.incrementAdWhatsappClicks(_currentAd.id);
    final target = _currentAd.contactWhatsapp.isNotEmpty
        ? _currentAd.contactWhatsapp
        : _currentAd.contactPhone;
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

    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => FullChatNegotiationScreen(
            adId: _currentAd.id,
            partnerName: _currentAd.publisherName,
            productTitle: _currentAd.title,
            initialPrice: _currentAd.priceUsd ?? _currentAd.priceSyp ?? 0,
          ),
        ),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('💬 جاري فتح المحادثة المباشرة مع البائع...')),
      );
    }
  }

  void _openWebPreview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => InAppPostWebPreviewScreen(ad: _currentAd),
      ),
    );
  }

  void _openSellerProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => PublicSellerProfileScreen(
          sellerId: _currentAd.userId,
          sellerName: _currentAd.publisherName,
          sellerPhone: _currentAd.contactPhone,
          sellerWhatsapp: _currentAd.contactWhatsapp,
          sellerAvatarUrl: _currentAd.publisherAvatarUrl,
          sellerBio: _currentAd.publisherBio,
          sellerPlanId: _currentAd.sellerPlanId,
          isVerified: _currentAd.isVerifiedSeller,
          positiveLikes: _currentAd.sellerPositiveLikes,
          dislikes: _currentAd.sellerDislikes,
        ),
      ),
    );
  }

  void _showBidsHistorySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          _manager.isDarkMode ? const Color(0xFF0F172A) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: dynamic,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.history,
                        color: Color(0xFFD4AF37), size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'سجل المزايدات الحية 📜 (${_currentAd.bids.length})',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _manager.darkAdaptiveTextColor,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const Divider(),
            if (_currentAd.bids.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Text(
                    'لا توجد مزايدات مسجلة بعد. كن أول من يفتتح المزاد!',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              )
            else
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _currentAd.bids.length,
                  itemBuilder: (context, idx) {
                    final b = _currentAd.bids[idx];
                    final isTopBidder = idx == 0;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isTopBidder
                            ? const Color(0xFFD4AF37).withOpacity(0.15)
                            : (_manager.isDarkMode
                                ? const Color(0xFF1E293B)
                                : Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isTopBidder
                              ? const Color(0xFFD4AF37)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: isTopBidder
                                ? const Color(0xFFD4AF37)
                                : Colors.grey.shade700,
                            child: Text(
                              '#${idx + 1}',
                              style: TextStyle(
                                color: isTopBidder
                                    ? const Color(0xFF0F172A)
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
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
                                      b.userName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: _manager.darkAdaptiveTextColor,
                                      ),
                                    ),
                                    if (isTopBidder) ...[
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1.5),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF16A34A),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: const Text(
                                          'المتصدر الحالي 👑',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  '${b.timestamp.day}/${b.timestamp.month} • ${b.timestamp.hour}:${b.timestamp.minute.toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${b.amount.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Color(0xFF22C55E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                '${(b.amount * _manager.exchangeRateUsdToSyp).toStringAsFixed(0)} ل.س',
                                style: TextStyle(
                                    color: _manager.priceSypColor,
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
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
        const SnackBar(content: Text('✅ تمت إضافة استفسارك بنجاح!')),
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
    widget.onAdUpdated?.call(_currentAd);

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
            backgroundColor:
                _manager.isDarkMode ? const Color(0xFF0F172A) : Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Row(
              children: [
                Icon(Icons.check_circle_outline,
                    color: Color(0xFFDC2626), size: 24),
                SizedBox(width: 8),
                Text('تأكيد تم البيع ✓ SOLD',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            content: Text(
              'هل تم بيع هذه السلعة بالفعل؟\nسيظهر ختم "تم البيع" لجميع المستخدمين مع عداد تنازلي 60 دقيقة، وسيتم حذف المنشور نهائياً بعد انتهاء المدة.',
              style: TextStyle(
                color: _manager.isDarkMode ? Colors.white70 : Colors.black87,
                fontSize: 13,
                height: 1.5,
              ),
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
    widget.onAdUpdated?.call(_currentAd);

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
          amountSyp: entered * _manager.exchangeRateUsdToSyp,
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

    widget.onAdUpdated?.call(updatedAd);

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
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => FullAddAdScreen(
            initialAd: _currentAd,
            onAdCreated: (up) {
              setState(() => _currentAd = up);
              widget.onAdUpdated?.call(up);
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
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('✏️ تعديل الإعلان متاح عبر شاشة إضافة وتعديل الإعلان.')),
      );
    }
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
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Icon(
                _isFav ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(_isFav),
                color: _isFav ? Colors.red : Colors.white,
              ),
            ),
            onPressed: () {
              setState(() => _isFav = !_isFav);
              widget.onToggleFavorite?.call();
            },
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
                      widget.onAdDeleted?.call(_currentAd.id);
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
                      '⏳ الإعلان قيد التدقيق والمراجعة في غرفة الإشراف وسيظهر للجميع فور اعتماده.',
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
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '❌ تم رفض هذا الإعلان من قبل المشرفين.',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        if (_currentAd.rejectionReason != null &&
                            _currentAd.rejectionReason!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'سبب الرفض: ${_currentAd.rejectionReason}',
                              style: const TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.bold),
                            ),
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
                          imageUrl: images[idx], fit: BoxFit.contain),
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
                  Text(
                    'روابط التواصل وفيديو المعاينة:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: _manager.darkAdaptiveTextColor,
                    ),
                  ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.gavel,
                                    color: Colors.amber, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  'المزاد العلني المباشر ⚖️',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.5,
                                      color: _manager.darkAdaptiveTextColor),
                                ),
                              ],
                            ),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFD4AF37),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                              ),
                              icon: const Icon(Icons.history,
                                  color: Color(0xFF0F172A), size: 15),
                              label: const Text(
                                'سجل المزايدين 📜',
                                style: TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                              onPressed: _showBidsHistorySheet,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'أعلى مزايدة: \$${(_currentAd.currentBid ?? _currentAd.startingBid ?? 0).toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              '(${_currentAd.bids.length} مزايدة مسجلة)',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 11),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _bidController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: _manager.darkAdaptiveTextColor),
                                decoration: InputDecoration(
                                  hintText: 'قيمة المزايدة (\$)',
                                  hintStyle: TextStyle(
                                    color: _manager.isDarkMode
                                        ? Colors.white38
                                        : Colors.grey,
                                  ),
                                  border: const OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.symmetric(
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
                Text(
                  'تفاصيل ومواصفات السلعة:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _manager.darkAdaptiveTextColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _currentAd.description,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.6,
                    color: _manager.darkAdaptiveTextColor,
                  ),
                ),
                const SizedBox(height: 20),

                // بطاقة متجر البائع
                InkWell(
                  onTap: _openSellerProfile,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _manager.isDarkMode
                          ? const Color(0xFF1E293B)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: const Color(0xFFD4AF37).withOpacity(0.5)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: _manager.primaryColor,
                              backgroundImage: _currentAd
                                      .publisherAvatarUrl.isNotEmpty
                                  ? NetworkImage(_currentAd.publisherAvatarUrl)
                                  : null,
                              child: _currentAd.publisherAvatarUrl.isEmpty
                                  ? Text(
                                      _currentAd.publisherName.isNotEmpty
                                          ? _currentAd.publisherName[0]
                                          : 'U',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          _currentAd.publisherName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.5,
                                            color:
                                                _manager.darkAdaptiveTextColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      KycVerificationBadge(
                                        isVerified: _currentAd.isVerifiedSeller,
                                        positiveLikes:
                                            _currentAd.sellerPositiveLikes,
                                        planId: _currentAd.sellerPlanId,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'اضغط لزيارة متجر البائع وتصفح جميع بضائعه 👈',
                                    style: TextStyle(
                                        fontSize: 10.5,
                                        color: _manager.secondaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                size: 14, color: Color(0xFFD4AF37)),
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
                ),
                const SizedBox(height: 20),
                Text(
                  'التعليقات والاستفسارات المباشرة 💬:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _manager.darkAdaptiveTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        style: TextStyle(color: _manager.darkAdaptiveTextColor),
                        decoration: InputDecoration(
                          hintText: 'اكتب استفسارك أو تعليقك حول السلعة...',
                          hintStyle: TextStyle(
                            color: _manager.isDarkMode
                                ? Colors.white38
                                : Colors.grey,
                          ),
                          filled: true,
                          fillColor: _manager.isDarkMode
                              ? const Color(0xFF1E293B)
                              : Colors.grey.shade100,
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
                        color: _manager.isDarkMode
                            ? const Color(0xFF1E293B)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: _manager.isDarkMode
                                ? Colors.white12
                                : Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(c.userName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: _manager.darkAdaptiveTextColor)),
                              Text(
                                '${c.createdAt.hour}:${c.createdAt.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            c.commentText,
                            style: TextStyle(
                              fontSize: 12,
                              color: _manager.darkAdaptiveTextColor,
                            ),
                          ),
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
          color: _manager.isDarkMode ? const Color(0xFF0F172A) : Colors.white,
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
// 21. شاشة متجر البائع الشامل ومعرض بضائعه الحية (PublicSellerProfileScreen)
// ==============================================================================
class PublicSellerProfileScreen extends StatefulWidget {
  final String sellerId;
  final String sellerName;
  final String sellerPhone;
  final String sellerWhatsapp;
  final String sellerAvatarUrl;
  final String sellerBio;
  final String sellerPlanId;
  final bool isVerified;
  final int positiveLikes;
  final int dislikes;

  const PublicSellerProfileScreen({
    Key? key,
    required this.sellerId,
    required this.sellerName,
    required this.sellerPhone,
    required this.sellerWhatsapp,
    required this.sellerAvatarUrl,
    required this.sellerBio,
    required this.sellerPlanId,
    required this.isVerified,
    required this.positiveLikes,
    required this.dislikes,
  }) : super(key: key);

  @override
  State<PublicSellerProfileScreen> createState() =>
      _PublicSellerProfileScreenState();
}

class _PublicSellerProfileScreenState extends State<PublicSellerProfileScreen> {
  final AppStateManager _manager = AppStateManager();
  List<AdItem> _sellerAds = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSellerAds();
  }

  Future<void> _fetchSellerAds() async {
    setState(() => _isLoading = true);
    try {
      final res = await Supabase.instance.client
          .from('ads')
          .select()
          .eq('user_id', widget.sellerId)
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 10));

      if (res is List && res.isNotEmpty) {
        _sellerAds = res
            .whereType<Map<String, dynamic>>()
            .map((e) => AdItem.fromMap(e))
            .where((a) => a.status == 'approved' || _manager.isSuperAdmin)
            .toList();
      } else {
        _sellerAds = _manager.ads
            .where((a) =>
                a.userId == widget.sellerId ||
                a.publisherName == widget.sellerName)
            .toList();
      }
    } catch (_) {
      _sellerAds = _manager.ads
          .where((a) =>
              a.userId == widget.sellerId ||
              a.publisherName == widget.sellerName)
          .toList();
    }
    if (mounted) setState(() => _isLoading = false);
  }

  void _callSeller() async {
    final uri = Uri.parse('tel:${widget.sellerPhone}');
    try {
      if (await canLaunchUrl(uri)) await launchUrl(uri);
    } catch (_) {}
  }

  void _whatsappSeller() async {
    final target = widget.sellerWhatsapp.isNotEmpty
        ? widget.sellerWhatsapp
        : widget.sellerPhone;
    final clean = PhoneHelper.formatForWhatsapp(target);
    final msg = Uri.encodeComponent(
      'مرحباً يا ${widget.sellerName}، اطلعت على متجرك في سوق سوريا الشامل 2028 وأود الاستفسار عن بضائعك.',
    );
    final uri = Uri.parse('https://wa.me/$clean?text=$msg');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: Text(
          'متجر المعلن: ${widget.sellerName}',
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
          Container(
            color: const Color(0xFF1E293B),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: const Color(0xFFD4AF37),
                  backgroundImage: widget.sellerAvatarUrl.isNotEmpty
                      ? NetworkImage(widget.sellerAvatarUrl)
                      : null,
                  child: widget.sellerAvatarUrl.isEmpty
                      ? Text(
                          widget.sellerName.isNotEmpty
                              ? widget.sellerName[0]
                              : 'U',
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.sellerName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    KycVerificationBadge(
                      isVerified: widget.isVerified,
                      positiveLikes: widget.positiveLikes,
                      planId: widget.sellerPlanId,
                      size: 20,
                    ),
                  ],
                ),
                if (widget.sellerBio.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    widget.sellerBio,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: Colors.green.withOpacity(0.5)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.thumb_up,
                              color: Colors.green, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'إيجابي: ${widget.positiveLikes}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.red.withOpacity(0.5)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.thumb_down,
                              color: Colors.red, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'سلبي: ${widget.dislikes}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        icon: const Icon(Icons.chat,
                            color: Colors.white, size: 18),
                        label: const Text(
                          'مراسلة واتساب',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        onPressed: _whatsappSeller,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0284C7),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        icon: const Icon(Icons.phone,
                            color: Colors.white, size: 18),
                        label: const Text(
                          'اتصال هاتفي',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        onPressed: _callSeller,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const Icon(Icons.store, color: Color(0xFFD4AF37), size: 20),
                const SizedBox(width: 8),
                Text(
                  'بضائع وإعلانات المعلن (${_sellerAds.length})',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _manager.darkAdaptiveTextColor,
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(36),
                child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
              ),
            )
          else if (_sellerAds.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(36),
                child: Text(
                  'لا توجد إعلانات معروضة حالياً لهذا البائع.',
                  style: TextStyle(
                    color: _manager.darkAdaptiveTextColor.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _sellerAds.length,
              itemBuilder: (ctx, idx) => FullAdCardItem(
                ad: _sellerAds[idx],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => FullAdDetailsScreen(ad: _sellerAds[idx]),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
// ==============================================================================
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [القسم الثالث - الدفعة 2 من 2: عناصر العرض المساعدة المحصنة والشاشة الرئيسية المركزية العملاقة]
// ==============================================================================

// ==============================================================================
// 22. عناصر العرض المساعدة المحصنة ذاتياً (Widgets المدمجة لضمان اكتمال المنظومة)
// ==============================================================================
class LiveExchangeRateBar extends StatelessWidget {
  const LiveExchangeRateBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = AppStateManager();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(Icons.attach_money,
                  color: Colors.greenAccent, size: 18),
              const SizedBox(width: 4),
              Text(
                '1\$ = ${manager.exchangeRateUsdToSyp.toStringAsFixed(0)} ل.س',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(width: 1, height: 16, color: Colors.white24),
          Row(
            children: [
              const Icon(Icons.diamond, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                'غرام الذهب (21): ${manager.goldPrice21kSyp.toStringAsFixed(0)} ل.س',
                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FullInvestmentBannerCarousel extends StatefulWidget {
  final List<BannerItem> banners;
  final Function(int) onSlotTap;

  const FullInvestmentBannerCarousel({
    Key? key,
    required this.banners,
    required this.onSlotTap,
  }) : super(key: key);

  @override
  State<FullInvestmentBannerCarousel> createState() =>
      _FullInvestmentBannerCarouselState();
}

class _FullInvestmentBannerCarouselState
    extends State<FullInvestmentBannerCarousel> {
  final PageController _pageController = PageController();
  int _activePage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasBanners = widget.banners.isNotEmpty;
    final count = hasBanners ? widget.banners.length : 1;

    return Column(
      children: [
        SizedBox(
          height: 115,
          child: PageView.builder(
            controller: _pageController,
            itemCount: count,
            onPageChanged: (i) => setState(() => _activePage = i),
            itemBuilder: (ctx, idx) {
              final slotIndex = hasBanners ? widget.banners[idx].slotIndex : 1;
              return InkWell(
                onTap: () => widget.onSlotTap(slotIndex),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFD4AF37).withOpacity(0.5),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.workspace_premium,
                            color: Color(0xFFD4AF37), size: 28),
                        const SizedBox(height: 6),
                        Text(
                          'مساحة إعلانية استثمارية شاغرة (خانة $slotIndex)',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'اضغط هنا لحجز هذه المساحة لعلامتك التجارية 👈',
                          style:
                              TextStyle(color: Color(0xFFD4AF37), fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (count > 1) ...[
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              count,
              (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: _activePage == i ? 14 : 5,
                height: 4,
                decoration: BoxDecoration(
                  color: _activePage == i
                      ? const Color(0xFFD4AF37)
                      : Colors.white30,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class FullAdCardItem extends StatelessWidget {
  final AdItem ad;
  final VoidCallback onTap;

  const FullAdCardItem({
    Key? key,
    required this.ad,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = AppStateManager();
    final firstImg = ad.imageUrls.isNotEmpty ? ad.imageUrls.first : '';

    return Card(
      color: manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ad.isAuction
              ? const Color(0xFFD4AF37)
              : (manager.isDarkMode ? Colors.white12 : Colors.grey.shade200),
          width: ad.isAuction ? 1.4 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 11,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppSmartImage(imageUrl: firstImg, fit: BoxFit.cover),
                  if (ad.isSold)
                    Container(
                      color: Colors.black.withOpacity(0.6),
                      child: Center(
                        child: Transform.rotate(
                          angle: -0.2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.shade700,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'تم البيع ✓',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (ad.isAuction && !ad.isSold)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '🔨 مزاد',
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                            fontSize: 9.5,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        ad.governorate,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 9.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ad.title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: manager.darkAdaptiveTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (ad.isAuction)
                          Text(
                            'السومة: \$${(ad.currentBid ?? ad.startingBid ?? 0).toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Color(0xFF22C55E),
                              fontWeight: FontWeight.bold,
                              fontSize: 12.5,
                            ),
                          )
                        else if (ad.priceUsd != null)
                          Text(
                            '\$${ad.priceUsd!.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Color(0xFF22C55E),
                              fontWeight: FontWeight.bold,
                              fontSize: 12.5,
                            ),
                          ),
                        if (ad.priceSyp != null)
                          Text(
                            '${ad.priceSyp!.toStringAsFixed(0)} ل.س',
                            style: TextStyle(
                              color: manager.priceSypColor,
                              fontSize: 10,
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person,
                            size: 11, color: Colors.grey.shade500),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            ad.publisherName,
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey.shade500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
}

// ==============================================================================
// 23. كلاس الشاشة الرئيسية المركزية وسوق المنشورات (MainDashboardScreen)
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
    with SingleTickerProviderStateMixin {
  final AppStateManager _manager = AppStateManager();

  int _currentIndex = 0;
  int get _currentNavIndex => _currentIndex;
  set _currentNavIndex(int val) => _currentIndex = val;

  // متحكمات البحث والتصفية المتقدمة
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  String _selectedCategory = 'الكل';
  String _selectedSubcategory = 'الكل';
  String _selectedGovernorate = 'الكل';
  String _selectedDistrict = 'الكل';
  String _selectedCondition = 'الكل';
  String _sortBy = 'newest';
  bool _onlyAuctions = false;
  bool _onlyVerifiedSellers = false;
  bool _isGridView = true;

  static const List<String> _governoratesList = [
    'الكل',
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
    'الحسكة',
  ];

  static const Map<String, List<String>> _districtsMap = {
    'دمشق': [
      'الكل',
      'الميدان',
      'المزة',
      'المالكي',
      'أبو رمانة',
      'الشعلان',
      'الصالحية',
      'المهاجرين',
      'ركن الدين',
      'القصاع',
      'باب توما',
      'كفرسوسة',
      'البرامكة',
      'دمر'
    ],
    'ريف دمشق': [
      'الكل',
      'جرمانا',
      'صحنايا',
      'أشرفية صحنايا',
      'جديدة عرطوز',
      'معضمية الشام',
      'داريا',
      'قدسيا',
      'الهامة',
      'الصبورة',
      'يعفور',
      'النبك',
      'يبرود',
      'التل',
      'دوما',
      'حرستا',
      'الكسوة',
      'قطنا',
      'الزبداني',
      'مضايا',
      'بلودان'
    ],
    'حلب': [
      'الكل',
      'الفرقان',
      'الشهباء',
      'المارتيني',
      'حلب الجديدة',
      'السليمانية',
      'العزيزية',
      'الميريديان',
      'سيف الدولة',
      'الجميلية',
      'الحمدانية',
      'صلاح الدين',
      'الزهراء'
    ],
    'حمص': [
      'الكل',
      'الحمراء',
      'الإنشاءات',
      'الغوطة',
      'الدبلان',
      'عكرمة',
      'الوعر',
      'كرم الشامي',
      'باب السباع',
      'الزهراء',
      'الأرمن',
      'الميدان',
      'المحطة',
      'القصور'
    ],
    'حماة': [
      'الكل',
      'الحاضر',
      'الدباغة',
      'المرابط',
      'الصابونية',
      'القصور',
      'البارودية',
      'شمال الخط',
      'الكرامة',
      'الشريعة',
      'طريق حلب',
      'سلمية',
      'مصياف',
      'محردة'
    ],
    'اللاذقية': [
      'الكل',
      'الصليبة',
      'الرمل الشمالي',
      'الزراعة',
      'المشروع السابع',
      'المشروع العاشر',
      'الأمريكان',
      'مار تقلا',
      'الكورنيش الجنوبي',
      'الكورنيش الغربي',
      'جبلة',
      'القرداحة',
      'الحفة'
    ],
    'طرطوس': [
      'الكل',
      'المشبكة',
      'الغمقة',
      'الرادار',
      'الكورنيش البحري',
      'الحمرات',
      'الإنشاءات',
      'بانياس',
      'صافيتا',
      'الدريكيش',
      'الشيخ بدر',
      'مشتى الحلو'
    ],
    'إدلب': [
      'الكل',
      'المدينة',
      'أريحا',
      'معرة النعمان',
      'سراقب',
      'جسر الشغور',
      'حارم',
      'سلقين',
      'الدانا',
      'سرمدا',
      'خان شيخون'
    ],
    'درعا': [
      'الكل',
      'درعا المحطة',
      'درعا البلد',
      'الصنمين',
      'إزرع',
      'طفس',
      'نوى',
      'داعل',
      'بصرى الشام',
      'جاسم',
      'الحراك'
    ],
    'السويداء': ['الكل', 'المدينة', 'شهبا', 'صلخد', 'القريا', 'شقا', 'المزرعة'],
    'القنيطرة': [
      'الكل',
      'المدينة',
      'خان أرنبة',
      'البعث',
      'جباتا الخشب',
      'الرفيد'
    ],
    'دير الزور': [
      'الكل',
      'المدينة',
      'الميادين',
      'البوكمال',
      'القصور',
      'الجورة'
    ],
    'الرقة': ['الكل', 'المدينة', 'الطبقة', 'تل أبيض'],
    'الحسكة': [
      'الكل',
      'المدينة',
      'القامشلي',
      'رأس العين',
      'المالكية',
      'عامودا',
      'الدرباسية'
    ],
  };

  @override
  void initState() {
    super.initState();
    _manager.addListener(_onStateChange);
    _fetchLiveServerData();
  }

  @override
  void dispose() {
    _manager.removeListener(_onStateChange);
    _searchController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _onStateChange() {
    if (mounted) setState(() {});
  }

  Future<void> _fetchLiveServerData() async {
    try {
      final res = await Supabase.instance.client
          .from('ads')
          .select()
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 12));

      if (res is List) {
        final fetched = res
            .whereType<Map<String, dynamic>>()
            .map((map) => AdItem.fromMap(map))
            .toList();
        setState(() {
          _manager.ads = fetched;
        });
      }

      final bannerRes = await Supabase.instance.client
          .from('banners')
          .select()
          .timeout(const Duration(seconds: 10));

      if (bannerRes is List && bannerRes.isNotEmpty) {
        final fetchedBanners = bannerRes
            .whereType<Map<String, dynamic>>()
            .map((map) => BannerItem.fromMap(map))
            .toList();
        setState(() {
          _manager.banners = fetchedBanners;
        });
      }
    } catch (e) {
      debugPrint('Fetch server data error: $e');
    }
  }

  Widget _buildHomeFeedTab() {
    var filteredAds = _manager.ads.where((ad) {
      final matchesGov = _selectedGovernorate == 'الكل' ||
          ad.governorate == _selectedGovernorate;
      final matchesDistrict =
          _selectedDistrict == 'الكل' || ad.neighborhood == _selectedDistrict;
      final matchesCat = _selectedCategory == 'الكل' ||
          ad.categoryId == _selectedCategory ||
          ad.categoryName == _selectedCategory;
      final matchesSub = _selectedSubcategory == 'الكل' ||
          ad.subcategory == _selectedSubcategory;
      final matchesCond =
          _selectedCondition == 'الكل' || ad.condition == _selectedCondition;

      final q = _searchController.text.trim().toLowerCase();
      final matchesSearch = q.isEmpty ||
          ad.title.toLowerCase().contains(q) ||
          ad.description.toLowerCase().contains(q) ||
          ad.neighborhood.toLowerCase().contains(q) ||
          ad.governorate.toLowerCase().contains(q);

      final minP = double.tryParse(_minPriceController.text.trim());
      final maxP = double.tryParse(_maxPriceController.text.trim());
      final matchesMinP =
          minP == null || (ad.priceUsd != null && ad.priceUsd! >= minP);
      final matchesMaxP =
          maxP == null || (ad.priceUsd != null && ad.priceUsd! <= maxP);

      final matchesAuctionFilter = !_onlyAuctions || ad.isAuction;
      final matchesVerifiedFilter =
          !_onlyVerifiedSellers || ad.isVerifiedSeller;

      final isApprovedForFeed =
          ad.status == 'approved' || (_manager.isModerator);

      return matchesGov &&
          matchesDistrict &&
          matchesCat &&
          matchesSub &&
          matchesCond &&
          matchesSearch &&
          matchesMinP &&
          matchesMaxP &&
          matchesAuctionFilter &&
          matchesVerifiedFilter &&
          isApprovedForFeed;
    }).toList();

    if (_sortBy == 'price_asc') {
      filteredAds.sort((a, b) => (a.priceUsd ?? 0).compareTo(b.priceUsd ?? 0));
    } else if (_sortBy == 'price_desc') {
      filteredAds.sort((a, b) => (b.priceUsd ?? 0).compareTo(a.priceUsd ?? 0));
    } else {
      filteredAds.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return RefreshIndicator(
      onRefresh: () async {
        await _fetchLiveServerData();
      },
      color: const Color(0xFFD4AF37),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 6, bottom: 4),
              child: LiveExchangeRateBar(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: FullInvestmentBannerCarousel(
                banners: _manager.banners,
                onSlotTap: (slotIdx) {
                  _showReserveBannerSlotDialog(slotIdx);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 94,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: _manager.categories.length,
                itemBuilder: (ctx, idx) {
                  final cat = _manager.categories[idx];
                  final isSel = _selectedCategory == cat.name;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedCategory == cat.name) {
                          _selectedCategory = 'الكل';
                          _selectedSubcategory = 'الكل';
                        } else {
                          _selectedCategory = cat.name;
                          _selectedSubcategory = 'الكل';
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: isSel
                                  ? const Color(0xFFD4AF37)
                                  : (_manager.isDarkMode
                                      ? const Color(0xFF1E293B)
                                      : Colors.white),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSel
                                    ? Colors.white
                                    : const Color(0xFFD4AF37).withOpacity(0.4),
                                width: isSel ? 2.2 : 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              cat.iconData,
                              color: isSel
                                  ? const Color(0xFF0F172A)
                                  : const Color(0xFFD4AF37),
                              size: 26,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cat.name,
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight:
                                  isSel ? FontWeight.bold : FontWeight.normal,
                              color: isSel
                                  ? const Color(0xFFD4AF37)
                                  : _manager.darkAdaptiveTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 42,
                          decoration: BoxDecoration(
                            color: _manager.isDarkMode
                                ? const Color(0xFF1E293B)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: _manager.isDarkMode
                                    ? Colors.white12
                                    : Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search,
                                  size: 20, color: Color(0xFFD4AF37)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  style: TextStyle(
                                      color: _manager.darkAdaptiveTextColor,
                                      fontSize: 12.5),
                                  decoration: InputDecoration(
                                    hintText:
                                        'بحث في الإعلانات، السلع، المحافظات...',
                                    hintStyle: TextStyle(
                                      color: _manager.isDarkMode
                                          ? Colors.white38
                                          : Colors.grey,
                                      fontSize: 12,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  onChanged: (v) => setState(() {}),
                                ),
                              ),
                              if (_searchController.text.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    _searchController.clear();
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.close,
                                      size: 16, color: Colors.grey),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: _showFilterDialog,
                        child: Container(
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.tune,
                                  color: Color(0xFF0F172A), size: 18),
                              SizedBox(width: 4),
                              Text(
                                'تصفية',
                                style: TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: _manager.isDarkMode
                              ? const Color(0xFF1E293B)
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: _manager.isDarkMode
                                      ? Colors.white12
                                      : Colors.grey.shade300)),
                        ),
                        icon: Icon(
                          _isGridView ? Icons.view_list : Icons.grid_view,
                          color: const Color(0xFFD4AF37),
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => _isGridView = !_isGridView),
                        tooltip: _isGridView ? 'عرض كقائمة' : 'عرض كشبكة',
                      ),
                    ],
                  ),
                  if (_selectedGovernorate != 'الكل' ||
                      _selectedCategory != 'الكل') ...[
                    const SizedBox(height: 6),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          if (_selectedGovernorate != 'الكل')
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Chip(
                                label: Text(
                                    '📍 المحافظة: $_selectedGovernorate',
                                    style: const TextStyle(fontSize: 11)),
                                deleteIcon: const Icon(Icons.close, size: 14),
                                onDeleted: () => setState(() {
                                  _selectedGovernorate = 'الكل';
                                  _selectedDistrict = 'الكل';
                                }),
                              ),
                            ),
                          if (_selectedCategory != 'الكل')
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Chip(
                                label: Text('🏷️ القسم: $_selectedCategory',
                                    style: const TextStyle(fontSize: 11)),
                                deleteIcon: const Icon(Icons.close, size: 14),
                                onDeleted: () => setState(() {
                                  _selectedCategory = 'الكل';
                                  _selectedSubcategory = 'الكل';
                                }),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          filteredAds.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox,
                            size: 54, color: Colors.grey.withOpacity(0.5)),
                        const SizedBox(height: 12),
                        Text(
                          'لا توجد إعلانات مطابقة لمعايير البحث والفلترة',
                          style: TextStyle(
                            color:
                                _manager.darkAdaptiveTextColor.withOpacity(0.7),
                            fontSize: 13.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: _isGridView
                      ? SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.68,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final ad = filteredAds[index];
                              return FullAdCardItem(
                                ad: ad,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          FullAdDetailsScreen(ad: ad),
                                    ),
                                  );
                                },
                              );
                            },
                            childCount: filteredAds.length,
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final ad = filteredAds[index];
                              return Card(
                                color: _manager.isDarkMode
                                    ? const Color(0xFF1E293B)
                                    : Colors.white,
                                margin: const EdgeInsets.only(bottom: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) =>
                                            FullAdDetailsScreen(ad: ad),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: SizedBox(
                                            width: 85,
                                            height: 85,
                                            child: AppSmartImage(
                                              imageUrl: ad.imageUrls.isNotEmpty
                                                  ? ad.imageUrls.first
                                                  : '',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ad.title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.5,
                                                  color: _manager
                                                      .darkAdaptiveTextColor,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '\$${(ad.priceUsd ?? 0).toStringAsFixed(0)}',
                                                style: const TextStyle(
                                                  color: Color(0xFF22C55E),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '📍 ${ad.governorate} - ${ad.neighborhood}',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 14, color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: filteredAds.length,
                          ),
                        ),
                ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(14),
      itemCount: _manager.categories.length,
      itemBuilder: (ctx, idx) {
        final cat = _manager.categories[idx];
        return Card(
          color: _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color:
                  _manager.isDarkMode ? Colors.white12 : Colors.grey.shade200,
            ),
          ),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF0F172A),
              child: Icon(cat.iconData, color: const Color(0xFFD4AF37)),
            ),
            title: Text(
              cat.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: _manager.darkAdaptiveTextColor,
              ),
            ),
            subtitle: Text(
              '${cat.subcategories.length} فروع تابعة',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            children: cat.subcategories.map((sub) {
              return ListTile(
                dense: true,
                title: Text(sub,
                    style: TextStyle(
                        color: _manager.darkAdaptiveTextColor, fontSize: 12.5)),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 12, color: Colors.grey),
                onTap: () {
                  setState(() {
                    _selectedCategory = cat.name;
                    _selectedSubcategory = sub;
                    _currentIndex = 0;
                  });
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildAuctionsTab() {
    final auctions = _manager.ads
        .where((a) => a.isAuction && a.status == 'approved')
        .toList();

    if (!_manager.showAuctions) {
      return Center(
        child: Text('تم إيقاف قسم المزادات مؤقتاً من غرفة الإدارة.',
            style: TextStyle(color: _manager.darkAdaptiveTextColor)),
      );
    }

    if (auctions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.gavel, size: 54, color: Color(0xFFD4AF37)),
            const SizedBox(height: 12),
            Text('لا توجد مزادات نشطة حالياً في السوق',
                style: TextStyle(
                    color: _manager.darkAdaptiveTextColor, fontSize: 14)),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: auctions.length,
      itemBuilder: (ctx, idx) {
        final ad = auctions[idx];
        return Card(
          color: _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFD4AF37), width: 1.2),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => FullAdDetailsScreen(ad: ad)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  SizedBox(
                    width: 85,
                    height: 85,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AppSmartImage(
                        imageUrl:
                            ad.imageUrls.isNotEmpty ? ad.imageUrls.first : '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('🔨 مزاد حي',
                                  style: TextStyle(
                                      color: Color(0xFFD4AF37),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10)),
                            ),
                            const Spacer(),
                            Text(
                              '${ad.bids.length} سومة',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ad.title,
                          style: TextStyle(
                              color: _manager.darkAdaptiveTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'أعلى سومة: \$${(ad.currentBid ?? ad.startingBid ?? 0).toStringAsFixed(0)}',
                          style: const TextStyle(
                              color: Color(0xFF22C55E),
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavoritesTab() {
    final favs = _manager.ads
        .where((a) => _manager.favoriteAdIds.contains(a.id))
        .toList();

    if (favs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_border, size: 54, color: Colors.grey),
            const SizedBox(height: 12),
            Text('لم تقم بإضافة أي إعلانات إلى المفضلة بعد',
                style: TextStyle(
                    color: _manager.darkAdaptiveTextColor, fontSize: 13)),
          ],
        ),
      );
    }

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: favs.length,
      itemBuilder: (ctx, idx) => FullAdCardItem(
        ad: favs[idx],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => FullAdDetailsScreen(ad: favs[idx])),
          );
        },
      ),
    );
  }

  Widget _buildProfileTab() {
    final plan = _manager.getCurrentUserPlan();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFD4AF37)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: const Color(0xFF0F172A),
                child: Text(
                  _manager.currentUserName.isNotEmpty
                      ? _manager.currentUserName[0]
                      : 'س',
                  style: const TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 26,
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
                        Text(
                          _manager.currentUserName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.5,
                              color: _manager.darkAdaptiveTextColor),
                        ),
                        if (_manager.isCurrentUserVerified) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.verified,
                              color: Color(0xFF38BDF8), size: 16),
                        ],
                      ],
                    ),
                    Text(
                      _manager.currentUserPhone,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'الباقة: ${plan.name}',
                        style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          tileColor:
              _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: const Icon(Icons.vpn_key, color: Color(0xFFD4AF37)),
          title: Text('تفعيل كود اشتراك / ترقية 🎟️',
              style: TextStyle(
                  color: _manager.darkAdaptiveTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          onTap: _showActivationCodeDialog,
        ),
        const SizedBox(height: 10),
        ListTile(
          tileColor:
              _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading:
              const Icon(Icons.workspace_premium, color: Color(0xFFD4AF37)),
          title: Text('باقات الاشتراك والترقية VIP 👑',
              style: TextStyle(
                  color: _manager.darkAdaptiveTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          onTap: () {
            try {
              Navigator.pushNamed(context, '/plans');
            } catch (_) {
              PhoneHelper.openAdminWhatsApp(
                  'أرغب في الاطلاع على باقات الترقية VIP المتاحة.');
            }
          },
        ),
        const SizedBox(height: 10),
        ListTile(
          tileColor:
              _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: const Icon(Icons.account_balance_wallet,
              color: Color(0xFF22C55E)),
          title: Text('بوابات الدفع الرسمية (شام كاش & بينانس)',
              style: TextStyle(
                  color: _manager.darkAdaptiveTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => const AlertDialog(
                backgroundColor: Color(0xFF0F172A),
                content: ExclusivePaymentGatewayCard(),
              ),
            );
          },
        ),
        if (_manager.isSuperAdmin) ...[
          const SizedBox(height: 16),
          ListTile(
            tileColor: const Color(0xFF7F1D1D),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            leading: const Icon(Icons.security, color: Colors.white),
            title: const Text('غرفة العمليات المركزية السيادية 🛡️',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 14, color: Colors.white70),
            onTap: () {
              try {
                Navigator.pushNamed(context, '/admin');
              } catch (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                          'غرفة العمليات المركزية متوفرة في القسم الرابع.')),
                );
              }
            },
          ),
        ],
      ],
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          _manager.isDarkMode ? const Color(0xFF0F172A) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          final List<String> availableDistricts =
              _districtsMap[_selectedGovernorate] ?? ['الكل'];
          if (!availableDistricts.contains(_selectedDistrict)) {
            _selectedDistrict = 'الكل';
          }

          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('تصفية الإعلانات المتقدمة 🔍',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _manager.darkAdaptiveTextColor)),
                      TextButton(
                        onPressed: () {
                          setModalState(() {
                            _selectedGovernorate = 'الكل';
                            _selectedDistrict = 'الكل';
                            _selectedCondition = 'الكل';
                            _minPriceController.clear();
                            _maxPriceController.clear();
                            _onlyAuctions = false;
                            _onlyVerifiedSellers = false;
                            _sortBy = 'newest';
                          });
                        },
                        child: const Text('إعادة ضبط',
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedGovernorate,
                    dropdownColor: _manager.isDarkMode
                        ? const Color(0xFF1E293B)
                        : Colors.white,
                    decoration: const InputDecoration(
                        labelText: 'المحافظة', border: OutlineInputBorder()),
                    items: _governoratesList
                        .map<DropdownMenuItem<String>>((String g) =>
                            DropdownMenuItem<String>(
                              value: g,
                              child: Text(g,
                                  style: TextStyle(
                                      color: _manager.darkAdaptiveTextColor)),
                            ))
                        .toList(),
                    onChanged: (String? v) {
                      if (v != null) {
                        setModalState(() {
                          _selectedGovernorate = v;
                          _selectedDistrict = 'الكل';
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  if (_selectedGovernorate != 'الكل')
                    DropdownButtonFormField<String>(
                      value: _selectedDistrict,
                      dropdownColor: _manager.isDarkMode
                          ? const Color(0xFF1E293B)
                          : Colors.white,
                      decoration: const InputDecoration(
                          labelText: 'المنطقة / الناحية',
                          border: OutlineInputBorder()),
                      items: availableDistricts
                          .map<DropdownMenuItem<String>>((String d) =>
                              DropdownMenuItem<String>(
                                value: d,
                                child: Text(d,
                                    style: TextStyle(
                                        color: _manager.darkAdaptiveTextColor)),
                              ))
                          .toList(),
                      onChanged: (String? v) {
                        if (v != null) {
                          setModalState(() => _selectedDistrict = v);
                        }
                      },
                    ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _sortBy,
                    dropdownColor: _manager.isDarkMode
                        ? const Color(0xFF1E293B)
                        : Colors.white,
                    decoration: const InputDecoration(
                        labelText: 'الترتيب حسب', border: OutlineInputBorder()),
                    items: const [
                      DropdownMenuItem<String>(
                          value: 'newest', child: Text('الأحدث أولاً')),
                      DropdownMenuItem<String>(
                          value: 'price_asc',
                          child: Text('السعر: من الأقل إلى الأعلى')),
                      DropdownMenuItem<String>(
                          value: 'price_desc',
                          child: Text('السعر: من الأعلى إلى الأقل')),
                    ],
                    onChanged: (String? v) {
                      if (v != null) setModalState(() => _sortBy = v);
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _minPriceController,
                          keyboardType: TextInputType.number,
                          style:
                              TextStyle(color: _manager.darkAdaptiveTextColor),
                          decoration: const InputDecoration(
                              labelText: 'السعر الأدنى (\$)',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _maxPriceController,
                          keyboardType: TextInputType.number,
                          style:
                              TextStyle(color: _manager.darkAdaptiveTextColor),
                          decoration: const InputDecoration(
                              labelText: 'السعر الأقصى (\$)',
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    value: _onlyAuctions,
                    title: Text('عرض المزادات الحية فقط 🔨',
                        style: TextStyle(
                            color: _manager.darkAdaptiveTextColor,
                            fontSize: 13)),
                    onChanged: (val) =>
                        setModalState(() => _onlyAuctions = val ?? false),
                  ),
                  CheckboxListTile(
                    value: _onlyVerifiedSellers,
                    title: Text('عرض إعلانات التجار المعتمدين فقط 🛡️',
                        style: TextStyle(
                            color: _manager.darkAdaptiveTextColor,
                            fontSize: 13)),
                    onChanged: (val) => setModalState(
                        () => _onlyVerifiedSellers = val ?? false),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37)),
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(ctx);
                      },
                      child: const Text('تطبيق الفلترة والتصفية ✓',
                          style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showReserveBannerSlotDialog(int slotIdx) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text('حجز الخانة الإعلانية رقم ($slotIdx)',
            style: const TextStyle(
                color: Color(0xFFD4AF37),
                fontWeight: FontWeight.bold,
                fontSize: 15)),
        content: const Text(
          'يمكنك حجز هذه الخانة لتظهر علامتك التجارية في الواجهة الرئيسية لآلاف المشترين يومياً.',
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37)),
            onPressed: () {
              Navigator.pop(ctx);
              PhoneHelper.openAdminWhatsApp(
                  'مرحباً، أود حجز البانوراما الإعلانية رقم $slotIdx');
            },
            child: const Text('طلب الحجز عبر واتساب 👑',
                style: TextStyle(
                    color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showActivationCodeDialog() {
    final codeController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Row(
          children: [
            Icon(Icons.vpn_key, color: Color(0xFFD4AF37)),
            SizedBox(width: 8),
            Text('تفعيل كود اشتراك / باقة 🎟️',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'أدخل كود التفعيل الممنوح لك من الإدارة أو من نقاط الشحن المعتمدة:',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: codeController,
              style: const TextStyle(
                  color: Color(0xFFD4AF37),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
              decoration: const InputDecoration(
                hintText: 'SYR-XXXX-XXXX',
                hintStyle: TextStyle(color: Colors.white38),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37)),
            onPressed: () async {
              final c = codeController.text.trim();
              if (c.isEmpty) return;

              final res = await _manager.redeemActivationCode(c);
              final bool isOk = res['success'] == true;
              final String msg = res['message']?.toString() ??
                  (isOk ? 'تم تفعيل الاشتراك بنجاح!' : 'كود التفعيل غير صالح.');

              Navigator.pop(ctx);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(msg),
                  backgroundColor: isOk ? Colors.green : Colors.red,
                ),
              );
            },
            child: const Text('تفعيل الكود الآن ✨',
                style: TextStyle(
                    color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
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
        elevation: 0,
        title: Row(
          children: [
            const SyrianIndependenceFlag(width: 32, height: 22),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'سوق سوريا الشامل 2028',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'المنظومة الاقتصادية الرقمية الحرة',
                  style: TextStyle(color: Color(0xFFD4AF37), fontSize: 9.5),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: const Color(0xFFD4AF37),
            ),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF0F172A),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF1E293B),
                border: Border(bottom: BorderSide(color: Color(0xFFD4AF37))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SyrianIndependenceFlag(width: 40, height: 26),
                  const SizedBox(height: 10),
                  Text(
                    _manager.currentUserName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    _manager.currentUserPhone,
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFFD4AF37)),
              title: const Text('الرئيسية والسوق',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category, color: Color(0xFFD4AF37)),
              title: const Text('الأقسام والتصنيفات',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.gavel, color: Color(0xFFD4AF37)),
              title: const Text('المزادات المباشرة',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 2);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.workspace_premium, color: Color(0xFFD4AF37)),
              title: const Text('باقات الترقية VIP',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                try {
                  Navigator.pushNamed(context, '/plans');
                } catch (_) {
                  PhoneHelper.openAdminWhatsApp('أود الاستفسار عن باقات VIP.');
                }
              },
            ),
            if (_manager.isSuperAdmin) ...[
              const Divider(color: Colors.white24),
              ListTile(
                leading: const Icon(Icons.security, color: Colors.redAccent),
                title: const Text('غرفة العمليات المركزية',
                    style: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                  try {
                    Navigator.pushNamed(context, '/admin');
                  } catch (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'غرفة العمليات المركزية متوفرة في القسم الرابع.')),
                    );
                  }
                },
              ),
            ],
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeFeedTab(),
          _buildCategoriesTab(),
          _buildAuctionsTab(),
          _buildFavoritesTab(),
          _buildProfileTab(),
        ],
      ),
      floatingActionButton: _manager.showAdPosting
          ? FloatingActionButton.extended(
              backgroundColor: const Color(0xFFD4AF37),
              icon: const Icon(Icons.add_circle, color: Color(0xFF0F172A)),
              label: const Text(
                'أضف إعلانك ➕',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              onPressed: () {
                try {
                  Navigator.pushNamed(context, '/add_ad');
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('شاشة إضافة الإعلان متوفرة في القسم الرابع.')),
                  );
                }
              },
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (idx) => setState(() => _currentIndex = idx),
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            _manager.isDarkMode ? const Color(0xFF0F172A) : Colors.white,
        selectedItemColor: const Color(0xFFD4AF37),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'السوق'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'الأقسام'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'المزادات'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}
// ==============================================================================
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [القسم الرابع والأخير: شاشة النشر والتعديل، المحادثة، الباقات، غرفة العمليات المركزية، وشاشة الصيانة، ودالة main]
// ==============================================================================

// ==============================================================================
// 22. شاشة إضافة وتعديل الإعلانات مع قفل السوشيال ميديا للمشتركين (FullAddAdScreen)
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
  late TextEditingController _startingBidController;

  // حقول روابط مواقع التواصل الاجتماعي وفيديوهات المعاينة
  late TextEditingController _videoUrlController;
  late TextEditingController _facebookUrlController;
  late TextEditingController _telegramUrlController;
  late TextEditingController _instagramUrlController;
  late TextEditingController _tiktokUrlController;
  late TextEditingController _youtubeUrlController;

  String _selectedGov = 'إدلب';
  String _selectedCategory = 'سيارات ومركبات';
  String _selectedSubcategory = 'سيارات سياحية للبيع';
  String _selectedCondition = 'مستعمل بحالة ممتازة';
  bool _isAuction = false;
  bool _isFeatured = false;
  List<String> _existingImageUrls = [];
  final List<Uint8List> _newImagesBytes = [];
  bool _isSubmitting = false;

  final List<String> _governoratesList = [
    'إدلب',
    'حلب',
    'دمشق',
    'ريف دمشق',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'درعا',
    'السويداء',
    'القنيطرة',
    'دير الزور',
    'الرقة',
    'الحسكة'
  ];

  final List<String> _conditionsList = [
    'جديد بالكرتونة',
    'مستعمل بحالة ممتازة',
    'مستعمل',
    'بحاجة صيانة',
    'كسر زيرو'
  ];

  @override
  void initState() {
    super.initState();
    final ad = widget.initialAd;
    _titleController = TextEditingController(text: ad?.title ?? '');
    _descController = TextEditingController(text: ad?.description ?? '');
    _priceUsdController =
        TextEditingController(text: ad?.priceUsd?.toStringAsFixed(0) ?? '');
    _priceSypController =
        TextEditingController(text: ad?.priceSyp?.toStringAsFixed(0) ?? '');
    _neighborhoodController =
        TextEditingController(text: ad?.neighborhood ?? '');
    _phoneController = TextEditingController(
        text: ad?.contactPhone ?? _manager.currentUserPhone);
    _whatsappController = TextEditingController(
        text: ad?.contactWhatsapp ?? _manager.currentUserPhone);
    _startingBidController =
        TextEditingController(text: ad?.startingBid?.toStringAsFixed(0) ?? '');

    _videoUrlController = TextEditingController(text: ad?.videoUrl ?? '');
    _facebookUrlController = TextEditingController(text: ad?.facebookUrl ?? '');
    _telegramUrlController = TextEditingController(text: ad?.telegramUrl ?? '');
    _instagramUrlController =
        TextEditingController(text: ad?.instagramUrl ?? '');
    _tiktokUrlController = TextEditingController(text: ad?.tiktokUrl ?? '');
    _youtubeUrlController = TextEditingController(text: ad?.youtubeUrl ?? '');

    if (ad != null) {
      _selectedGov = ad.governorate;
      _selectedCategory = ad.categoryId;
      _selectedSubcategory = ad.subcategory;
      _selectedCondition = ad.condition;
      _isAuction = ad.isAuction;
      _isFeatured = ad.isFeatured;
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
    _startingBidController.dispose();
    _videoUrlController.dispose();
    _facebookUrlController.dispose();
    _telegramUrlController.dispose();
    _instagramUrlController.dispose();
    _tiktokUrlController.dispose();
    _youtubeUrlController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final plan = _manager.getCurrentUserPlan();
    final maxAllowed = plan.maxImagesPerAd;

    final currentTotal = _existingImageUrls.length + _newImagesBytes.length;
    if (currentTotal >= maxAllowed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '⚠️ باقتك الحالية (${plan.name}) تسمح بإضافة حتى $maxAllowed صور لكل إعلان.'),
        ),
      );
      return;
    }

    try {
      final List<XFile> files = await _picker.pickMultiImage(
        imageQuality: 70,
        maxWidth: 1000,
      );

      for (var f in files) {
        if (_existingImageUrls.length + _newImagesBytes.length < maxAllowed) {
          final bytes = await f.readAsBytes();
          setState(() => _newImagesBytes.add(bytes));
        }
      }
    } catch (e) {
      debugPrint('Pick images notice: $e');
    }
  }

  Future<void> _submitAd() async {
    if (!_formKey.currentState!.validate()) return;

    final forbiddenWord = _manager.checkForbiddenContent(
        '${_titleController.text} ${_descController.text}');
    if (forbiddenWord != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '⚠️ يحتوي المنشور على محتوى محظور سيادياً: "$forbiddenWord". يرجى تعديله.'),
          backgroundColor: Colors.red.shade900,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    List<String> uploadedUrls = List.from(_existingImageUrls);

    if (_newImagesBytes.isNotEmpty) {
      final newUrls = await StorageUploadService.uploadMultipleImageBytes(
        bucketName: kStorageBucketAds,
        imagesBytesList: _newImagesBytes,
        prefix: 'ad',
      );
      uploadedUrls.addAll(newUrls);
    }

    final double? pUsd = double.tryParse(_priceUsdController.text);
    final double? pSyp = double.tryParse(_priceSypController.text);
    final double? startBid = double.tryParse(_startingBidController.text);

    // 🛡️ المنشور يذهب كـ pending للمشرفين، وفقط الـ SuperAdmin ينشر فوراً
    final String initialStatus = _manager.isSuperAdmin ? 'approved' : 'pending';

    final canAddSocial = _manager.canUserAddSocialLinks();

    final adToSave = AdItem(
      id: widget.initialAd?.id ?? 'ad_${DateTime.now().millisecondsSinceEpoch}',
      userId: _manager.currentUserId.isNotEmpty
          ? _manager.currentUserId
          : 'usr_guest',
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      priceUsd: pUsd,
      priceSyp: pSyp,
      governorate: _selectedGov,
      neighborhood: _neighborhoodController.text.trim().isNotEmpty
          ? _neighborhoodController.text.trim()
          : 'المركز',
      categoryId: _selectedCategory,
      subcategory: _selectedSubcategory,
      condition: _selectedCondition,
      contactPhone: _phoneController.text.trim(),
      contactWhatsapp: _whatsappController.text.trim().isNotEmpty
          ? _whatsappController.text.trim()
          : _phoneController.text.trim(),
      imageUrls: uploadedUrls,
      videoUrl: (canAddSocial && _videoUrlController.text.trim().isNotEmpty)
          ? _videoUrlController.text.trim()
          : null,
      facebookUrl:
          (canAddSocial && _facebookUrlController.text.trim().isNotEmpty)
              ? _facebookUrlController.text.trim()
              : null,
      telegramUrl:
          (canAddSocial && _telegramUrlController.text.trim().isNotEmpty)
              ? _telegramUrlController.text.trim()
              : null,
      instagramUrl:
          (canAddSocial && _instagramUrlController.text.trim().isNotEmpty)
              ? _instagramUrlController.text.trim()
              : null,
      tiktokUrl: (canAddSocial && _tiktokUrlController.text.trim().isNotEmpty)
          ? _tiktokUrlController.text.trim()
          : null,
      youtubeUrl: (canAddSocial && _youtubeUrlController.text.trim().isNotEmpty)
          ? _youtubeUrlController.text.trim()
          : null,
      publisherName: _manager.currentUserName,
      publisherEmail: _manager.currentUserEmail,
      publisherAvatarUrl: _manager.currentUserAvatarUrl,
      publisherBio: _manager.currentUserBioDescription,
      isVerifiedSeller: _manager.isCurrentUserVerified,
      status: initialStatus,
      isAuction: _isAuction,
      startingBid: startBid,
      currentBid: startBid,
      auctionEndTime:
          _isAuction ? DateTime.now().add(const Duration(days: 3)) : null,
      isFeatured: _isFeatured,
      createdAt: widget.initialAd?.createdAt ?? DateTime.now(),
    );

    // 🌟 الحفظ الدائم على السيرفر (Supabase) + الحفظ الاحتياطي المحلي لضمان عدم الاختفاء
    try {
      if (widget.initialAd != null) {
        await Supabase.instance.client
            .from('ads')
            .update(adToSave.toMap())
            .eq('id', adToSave.id)
            .timeout(const Duration(seconds: 10));
      } else {
        await Supabase.instance.client
            .from('ads')
            .insert(adToSave.toMap())
            .timeout(const Duration(seconds: 10));
      }
    } catch (e) {
      debugPrint('Supabase save ad notice: $e');
    }

    if (mounted) {
      setState(() => _isSubmitting = false);
      widget.onAdCreated(adToSave);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final plan = _manager.getCurrentUserPlan();
    final canAddSocial = _manager.canUserAddSocialLinks();

    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: Text(
          widget.initialAd != null
              ? 'تعديل الإعلان'
              : 'إضافة إعلان جديد في السوق',
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
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFD4AF37)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.security,
                      color: Color(0xFFD4AF37), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _manager.isSuperAdmin
                          ? '👑 حساب إدارة: سينشر الإعلان مباشرةً دون انتظار موافقة.'
                          : '🛡️ نظام الأمان: يُرسل المنشور أولاً لغرفة الإشراف لمراجعته وتدقيقه قبل ظهوره في الشاشة الرئيسية للجميع.',
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 11.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('صور الإعلان:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: _manager.darkAdaptiveTextColor)),
            const SizedBox(height: 8),
            SizedBox(
              height: 95,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color(0xFFD4AF37),
                            style: BorderStyle.solid),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo,
                              color: _manager.primaryColor, size: 28),
                          const SizedBox(height: 4),
                          Text(
                            'إضافة صورة\n(الحد: ${plan.maxImagesPerAd})',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 9.5,
                              color: _manager.darkAdaptiveTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ..._existingImageUrls.asMap().entries.map(
                        (entry) => Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: 90,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: AppSmartImage(
                                  imageUrl: entry.value, fit: BoxFit.cover),
                            ),
                            Positioned(
                              top: 2,
                              right: 10,
                              child: GestureDetector(
                                onTap: () => setState(() =>
                                    _existingImageUrls.removeAt(entry.key)),
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.close,
                                      color: Colors.white, size: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ..._newImagesBytes.asMap().entries.map(
                        (entry) => Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: 90,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  Image.memory(entry.value, fit: BoxFit.cover),
                            ),
                            Positioned(
                              top: 2,
                              right: 10,
                              child: GestureDetector(
                                onTap: () => setState(
                                    () => _newImagesBytes.removeAt(entry.key)),
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.close,
                                      color: Colors.white, size: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              style: TextStyle(color: _manager.darkAdaptiveTextColor),
              decoration: InputDecoration(
                labelText: 'عنوان الإعلان *',
                labelStyle: TextStyle(color: _manager.formLabelColor),
                hintText: 'مثال: سيارة كيا سيراتو 2020 خالية العلام',
                hintStyle: TextStyle(
                  color: _manager.isDarkMode ? Colors.white38 : Colors.grey,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().length < 4)
                  ? 'يرجى كتابة عنوان واضح'
                  : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedGov,
                    dropdownColor: _manager.isDarkMode
                        ? const Color(0xFF1E293B)
                        : Colors.white,
                    decoration: InputDecoration(
                      labelText: 'المحافظة *',
                      labelStyle: TextStyle(color: _manager.formLabelColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    items: _governoratesList
                        .map((g) => DropdownMenuItem(
                            value: g,
                            child: Text(g,
                                style: TextStyle(
                                    color: _manager.darkAdaptiveTextColor))))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _selectedGov = v);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _neighborhoodController,
                    style: TextStyle(color: _manager.darkAdaptiveTextColor),
                    decoration: InputDecoration(
                      labelText: 'المنطقة / الحي *',
                      labelStyle: TextStyle(color: _manager.formLabelColor),
                      hintText: 'مثال: شارع الجلاء، سرمدا',
                      hintStyle: TextStyle(
                        color:
                            _manager.isDarkMode ? Colors.white38 : Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    dropdownColor: _manager.isDarkMode
                        ? const Color(0xFF1E293B)
                        : Colors.white,
                    decoration: InputDecoration(
                      labelText: 'القسم الرئيسي *',
                      labelStyle: TextStyle(color: _manager.formLabelColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    items: _manager.categories
                        .map((c) => DropdownMenuItem(
                            value: c.name,
                            child: Text(c.name,
                                style: TextStyle(
                                    color: _manager.darkAdaptiveTextColor))))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() {
                          _selectedCategory = v;
                          final cat = _manager.categories
                              .firstWhere((c) => c.name == v);
                          _selectedSubcategory = cat.subcategories.isNotEmpty
                              ? cat.subcategories.first
                              : 'عام';
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCondition,
                    dropdownColor: _manager.isDarkMode
                        ? const Color(0xFF1E293B)
                        : Colors.white,
                    decoration: InputDecoration(
                      labelText: 'حالة السلعة *',
                      labelStyle: TextStyle(color: _manager.formLabelColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    items: _conditionsList
                        .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text(c,
                                style: TextStyle(
                                    color: _manager.darkAdaptiveTextColor))))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _selectedCondition = v);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceUsdController,
                    style: TextStyle(color: _manager.darkAdaptiveTextColor),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'السعر بالدولار (\$)',
                      labelStyle: TextStyle(color: _manager.formLabelColor),
                      prefixIcon: const Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onChanged: (v) {
                      final val = double.tryParse(v);
                      if (val != null) {
                        final calc = val * _manager.exchangeRateUsdToSyp;
                        _priceSypController.text = calc.toStringAsFixed(0);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _priceSypController,
                    style: TextStyle(color: _manager.darkAdaptiveTextColor),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'السعر بالليرة السورية',
                      labelStyle: TextStyle(color: _manager.formLabelColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descController,
              maxLines: 4,
              style: TextStyle(color: _manager.darkAdaptiveTextColor),
              decoration: InputDecoration(
                labelText: 'تفاصيل ومواصفات الإعلان بالكامل *',
                labelStyle: TextStyle(color: _manager.formLabelColor),
                hintText: 'اكتب كافة المواصفات والعيوب والميزات بأمانة...',
                hintStyle: TextStyle(
                  color: _manager.isDarkMode ? Colors.white38 : Colors.grey,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().length < 8)
                  ? 'يرجى كتابة تفاصيل وافية'
                  : null,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: _manager.darkAdaptiveTextColor),
                    decoration: InputDecoration(
                      labelText: 'رقم الهاتف للاتصال *',
                      labelStyle: TextStyle(color: _manager.formLabelColor),
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (v) => (v == null || v.trim().length < 9)
                        ? 'رقم هاتف غير صالح'
                        : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _whatsappController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: _manager.darkAdaptiveTextColor),
                    decoration: InputDecoration(
                      labelText: 'رقم الواتساب',
                      labelStyle: TextStyle(color: _manager.formLabelColor),
                      prefixIcon: const Icon(Icons.chat),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // قسم السوشيال ميديا وفيديوهات المعاينة
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:
                      canAddSocial ? const Color(0xFFD4AF37) : Colors.white24,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            canAddSocial ? Icons.share : Icons.lock,
                            color: const Color(0xFFD4AF37),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'روابط التواصل الاجتماعي وفيديوهات المعاينة 🌐',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      if (!canAddSocial)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'VIP مقفل 🔒',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (!canAddSocial) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star,
                              color: Color(0xFFD4AF37), size: 16),
                          const SizedBox(width: 6),
                          const Expanded(
                            child: Text(
                              'إضافة روابط السوشيال ميديا متاحة لمشتركي الباقات الفضية والذهبية VIP أو تفعيل كود خاص.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10.5,
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              backgroundColor: const Color(0xFFD4AF37),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) =>
                                      const FullSubscriptionPlansScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'ترقية 👑',
                              style: TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _videoUrlController,
                    enabled: canAddSocial,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: InputDecoration(
                      labelText: 'رابط فيديو توضيحي للسلعة (يوتيوب أو درايف)',
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon:
                          const Icon(Icons.play_circle_fill, color: Colors.red),
                      suffixIcon: !canAddSocial
                          ? const Icon(Icons.lock,
                              color: Colors.white30, size: 16)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _facebookUrlController,
                    enabled: canAddSocial,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: InputDecoration(
                      labelText: 'رابط صفحة أو منشور فيسبوك',
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon:
                          const Icon(Icons.facebook, color: Colors.blue),
                      suffixIcon: !canAddSocial
                          ? const Icon(Icons.lock,
                              color: Colors.white30, size: 16)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _telegramUrlController,
                    enabled: canAddSocial,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: InputDecoration(
                      labelText: 'رابط قناة أو حساب تليجرام',
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon:
                          const Icon(Icons.send, color: Colors.lightBlue),
                      suffixIcon: !canAddSocial
                          ? const Icon(Icons.lock,
                              color: Colors.white30, size: 16)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _instagramUrlController,
                    enabled: canAddSocial,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: InputDecoration(
                      labelText: 'رابط حساب إنستغرام',
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon:
                          const Icon(Icons.camera_alt, color: Colors.pink),
                      suffixIcon: !canAddSocial
                          ? const Icon(Icons.lock,
                              color: Colors.white30, size: 16)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _tiktokUrlController,
                    enabled: canAddSocial,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: InputDecoration(
                      labelText: 'رابط مقطع تيك توك للسلعة',
                      labelStyle: const TextStyle(color: Colors.white70),
                      prefixIcon:
                          const Icon(Icons.music_note, color: Colors.white70),
                      suffixIcon: !canAddSocial
                          ? const Icon(Icons.lock,
                              color: Colors.white30, size: 16)
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SwitchListTile(
              title: Text('تفعيل المزاد العلني المباشر 🔨',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: _manager.darkAdaptiveTextColor)),
              subtitle: const Text(
                  'السماح بالمزايدات مع نظام منع القنص وتمديد الوقت تلقائياً'),
              value: _isAuction,
              onChanged: (v) => setState(() => _isAuction = v),
            ),
            if (_isAuction) ...[
              TextFormField(
                controller: _startingBidController,
                style: TextStyle(color: _manager.darkAdaptiveTextColor),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'سعر بداية المزاد بالدولار (\$)',
                  labelStyle: TextStyle(color: _manager.formLabelColor),
                  prefixIcon: const Icon(Icons.gavel),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _isSubmitting ? null : _submitAd,
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        widget.initialAd != null
                            ? 'حفظ التعديلات ✨'
                            : 'نشر الإعلان وإرساله للإشراف 🚀',
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
// 23. شاشة التفاوض والمحادثة المباشرة (FullChatNegotiationScreen)
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
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _msgController = TextEditingController();
  final TextEditingController _offerPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _offerPriceController.text = widget.initialPrice.toStringAsFixed(0);
    _loadMessages();
  }

  @override
  void dispose() {
    _msgController.dispose();
    _offerPriceController.dispose();
    super.dispose();
  }

  void _loadMessages() async {
    try {
      final res = await Supabase.instance.client
          .from('chat_messages')
          .select()
          .eq('ad_id', widget.adId)
          .order('created_at', ascending: true);
      if (res is List && mounted) {
        setState(() {
          _messages.clear();
          for (var r in res) {
            _messages.add(r as Map<String, dynamic>);
          }
        });
      }
    } catch (_) {}
  }

  void _sendMessage({String? customText}) async {
    final text = customText ?? _msgController.text.trim();
    if (text.isEmpty) return;

    final newMsg = {
      'ad_id': widget.adId,
      'sender_id': _manager.currentUserId,
      'sender_name': _manager.currentUserName,
      'message': text,
      'created_at': DateTime.now().toIso8601String(),
    };

    setState(() {
      _messages.add(newMsg);
      _msgController.clear();
    });

    try {
      await Supabase.instance.client.from('chat_messages').insert(newMsg);
    } catch (_) {}
  }

  void _sendPriceOffer() {
    final val = _offerPriceController.text.trim();
    if (val.isEmpty) return;
    _sendMessage(customText: '🤝 عرض سعر رسمي مقدم: \$$val دولار.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.partnerName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            Text(widget.productTitle,
                style: const TextStyle(color: Colors.white60, fontSize: 10),
                maxLines: 1),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: const Color(0xFF1E293B),
            child: Row(
              children: [
                const Icon(Icons.handshake, color: Color(0xFFD4AF37), size: 18),
                const SizedBox(width: 8),
                const Text('عرض تفاوض: \$',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _offerPriceController,
                    style: const TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(isDense: true),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  ),
                  onPressed: _sendPriceOffer,
                  child: const Text('إرسال العرض',
                      style: TextStyle(
                          color: Color(0xFF0F172A),
                          fontWeight: FontWeight.bold,
                          fontSize: 11)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (ctx, idx) {
                final m = _messages[idx];
                final isMe = m['sender_id'] == _manager.currentUserId;
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isMe
                          ? const Color(0xFF0284C7)
                          : const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      m['message']?.toString() ?? '',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12.5),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFF1E293B),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: 'اكتب رسالتك...',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFFD4AF37)),
                  onPressed: () => _sendMessage(),
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
// 24. شاشة باقات الاشتراك والترقية VIP وبوابات الدفع (FullSubscriptionPlansScreen)
// ==============================================================================
class FullSubscriptionPlansScreen extends StatelessWidget {
  const FullSubscriptionPlansScreen({Key? key}) : super(key: key);

  void _subscribeToPlan(BuildContext context, SubscriptionPlanItem plan) {
    final refController = TextEditingController();
    String gateway = 'SHAM_CASH';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ترقية إلى ${plan.name}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD4AF37))),
              const SizedBox(height: 10),
              const ExclusivePaymentGatewayCard(),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: gateway,
                dropdownColor: const Color(0xFF1E293B),
                decoration: const InputDecoration(
                  labelText: 'بوابة الدفع المستخدمة',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem(
                      value: 'SHAM_CASH',
                      child: Text('حساب شام كاش (بالليرة السورية)',
                          style: TextStyle(color: Colors.white))),
                  DropdownMenuItem(
                      value: 'BINANCE_USDT',
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          BinanceOfficialLogoIcon(size: 18),
                          SizedBox(width: 8),
                          Text('منصة بينانس Binance (USDT TRC20)',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                ],
                onChanged: (v) {
                  if (v != null) setModalState(() => gateway = v);
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: refController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'رقم الإشعار / معرّف التحويل (TxID) *',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37)),
                  onPressed: () async {
                    final ref = refController.text.trim();
                    if (ref.isEmpty) return;

                    await AppStateManager().submitPaymentAuditRequest(
                      plan: plan,
                      gateway: gateway,
                      refOrTxId: ref,
                    );

                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            '✅ تم إرسال طلب الترقية لغرفة العمليات المركزية للمراجعة والاعتماد!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text('تأكيد وإرسال الإشعار للإدارة 🚀',
                      style: TextStyle(
                          color: Color(0xFF0F172A),
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final manager = AppStateManager();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('باقات الاشتراك والترقية VIP 👑',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          const ExclusivePaymentGatewayCard(),
          const SizedBox(height: 16),
          ...manager.subscriptionPlans.map(
            (p) => Card(
              color: const Color(0xFF1E293B),
              margin: const EdgeInsets.only(bottom: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: p.id == 'plan_diamond_vip'
                      ? const Color(0xFFD4AF37)
                      : Colors.white12,
                  width: p.id == 'plan_diamond_vip' ? 2 : 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(p.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text(
                          p.priceUsd == 0
                              ? 'مجاناً'
                              : '\$${p.priceUsd.toInt()}',
                          style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.white24, height: 20),
                    ...p.features.map(
                      (f) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle,
                                color: Color(0xFF22C55E), size: 16),
                            const SizedBox(width: 8),
                            Text(f,
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: p.id == 'plan_diamond_vip'
                              ? const Color(0xFFD4AF37)
                              : const Color(0xFF0284C7),
                        ),
                        onPressed: () => _subscribeToPlan(context, p),
                        child: Text(
                          'ترقية الآن ✨',
                          style: TextStyle(
                            color: p.id == 'plan_diamond_vip'
                                ? const Color(0xFF0F172A)
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 25. غرفة العمليات المركزية السيادية الشاملة (FullAdminPanelScreen)
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
  final TextEditingController _goldRateController = TextEditingController();
  final TextEditingController _maintenanceMsgController =
      TextEditingController();

  // حقول توليد كود تفعيل فوري
  String _selectedPackageType = 'ALL_ACCESS';
  final TextEditingController _customDaysController =
      TextEditingController(text: '30');
  List<ActivationCodeItem> _recentCodes = <ActivationCodeItem>[];
  bool _isLoadingCodes = false;

  final List<Map<String, dynamic>> _iconLibrary = [
    {'name': 'DirectionsCar', 'icon': Icons.directions_car, 'label': 'سيارات'},
    {'name': 'Home', 'icon': Icons.home, 'label': 'عقارات'},
    {'name': 'WbSunny', 'icon': Icons.wb_sunny, 'label': 'طاقة شمسية'},
    {'name': 'PhoneAndroid', 'icon': Icons.phone_android, 'label': 'هواتف'},
    {'name': 'Work', 'icon': Icons.work, 'label': 'وظائف'},
    {'name': 'Chair', 'icon': Icons.chair, 'label': 'مفروشات'},
    {'name': 'Grass', 'icon': Icons.grass, 'label': 'زراعة ومواشي'},
    {'name': 'ShoppingBag', 'icon': Icons.shopping_bag, 'label': 'ألبسة'},
    {'name': 'Build', 'icon': Icons.build, 'label': 'صيانة ومعدات'},
    {'name': 'LocalHospital', 'icon': Icons.local_hospital, 'label': 'صحة وطب'},
    {'name': 'Laptop', 'icon': Icons.laptop, 'label': 'كمبيوتر ولابتوب'},
    {'name': 'Pets', 'icon': Icons.pets, 'label': 'حيوانات أليفة'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 7, vsync: this, initialIndex: widget.initialTab);
    _usdRateController.text = _manager.exchangeRateUsdToSyp.toStringAsFixed(0);
    _goldRateController.text = _manager.goldPrice21kSyp.toStringAsFixed(0);
    _maintenanceMsgController.text = _manager.maintenanceMessage;
    _fetchLiveActivationCodes();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _usdRateController.dispose();
    _goldRateController.dispose();
    _maintenanceMsgController.dispose();
    _customDaysController.dispose();
    super.dispose();
  }

  Future<void> _fetchLiveActivationCodes() async {
    setState(() => _isLoadingCodes = true);
    try {
      final res = await Supabase.instance.client
          .from('activation_codes')
          .select()
          .order('created_at', ascending: false)
          .limit(30)
          .timeout(const Duration(seconds: 8));

      if (res is List && mounted) {
        setState(() {
          _recentCodes = res
              .map<ActivationCodeItem>(
                  (r) => ActivationCodeItem.fromMap(r as Map<String, dynamic>))
              .toList();
        });
      }
    } catch (e) {
      debugPrint('Fetch codes error: $e');
    }
    if (mounted) setState(() => _isLoadingCodes = false);
  }

  void _generateCode() async {
    final days = int.tryParse(_customDaysController.text.trim()) ?? 30;

    final rand = Random();
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final p1 =
        List.generate(4, (_) => chars[rand.nextInt(chars.length)]).join();
    final p2 =
        List.generate(4, (_) => chars[rand.nextInt(chars.length)]).join();
    final generatedCode = 'SYR-$p1-$p2';

    final newCodeItem = ActivationCodeItem(
      code: generatedCode,
      packageType: _selectedPackageType,
      durationDays: days,
      isUsed: 0,
      createdAt: DateTime.now(),
    );

    setState(() {
      _recentCodes.insert(0, newCodeItem);
    });

    try {
      await Supabase.instance.client
          .from('activation_codes')
          .insert(newCodeItem.toMap())
          .timeout(const Duration(seconds: 8));
    } catch (e) {
      debugPrint('Save code to Supabase notice: $e');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✅ تم توليد المفتاح بنجاح: $generatedCode'),
        backgroundColor: const Color(0xFF16A34A),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _saveExchangeRates() {
    final usd = double.tryParse(_usdRateController.text);
    final gold = double.tryParse(_goldRateController.text);
    if (usd != null) _manager.exchangeRateUsdToSyp = usd;
    if (gold != null) _manager.goldPrice21kSyp = gold;

    _manager.updateExchangeRate(
      usd ?? _manager.exchangeRateUsdToSyp,
      gold ?? _manager.goldPrice21kSyp,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ تم تحديث ونشر أسعار الصرف والذهب لجميع المستخدمين!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _rejectAdWithReason(String adId) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Row(
          children: [
            Icon(Icons.cancel, color: Colors.redAccent),
            SizedBox(width: 8),
            Text('تحديد سبب الرفض وإرساله للمعلن ❌',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'سيتم إرسال هذه الرسالة مباشرة لصاحب الإعلان لتوضيح سبب الرفض:',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: reasonController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText:
                    'مثال: الصور غير واضحة، السعر غير متطابق، يرجى كتابة تفاصيل أكثر...',
                hintStyle: TextStyle(color: Colors.white54, fontSize: 12),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              final r = reasonController.text.trim();
              _manager.rejectAd(
                  adId, r.isNotEmpty ? r : 'مخالف للشروط والمواصفات');
              Navigator.pop(ctx);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      '❌ تم رفض المنشور وإرسال سبب الرفض لصاحب الإعلان بنجاح.'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('تأكيد الرفض والإرسال',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showAddEditCategoryDialog({CategoryItem? category}) {
    final nameController = TextEditingController(text: category?.name ?? '');
    final subcategoriesController = TextEditingController(
        text: category != null ? category.subcategories.join(', ') : '');
    IconData selectedIcon = category?.iconData ?? Icons.category;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDlgState) => AlertDialog(
          backgroundColor: const Color(0xFF0F172A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(category != null ? Icons.edit : Icons.add_circle,
                  color: const Color(0xFFD4AF37)),
              const SizedBox(width: 8),
              Text(
                category != null
                    ? 'تعديل القسم والفروع'
                    : 'إضافة قسم جديد للمنظومة',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'اسم القسم الرئيسي *',
                    labelStyle: TextStyle(color: Color(0xFFD4AF37)),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: subcategoriesController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'الفروع التابعة (افصل بينها بفاصلة ,)',
                    labelStyle: TextStyle(color: Color(0xFFD4AF37)),
                    hintText: 'فرع 1, فرع 2, فرع 3...',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                const Text('اختر أيقونة القسم:',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _iconLibrary.map((item) {
                    final isSel = selectedIcon == item['icon'];
                    return InkWell(
                      onTap: () => setDlgState(
                          () => selectedIcon = item['icon'] as IconData),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSel
                              ? const Color(0xFFD4AF37)
                              : const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: isSel ? Colors.white : Colors.white12),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: isSel ? const Color(0xFF0F172A) : Colors.white,
                          size: 20,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37)),
              onPressed: () {
                final n = nameController.text.trim();
                if (n.isEmpty) return;

                final subs = subcategoriesController.text
                    .split(',')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toList();

                if (category != null) {
                  final idx = _manager.categories
                      .indexWhere((c) => c.id == category.id);
                  if (idx != -1) {
                    _manager.categories[idx] = CategoryItem(
                      id: category.id,
                      name: n,
                      iconData: selectedIcon,
                      subcategories: subs.isNotEmpty ? subs : ['عام'],
                    );
                  }
                } else {
                  _manager.categories.add(
                    CategoryItem(
                      id: 'cat_${DateTime.now().millisecondsSinceEpoch}',
                      name: n,
                      iconData: selectedIcon,
                      subcategories: subs.isNotEmpty ? subs : ['عام'],
                    ),
                  );
                }

                _manager.notifyListeners();
                Navigator.pop(ctx);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('✅ تم حفظ وتحديث الأقسام والفروع بنجاح!'),
                      backgroundColor: Colors.green),
                );
              },
              child: const Text('حفظ القسم ✨',
                  style: TextStyle(
                      color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingAds =
        _manager.ads.where((a) => a.status == 'pending').toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Row(
          children: [
            Icon(Icons.security, color: Colors.redAccent),
            SizedBox(width: 8),
            Text(
              'غرفة العمليات المركزية 🛡️',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
          unselectedLabelColor: Colors.white60,
          tabs: [
            const Tab(text: 'أكواد التفعيل 🎟️'),
            Tab(text: 'موافقة الإعلانات (${pendingAds.length})'),
            const Tab(text: 'إدارة الأقسام والفروع 🗂️'),
            const Tab(text: 'لوحة الصيانة 🛠️'),
            const Tab(text: 'إدارة البانورامات'),
            const Tab(text: 'قفل وإخفاء الميزات ⚙️'),
            const Tab(text: 'أسعار الصرف والذهب'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. تبويب توليد وإدارة أكواد التفعيل الفورية
          ListView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(14),
                  border:
                      Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 8,
                        offset: Offset(0, 3)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.vpn_key, color: Color(0xFFD4AF37), size: 22),
                        SizedBox(width: 8),
                        Text(
                          'توليد مفتاح تفعيل واشتراك فوري 🎟️',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      value: _selectedPackageType,
                      dropdownColor: const Color(0xFF0F172A),
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: const InputDecoration(
                        labelText: 'نوع الصلاحية والباقة',
                        labelStyle: TextStyle(color: Color(0xFFD4AF37)),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFF0F172A),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'ALL_ACCESS',
                            child: Text('🌟 شاملة (الأقسام الأربعة كاملة)')),
                        DropdownMenuItem(
                            value: 'VIP_PASS',
                            child:
                                Text('👑 باقة VIP والبانوراما وسوشيال ميديا')),
                        DropdownMenuItem(
                            value: 'AUCTION_PASS',
                            child: Text('🔨 باقة المزادات والمزايدة الحرة')),
                        DropdownMenuItem(
                            value: 'MARKET_PASS',
                            child: Text('🏬 باقة نشر الإعلانات وتوثيق الحساب')),
                        DropdownMenuItem(
                            value: 'SOCIAL_PASS',
                            child: Text('💬 باقة التواصل والتفاوض المباشر')),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => _selectedPackageType = v);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _customDaysController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        labelText: 'مدة الصلاحية بالأيام (مثال: 30, 90, 365)',
                        labelStyle: TextStyle(color: Color(0xFFD4AF37)),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFF0F172A),
                        prefixIcon:
                            Icon(Icons.date_range, color: Color(0xFFD4AF37)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.flash_on,
                            color: Color(0xFF0F172A)),
                        label: const Text(
                          'توليد المفتاح الآن ⚡',
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: _generateCode,
                      ),
                    ),
                  ],
                ),
              ),
              if (_recentCodes.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: const Color(0xFF22C55E), width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '🔑 آخر مفتاح تم توليده (جاهز للاستخدام والنسخ):',
                            style: TextStyle(
                              color: Color(0xFF22C55E),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'فعال 100%',
                              style: TextStyle(
                                  color: Color(0xFF22C55E),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFD4AF37)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: SelectableText(
                                _recentCodes.first.code,
                                style: const TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy,
                                  color: Color(0xFFD4AF37)),
                              tooltip: 'نسخ المفتاح',
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: _recentCodes.first.code));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '✓ تم نسخ الكود: ${_recentCodes.first.code}'),
                                    backgroundColor: const Color(0xFF16A34A),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'الباقة: ${_recentCodes.first.packageType} | المدة: ${_recentCodes.first.durationDays} يوم',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'سجل الأكواد السابقة المنشأة:',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh,
                        color: Color(0xFFD4AF37), size: 20),
                    onPressed: _fetchLiveActivationCodes,
                    tooltip: 'تحديث السجل',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_isLoadingCodes)
                const Center(
                    child: CircularProgressIndicator(color: Color(0xFFD4AF37)))
              else if (_recentCodes.isEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'لا توجد أكواد مولدة بعد. اضغط "توليد المفتاح الآن" لإنشاء أول كود.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ),
                )
              else
                ..._recentCodes.map<Widget>(
                  (ActivationCodeItem c) {
                    final bool isUsedBool = (c.isUsed == 1);
                    return Card(
                      color: const Color(0xFF1E293B),
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: isUsedBool
                              ? Colors.white12
                              : const Color(0xFFD4AF37).withOpacity(0.5),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          isUsedBool ? Icons.check_circle : Icons.vpn_key,
                          color: isUsedBool
                              ? Colors.grey
                              : const Color(0xFFD4AF37),
                        ),
                        title: SelectableText(
                          c.code,
                          style: const TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontFamily: 'monospace',
                          ),
                        ),
                        subtitle: Text(
                          'الباقة: ${c.packageType} • المدة: ${c.durationDays} يوم',
                          style: const TextStyle(
                              color: Colors.white60, fontSize: 11),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isUsedBool
                                    ? Colors.red.withOpacity(0.2)
                                    : Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                isUsedBool ? 'مستعمل ❌' : 'متاح ✓',
                                style: TextStyle(
                                  color: isUsedBool
                                      ? Colors.redAccent
                                      : Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy,
                                  color: Colors.white70, size: 18),
                              tooltip: 'نسخ الكود',
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: c.code));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('✓ تم نسخ الكود: ${c.code}'),
                                    backgroundColor: const Color(0xFF16A34A),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
            ],
          ),

          // 2. تبويب موافقة ورفض الإعلانات (غرفة الإشراف)
          pendingAds.isEmpty
              ? const Center(
                  child: Text(
                    '✅ لا توجد إعلانات معلقة بانتظار الموافقة حالياً.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: pendingAds.length,
                  itemBuilder: (ctx, idx) {
                    final ad = pendingAds[idx];
                    return Card(
                      color: const Color(0xFF1E293B),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: AppSmartImage(
                                      imageUrl: ad.imageUrls.isNotEmpty
                                          ? ad.imageUrls.first
                                          : '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(ad.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
                                      Text(
                                        'المعلن: ${ad.publisherName} • ${ad.contactPhone}',
                                        style: const TextStyle(
                                            color: Colors.white60,
                                            fontSize: 11),
                                      ),
                                      Text(
                                        'السعر: \$${ad.priceUsd ?? 0} (${ad.priceSyp ?? 0} ل.س)',
                                        style: const TextStyle(
                                            color: Color(0xFF22C55E),
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.white24, height: 16),
                            Text(ad.description,
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 12)),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF16A34A)),
                                    icon: const Icon(Icons.check,
                                        color: Colors.white, size: 16),
                                    label: const Text('موافقة ونشر ✓',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      _manager.approveAd(ad.id);
                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                '✅ تمت الموافقة ونشر الإعلان فوراً في الشاشة الرئيسية!')),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFDC2626)),
                                    icon: const Icon(Icons.close,
                                        color: Colors.white, size: 16),
                                    label: const Text('رفض وتحديد السبب ❌',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () => _rejectAdWithReason(ad.id),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

          // 3. تبويب التحكم بالأقسام والفروع الشجرية التفاعلية
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.add_circle, color: Color(0xFF0F172A)),
                label: const Text('إضافة قسم رئيسي جديد ➕',
                    style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                onPressed: () => _showAddEditCategoryDialog(),
              ),
              const SizedBox(height: 16),
              ..._manager.categories.map(
                (cat) => Card(
                  color: const Color(0xFF1E293B),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF0F172A),
                      child: Icon(cat.iconData, color: const Color(0xFFD4AF37)),
                    ),
                    title: Text(cat.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    subtitle: Text(
                      'الفروع: ${cat.subcategories.join(" • ")}',
                      style:
                          const TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: Color(0xFF38BDF8), size: 20),
                          onPressed: () =>
                              _showAddEditCategoryDialog(category: cat),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: Colors.redAccent, size: 20),
                          onPressed: () {
                            setState(() {
                              _manager.categories
                                  .removeWhere((c) => c.id == cat.id);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 4. تبويب لوحة وإدارة الصيانة
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD4AF37)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.build_circle,
                            color: Color(0xFFD4AF37), size: 24),
                        SizedBox(width: 8),
                        Text(
                          'التحكم العام بوضع الصيانة والترقية:',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      tileColor: const Color(0xFF0F172A),
                      title: const Text('تفعيل شاشة الصيانة لجميع المستخدمين',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      subtitle: const Text(
                          'سيتم قفل التطبيق وإظهار الشاشة الروحانية فوراً',
                          style:
                              TextStyle(color: Colors.white60, fontSize: 11)),
                      value: _manager.isMaintenanceMode,
                      onChanged: (v) {
                        setState(() => _manager.isMaintenanceMode = v);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(v
                                ? '⚠️ تم تفعيل وضع الصيانة العام للمنظومة.'
                                : '✅ تم إلغاء وضع الصيانة وعودة التطبيق للعمل!'),
                            backgroundColor:
                                v ? Colors.orange.shade900 : Colors.green,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    const Text('نص رسالة الصيانة والترقية المعروضة للناس:',
                        style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _maintenanceMsgController,
                      maxLines: 5,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4AF37)),
                        onPressed: () {
                          _manager.maintenanceMessage =
                              _maintenanceMsgController.text.trim();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('✅ تم تحديث رسالة الصيانة بنجاح!'),
                                backgroundColor: Colors.green),
                          );
                        },
                        child: const Text('حفظ نص الرسالة 💾',
                            style: TextStyle(
                                color: Color(0xFF0F172A),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 5. تبويب إدارة البانورامات الاستثمارية مع الخانات
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ..._manager.banners.map(
                (b) => Card(
                  color: const Color(0xFF1E293B),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: SizedBox(
                      width: 60,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: AppSmartImage(
                            imageUrl: b.imageUrl, fit: BoxFit.contain),
                      ),
                    ),
                    title: Text('${b.title} (خانة ${b.slotIndex})',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'ينتهي: ${b.expiresAt.day}/${b.expiresAt.month}/${b.expiresAt.year}',
                      style:
                          const TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        setState(() =>
                            _manager.banners.removeWhere((x) => x.id == b.id));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 6. تبويب قفل وإخفاء الميزات السيادي المزدوج
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'لوحة التحكم السيادية بقفل وإخفاء ميزات المنصة لحظياً:',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                tileColor: const Color(0xFF1E293B),
                title: const Text('إظهار قسم السوشيال ميديا وفيديوهات المعاينة',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: const Text(
                    'إخفاء أو إظهار القسم نهائياً من إعلانات السوق',
                    style: TextStyle(color: Colors.white60, fontSize: 11)),
                value: _manager.showSocialLinks,
                onChanged: (v) => setState(() => _manager.showSocialLinks = v),
              ),
              const SizedBox(height: 6),
              SwitchListTile(
                tileColor: const Color(0xFF1E293B),
                title: const Text('قفل السوشيال ميديا كـ VIP فقط 🔒',
                    style: TextStyle(
                        color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                subtitle: const Text(
                    'عند تفعيله يطلب ترقية باقة لإضافة الروابط',
                    style: TextStyle(color: Colors.white60, fontSize: 11)),
                value: _manager.lockSocialLinksForVip,
                onChanged: (v) =>
                    setState(() => _manager.lockSocialLinksForVip = v),
              ),
              const Divider(color: Colors.white24, height: 16),
              SwitchListTile(
                tileColor: const Color(0xFF1E293B),
                title: const Text('تشغيل غرف المزادات العلنية 🔨',
                    style: TextStyle(color: Colors.white)),
                value: _manager.showAuctions,
                onChanged: (v) => setState(() => _manager.showAuctions = v),
              ),
              const SizedBox(height: 6),
              SwitchListTile(
                tileColor: const Color(0xFF1E293B),
                title: const Text('تشغيل المحادثات والتفاوض المباشر 💬',
                    style: TextStyle(color: Colors.white)),
                value: _manager.showDirectChat,
                onChanged: (v) => setState(() => _manager.showDirectChat = v),
              ),
              const SizedBox(height: 6),
              SwitchListTile(
                tileColor: const Color(0xFF1E293B),
                title: const Text('السماح بنشر إعلانات جديدة ➕',
                    style: TextStyle(color: Colors.white)),
                value: _manager.showAdPosting,
                onChanged: (v) => setState(() => _manager.showAdPosting = v),
              ),
              const SizedBox(height: 6),
              SwitchListTile(
                tileColor: const Color(0xFF1E293B),
                title: const Text('تشغيل التعليقات على المنشورات 📝',
                    style: TextStyle(color: Colors.white)),
                value: _manager.showComments,
                onChanged: (v) => setState(() => _manager.showComments = v),
              ),
            ],
          ),

          // 7. تبويب تحديث أسعار الصرف والذهب
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'تعديل أسعار الصرف والذهب المعتمدة في شريط البورصة:',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _usdRateController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'سعر \$1 دولار مقابل الليرة السورية',
                    labelStyle: TextStyle(color: Color(0xFFD4AF37)),
                    filled: true,
                    fillColor: Color(0xFF1E293B),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _goldRateController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'سعر غرام الذهب عيار 21 بالليرة السورية',
                    labelStyle: TextStyle(color: Color(0xFFD4AF37)),
                    filled: true,
                    fillColor: Color(0xFF1E293B),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37)),
                    onPressed: _saveExchangeRates,
                    child: const Text('حفظ ونشر الأسعار فوراً 🚀',
                        style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
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
// 26. شاشة الصيانة الروحانية الأنيقة (MaintenanceModeScreen)
// ==============================================================================
class MaintenanceModeScreen extends StatelessWidget {
  const MaintenanceModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = AppStateManager();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SyrianIndependenceFlag(width: 45, height: 30),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD4AF37), width: 2),
                ),
                child: const Icon(Icons.handshake,
                    color: Color(0xFFD4AF37), size: 48),
              ),
              const SizedBox(height: 20),
              const Text(
                'اللهم صلّ وسلّم وبارك على سيدنا محمد ﷺ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFD4AF37),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white12),
                ),
                child: Text(
                  manager.maintenanceMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Color(0xFFD4AF37)),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'جاري التحديث والتطوير التلقائي...',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==============================================================================
// 27. نقطة الانطلاق الرسمية للمنظومة ودالة main المهيأة لـ Firebase و Supabase
// ==============================================================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. تهيئة Firebase الرسمية
  try {
    await Firebase.initializeApp();
    debugPrint('Firebase Core Initialized Successfully 🇸🇾');
  } catch (e) {
    debugPrint('Firebase Initialization Notice: $e');
  }

  // 2. تهيئة Supabase الرسمية بالرابط والمفتاح الحقيقي
  try {
    await Supabase.initialize(
      url: kSupabaseUrl,
      anonKey: kSupabaseAnonKey,
    );
    debugPrint('Supabase Storage & DB Initialized Successfully 🚀');
  } catch (e) {
    debugPrint('Supabase Initialization Notice: $e');
  }

  // 3. ضبط اتجاه الشاشة وشريط الحالة
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const SyriaMarket2028App());
}

class SyriaMarket2028App extends StatefulWidget {
  const SyriaMarket2028App({Key? key}) : super(key: key);

  @override
  State<SyriaMarket2028App> createState() => _SyriaMarket2028AppState();
}

class _SyriaMarket2028AppState extends State<SyriaMarket2028App> {
  final AppStateManager _manager = AppStateManager();

  @override
  void initState() {
    super.initState();
    _manager.loadPersistedSession();
    _manager.fetchRealDataFromSupabase();
    _manager.addListener(() {
      if (mounted) setState(() {});
    });
  }

  void _toggleTheme() {
    setState(() {
      _manager.isDarkMode = !_manager.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سوق سوريا الشامل 2028',
      debugShowCheckedModeBanner: false,
      themeMode: _manager.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Cairo',
        primaryColor: const Color(0xFF0F172A),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F172A),
          primary: const Color(0xFF0F172A),
          secondary: const Color(0xFFD4AF37),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Cairo',
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF0F172A),
        scaffoldBackgroundColor: const Color(0xFF0B1120),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF0F172A),
          secondary: Color(0xFFD4AF37),
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: (_manager.isMaintenanceMode && !_manager.isSuperAdmin)
          ? const MaintenanceModeScreen()
          : MainDashboardScreen(
              isDarkMode: _manager.isDarkMode,
              onToggleTheme: _toggleTheme,
            ),
    );
  }
}
