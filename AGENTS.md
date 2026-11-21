# 🤖 AGENTS.md — Amole App AI Rulebook

> **हे फाईल कोणत्याही AI (Claude, ChatGPT, DeepSeek, Cursor, इ.) ने सर्वात आधी वाचायची.**
> हे फाईल = नियम + प्रोजेक्ट माहिती + व्यवसाय नियम + तंत्रज्ञान.
> शेवटचं अपडेट: नोव्हेंबर 2026 | शेवटचा commit: `ce900e2`

---

## ०. AI ला सर्वात आधी हे समजलं पाहिजे

### ०.१ कोण काम करतं
- **नाव:** Amol (Amol Impex International)
- **Coding knowledge:** नाही — complete beginner
- **Device:** Android mobile (GitHub app) + Codespace (browser, जुन्या Windows 7 लॅपटॉपवर)
- **भाषा:** मराठी. English technical terms चालतील.
- **Team:** Amol + १ सहकारी

### ०.२ काम कसं चालतं (STRICT)
1. **Amol file चा कोड देतो** (किंवा बदल सांगतो)
2. **AI बदल करून पूर्ण file देतो** (भाग नाही — संपूर्ण!)
3. **Amol copy-paste करतो** (select all → delete → paste → save)
4. **प्रत्येक बदलापूर्वी AI थोडक्यात सांगतो:** कोणती file, का बदलणार
5. **Amol "OK" / "हो" म्हणाल तेव्हाच कोड**
6. **एका वेळी एकच बदल** — एकत्र कधीही नको

### ०.३ भाषा
- **मराठीत** समजाव — technical terms English मध्ये चालतील
- Coding jargon टाळ — सोप्या शब्दांत सांग

---

## १. GOLDEN RULES — कधीही मोडू नका

| # | नियम |
|---|---|
| १ | **`git add .` कधीही नको** — फक्त बदललेल्या files |
| २ | **जुनं code नव्याला overwrite होऊ नये** — हा सर्वोच्च नियम |
| ३ | **`git reset --hard`, `git revert`, branch मागे नेणे — कधीही नको** |
| ४ | **`flutter analyze` errors 0 नसल्यावर commit नको** |
| ५ | **Amol ने test करून OK केल्यावरच commit** |
| ६ | **दुसऱ्याची file duplicate करू नको** — आधी existing तपास |
| ७ | **Dummy data ला real backend ने replace करू नको** — Stage 3 पर्यंत |
| ८ | **फक्त सांगितलेलंच बदल** — unrelated screens बदलू नको |
| ९ | **प्रत्येक बदलापूर्वी विचार + OK माग** |
| १० | **Conflict आला तर स्वतः काही नको** — Amol ला सांग |

---

## २. प्रोजेक्ट — Amole App

**नाव:** Amole
**कंपनी:** Amol Impex International
**Tagline:** "माझा पैसा माझ्या खिशात, आपल्या लोकांचा आपला बाजार"
**Website:** amole.in
**GitHub:** `amolimpexinternational/amole-app` | Branch: `main`
**Platform:** Flutter (Dart) — Android first
**Flutter SDK:** v3.47.1

**काय आहे:** Maharashtra-based Local Social Commerce Super App — JioMart + Paytm + Instagram + Rapido + Swiggy + Porter + Urban Company + IndiaMart सारखं — पण १००% local focus.

---

## ३. ६ User Roles

| Role | काय करतो | Level |
|---|---|---|
| **Buyer** | ग्राहक — खरेदी, ऑर्डर, रिवॉर्ड | User |
| **Seller** | विक्रेता — sub-types खाली | Area |
| **Franchise** | एरिया प्रमुख — seller KYC, ads approval | Pincode/Taluka |
| **Channel Partner (CP)** | जिल्हा प्रमुख — multiple franchises | District |
| **Admin** | सुपर — संपूर्ण प्लॅटफॉर्म | National |
| **Promoter** | Buyer जो mini-seller झाला — catalog share करतो | User |

**Seller sub-types:** Local/ZatPat, Global Shopping, Service Provider, Hotel, Cargo, Delivery Boy, Rider

