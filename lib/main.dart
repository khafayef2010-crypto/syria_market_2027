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
    _startingBidController = TextEditingController(
        text: ad?.startingBid?.toStringAsFixed(0) ?? '');

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

    final forbiddenWord = _manager
        .checkForbiddenContent('${_titleController.text} ${_descController.text}');
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
    final String initialStatus =
        _manager.isSuperAdmin ? 'approved' : 'pending';

    final canAddSocial = _manager.canUserAddSocialLinks();

    final adToSave = AdItem(
      id: widget.initialAd?.id ??
          'ad_${DateTime.now().millisecondsSinceEpoch}',
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
      facebookUrl: (canAddSocial && _facebookUrlController.text.trim().isNotEmpty)
          ? _facebookUrlController.text.trim()
          : null,
      telegramUrl: (canAddSocial && _telegramUrlController.text.trim().isNotEmpty)
          ? _telegramUrlController.text.trim()
          : null,
      instagramUrl: (canAddSocial && _instagramUrlController.text.trim().isNotEmpty)
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
      auctionEndTime: _isAuction
          ? DateTime.now().add(const Duration(days: 3))
          : null,
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
                            onTap: () => setState(
                                () => _existingImageUrls.removeAt(entry.key)),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
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
                          child: Image.memory(entry.value, fit: BoxFit.cover),
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
                                  color: Colors.red, shape: BoxShape.circle),
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
                    dropdownColor: _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
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
                        color: _manager.isDarkMode ? Colors.white38 : Colors.grey,
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
                    dropdownColor: _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
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
                    dropdownColor: _manager.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
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
                  color: canAddSocial ? const Color(0xFFD4AF37) : Colors.white24,
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
                      prefixIcon: const Icon(Icons.play_circle_fill, color: Colors.red),
                      suffixIcon: !canAddSocial
                          ? const Icon(Icons.lock, color: Colors.white30, size: 16)
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
                      prefixIcon: const Icon(Icons.facebook, color: Colors.blue),
                      suffixIcon: !canAddSocial
                          ? const Icon(Icons.lock, color: Colors.white30, size: 16)
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
                      prefixIcon: const Icon(Icons.send, color: Colors.lightBlue),
                      suffixIcon: !canAddSocial
                          ? const Icon(Icons.lock, color: Colors.white30, size: 16)
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
                      prefixIcon: const Icon(Icons.camera_alt, color: Colors.pink),
                      suffixIcon: !canAddSocial
                          ? const Icon(Icons.lock, color: Colors.white30, size: 16)
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
                      prefixIcon: const Icon(Icons.music_note, color: Colors.white70),
                      suffixIcon: !canAddSocial
                          ? const Icon(Icons.lock, color: Colors.white30, size: 16)
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
              subtitle: const Text('السماح بالمزايدات مع نظام منع القنص وتمديد الوقت تلقائياً'),
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
                      style: const TextStyle(color: Colors.white, fontSize: 12.5),
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
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                          p.priceUsd == 0 ? 'مجاناً' : '\$${p.priceUsd.toInt()}',
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
  final TextEditingController _maintenanceMsgController = TextEditingController();

  // حقول توليد كود تفعيل فوري
  String _selectedPackageType = 'ALL_ACCESS';
  final TextEditingController _customDaysController = TextEditingController(text: '30');
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
    _tabController = TabController(
        length: 7, vsync: this, initialIndex: widget.initialTab);
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
              .map<ActivationCodeItem>((r) => ActivationCodeItem.fromMap(r as Map<String, dynamic>))
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
    final p1 = List.generate(4, (_) => chars[rand.nextInt(chars.length)]).join();
    final p2 = List.generate(4, (_) => chars[rand.nextInt(chars.length)]).join();
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
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
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
                hintText: 'مثال: الصور غير واضحة، السعر غير متطابق، يرجى كتابة تفاصيل أكثر...',
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
              _manager.rejectAd(adId, r.isNotEmpty ? r : 'مخالف للشروط والمواصفات');
              Navigator.pop(ctx);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('❌ تم رفض المنشور وإرسال سبب الرفض لصاحب الإعلان بنجاح.'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('تأكيد الرفض والإرسال',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(category != null ? Icons.edit : Icons.add_circle, color: const Color(0xFFD4AF37)),
              const SizedBox(width: 8),
              Text(
                category != null ? 'تعديل القسم والفروع' : 'إضافة قسم جديد للمنظومة',
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
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
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _iconLibrary.map((item) {
                    final isSel = selectedIcon == item['icon'];
                    return InkWell(
                      onTap: () => setDlgState(() => selectedIcon = item['icon'] as IconData),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSel ? const Color(0xFFD4AF37) : const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: isSel ? Colors.white : Colors.white12),
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
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
              onPressed: () {
                final n = nameController.text.trim();
                if (n.isEmpty) return;

                final subs = subcategoriesController.text
                    .split(',')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toList();

                if (category != null) {
                  final idx = _manager.categories.indexWhere((c) => c.id == category.id);
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
                  const SnackBar(content: Text('✅ تم حفظ وتحديث الأقسام والفروع بنجاح!'), backgroundColor: Colors.green),
                );
              },
              child: const Text('حفظ القسم ✨',
                  style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingAds = _manager.ads.where((a) => a.status == 'pending').toList();

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
                  border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 3)),
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
                        DropdownMenuItem(value: 'ALL_ACCESS', child: Text('🌟 شاملة (الأقسام الأربعة كاملة)')),
                        DropdownMenuItem(value: 'VIP_PASS', child: Text('👑 باقة VIP والبانوراما وسوشيال ميديا')),
                        DropdownMenuItem(value: 'AUCTION_PASS', child: Text('🔨 باقة المزادات والمزايدة الحرة')),
                        DropdownMenuItem(value: 'MARKET_PASS', child: Text('🏬 باقة نشر الإعلانات وتوثيق الحساب')),
                        DropdownMenuItem(value: 'SOCIAL_PASS', child: Text('💬 باقة التواصل والتفاوض المباشر')),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => _selectedPackageType = v);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _customDaysController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        labelText: 'مدة الصلاحية بالأيام (مثال: 30, 90, 365)',
                        labelStyle: TextStyle(color: Color(0xFFD4AF37)),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFF0F172A),
                        prefixIcon: Icon(Icons.date_range, color: Color(0xFFD4AF37)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.flash_on, color: Color(0xFF0F172A)),
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
                    border: Border.all(color: const Color(0xFF22C55E), width: 1.5),
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
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'فعال 100%',
                              style: TextStyle(color: Color(0xFF22C55E), fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                              icon: const Icon(Icons.copy, color: Color(0xFFD4AF37)),
                              tooltip: 'نسخ المفتاح',
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: _recentCodes.first.code));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('✓ تم نسخ الكود: ${_recentCodes.first.code}'),
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
                        style: const TextStyle(color: Colors.white70, fontSize: 11),
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
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Color(0xFFD4AF37), size: 20),
                    onPressed: _fetchLiveActivationCodes,
                    tooltip: 'تحديث السجل',
                  ),
                ],
              ),
              const SizedBox(height: 8),

              if (_isLoadingCodes)
                const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)))
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
                          color: isUsedBool ? Colors.white12 : const Color(0xFFD4AF37).withOpacity(0.5),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          isUsedBool ? Icons.check_circle : Icons.vpn_key,
                          color: isUsedBool ? Colors.grey : const Color(0xFFD4AF37),
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
                          style: const TextStyle(color: Colors.white60, fontSize: 11),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isUsedBool ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                isUsedBool ? 'مستعمل ❌' : 'متاح ✓',
                                style: TextStyle(
                                  color: isUsedBool ? Colors.redAccent : Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy, color: Colors.white70, size: 18),
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
                                    onPressed: () =>
                                        _rejectAdWithReason(ad.id),
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
                      style: const TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Color(0xFF38BDF8), size: 20),
                          onPressed: () => _showAddEditCategoryDialog(category: cat),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
                          onPressed: () {
                            setState(() {
                              _manager.categories.removeWhere((c) => c.id == cat.id);
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
                        Icon(Icons.build_circle, color: Color(0xFFD4AF37), size: 24),
                        SizedBox(width: 8),
                        Text(
                          'التحكم العام بوضع الصيانة والترقية:',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      tileColor: const Color(0xFF0F172A),
                      title: const Text('تفعيل شاشة الصيانة لجميع المستخدمين',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: const Text('سيتم قفل التطبيق وإظهار الشاشة الروحانية فوراً',
                          style: TextStyle(color: Colors.white60, fontSize: 11)),
                      value: _manager.isMaintenanceMode,
                      onChanged: (v) {
                        setState(() => _manager.isMaintenanceMode = v);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(v
                                ? '⚠️ تم تفعيل وضع الصيانة العام للمنظومة.'
                                : '✅ تم إلغاء وضع الصيانة وعودة التطبيق للعمل!'),
                            backgroundColor: v ? Colors.orange.shade900 : Colors.green,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    const Text('نص رسالة الصيانة والترقية المعروضة للناس:',
                        style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
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
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                        onPressed: () {
                          _manager.maintenanceMessage = _maintenanceMsgController.text.trim();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('✅ تم تحديث رسالة الصيانة بنجاح!'), backgroundColor: Colors.green),
                          );
                        },
                        child: const Text('حفظ نص الرسالة 💾',
                            style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
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
                      style: const TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        setState(() => _manager.banners.removeWhere(
                            (x) => x.id == b.id));
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
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: const Text('إخفاء أو إظهار القسم نهائياً من إعلانات السوق',
                    style: TextStyle(color: Colors.white60, fontSize: 11)),
                value: _manager.showSocialLinks,
                onChanged: (v) => setState(() => _manager.showSocialLinks = v),
              ),
              const SizedBox(height: 6),
              SwitchListTile(
                tileColor: const Color(0xFF1E293B),
                title: const Text('قفل السوشيال ميديا كـ VIP فقط 🔒',
                    style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                subtitle: const Text('عند تفعيله يطلب ترقية باقة لإضافة الروابط',
                    style: TextStyle(color: Colors.white60, fontSize: 11)),
                value: _manager.lockSocialLinksForVip,
                onChanged: (v) => setState(() => _manager.lockSocialLinksForVip = v),
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
                child: const Icon(Icons.handshake, color: Color(0xFFD4AF37), size: 48),
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
                    child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFD4AF37)),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'جاري التحديث والتطوير التلقائي...',
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
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
