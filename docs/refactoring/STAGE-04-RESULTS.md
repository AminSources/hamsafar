# نتیجه مرحلهٔ Domain/Data و کیفیت داده — 2026-11-12

## تغییرات

- `TripEntity.members` اکنون `List<TripMemberEntity>` است.
- `TripEntity.departureOptions` اکنون `List<TripDepartureOptionEntity>` است.
- JSON مربوط به اعضا و گزینه‌های حرکت فقط در مدل‌های Data parse می‌شود.
- کلیدهای واقعی member از RPC `get_trips` و migration استخراج شده‌اند: `id`, `first_name`, `last_name`, `username`, `avatar_icon`, `member_type`, `member_status`.
- فیلدهای واقعی گزینهٔ حرکت از جدول `trip_departure_options` استخراج شده‌اند: `id`, `starts_at`, `ends_at`.
- مصرف‌کنندگان TripEntity در route و صفحه جزئیات سفر به مدل typed مهاجرت کردند.
- فیلدهای اجباری RPC مانند `members`, `cost_items`, `rules`, `can_join` در صورت فقدان/نوع نامعتبر خطای parsing می‌دهند؛ خطا به empty list تبدیل نمی‌شود.
- نبود `departure_options` در پاسخ list/search مجاز است، چون این فیلد در RPC فهرست برگردانده نمی‌شود و فقط در details از DataSource تکمیل می‌شود.
- `getRecentActivities` دیگر خطا یا پاسخ نامعتبر را به فهرست خالی تبدیل نمی‌کند.
- log کامل response دوستان حذف شد تا داده‌های پروفایل در log چاپ نشوند.
- چهار درخواست مستقل membership status، membership closed، departure options و اطلاعات پرداخت لیدر در `TripsRepositoryImpl.getTripDetails` به‌صورت موازی اجرا می‌شوند.
- پیام‌های خطای Home به پیام امن و قابل‌فهم تبدیل شدند و جزئیات داخلی exception به UI نشت نمی‌کند.

## تست‌های اضافه‌شده

- mapping اعضا و گزینه‌های حرکت در `TripModel`
- رد JSON ناقص یا invalid برای member و departure option
- سازگاری avatar registry و fallback `tent`
- تست event-driven برای `TripDraftBloc`

تست پیش‌فرض Counter حذف شد؛ آن تست `MyApp` واقعی را بدون bootstrap و با فرض یک counter ناموجود اجرا می‌کرد.

## محدودیت راستی‌آزمایی

محیط عامل فاقد Flutter و Dart CLI است. در نتیجه فایل‌ها و تست‌ها از نظر منبع و قرارداد بازبینی شده‌اند، اما `dart format`, `flutter analyze`, `flutter test` یا build در این محیط اجرا نشده‌اند. اجرای این quality gateها در CI/local Flutter پیش از merge الزامی است.

هیچ SQL، migration، schema، RPC یا policy اجرا یا تغییر داده نشده است.