**Hierarchy:** Admin → CP → Franchise → Seller → Buyer
**Promoter** — Franchise अंतर्गत, seller products promote करतो

---

## ४. १२ मुख्य Modules (Grid Icons)

| # | Module | काय | स्थिती |
|---|---|---|---|
| १ | **Global Shopping** | देशभर products, Shiprocket shipping | ✅ Demo |
| २ | **Taxi/Rikshaw** | Ride booking, GPS driver | ✅ Demo |
| ३ | **ZatPat** | 10km local quick delivery | ✅ Demo |
| ४ | **Hotel Food** | Restaurant food delivery | ✅ Demo |
| ५ | **Services & Repair** | Plumber, electrician, इ. | ✅ Demo |
| ६ | **Parcel Cargo** | Cargo/luggage transport | ✅ Demo |
| ७ | **Resale/Rent** | Used goods + rent | ✅ Demo |
| ८ | **Kirana Mart** | Grocery (ZatPat चं variant) | ✅ Demo |
| ९ | **Jobs** | Job portal (seeker + employer) | ✅ Demo |
| १० | **Mom's Miracle** | Baby/kids products | ✅ Demo |
| ११ | **Manufacturer** | B2B (IndiaMart सारखं) | ⏳ Coming Soon |
| १२ | **Farmers & Vegetable** | शेतकरी थेट विक्री | ⏳ Coming Soon |

### ४.१ Module तपशील

**Global Shopping:**
- Buyer-facing e-commerce home
- Product grid (2 col), category filter, search, offers slider
- Product detail → Add to cart → Checkout
- Shipping: Shiprocket (Stage 3)
- Delivery: देशभर

**ZatPat / Kirana Mart:**
- 10km radius local shops
- Product list sorted by distance
- Delivery charge: 3km ₹30, 5km ₹45, 7km ₹60, 10km ₹100
- Cart bar at bottom
- Same file — `initialCategory` + `title` parameters

**Hotel Food:**
- 10km hotels list
- Menu per hotel
- Shared cart with other modules
- Hotel orders screen for seller

**Taxi/Rikshaw:**
- Vehicle type: Bike, Rickshaw, Car5, Car7, SUV
- GPS pickup + area name (Geocoding)
- Google Maps button
- Fare chart per vehicle
- Driver nearby (Stage 3)

**Services & Repair:**
- Service categories (electrician, plumber, etc.)
- Requirement form
- Provider accepts (Demo buttons)
- Report, bill, code (7359 demo)

**Parcel Cargo:**
- Vehicle types (Three Wheeler, 1-ton, 2-ton, Container)
- 30km = ₹465 (Three Wheeler)
- GPS pickup
- Real rates pending (Stage 3)

**Resale/Rent/Jobs:**
- Post fee ₹50
- My posts (Edit/Delete)
- 30 days expiry
- Jobs (separate detailed portal)

**Mom's Miracle:**
- Baby/kids products (5 demo)
- Chips filter, search
- Same product card as Global Shopping

**Jobs (मोठं):**
- ३ tabs: नोकऱ्या शोधा / माझे प्रोफाइल / कर्मचारी शोधा
- Apply fee: ₹30
- Resume builder (free)
- Post requirement (free)

---

## ५. व्यवसाय नियम (Business Rules)

### ५.१ Commission Split
- **Company: 10%**
- **Promoter: 5%** (reward points मध्ये)
- **Referral: 0.25%**
- **Franchise: 1%**
- **CP: 0.25%**
- **Seller: बाकी** (delivery charge वजा करून)

### ५.२ Reward Points
- 1 pt = ₹1
- 3 महिन्यांत expire
- Checkout मध्ये वापरता येईल
- Transfer होत नाहीत
- मिळतात: खरेदीवर 2%, referral 0.25%, ad poll answer, lucky draw

### ५.३ Settlement
- **Buyer → Amole (full amount)**
- **Return window (7 दिवस) संपल्यावर → Seller ला payment** (Amazon सारखं)
- Delivery charge वजा करून
- Cashfree (Stage 3)

