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

