import '../models/mobile_code.dart';

// تنبيه: هذه بيانات تجريبية لبناء الواجهة فقط. لا تُعرض كأكواد مؤكدة.
// يجب مراجعة كل كود من مصدر الشركة الرسمي قبل تفعيل الاتصال في إصدار النشر.
const seedCodes = <MobileCode>[
  MobileCode(id: 'vf_balance', providerId: 'vodafone', providerName: 'Vodafone', title: 'معرفة الرصيد', code: '*868*1#', category: 'الرصيد', description: 'استعلام عن رصيد الخط.', verified: false),
  MobileCode(id: 'vf_customer', providerId: 'vodafone', providerName: 'Vodafone', title: 'خدمة العملاء', code: '888', category: 'الدعم', description: 'الاتصال بخدمة عملاء فودافون.', verified: false),
  MobileCode(id: 'orange_customer', providerId: 'orange', providerName: 'Orange', title: 'خدمة العملاء', code: '110', category: 'الدعم', description: 'الاتصال بخدمة عملاء أورنج.', verified: false),
  MobileCode(id: 'et_customer', providerId: 'etisalat', providerName: 'e&', title: 'خدمة العملاء', code: '333', category: 'الدعم', description: 'الاتصال بخدمة عملاء e&.', verified: false),
  MobileCode(id: 'we_customer', providerId: 'we', providerName: 'WE', title: 'خدمة العملاء', code: '111', category: 'الدعم', description: 'الاتصال بخدمة عملاء WE.', verified: false),
];

const providers = [
  ('all', 'الكل', 0xFF5B4BDB),
  ('vodafone', 'Vodafone', 0xFFE60000),
  ('orange', 'Orange', 0xFFFF7900),
  ('etisalat', 'e&', 0xFF00A86B),
  ('we', 'WE', 0xFF6C3CCB),
];
