# AMOLE APP — COMPLETE HANDOFF FOR NEW AI (November 2026)

## ⚠️ हे सर्वात आधी वाच

हा document Amole App चा **संपूर्ण इतिहास** आहे. हे वाचल्यावर तुला **कुठेही विचारायची गरज नाही** — सर्व माहिती इथे आहे.

---

## १. USER — Amol (Amol Impex International)

- **नाव:** Amol
- **Coding:** नाही — complete beginner
- **Device:** Android mobile (GitHub app) + GitHub Codespaces (browser)
- **Laptop:** जुना Windows 7 — Codespace वापरतो
- **भाषा:** मराठी (कधी English terms)
- **Team:** Amol + 1 सहकारी

### **⚠️ कामाची पद्धत (STRICTLY पाळ):**

1. **मी (user) file चा कोड देतो** → तू बदल करून **पूर्ण कोड** देतोस → मी **copy-paste** करतो
2. **प्रत्येक बदलापूर्वी** — **थोडक्यात सांग** (कोणती file, का बदलणार) → **मी OK** म्हणाल तेव्हाच कोड
3. **एका वेळी एक बदल** — एकत्र नको
4. **`git add .` कधीही वापरू नको** — फक्त बदललेल्या files
5. **Codespace ची फ्री मासिक लिमिट** जपण्यासाठी — मोबाईलवरून code edit, Codespace फक्त test साठी
6. **मी नवीन आहे** — **अगदी सोप्या भाषेत** समजाव, **coding jargon नको**
7. **`--release` मध्ये `q` दाबल्यावर ॲप बंद होतं** — पण `q` शिवाय पुढचा कोड टाकता येत नाही — **`Ctrl+C` वापर** किंवा **नवीन terminal tab**

---

## २. PROJECT — Amole App

- **नाव:** Amole
- **कंपनी:** Amol Impex International
- **Tagline:** "माझा पैसा माझ्या खिशात, आपल्या लोकांचा आपला बाजार"
- **Website:** amole.in
- **GitHub:** amolimpexinternational/amole-app
- **Branch:** main
- **Platform:** Flutter (Dart) — Android first
- **Flutter SDK:** v3.47.1

### **काय आहे:**
Maharashtra-based **Local Social Commerce Super App** — JioMart + Paytm + Instagram + Rapido + Swiggy + Porter + Urban Company + IndiaMart + Matrimony सारखं — पण **100% local focus**.

### **६ User Roles:**
1. **Buyer** — ग्राहक
2. **Seller** (sub-types: Local/ZatPat, Global Shopping, Service Provider, Hotel, Cargo)
3. **Franchise** — एरिया, seller KYC (GPS visit, 72hrs)
4. **Channel Partner (CP)** — जिल्हा, multiple franchises
5. **Admin** — सुपर + सब-अॅडमिन
6. **Promoter** — buyer जो प्रमोटर होतो (mini-seller)

### **१२ मुख्य Modules (grid icons):**
Global Shopping, Taxi/Rikshaw, ZatPat, Hotel Food, Services & Repair, Parcel Cargo, Resale/Rent, Kirana Mart, Jobs, Mom's Miracle, Manufacturer, Farmers & Vegetable

### **विशेष Tabs:**
- **Top Offer Tab** (`OffersSliderWidget`) — सर्व स्क्रीनवर — seller/franchise/CP/admin ऑफर टाकतात
- **आठवडी बाजार** — दर शनिवारी ३-१२, CP/Admin क्रिएट करतात
- **Extra Income** — ६ पर्याय (प्रमोटर, जाहिराती, refer, delivery boy, आठवडी बाजार, seller onboard)
- **Lucky Draw** — ₹५ तिकीट, दररोज 4PM

---

## ३. BUSINESS RULES

- **Commission:** 10% कंपनी + 5% प्रमोटर (रिवॉर्ड पॉईंट्समध्ये)
- **Reward Points:** 1 pt = ₹1, 3 महिन्यांत expire
- **Settlement:** ऑर्डर return window (7 दिवस) संपल्यावर seller ला पेमेंट (Amazon सारखं)
- **पेमेंट:** संपूर्ण रक्कम **Amole कंपनीकडे** → 7 दिवसांनंतर seller ला
- **फ्री ऑफर:** Seller Discount Offer — फक्त त्याच्या जिल्ह्यात
- **पेड ऑफर (Top Offer):** Seller/Franchise/CP/Admin — **टार्गेटिंग** (राज्य/जिल्हा/तालुका multi-select)

