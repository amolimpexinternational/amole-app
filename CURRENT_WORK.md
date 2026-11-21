# CURRENT_WORK.md — आत्ता काय चालू आहे

**शेवटचं अपडेट:** २१ नोव्हेंबर 2026

> **महत्त्वाचं:** ही फाईल प्रत्येक file पूर्ण झाल्यावर update करायची.
> Session संपल्यावर नवीन AI ला ही फाईल द्या — तो नेमक्या ठिकाणाहून सुरू करेल.

---

## 🎯 आत्ताचं काम

**मोठं काम:** Admin → CP → Franchise screens पुनर्रचना (क्रमाने)

**सध्याचा टप्पा:** टप्पा 1 — Admin छोटे बदल

---

## ✅ पूर्ण झालं (आज)

- ✅ `admin_seller_list_screen.dart` — `ctx` parameter fix (commit `ce900e2`)
- ✅ `AGENTS.md` — mobile वर तयार (Codespace commit बाकी)
- ✅ `PROJECT_STATUS.md` — Section 25 जोडलं (Codespace commit बाकी)
- ✅ `HANDOFF_NEW_AI.md` — update (Codespace commit बाकी)
- ⏳ `CURRENT_WORK.md` — हे फाईल तयार होतंय

---

## ⏳ बाकी (टप्पा 1 — छोटे बदल, ५ files)

| # | File | बदल | स्थिती |
|---|---|---|---|
| १ | `admin_home_screen.dart` | ४ Quick Actions काढ; Revenue merge → "Income"; "आजचे उत्पादन" → "Total Promoters"; Daily Settlement → Accounting; Bottom Nav Revenue → "Amole Ecosystem" | ⏳ पुढची |
| २ | `admin_franchise_list_screen.dart` | Header खालचा stats card काढ; Mobile + monthly income जोड | ⏳ |
| ३ | `admin_seller_list_screen.dart` | Header खालचा stats card काढ; Mobile जोड | ⏳ |
| ४ | `admin_channel_partners_screen.dart` | Mobile + counts + monthly income | ⏳ |
| ५ | `admin_live_ads_screen.dart` | ३ tabs (Live/Pending/Rejected) + hierarchy + edit/preview/approve/reject | ⏳ |

---

## ⏳ बाकी (टप्पा 2 — Dialogs, ४ files)

| # | File | बदल |
|---|---|---|
| ६ | `admin_profile_screen.dart` | सर्व clickable + logo edit + CP/SubAdmin + contact/company |
| ७ | `admin_wallet_screen.dart` | Today/Week/Month + Calendar picker |
| ८ | `admin_notification_screen.dart` | ६ प्रकार notifications |
| ९ | `admin_approvals_screen.dart` | ३ tabs (Pending Ads/Offers/Onboarding) |

---

## ⏳ बाकी (टप्पा 3 — नवीन screens, २ files)

| # | File | काय |
|---|---|---|
| १० | `admin_settlement_screen.dart` | Rename → Accounting + सर्व payments/Lucky Draw/rewards/ads/subscription/net income |
| ११ | `admin_ecosystem_screen.dart` | नवीन — सर्व stats + Excel button + filters |

---

## ⏳ बाकी (टप्पा 4 — Add screens, २ files)

| # | File | बदल |
|---|---|---|
| १२ | `admin_add_franchise_screen.dart` | CP button → CP यादी |
| १३ | `admin_add_seller_screen.dart` | CP button + Franchise button |

---

## ⏳ बाकी (टप्पा 5 — Notifications, १ file)

| # | File | बदल |
|---|---|---|
| १४ | `admin_send_notification_screen.dart` | Promoter/Weekly-Seller/Rider/Parcel/Referrer/Buyer-स्त्री-पुरुष जोड |

---

## 📋 मोठी योजना — सर्व टप्पे

**टप्पा 1-5 (Admin सर्व):** वर बघ

**टप्पा 6 (CP screen):**
- `channel_partner_home_screen.dart` — Admin सारखं पुनर्रचना
- `cp_franchise_screen.dart`, `cp_seller_screen.dart`, `cp_ads_screen.dart` — Admin सारखे
- **नवीन:** `cp_ecosystem_screen.dart`, `cp_accounting_screen.dart` (त्यांच्या अंडरचे)
- **"Notification पाठवा"** Quick Action जोड

**टप्पा 7 (Franchise screen):**
- `franchise_home_screen.dart` — Admin/CP सारखं पुनर्रचना
- `franchise_seller_list_screen.dart`, `franchise_ad_screen.dart` — Admin सारखे
- **नवीन:** `franchise_ecosystem_screen.dart`, `franchise_accounting_screen.dart`

---

## ⚠️ महत्त्वाच्या नोंदी

- **Excel download** — फक्त button, Stage 3 मध्ये काम
- **सर्व data demo (mock)** — Stage 3 मध्ये Firestore
- **Sub Admin** = Admin सारखे सर्व अधिकार, पण Admin च्या अंडर
- **Bottom Nav Revenue** — पूर्ण काढून "Amole Ecosystem" (∞ infinity logo)
- **Daily Settlement, Revenue Report** — Quick Actions मधून काढ
- **CP स्तरावर "Revenue" ची जागी "Ecosystem"**
- **Franchise स्तरावर "Revenue" ची जागी "Ecosystem"**
- **कोणताही नवीन AI** — AGENTS.md + PROJECT_STATUS.md + PROJECT_MAP.md + हे फाईल वाचून सुरू करावं

---

## 📝 Update कसं करायचं (सोपी पद्धत)

**प्रत्येक file पूर्ण झाल्यावर:**

1. "✅ पूर्ण झालं" मध्ये ✅ जोड
2. "⏳ बाकी" मधून ती ओळ काढ
3. पुढच्या file ला "⏳ पुढची" मार्क कर

