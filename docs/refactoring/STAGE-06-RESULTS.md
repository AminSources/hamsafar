# نتیجهٔ مراحل تکمیلی Refactor — 2026-11-12

## Authentication و Routing

- نبود نشست احراز هویت اکنون `DataSuccess<UserEntity?>(null)` است و از خطای واقعی parsing یا شبکه جدا شده است.
- پیام خطاهای sign-in و sign-up به پیام قابل نمایش نگاشت می‌شوند؛ raw exception در UI یا log چاپ نمی‌شود.
- وضعیت onboarding فقط پس از پاسخ موفق cache می‌شود و cache با تغییر auth state invalidate می‌شود.
- redirectهای async با generation counter کنترل می‌شوند تا پاسخ قدیمی redirect جدیدتر را overwrite نکند.
- خطای بررسی نشست یا onboarding به صفحهٔ retry می‌رود، نه login یا onboarding.
- آرگومان‌های route برای FriendEntity، TripEntity و tripId پیش از cast اعتبارسنجی می‌شوند.
- TripCreationWrapper شناسهٔ سفر ذخیره‌شده را به route قبلی برمی‌گرداند؛ route مستقیماً TripsBloc را صدا نمی‌زند.

## Trip Coordination

- رأی‌گیری زمان حرکت نیز از state محلی صفحه به `TripVoteBloc` انتقال یافته است.
- انتخاب گزینه، ثبت رأی، refresh و feedback در Bloc قرار دارند.
- Blocهای Tasks، Budget و Voting با `registerFactory` و provider مختص route ساخته می‌شوند.
- فرم‌های bottom sheet و controllerهای ورودی در UI باقی مانده‌اند؛ منطق درخواست و refresh در Bloc است.

## پروفایل و Queryهای مستقل

- queryهای مستقل profile، شمارش دوستان، availability و tools با `Future.wait` اجرا می‌شوند.
- queryهای مستقل profile preferences نیز موازی شده‌اند.
- فیلدهای `rate` و `trip_count` از update کلاینت حذف شده‌اند؛ این فیلدها باید server-owned باقی بمانند.
- خطای unique constraint نام کاربری به پیام اختصاصی نگاشت می‌شود؛ دیگر خطاها پیام عمومی و امن دارند.
- constructorهای Auth/Home/Profile DataSource با پارامتر عمومی `supabaseClient` با DI هماهنگ شده‌اند.

## بازبینی Supabase و امنیت

این بازبینی فقط با خواندن migrationهای مخزن و DataSourceها انجام شد؛ به Supabase متصل نشده‌ایم و هیچ SQL اجرا یا ویرایش نشده است.

- RPCهای مدیریت عضویت و وظایف از هویت `auth.uid()` استفاده می‌کنند.
- helperهای حساس به schema خصوصی منتقل شده‌اند و در functionهای حساس `search_path` محدود شده است.
- RPCهای availability و tools در migration مربوطه `SECURITY INVOKER` هستند و به RLS متکی‌اند.
- قراردادهای موجود friendship، membership، task و payment حفظ شده‌اند؛ تغییر schema و policy خارج از دامنهٔ این شاخه است.

این بررسی جایگزین audit مستقیم policyهای deploy شده در Supabase یا تست integration با حساب‌های متفاوت نیست.

## تست و CI

تست‌های این شاخه شامل mapping مدل سفر، avatar registry، TripDraftBloc، Tasks/Budget/Voting Blocs، AuthRouterNotifier و Blocs مربوط به navigation، settings، creation و trips است.

Workflow جدید `.github/workflows/flutter-ci.yml` این quality gateها را اجرا می‌کند:
1. `dart format --output=none --set-exit-if-changed lib test`
2. `flutter analyze`
3. `flutter test --reporter expanded`

فایل `.env.example` فقط placeholder دارد و CI آن را برای asset موردنیاز اپ به `.env` کپی می‌کند؛ کلید واقعی Supabase در Git قرار نمی‌گیرد.

## محدودیت اجرای محلی

محیط اجرای این refactor Flutter و Dart CLI نداشت؛ بنابراین format، analyzer، تست‌ها و build در همین محیط اجرا نشده‌اند. هیچ نتیجهٔ سبز برای این فرمان‌ها ادعا نمی‌شود. نتیجهٔ واقعی GitHub Actions باید پیش از merge بررسی شود.

## خارج از دامنه

- شاخهٔ `main` تغییر نکرده و این شاخه merge نشده است.
- هیچ migration، table، RLS، RPC یا داده‌ای در Supabase تغییر نکرده است.
- هیچ کلید service-role یا secret در Flutter یا مخزن اضافه نشده است.