### ५.४ पेमेंट
- संपूर्ण रक्कम Amole कंपनीकडे
- 7 दिवसांनंतर seller ला
- ZatPat/Hotel: 100% online (Stage 3)

### ५.५ Ads (जाहिरात) — २ प्रकार

**फ्री ऑफर (Create Offer Free):**
- फक्त **Seller**
- **फक्त स्वतःच्या जिल्ह्यात** दिसते (आपोआप)
- फ्री

**पेड ऑफर (Create Top Offer):**
- **Seller, Franchise, CP, Admin**
- **देशात कुठेही** (राज्य→जिल्हा→तालुका→पिनकोड)
- फी लागते
- वैधता: **कमाल 7 दिवस** (auto-delete)
- Preview → Edit → Approval/Live

**Ads (जाहिरात तयार करा):**
- **Seller** → Franchise → CP → Admin approval
- **Franchise/CP/Admin** → **थेट Live** (approval नाही)
- Admin = संपूर्ण edit + delete
- Content: Text/Photo/Video
- Budget: किमान ₹100
- Duration: 1-7 दिवस
- Poll question + Age/Gender/Time targeting
- Hierarchical location (राज्य→जिल्हा→तालुका→पिनकोड)

**Ads Revenue Split (poll reply):**
- Buyer 35%, Franchise 15%, CP 5%, Referrer 5%, Ad Generator 10%, Company 30%
- Cost per poll: ₹0.10 text, ₹0.25 photo, ₹0.50 video

### ५.६ आठवडी बाजार (Weekly Market)
- दर **शनिवारी 3-12 PM**
- CP/Admin create करतात (तारीख, वेळ, परिसर)
- Seller/Promoter/Franchise/CP/Admin catalog तयार करतात
- **₹50 fee** (promoter साठी) — seller फ्री
- **30 दिवस auto delete**
- ON/OFF toggle प्रत्येक catalog ला

### ५.७ Lucky Draw
- तिकीट ₹5
- Draw: **दररोज 4:00 PM**
- Cutoff: 3:50 PM
- Winner: priority (90 days purchase history)
- 50% company, 50% winners (20% participants) — reward points मध्ये

### ५.८ KYC
- **Seller:** आधार, पॅन, बँक, पत्ता, फोटो, सेल्फी, GPS (Franchise verify — 72hrs)
- **Franchise:** आधार, पॅन, बँक, पत्ता (CP verify)
- **Promoter:** आधार, पॅन, पत्ता (Franchise verify)

### ५.९ Subscription Plans
| Plan | किंमत | कालावधी | Products | Ads Free |
|---|---|---|---|---|
| 1 | Free | कायम | 5 | 1 |
| 2 | ₹499 | 5 महिने | 10 | 5 |
| 3 | ₹999 | 1 वर्ष | 20 | - |
| 4 | ₹1,500 | 1 वर्ष | 100 | - |

### ५.१० Jobs
- **Apply fee: ₹30** (contact दिसण्यासाठी)
- **Resume builder: Free**
- **Post requirement: Free**
- **Post कोणी केली** — फक्त Franchise/CP/Admin बघू शकतात

### ५.११ Delivery Charge
- ZatPat/Hotel: 3km ₹30, 5km ₹45, 7km ₹60, 10km ₹100
- Global Shopping: Shiprocket (Stage 3 — स्थानिक charge नाही)
- Parcel Cargo: वाहन नुसार वेगळं

### ५.१२ रद्दबातल नियम
- **Order return window:** 7 दिवस
- **Settlement:** 7 दिवसांनंतर
- **Ads validity:** 1-7 दिवस (auto-delete)
- **Weekly Market catalog:** 30 दिवस (auto-delete)
- **Reward points:** 3 महिने (expire)

---

## ६. तंत्रज्ञान (Tech Stack)

### ६.१ सध्याचं (Stage 2 — Demo)
- Flutter 3.47.1, Dart
- Static in-memory data (dummy)
- **Firebase packages आहेत पण initialize नाही**
- `services/` folder नाही
- **कोणतंही backend नाही**

