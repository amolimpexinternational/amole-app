# AMOLE APP — PROJECT STATUS & AI DEVELOPMENT INSTRUCTIONS

## 1. PROJECT PURPOSE

This file is the main project-status and development-instruction document for the Amole Flutter application.

Any AI/developer who starts working on this project must read this file FIRST and understand the existing project before changing code.

The project is a multi-role local commerce/social/advertising application with:
- Buyer
- Seller
- Franchise
- Channel Partner
- Admin

The application is currently being developed and tested primarily as a DEMO using dummy/mock/local data.

---

# 2. IMPORTANT INSTRUCTIONS FOR AI / DEVELOPERS

## 2.1 Understand the existing project first

Before writing or changing code:
1. Read this file.
2. Inspect the existing relevant files.
3. Understand the existing screen, navigation, widgets, models and data.
4. Check whether the requested functionality already exists.
5. Do NOT recreate an existing screen or feature.
6. Do NOT duplicate existing navigation/routes/widgets.
7. Do NOT overwrite existing working functionality unnecessarily.
8. Preserve existing folder structure and naming conventions.

If existing code must be changed, explain WHY before making the change.

## 2.2 User is new to coding

The user is relatively new to software development.

Therefore AI must:
- Explain technical work in simple language.
- Do not assume the user understands programming terminology.
- Before making a significant change, briefly explain:
  - what will be changed,
  - which file(s) will be changed,
  - why the change is needed,
  - what the user should test.
- Give exact copy-paste terminal commands when a terminal command is required.
- Prefer one command at a time when possible.
- After the user runs/tests something, wait for the result before moving to the next step.
- Do not give unnecessarily long or risky terminal commands.
- Avoid commands that may hang or produce uncontrolled large output.

## 2.3 User controls the requested changes

The user will describe the improvements/corrections they want.

AI should implement the requested change while preserving the rest of the application.

If there are multiple possible approaches, explain them briefly and let the user understand what is being changed.

Do not independently redesign unrelated parts of the application.

---

# 3. CURRENT DEVELOPMENT STRATEGY

The development is intentionally divided into stages.

## STAGE 1 — UI / SCREEN DEVELOPMENT
Status: Largely completed

Most role-based screens have already been created.

## STAGE 2 — DEMO / NAVIGATION / USER FLOW
Status: In progress / being tested

The current priority is:

BUILD AND TEST THE COMPLETE DEMO APP USING DUMMY DATA.

The user will run the screens and identify:
- UI problems
- wrong navigation
- missing buttons/actions
- incorrect information
- layout problems
- workflow problems
- wording/text problems
- other corrections

AI should make those corrections according to the user's instructions.

## STAGE 3 — REAL BACKEND
Status: Pending

Only AFTER the demo application is satisfactorily completed and the user approves the demo should the project move to the backend stage.

Expected backend technologies/tasks include:
- Firebase Authentication
- Firestore
- Firebase Storage
- Firebase Cloud Messaging
- Real-time data
- Real transactions
- Real revenue calculations
- Real advertisements
- Real chat/notifications
- Other required production integrations

DO NOT prematurely replace all demo data with backend data unless the user specifically starts the backend stage.

---

# 4. CURRENT APP STRUCTURE

Main directories include:

lib/
  constants/
  data/
  models/
  screens/
  widgets/
  main.dart
  main_demo_franchise.dart

Role-based screen folders:

lib/screens/admin/
lib/screens/buyer/
lib/screens/channel_partner/
lib/screens/common/
lib/screens/franchise/
lib/screens/seller/
lib/screens/shared/

---

# 5. EXISTING SCREENS

## ADMIN