---

## ४. TECH STACK

- **Frontend:** Flutter (Dart)
- **Auth:** Firebase Phone Auth (Stage 3 मध्ये)
- **Database:** Firestore (Stage 3)
- **Storage:** Firebase Storage / Cloudflare R2 (Stage 3)
- **Maps:** Mapbox (Stage 3 — Google पेक्षा स्वस्त)
- **Notifications:** FCM
- **जवळचे drivers:** GeoFlutterFire / Geohash
- **पेमेंट:** Cashfree / Razorpay (Stage 3)
- **जोडलेली packages:** shared_preferences, image_picker, file_picker, geolocator, **geocoding**, **url_launcher**, share_plus (13.3.1), cached_network_image, intl, flutter_svg, firebase_* (pubspec मध्ये पण initialize नाही)

### **⚠️ Stage 3 अजून सुरू नाही:**
- Firebase initialize नाही
- services/ folder नाही
- Data सध्या static in-memory (intentional)
- सर्व **Demo/dummy data**

---

## ५. PROJECT STRUCTURE
lib/
├── constants/ app_colors.dart, app_strings.dart
├── data/ ads, posts, products, transactions, listings, parcel,
│ ride_rates, services, zatpat, buyer_*, kids_demo
├── models/ ad, business_profile, notification, product,
│ seller, subscription, transaction
├── screens/
│ ├── admin/ (~22 screens + weekly_market_create_screen)
│ ├── buyer/ (~40 screens + promoter_kyc_screen)
│ ├── channel_partner/
│ ├── common/
│ ├── delivery/
│ ├── franchise/
│ ├── rider/
│ ├── seller/ (+ expenses_wallet_screen, registration/)
│ ├── shared/ (chat_screen + top_offer_create_screen
│ │ + weekly_market_catalog_screen)
│ └── user/
├── services/ (rider_stand_service.dart.bak — disabled)
├── widgets/ ad_feed, offers_slider, home_services_grid,
│ notification_list, seller_delivery_tiles
└── main.dart, main_demo_franchise.dart

---

## ६. COMPLETED CHANGES (सर्व पूर्ण + GitHub वर)

**शेवटचे commits:**
- `3903361` — ७ बदल पूर्ण
- `8965ff1` — Merge + HANDOFF + PROJECT_STATUS + gradle fix

### **७ मुख्य बदल:**
1. **Seller Dashboard** — आठवडी बाजार कार्ड **आडवं** (75 उंची, बायरसारखं) + **"वस्तू जोडा"** बटन → `WeeklyMarketCatalogScreen`
2. **Buyer "माझे मेसेज"** — **५ डमी सेलर मेसेज** + **"महत्त्वाचे नोटिफिकेशन"** टॅब + प्रत्येक मेसेजवर `onTap` → डिटेल बॉटम शीट
3. **प्रमोटर KYC** — `promoter_kyc_screen.dart` (आधार, पॅन, पत्ता — कंपल्सरी)
4. **प्रमोटर डॅशबोर्ड** — "प्रमोटर व्हा" → `PromoterKycScreen`; KYC यशस्वी → `isPromoter = true`
5. **प्रमोटर कॅटलॉग** — "माझा प्रमोटर कॅटलॉग" + उपलब्ध प्रॉडक्ट्स (max 50, फक्त "प्रमोशन ON")
6. **आठवडी बाजार कॅटलॉग** — `weekly_market_catalog_screen.dart` (shared) ON/OFF + प्रॉडक्ट जोडा; `weekly_market_create_screen.dart` (admin) तारीख/वेळ/परिसर
7. **क्रिएट टॉप ऑफर** — `top_offer_create_screen.dart` (shared) — फोटो (16:9), शीर्षक, माहिती, किंमत, लिंक, वैधता, **टार्गेटिंग** (राज्य/जिल्हा/तालुका multi-select); Seller/Franchise/CP/Admin — "क्रिएट टॉप ऑफर" KPI; Franchise/CP/Admin — "जाहिरात विभाग" KPI

