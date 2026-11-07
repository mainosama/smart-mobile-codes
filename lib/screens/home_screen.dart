import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/seed_codes.dart';
import '../models/mobile_code.dart';
import '../services/dialer_service.dart';
import '../services/favorites_service.dart';
import '../widgets/code_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _search = TextEditingController();
  final _favorites = FavoritesService();
  final _dialer = DialerService();
  Set<String> _favoriteIds = {};
  String _provider = 'all';
  String _category = 'الكل';
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final values = await _favorites.load();
    if (mounted) setState(() => _favoriteIds = values);
  }

  List<MobileCode> get _visibleCodes {
    Iterable<MobileCode> items = seedCodes;
    if (_provider != 'all') items = items.where((e) => e.providerId == _provider);
    if (_category != 'الكل') items = items.where((e) => e.category == _category);
    if (_tab == 1) items = items.where((e) => _favoriteIds.contains(e.id));
    final q = _search.text.trim().toLowerCase();
    if (q.isNotEmpty) items = items.where((e) => '${e.title} ${e.code} ${e.category} ${e.providerName}'.toLowerCase().contains(q));
    return items.toList();
  }

  Future<void> _toggleFavorite(MobileCode item) async {
    await _favorites.toggle(item.id, _favoriteIds);
    await _loadFavorites();
  }

  Future<void> _dial(MobileCode item) async {
    final ok = await _dialer.dial(item.code);
    if (!mounted) return;
    if (!ok) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تعذر فتح تطبيق الاتصال على هذا الجهاز')));
  }

  @override
  void dispose() { _search.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final codes = _visibleCodes;
    return Scaffold(
      appBar: AppBar(title: const Text('كود موبايل', style: TextStyle(fontWeight: FontWeight.w900)), actions: [IconButton(tooltip: 'حول التطبيق', onPressed: () => showAboutDialog(context: context, applicationName: 'كود موبايل', applicationVersion: '1.0.0', children: const [Text('دليل أكواد خدمات شركات المحمول.')]), icon: const Icon(Icons.info_outline))]),
      body: SafeArea(child: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(16, 4, 16, 12), child: Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF5143C7), Color(0xFF8879F2)]), borderRadius: BorderRadius.circular(24)), child: const Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('كل خدمات خطك في مكان واحد', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 5), Text('ابحث عن الخدمة وافتح كود الاتصال بضغطة', style: TextStyle(color: Colors.white70, fontSize: 12))])), Icon(Icons.sim_card_rounded, color: Colors.white, size: 44)]))),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: SearchBar(controller: _search, onChanged: (_) => setState(() {}), hintText: 'ابحث عن خدمة أو كود...', leading: const Icon(Icons.search), trailing: [if (_search.text.isNotEmpty) IconButton(onPressed: () { _search.clear(); setState(() {}); }, icon: const Icon(Icons.close))])),
        const SizedBox(height: 12),
        SizedBox(height: 44, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12), children: providers.map((p) => Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(p.$2), selected: _provider == p.$1, onSelected: (_) => setState(() => _provider = p.$1)))).toList())),
        const SizedBox(height: 8),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(children: [Expanded(child: Text(_tab == 1 ? 'الأكواد المفضلة' : 'الأكواد والخدمات', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800))), PopupMenuButton<String>(initialValue: _category, onSelected: (v) => setState(() => _category = v), itemBuilder: (_) => ['الكل', 'الرصيد', 'الدعم', 'الإنترنت', 'الشحن', 'الباقات'].map((e) => PopupMenuItem(value: e, child: Text(e))).toList(), child: Chip(avatar: const Icon(Icons.filter_list, size: 17), label: Text(_category)))])),
        Expanded(child: codes.isEmpty ? const Center(child: Text('مفيش نتائج مطابقة حالياً')) : ListView.builder(padding: const EdgeInsets.fromLTRB(16, 8, 16, 16), itemCount: codes.length, itemBuilder: (context, index) { final item = codes[index]; return CodeCard(item: item, favorite: _favoriteIds.contains(item.id), onFavorite: () => _toggleFavorite(item), onDial: () => _dial(item), onCopy: () async { await Clipboard.setData(ClipboardData(text: item.code)); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نسخ الكود'))); }); })),
      ])),
      bottomNavigationBar: NavigationBar(selectedIndex: _tab, onDestinationSelected: (v) => setState(() => _tab = v), destinations: const [NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'), NavigationDestination(icon: Icon(Icons.star_border), selectedIcon: Icon(Icons.star), label: 'المفضلة'), NavigationDestination(icon: Icon(Icons.widgets_outlined), label: 'الويدجت')]),
    );
  }
}