- admin_add_franchise_screen.dart
- admin_add_seller_screen.dart
- admin_approvals_screen.dart
- admin_buyer_list_screen.dart
- admin_channel_partners_screen.dart
- admin_create_ad_screen.dart
- admin_edit_ad_screen.dart
- admin_edit_profile_screen.dart
- admin_entity_transactions_screen.dart
- admin_franchise_list_screen.dart
- admin_home_screen.dart
- admin_live_ads_screen.dart
- admin_notification_screen.dart
- admin_profile_screen.dart
- admin_revenue_screen.dart
- admin_seller_list_screen.dart
- admin_send_notification_screen.dart
- admin_settlement_screen.dart
- admin_subadmin_screen.dart
- admin_view_dashboard_screen.dart
- admin_viral_posts_screen.dart
- admin_wallet_screen.dart

## BUYER

- all_categories_screen.dart
- buyer_home_screen.dart
- buyer_notification_screen.dart
- buyer_profile_screen.dart
- buyer_search_screen.dart
- cart_screen.dart
- coming_soon_screen.dart
- lucky_draw_screen.dart
- my_wall_screen.dart
- new_post_screen.dart
- order_tracking_screen.dart
- pincode_shops_screen.dart
- product_detail_screen.dart
- qr_payment_screen.dart
- referred_users_screen.dart
- reward_wallet_screen.dart
- seller_profile_screen.dart

## CHANNEL PARTNER

- add_franchise_screen.dart
- channel_partner_home_screen.dart
- cp_ads_screen.dart
- cp_approvals_screen.dart
- cp_buyer_screen.dart
- cp_create_ad_screen.dart
- cp_franchise_screen.dart
- cp_notification_screen.dart
- cp_profile_screen.dart
- cp_revenue_screen.dart
- cp_seller_revenue_screen.dart
- cp_seller_screen.dart

## FRANCHISE

- franchise_ad_screen.dart
- franchise_add_seller_screen.dart
- franchise_buyer_list_screen.dart
- franchise_create_ad_screen.dart
- franchise_home_screen.dart
- franchise_kyc_screen.dart
- franchise_notification_screen.dart
- franchise_profile_screen.dart
- franchise_revenue_screen.dart
- franchise_seller_list_screen.dart
- franchise_seller_profile_screen.dart
- franchise_wallet_screen.dart

## SELLER

- add_product_screen.dart
- customer_orders_screen.dart
- edit_product_screen.dart
- my_shopping_screen.dart
- seller_advertisement_screen.dart
- seller_advertisements_screen.dart
- seller_analytics_screen.dart
- seller_community_screen.dart
- seller_customer_profile_screen.dart
- seller_discount_offer_screen.dart
- seller_home_screen.dart
- seller_loyalty_setup_screen.dart
- seller_notification_screen.dart
- seller_orders_screen.dart
- seller_products_screen.dart
- seller_profile_detail_screen.dart
- seller_qr_screen.dart
- seller_revenue_detail_screen.dart
- seller_subscription_screen.dart
- seller_support_screen.dart
- stock_management_screen.dart
- registration/seller_registration_screen.dart

## COMMON

- contact_screen.dart
- language_screen.dart
- mobile_number_screen.dart
- notification_screen.dart
- otp_screen.dart
- role_selection_screen.dart
- splash_screen.dart
- terms_screen.dart
- welcome_screen.dart

## SHARED

- chat_screen.dart

---

# 6. EXISTING DATA / MODELS

Important existing data files:

- lib/data/ads_data.dart
- lib/data/local_posts_data.dart
- lib/data/product_database.dart
- lib/data/transactions_data.dart

Important existing models:

- ad_model.dart
- business_profile_model.dart
- notification_model.dart
- product_model.dart
- seller_model.dart
- subscription_model.dart
- transaction_model.dart

Existing shared widgets include:
- ad_feed_widget.dart
- notification_list_view.dart

---

# 7. IMPORTANT EXISTING NAVIGATION

The application already contains extensive navigation between existing screens.

Examples:

COMMON FLOW:
Splash -> Welcome -> Language -> Mobile Number -> OTP -> Role Selection -> Terms/Contact -> Role Home

BUYER FLOW includes:
- Search
- Categories
- Pincode shops
- Product detail
- Cart
- Order tracking
- Notifications
- Profile
- Reward wallet
- Lucky draw
- Referrals
- My Wall
- QR payment
- Seller profile

