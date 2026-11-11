# نتیجه مرحلهٔ Trip Coordination State — 2026-11-12

## Tasks

- `TripTasksBloc` با Eventهای load/save/delete/complete ساخته شد.
- state شامل دادهٔ task context، شناسه کاربر جاری، loading، busy، خطا و feedback است.
- دریافت شناسه کاربر و task context در Bloc انجام می‌شود.
- mutationها پس از اجرای UseCase، task context را refresh می‌کنند.
- اگر mutation موفق ولی refresh ناموفق باشد، UI موفقیت عملیات و شکست بازخوانی را از هم تفکیک می‌کند.
- `TripTasksPage` از StatefulWidget به StatelessWidget تبدیل شد؛ form bottom sheet و controller آن به‌عنوان state صرفاً نمایشی/ورودی باقی ماند.
- نقش لیدر، مالکیت task برای completion و شرط بسته بودن عضوگیری در UI حفظ شد؛ authorization نهایی همچنان سمت backend است.

## Budget / Payments

- `TripBudgetBloc` با Eventهای load، submit payment و confirm payment ساخته شد.
- state شامل بودجه، loading، busy، خطا و feedback است.
- ثبت و تأیید پرداخت و refresh بودجه در Bloc انجام می‌شود.
- `TripBudgetPage` به StatelessWidget تبدیل شد؛ TextEditingController و انتخاب روش پرداخت در bottom sheet محلی باقی ماندند.
- نقش لیدر و وضعیت پرداخت برای نمایش/غیرفعال‌سازی actionها حفظ شد؛ RLS/RPC backend مرجع نهایی مجوز است.

## DI و lifecycle

- دو Bloc با `registerFactory` ثبت شدند.
- routeهای `/trip-tasks` و `/trip-budget` هرکدام Bloc مخصوص همان route را می‌سازند و با خروج از route dispose می‌کنند.
- صفحه‌ها دیگر مجموعه‌ای از UseCaseها را در constructor دریافت و مستقیماً اجرا نمی‌کنند.

## تست‌ها

تست‌های Bloc برای بارگذاری و ذخیره task، بارگذاری/ثبت پرداخت و تأیید پرداخت اضافه شدند.

## محدودیت اجرا

Flutter/Dart CLI در محیط عامل در دسترس نیست؛ بنابراین تست‌ها در این مرحله نوشته و از نظر ساختار بازبینی شده‌اند، اما اجرا نشده‌اند. اجرای `dart format`, `flutter analyze` و `flutter test` در محیط Flutter محلی/CI پیش از merge لازم است.

هیچ تغییر SQL یا backend در این مرحله انجام نشده است.