### ६.२ Stage 3 (भविष्य — user म्हणाल तेव्हाच)
| Technology | कशासाठी | पर्याय |
|---|---|---|
| **Firebase** | Auth (Phone OTP), Firestore, Storage, Functions, FCM | — |
| **Cashfree** | Payment (Easy Split) | Razorpay |
| **Shiprocket** | Global Shopping shipping | NimbusPost (स्वस्त) |
| **Mapbox** | Maps (Google पेक्षा स्वस्त) | Google Maps |
| **Tracelet** | 250m location tracking | — |
| **GeoFlutterFire** | जवळचे drivers | Geohash |
| **Cloud Functions** | Settlement, Lucky Draw, Weekly Market, TTL | — |

### ६.३ Installed Packages
firebase_core, firebase_auth, cloud_firestore, google_sign_in,
shared_preferences, flutter_svg, cached_network_image, intl,
image_picker, file_picker, geolocator, geocoding, wakelock_plus,
share_plus 13.3.1, url_launcher


### ६.४ Firebase Firestore Collections (Stage 3 साठी तयार)

users, sellers, franchises, channel_partners, promoters, buyers,
products, orders, order_groups, ads, offers, weekly_market,
weekly_market_catalogs, ads_watched, transactions, wallets,
notifications, chats, lucky_draw



---

## ७. Stage strategy

| Stage | काय | स्थिती |
|---|---|---|
| **Stage 1** | UI/Screen development | ✅ पूर्ण |
| **Stage 2** | Demo (dummy data, navigation, user flow) | 🟡 **सध्या इथे** |
| **Stage 3** | Real backend (Firebase + Cashfree + Shiprocket + Mapbox + Tracelet) | ⏳ **user म्हणाल तेव्हाच** |

**⚠️ Stage 3 user म्हणाल तेव्हाच सुरू कर — स्वतःहून नको.**

---

## ८. Project Structure


lib/
├── constants/      app_colors, app_strings
├── data/           ads, buyer_*, delivery_rates, listings, parcel,
│                   product_database, ride_rates, services, transactions,
│                   zatpat_data, kids_demo
├── models/         ad, business_profile, notification, product,
│                   seller, subscription, transaction
├── screens/
│   ├── admin/      (~22 + weekly_market_create)
│   ├── buyer/      (~40 + promoter_kyc)
│   ├── channel_partner/
│   ├── common/
│   ├── delivery/
│   ├── franchise/
│   ├── rider/
│   ├── seller/     (+ expenses_wallet, registration/)
│   ├── shared/     (chat, top_offer_create, weekly_market_catalog)
│   └── user/
├── services/       (stand_location_service — active)
├── widgets/        ad_feed, home_services_grid, notification_list,
│                   offers_slider, seller_delivery_tiles
├── main.dart
└── main_demo_franchise.dart




---

## ९. नवीन task कसा handle करायचा

### प्रत्येक task साठी हे क्रम पाळा:

**Step 1:** Amol चा request सोप्या शब्दांत समजून घे
**Step 2:** संबंधित existing code तपास (file मागून वाच)
**Step 3:** थोडक्यात सांग:
- आधी काय आहे
- काय बदलणार
- कोणती file
- बदलाचा उद्देश
**Step 4:** Amol "OK" / "हो" म्हणाल तेव्हाच **पूर्ण file चा कोड** दे (भाग नको)
**Step 5:** Amol copy-paste करेल → test करेल
**Step 6:** OK म्हणाल तेव्हाच पुढचा बदल
**Step 7:** Important feature झाल्यावर `PROJECT_STATUS.md` update सांग

---

## १०. महत्त्वाचे patterns (आधीच्या कामातून)

### १०.१ ElevatedButton Row मध्ये
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(minimumSize: const Size(0, 44)),
  ...
)


का: main.dart theme मध्ये minimumSize: Size(double.infinity, 52) आहे — Row मध्ये पूर्ण रुंदी घेऊन मजकूर मोडतो.

actionsPadding: const EdgeInsets.only(right: 8),
actions: [
  IconButton(favorite) — 40x40, iconSize 22,
  SizedBox(width: 2),
  Padding(right: 16,
    Badge(child: IconButton(cart, 40x40, iconSize 24))
  ),
]