SELLER FLOW includes:
- Products
- Add/Edit product
- Stock management
- Orders
- Customer profiles
- Revenue
- Advertisements
- Subscription
- Notifications
- Profile
- Analytics
- Community
- Loyalty
- Discounts
- QR
- Support

FRANCHISE FLOW includes:
- KYC
- Sellers
- Buyers
- Revenue
- Wallet
- Advertisements
- Notifications
- Profile
- Add seller

CHANNEL PARTNER FLOW includes:
- Sellers
- Buyers
- Franchises
- Advertisements
- Approvals
- Revenue
- Notifications
- Profile

ADMIN FLOW includes:
- Wallet
- Approvals
- Channel partners
- Franchises
- Sellers
- Buyers
- Revenue
- Live ads
- Viral posts
- Settlement
- Notifications
- Profile
- Dashboard
- Sub-admin
- Entity transactions

IMPORTANT:
Existing navigation must be preserved unless the user specifically asks for a navigation change.

---

# 8. DEMO / DUMMY DATA

The application is currently being tested with demo/mock/local data.

Known demo areas:

- main_demo_franchise.dart
- seller advertisement photo selection
- buyer lucky draw winners
- franchise profile avatar
- franchise revenue calculation

Example:
franchise_revenue_screen.dart currently uses a demo calculation:
mockRangeEarning = days * 610

This is intentional demo behavior and should NOT be treated as real financial/business data.

During the current demo stage:
- Keep dummy data working.
- Use existing dummy data where appropriate.
- Do not unnecessarily replace dummy data.
- The user will report corrections after testing.
- Fix the reported demo issues first.

---

# 9. BACKEND TODO / PENDING WORK

Backend integration is largely pending.

## DATA

- ads_data.dart -> Firestore advertisements
- transactions_data.dart -> Firestore transactions
- local_posts_data.dart -> Firestore wall_posts

## CHANNEL PARTNER

- Profile camera/gallery upload -> Firebase Storage
- Seller revenue -> real Firestore aggregation
- Advertisement approvals -> Firestore
- Advertisement reject/live status -> Firestore
- Seller/franchise approval data -> Firestore
- Create advertisement -> Storage + Firestore

## SELLER

- Customer purchase history -> Firestore
- Seller discount offers -> Firestore seller_offers
- Advertisement uploads -> Firebase Storage
- Other real seller data integrations

## ADMIN

- Send notification -> Firestore + Firebase Cloud Messaging
- Add seller -> Firestore
- Add franchise -> Firestore
- Add channel partner -> Firestore
- Wallet -> company_ledger
- Notifications -> admin_notifications
- Create/edit advertisements -> Firestore + Storage
- Sub-admin -> Firestore
- Dashboard -> Firestore
- Viral post delete -> Firestore

## BUYER

- New post -> Firebase Storage + Firestore
- All categories/seller query -> Firestore
- Other real buyer data integrations

## FRANCHISE

- Profile photo -> Firebase Storage
- Advertisement edit -> Firestore
- Seller list -> Firestore
- Add seller -> Firestore
- Revenue -> real Firestore
- Advertisement media upload -> Firebase Storage
- Video duration validation

## SHARED

- Chat -> Firebase Cloud Messaging / Firestore
- Real VoIP integration -> future stage

---

# 10. CURRENT GIT / PROJECT HISTORY

Current branch:
main

Recent important commits:

1. 1f411a5
   Fix: remove extra padding around splash screen logo so it displays at full size

2. bb35669
   Restore Local Connect/Most Viral tabs in ad_feed_widget
   (These tabs had accidentally been overwritten by an old file on 30 Aug.)

These commits show that existing functionality can accidentally be overwritten, therefore AI must be particularly careful when modifying files.

---

# 11. CURRENT UNCOMMITTED CHANGES

At the time this status was created, Git showed changes involving:

- Android launcher icons
- assets/images/logo.png
- lib/screens/common/splash_screen.dart
- pubspec.yaml
- pubspec.lock
- Android drawable/mipmap resources
- values/colors.xml
- project_status.sh