### **नंतरचे बदल (commit 8965ff1 नंतर — कदाचित commit नाही):**
8. **Buyer notification bar** — २ रांगेत redesign (वर: AMOLE + cart/favourite/notification/profile; खाली: 245pts/ऑर्डर/शोधा)
9. **Buyer search** — "मित्र शोध" टॅब काढलं; "मित्र बनवा" बटण + `social` case काढलं
10. **Ride booking** — GPS बटन (`Geolocator`) + area नाव (`geocoding`) + Google Maps बटन (`url_launcher`)

---

## ७. PENDING CHANGES (बाकी — क्रमाने)

### **A. आत्ता सुरू असलेले:**
- **Parcel Cargo** — `parcel_booking_screen.dart` मध्ये GPS बटन + area नाव + Google Maps बटन (Ride सारखं)
- **Resale/Rent** — `listings_home_screen.dart` मध्ये उत्पादनावर क्लिक → माहिती स्क्रीन

### **B. Buyer स्क्रीन दुरुस्त्या:**
- **Cart** — क्लिक केल्यावर **रिकामी स्क्रीन** — cart items दिसत नाहीत
- **Global Shopping / ZatPat / Hotel Food / Kirana Mart / Mom's Miracle** — खालचा **"Cart बघा" बार + आडवा पट्टा** काढून **cart icon वर badge** (संख्या)
- **Top Offer Tab** — "Admin offer/Channel partner offer/Franchise offer" ऐवजी **ऑफरचं शीर्षक + फोटो**
- **Offer Detail Screen** — **प्रॉडक्ट खरेदी लिंक** (Global Shopping सारखी)
- **Product Detail** — "Cart मध्ये टाका" हिरवा (add झाल्यावर); "आत्ता खरेदी करा" → **नवीन `checkout_screen.dart`** (पेमेंट, डिलिव्हरी फी, Reward points)
- **Checkout** — फक्त ऑनलाइन (UPI/Card/NetBanking), Reward points (1pt=₹1), डिलिव्हरी फी Shiprocket सारखी

### **C. Stage 3 (नंतर):**
- Firebase initialize (Auth, Firestore, Storage, Functions)
- Cashfree पेमेंट (7 दिवसांनंतर settlement)
- tracelet (250m location — `.bak` केलेलं `rider_stand_service.dart` परत)
- Mapbox (नकाशा + directions)
- Shiprocket API (Global Shopping orders)
- खरे टार्गेटिंग (जिल्हा/तालुका/राज्य)
- Parcel Cargo — मोठ्या वाहनांचे दर

---

## ८. GIT SAFETY RULES (STRICTLY)

**कधीही करू नको:**
- ❌ `git reset --hard`
- ❌ `git revert`
- ❌ Branch मागे नेणे
- ❌ जुना commit checkout करणे
- ❌ नवीन development overwrite करणे
- ❌ `git add .`

**Conflict/diverge दिसल्यास:**
- स्वतःहून काहीही करू नको
- User ला सोप्या भाषेत सांग
- User च्या परवानगीनेच पुढे

**NEWER CODE कधीही OLDER CODE ने replace होऊ नये. हा सर्वोच्च नियम आहे.**

### **मोबाईलवरून code update केल्यावर Codespace मध्ये आणायची पद्धत:**