१०.३ Hierarchical Location Picker

Reference file: admin_create_ad_screen.dart

· _locationData — Map<State, Map<District, Map<Taluka, List<Pincode>>>>
· _selectedStates, _selectedDistricts, _selectedTalukas, _selectedPincodes — Sets
· _showLocationPicker() — BottomSheet with CheckboxListTile
· _locationChip() — Display + count
· "सर्व निवडा" / "सर्व काढा" toggle

१०.४ ON/OFF Toggle Pattern

```dart
'active': true,  // field
// Card border based on active
// Switch → _toggleX(index, value)
// Status auto-adjust (Active ↔ Inactive)
// Snackbar feedback
```

१०.५ Tabs Pattern

```dart
int _selectedTab = 0;
List<Map<String, dynamic>> get _filtered {
  switch (_selectedTab) { ... }
}
Widget _buildTab(int index, String label, int count) { ... }
// AppBar bottom: PreferredSize + Row of _buildTab
```

१०.६ Preview + Edit pattern

· Primary button = Preview (dialog)
· Icon button = Edit (full screen)
· Icon button = Delete (confirm)

१०.७ Quick Action pattern (franchise/CP/Admin)

```dart
Card(
  child: ListTile(
    leading: Icon,
    title: Text,
    subtitle: Text,
    trailing: chevron_right,
    onTap: Navigator.push
  )
)
```

---

११. Terminal commands (Codespace)

```bash
# Pull
git pull --no-rebase --no-edit

# Packages
flutter pub get

# Analyze
flutter analyze 2>&1 | grep "error •" | head -20

# Run demo
flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0 --release

# Build APK
flutter build apk --release
# → build/app/outputs/flutter-apk/app-release.apk

# Map regenerate (commit आधी)
python3 tools/make_map.py
```

⚠️ q दाबू नको (--release मध्ये) — Ctrl+C वापर
⚠️ gradle 8G नको — 2048m ठेव (android/gradle.properties)

---

१२. Git safety (आवश्यक)

✅ करा:

· फक्त बदललेल्या files git add <file1> <file2>
· Amol OK नंतरच commit
· python3 tools/make_map.py commit आधी
· PROJECT_STATUS.md update मोठ्या बदलानंतर

❌ कधीही नको:

· git add .
· git reset --hard
· git revert
· Branch मागे नेणे
· जुना commit checkout
· स्वतः conflict resolve

Conflict असल्यास:

1. स्वतः काही नको
2. Amol ला सोप्या भाषेत सांग
3. Amol च्या परवानगीनेच पुढे

मोबाईल → Codespace conflict:

```bash
git stash push -u -m "backup"
git pull --no-rebase --no-edit
git stash pop
# Conflict: git checkout --theirs <file> → git add <file> → git stash drop
```

---

१३. सध्याची स्थिती (नोव्हेंबर 2026)

· Stage 2 (Demo) — बहुतेक पूर्ण
· शेवटचा commit: ce900e2
· flutter analyze: 0 errors ✅
· APK: Build बाकी
· Warnings: ~२०८ (deprecated/unused — Stage 3 पर्यंत नको)

बाकी काम:

· Codespace मध्ये APK build
· Mobile वर सर्व screens test
· Codespace मध्ये APK build

---

१४. अजून वाचायच्या फाइल्स (या फाईल नंतर)

File काय
PROJECT_STATUS.md सविस्तर बदलांची नोंद
PROJECT_MAP.md प्रत्येक file काय करते
STAGE_3_FULL_PROMPT.md Stage 3 पूर्ण योजना

---

१५. मदत हवी असल्यास

· File नावं confusion: PROJECT_MAP.md बघ
· काय बदललं: PROJECT_STATUS.md बघ
· कसं बदलायचं: हे फाईल (AGENTS.md)
· भविष्य: STAGE_3_FULL_PROMPT.md

हे फाईल = AI साठी "संविधान". यात बदल केल्याशिवाय काहीही नियम मोडू नका.

```

---