These changes must NOT be blindly discarded or overwritten.

Before committing, inspect the changes and make sure the current splash/logo work is preserved.

---

# 12. KNOWN FLUTTER ANALYSIS WARNINGS

Previous flutter analyze output reported approximately 132 issues.

The output was mainly warnings/info such as:
- deprecated withOpacity
- unnecessary underscores
- unused variables
- deprecated activeColor
- deprecated value parameters

These are NOT currently the main development priority.

Do not perform a broad cleanup/refactor while working on an unrelated requested feature.

Only fix such warnings when:
- the user asks for cleanup, OR
- they directly prevent the requested functionality/build.

---

# 13. DEMO TESTING RULE

CURRENT PRIMARY GOAL:

Make the complete DEMO application satisfactory before starting backend development.

Testing cycle:

1. AI understands existing code.
2. AI explains proposed change.
3. AI makes only the requested change.
4. User runs the app.
5. User checks the relevant screen/workflow.
6. User reports problems/corrections.
7. AI fixes those reported problems.
8. Repeat until the demo is satisfactory.
9. Then move to the next demo feature/screen.
10. Only after the overall demo is satisfactory, begin backend integration.

The user's reported UI/demo corrections take priority over unnecessary redesign.

---

# 14. HOW AI SHOULD RESPOND TO NEW TASKS

For each new task:

### Step 1
Understand the request in simple terms.

### Step 2
Check existing relevant code.

### Step 3
Tell the user briefly:
- What already exists
- What needs changing
- Which files are involved
- What the change will do

### Step 4
Make the smallest appropriate code change.

### Step 5
Tell the user exactly how to test it.

### Step 6
Do not move to unrelated work until the user confirms the result.

### Step 7
After an important feature is confirmed working, update this PROJECT_STATUS.md with the completed work.

---

# 15. STATUS UPDATE RULE

This file should be treated as a living project document.

It should be updated when an important feature/screen/workflow is:
- completed,
- significantly changed,
- tested,
- approved,
- or intentionally postponed.

Do NOT fill this file with every tiny code change.

Git commits remain the detailed code history.

PROJECT_STATUS.md is the current project map for humans and AI.

---

# 16. BACKUP / CODESPACE SAFETY

The GitHub repository is the primary persistent source for the project code.

Important work must be committed and pushed to GitHub.

Do not rely only on files existing inside a Codespace.

Before ending a development session:
1. Check Git status.
2. Review important changes.
3. Commit completed work.
4. Push the commit to the remote repository.
5. Then the Codespace can safely be stopped when necessary.

If the user is going to be away from the Codespace for a long period, make sure all important work is committed and pushed first.

Do not assume a particular calendar date for the next session. The user may resume work at any later date.

When the user returns:
1. Open/resume the Codespace if available.
2. Run git status.
3. Run git pull if appropriate.
4. Read PROJECT_STATUS.md.
5. Continue from the documented current status.
6. Do not restart or recreate completed work.

---

# 17. CURRENT DEVELOPMENT PRIORITY

Priority order:

1. Complete and improve existing DEMO screens.
2. Test navigation and user flows.
3. Fix UI/functional issues reported by the user.
4. Ensure dummy data gives realistic demo behavior.
5. Complete all important demo workflows.
6. User approves the overall demo.
7. Only then begin Firebase/backend architecture and implementation.

DO NOT jump to Stage 3 simply because TODO comments exist.

---

# 18. GOLDEN RULE

The most important rule for this project:

READ FIRST.
UNDERSTAND EXISTING WORK.
EXPLAIN TO THE USER.
CHANGE ONLY WHAT IS REQUESTED.
PRESERVE EXISTING FUNCTIONALITY.
TEST WITH DUMMY DATA.
FIX USER-REPORTED DEMO ISSUES.
COMPLETE THE DEMO.
THEN MOVE TO BACKEND.


---