```bash
git status                                    # स्थिती बघ
git stash push -u -m "backup"                 # local बदल बाजूला
git pull --no-rebase --no-edit                # GitHub वरचे आण
git stash pop                                 # local बदल परत
# Conflict आल्यास:
git checkout --theirs <file1> <file2>         # GitHub वरची आवृत्ती ठेव
git add <file1> <file2>                       # conflict नाहीसे
git stash drop                                # stash काढ
git commit -m "..." && git push origin main
९. TERMINAL / CODESPACE RULES
लांब किंवा अनेक ओळींचे command — मोबाईलवर तुटते — एका ओळीचे छोटे commands वापर

मोठा code — Explorer मध्ये New File करून editor मध्ये paste करायला सांग, मग Save

मोठे output — | head -20 वापर; q दाबू नको (file मध्ये टाईप होतं)

Backup: cp file /tmp/file.bak

ॲप तपासायला: flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0 --release → Ports → 8080

--release मध्ये hot reload नाही — Ctrl+C करून पुन्हा चालव

q दाबल्यावर ॲप बंद होतं — पुढचा कोड टाकण्यासाठी Ctrl+C वापर किंवा नवीन terminal tab

APK: flutter build apk --release → build/app/outputs/flutter-apk/app-release.apk

android/gradle.properties: org.gradle.jvmargs=-Xmx2048m -XX:MaxMetaspaceSize=512m -XX:ReservedCodeCacheSize=256m -XX:+HeapDumpOnOutOfMemoryError (Codespace मध्ये 8G नको — daemon crash होतो)


१०. GOLDEN RULES
text
READ FIRST → UNDERSTAND → EXPLAIN → CHANGE ONLY WHAT USER REQUESTS → TEST → PUSH
फक्त User ने सांगितलेलेच बदल

Unrelated screens/widgets बदलू नको

नवीन screen बनवण्यापूर्वी existing तपास — Duplicate नको

Dummy data ला real backend ने replace करू नको (Stage 3 पर्यंत)

प्रत्येक बदलापूर्वी User ला सांग — कोणती file, का

जी file बदलायची ती आधी पूर्ण वाचा

flutter analyze — error नसल्यावरच commit (warning/info चालतात)

User ने test करून OK केल्यावरच commit

Commit आधी: python3 tools/make_map.py + PROJECT_STATUS.md update

प्रत्येक completed काम लगेच push — फक्त बदललेल्या files

११. CURRENT STATUS (November 2026)
Stage 2 (Demo) — बहुतेक पूर्ण

शेवटचा commit: 8965ff1

APK तयार: 61.7MB (मोबाईलवर install केलं)

flutter analyze: शून्य errors (शेवटच्या तपासणीत)

Pending: वर §7 मध्ये

१२. नवीन AI — पहिला संदेश
हे फाईल वाचल्यावर हे उत्तर दे:

१. "हे वाचलं. तुम्ही Amol, Amole App वर काम करता. ७ बदल पूर्ण, GitHub वर 8965ff1 वर. पुढचं काम: Parcel Cargo GPS + Resale/Rent product click."

२. "तुमची पद्धत समजली: file कोड → मी बदलून पूर्ण कोड → तुम्ही copy-paste. प्रत्येक बदलापूर्वी थोडक्यात सांगून OK मागेन. एका वेळी एक बदल."

३. "आता सांगा — कोणत्या file पासून सुरू करायचं?"

हे सर्व माहिती पुरेशी आहे. आता पुढे काम सुरू कर.

text

---

## ✅ **आता तू काय कर:**

1. **हा संपूर्ण मजकूर** — **`HANDOFF_NEW_AI.md`** फाईलमध्ये सेव्ह कर (GitHub वर)
2. **नवीन AI सोबत चॅट सुरू कर**
3. **हे ५ फाईल्स दे:**
   - `PROJECT_STATUS.md`
   - `PROJECT_MAP.md`
   - `HANDOFF.md` (जुनं)
   - **`HANDOFF_NEW_AI.md`** (नवीन — हा)
   - `AI_DEVELOPMENT_PROMPT_v3.1`
4. **पहिला संदेश:** *"हे ५ फाईल्स वाच. HANDOFF_NEW_AI.md मध्ये सर्व आहे. वाचल्यावर सांग तयार आहेस का."*

---

## ⚠️ **महत्त्वाचं:**

- **`HANDOFF_NEW_AI.md`** — **सर्वात महत्त्वाचं** — **संपूर्ण इतिहास** इथे आहे
- **`PROJECT_STATUS.md`** — **अपडेट कर** (§22 + नवीन बदल)
- **`PROJECT_MAP.md`** — **`python3 tools/make_map.py`** ने **पुन्हा बनव** (Codespace मध्ये)
- **Commit + Push** — **सर्व फाईल्स** GitHub वर

---