# 19. CURRENT DEMO STATUS — OCTOBER 2026

## Completed Buyer Demo Work

The following buyer demo functionality has been completed and pushed to GitHub:

- Buyer order history demo with dummy past orders.
- Buyer social profile demo.
- Buyer public social profile demo.
- Buyer search for products and buyers.
- Buyer favourites demo.
- Buyer cart demo with quantity controls and final amount summary.
- Product detail demo with quantity controls, favourite, add-to-cart and buy-now actions.
- Existing dummy product database and shared shopping data are being reused.
- Dedicated Global Shopping Home implemented with product search, categories, offers, product cards, cart and favourites.
- Global Shopping header includes a Home button that returns to the main Buyer Home screen.
- Four demo products (IDs 5-8) added to ProductDatabase; six active, in-stock products are available for the shopping grid.

Latest pushed commit:
- 254199a — Add buyer shopping and social demo updates

Current Git branch:
- main

Current remote:
- origin/main

## Next Planned Demo Work

Create a dedicated:

Global Shopping Home

This must be separate from the main Amole App Home.

Important navigation rule:

- Notification -> Home must continue to open the complete Amole App Buyer Home.
- Global Shopping -> Global Shopping Home must open a dedicated e-commerce shopping home.
- Global Shopping Home should show products directly on the main screen, along with shopping search, categories, offers/deals and other professional e-commerce elements.
- Do NOT copy Amazon's exact code, screen design or branding.
- Build an Amole-branded professional e-commerce experience inspired by common marketplace UX.
- Reuse the existing ProductDetailScreen, CartScreen, ProductDatabase and BuyerShoppingData wherever appropriate.
- Do not recreate existing product detail or cart functionality unnecessarily.

Global Shopping Home demo implementation is complete and has been tested by the user. Backend integration is not included.

## Update - Global Shopping header
- Global Shopping Home header compacted (padding, icon sizes, AMOLE font) - commit f788ffc, pushed.
- buyer_home_screen.dart was accidentally damaged in Codespace and restored from commit 8368d35. No code lost.

## Update - Buyer Home redesign
- Buyer Home redesigned (commit 207f33f): Search icon moved to header next to Cart, auto-sliding offers (offers_slider_widget.dart), 4x3 grid of 12 service icons (home_services_grid.dart), Gavatil Dukane banner and Lucky Draw below the grid, Nearby Sellers section removed.
- Local Connect and Most Viral tabs in ad_feed_widget.dart now slide left-right with full-height posts.
- Grid icons linked to ComingSoonScreen for now: Taxi, Services and Repair, Parcel Cargo, Resale or Rent, Jobs, Moms Miracle, Manufacturer. Grid icon colors are temporary, final colors pending from user.

## Update - Project map for AI
- AI/developers: after PROJECT_STATUS.md, also read PROJECT_MAP.md (auto-generated map of every Dart file). Regenerate it before committing with: python3 tools/make_map.py
- Note: firebase packages are listed in pubspec.yaml but Firebase is NOT initialized yet. Backend is still Stage 3.
- Seller list (PincodeShopsScreen) now one continuous list ordered by buyer pincode, then taluka, then district, nearest first. Buyer location is a fixed demo value (411028, Haveli, Pune). Dummy shops only.
- Update (Oct 2026): Global Shopping Home: एका screen वर 6 products (2x3), अखंड फिरणारी यादी, प्रत्येक product वर - 1 + आणि Cart मध्ये टाका. File: global_shopping_home_screen.dart. Commit: Global Shopping 6 products grid. बाकी: ZatPat/Hotel Food/Mom's Miracle चा कापणारा मजकूर, Buyer Home चे offer tabs.

---

# 20. UPDATE — 20 OCTOBER 2026 (मोबाईल modules जोडले आणि जोडणी पूर्ण)

## 20.1 काय झाले
मोबाईलवरून GitHub app द्वारे नवीन Demo modules जोडले होते (HANDOFF प्रमाणे). Codespace मध्ये `flutter analyze` चालवून जोडणी पूर्ण केली. सर्व Demo/dummy डेटा आहे, Stage 3 नाही.

नवीन modules: ZatPat, Hotel Food, Kirana Mart (ZatPat screen चे दुसरे रूप), Taxi/Rikshaw, Services & Repair, Resale/Rent/Jobs, Parcel Cargo, Mom's Miracle, Delivery Boy.

## 20.2 दुरुस्त केलेले
- `lib/screens/seller/parcel_provider_screen.dart` आणि `service_provider_screen.dart` मोबाईलवर paste करताना अर्ध्यावर तुटल्या होत्या (build error). दोन्ही पूर्ण code ने बदलल्या. आता 676 आणि 626 ओळी, शेवट `}`.
- बाकी सर्व नवीन files पूर्ण आहेत (शेवटची ओळ तपासली).

## 20.3 HANDOFF चे बदल (सर्व पूर्ण, `flutter analyze` मध्ये error शून्य)
- **A:** `zatpat_home_screen.dart` ला पर्यायी `initialCategory` आणि `title` (Kirana Mart साठी).
- **B:** त्याच file मध्ये दुकानदाराचा ON/OFF (`ZatPatData.isOn`) आणि डिलिव्हरी चार्ज `DeliveryRates.chargeForKm`. जुना `_chargeForKm` function अजून file मध्ये आहे (वापरात नाही, काढला तरी चालेल).
- **C:** `lib/widgets/home_services_grid.dart` पूर्ण बदलली. 12 icon खऱ्या screens ला जोडले. फक्त Manufacturer आणि Farmers & Vegetable "Coming Soon" आहेत.
- **D:** `seller_registration_screen.dart` मध्ये category `RT` (रिक्षा / टॅक्सी सेवा) आणि `KD` (लहान मुले) जोडल्या.
- **E:** `CartScreen` ला पर्यायी `deliveryCharge` (डिफॉल्ट 0) आणि `orderTitle`. ZatPat/Hotel Food मधून उघडल्यास Cart मध्ये "डिलिव्हरी चार्ज" ओळ दिसते, ती Final Amount मध्ये जोडली जाते, आणि "ऑर्डर नक्की करा" ने `ZatPatOrderStatusScreen` उघडते (पर्यायी `title`, Hotel Food साठी "Hotel Food ऑर्डर"). इतर ठिकाणांहून (Global Shopping) Cart जुन्यासारखाच चालतो आणि जुना `OrderTrackingScreen` उघडतो.
- **F:** तिन्ही `_testMode` = `false` तपासले.

## 20.4 अजून बाकी
- **App चालवून तपासणी अजून झालेली नाही** (HANDOFF §5 ची यादी). ही सर्वात आधी करायची.
- रिक्षा सेलरच्या नोंदणीत वाहन आणि ड्रायव्हिंग लायसन्सची माहिती घेणारे फील्ड.
- निर्णय बाकी: जुना `order_tracking_screen.dart` आणि `ZatPatOrderStatusScreen` एकत्र करायचे का.
- Demo मर्यादा: Cart मधील डिलिव्हरी चार्ज Cart उघडतानाच काढला जातो. Cart मध्ये गेल्यावर वस्तू काढल्या तर तो बदलत नाही.
- `kids_demo_products.dart` खरे प्रॉडक्ट आल्यावर काढायची.
- `PROJECT_MAP.md` जुना आहे (17 ऑक्टोबर, 121 files). commit आधी `python3 tools/make_map.py` चालवायचे.

## 20.5 व्यवसाय निर्णय (Stage 3 साठी, आत्ता करू नका)
- **Global Shopping:** देशभर ऑर्डर पाठवण्यासाठी Shiprocket सारख्या शिपिंग कंपन्यांशी व्यावसायिक करार. त्यांचे शिपिंग शुल्क Stage 3 मध्ये येईल. स्थानिक डिलिव्हरी चार्ज Global Shopping ला लागू नाही.
- **ZatPat, Hotel Food, Kirana Mart:** स्थानिक डिलिव्हरी बॉय Amole वर सेलर म्हणून (category `DB`) जोडले जातील.
- Stage 3 ची बाकी यादी HANDOFF §7 प्रमाणेच आहे (tracelet लोकेशन, Firebase, Cashfree पेमेंट, शहरानुसार दर screens, Parcel चे मोठ्या वाहनांचे दर).

## 20.6 फॉलो-अप — 21 ऑक्टोबर 2026 (app चालवून तपासणी आणि दुरुस्त्या)

**तपासणीत सापडलेले कारण:** `lib/main.dart` ओळ 27 ते 31 मध्ये सामायिक theme मध्ये सर्व `ElevatedButton` ला `minimumSize: Size(double.infinity, 52)` आहे. म्हणून Row मध्ये ठेवलेले कोणतेही `ElevatedButton` पूर्ण रुंदी घेते आणि शेजारचा मजकूर अक्षरा-अक्षराने खाली मोडतो. theme बदलला नाही (इतर शेकडो ठिकाणी पूर्ण रुंदीची बटणे बरोबर आहेत). नियम: Row मध्ये `ElevatedButton` वापरल्यास त्याच्या `styleFrom` मध्ये `minimumSize: const Size(0, 44)` द्या.

**दुरुस्त केलेले (बटण रुंदी):**
- `zatpat_home_screen.dart` तळाचा "Cart बघा" बार (हाताने)
- `hotel_food_home_screen.dart` `_CartBar`, `moms_miracle_screen.dart` `_bottomBar`, `services_home_screen.dart` "संपर्क" बटण (`apply_buttons.py` स्क्रिप्टने)

**प्रयत्न करून परत घेतले:** `fix_global.py` (Global Shopping चे कार्ड बदलणारी स्क्रिप्ट) चालवल्यावर `_pick`, `_selectedQty`, `_changePick`, `_addSelected` आधीच file मध्ये असल्याने duplicate error आले. `git checkout -- lib/screens/buyer/global_shopping_home_screen.dart` ने file मूळ स्थितीत परत आणली. Global Shopping मध्ये +/− आधीपासून आहे. त्या स्क्रिप्टची गरज नाही, ती commit करायची नाही.

**ZatPat:** बटण दुरुस्तीनंतर screen वापरकर्त्याला योग्य वाटली (Kirana Mart ही त्याच screen चे रूप आहे).

## 20.7 अजून बाकी UI दुरुस्त्या (वापरकर्त्याने सांगितलेल्या)
1. **Global Shopping:** प्रॉडक्ट कार्ड लहान करून एका ओळीत दोन दिसावेत, वर स्क्रोल करत पुढचे दिसावेत. कार्डवर "कार्ट मध्ये टाका" आणि +/− (किंमतही बदलावी). ही दुरुस्ती फक्त आकाराची आहे.
2. **Hotel Food (`HotelMenuScreen`), Mom's Miracle, Services च्या सेवा screens:** प्रॉडक्ट Global Shopping सारखे दिसावेत (फोटो, नाव, किंमत, कार्ट मध्ये टाका, +/− ने किंमत बदलणे). बार दुरुस्त झाल्यावर किती राहते ते तपासायचे, उरलेले screenshot पाहून करायचे. Mom's Miracle मध्ये कार्डची उंची `mainAxisExtent: 290` ठोक आहे.
3. **Services:** icon चा grid (`_categoryGrid`) खाली सरकवता यावा. तो `shrinkWrap` आणि `NeverScrollableScrollPhysics` सह आहे, म्हणून आजूबाजूची रचना (`build`, ओळ सुमारे 270 ते 340) वाचून ठरवायचे.
4. **Stage 3 साठी:** सेलर म्हणून नोंदणी केलेले सर्व सेवा प्रोव्हायडर आणि "डिलिव्हरी बॉय" सेवा Services मध्ये दिसणे. आत्ता Demo मध्ये Delivery Boy चा icon जोडता येईल, ते वापरकर्ता सांगेल तेव्हा.
