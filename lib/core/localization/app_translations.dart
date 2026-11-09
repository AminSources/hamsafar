import 'package:flutter/widgets.dart';

class AppTranslations {
  AppTranslations._();

  static const Map<String, String> _english = {
    'خانه': 'Home',
    'سفرها': 'Trips',
    'دوستان': 'Friends',
    'پروفایل': 'Profile',
    'پروفایل من': 'My profile',
    'تنظیمات': 'Settings',
    'تنظیمات برنامه': 'App settings',
    'زبان برنامه': 'App language',
    'فارسی': 'Persian',
    'انگلیسی': 'English',
    'حالت تم': 'Theme mode',
    'انتخاب زبان': 'Choose language',
    'انتخاب حالت تم': 'Choose theme mode',
    'پیشفرض سیستم': 'System default',
    'روشن': 'Light',
    'تیره': 'Dark',
    'رنگ تم': 'Theme color',
    'پیشفرض': 'Default',
    'حساب کاربری و پشتیبانی': 'Account & support',
    'گزارش باگ': 'Report a bug',
    'گزارش باگ و تماس': 'Bug report & contact',
    'تماس با ما': 'Contact us',
    'تنظیمات حساب کاربری': 'Account settings',
    'خروج از حساب کاربری': 'Log out',
    'روزهای آزاد من': 'My availability',
    'انتخاب نشده': 'Not selected',
    'وسایل من': 'My items',
    'ذخیره تغییرات': 'Save changes',
    'لغو': 'Cancel',
    'تأیید': 'Confirm',
    'بازگشت': 'Back',
    'افزودن': 'Add',
    'ویرایش': 'Edit',
    'حذف': 'Delete',
    'جستجو': 'Search',
    'تلاش دوباره': 'Try again',
    'سفر خوبی داشته باشی!': 'Have a great trip!',
    'آماده‌ی سفر بعدی هستی؟': 'Ready for your next trip?',
    'سفر شما در حال اجراست': 'Your trip is in progress',
    'سفر فعلی': 'Current trip',
    'جزئیات کامل': 'View details',
    'فعالیت‌های اخیر': 'Recent activity',
    'شما هنوز عضو سفری نشده اید': 'You have not joined a trip yet',
    'برای عضویت یا ساخت سفر جدید به بخش سفرها مراجعه کنید':
        'Go to Trips to join or create a new trip',
    'اطلاعات صفحهٔ خانه هنوز بارگذاری نشده است.':
        'Home page data has not loaded yet.',
    'دریافت اطلاعات ناموفق بود': 'Could not load information',
    'روزهای هفته': 'Days of the week',
    'بازه زمانی': 'Time range',
    'از ساعت': 'From',
    'تا ساعت': 'To',
    'ذخیره': 'Save',
    'روزهای آزاد شما در پروفایلتان به دوستان نمایش داده می‌شود و لیدر هنگام برنامه‌ریزی سفر آن‌ها را در نظر می‌گیرد.':
        'Your availability is visible to friends and is considered by the trip leader when planning a trip.',
    'روزها و ساعت آزاد با موفقیت ذخیره شد':
        'Availability and time range saved successfully',
    'ساعت پایان باید بعد از ساعت شروع باشد':
        'The end time must be after the start time',
    'انتخاب آواتار': 'Choose an avatar',
    'ویرایش پروفایل': 'Edit profile',
    'پروفایل با موفقیت به‌روزرسانی شد':
        'Profile updated successfully',
    'روزهای آزاد هفته‌ات را انتخاب کن تا هماهنگی زمان سفرها راحت‌تر انجام شود.':
        'Choose your available days to make trip planning easier.',
    'نام': 'First name',
    'نام خانوادگی': 'Last name',
    'نام کاربری': 'Username',
    'بیوگرافی': 'Bio',
    'ادامه': 'Continue',
    'ورود': 'Log in',
    'ثبت‌نام': 'Sign up',
    'رمز عبور': 'Password',
    'تکرار رمز عبور': 'Confirm password',
    'ایمیل': 'Email',
    'فراموشی رمز عبور': 'Forgot password',
    'ساخت سفر': 'Create trip',
    'ساخت سفر جدید': 'Create a new trip',
    'جزئیات سفر': 'Trip details',
    'اعضای سفر': 'Trip members',
    'قوانین سفر': 'Trip rules',
    'برنامه سفر': 'Trip schedule',
    'هزینه‌های سفر': 'Trip expenses',
    'مدیریت سفر': 'Manage trip',
    'پیوستن به سفر': 'Join trip',
    'خروج از سفر': 'Leave trip',
    'دعوت از دوستان': 'Invite friends',
    'افزودن عضو': 'Add member',
    'حذف عضو': 'Remove member',
    'رأی‌گیری': 'Poll',
    'بودجه سفر': 'Trip budget',
    'وظایف سفر': 'Trip tasks',
    'دوستان من': 'My friends',
    'درخواست‌های دوستی': 'Friend requests',
    'درخواست‌های دریافتی': 'Received requests',
    'درخواست‌های ارسالی': 'Sent requests',
    'افزودن دوست': 'Add friend',
    'حذف دوست': 'Remove friend',
    'پذیرفتن': 'Accept',
    'رد کردن': 'Reject',
    'در انتظار': 'Pending',
    'ارسال درخواست': 'Send request',
    'هیچ موردی یافت نشد': 'No results found',
    'بارگذاری اطلاعات ناموفق بود': 'Failed to load data',
    'خطایی رخ داده است': 'Something went wrong',
    'ذخیره با موفقیت انجام شد': 'Saved successfully',
    'عملیات ناموفق بود': 'The operation failed',
    'مورد': 'item',
    'عضو': 'member',
    'اعضا': 'members',
    'نفر': 'people',
    'ساعت': 'Time',
    'تاریخ': 'Date',
    'مقصد': 'Destination',
    'مبدا': 'Origin',
    'توضیحات': 'Description',
    'توضیحات اختیاری': 'Optional description',
    'عنوان': 'Title',
    'نام سفر': 'Trip name',
    'جستجوی سفر': 'Search trips',
    'فیلتر': 'Filter',
    'اعمال': 'Apply',
    'پاک کردن': 'Clear',
    'تأیید و ادامه': 'Confirm and continue',
    'مرحله بعد': 'Next step',
    'مرحله قبل': 'Previous step',
    'نوع مشکل': 'Issue type',
    'موضوع': 'Subject',
    'توضیحات مشکل را با جزئیات بنویسید...':
        'Describe the issue in detail...',
    'ارسال گزارش': 'Submit report',
    'بازخورد شما به بهتر شدن همسفر کمک می‌کند 💚':
        'Your feedback helps make Hamsafar better 💚',
  };

  static String translate(BuildContext context, String value) {
    if (Localizations.localeOf(context).languageCode != 'en') {
      return value;
    }

    final exact = _english[value];
    if (exact != null) return exact;

    final normalized = _normalizeDigits(value);
    final itemCount = RegExp(r'^(\d+)\s+مورد$').firstMatch(normalized);
    if (itemCount != null) {
      final count = itemCount.group(1)!;
      return '$count ${count == "1" ? "item" : "items"}';
    }

    final memberCount = RegExp(r'^(\d+)\s+عضو$').firstMatch(normalized);
    if (memberCount != null) {
      final count = memberCount.group(1)!;
      return '$count ${count == "1" ? "member" : "members"}';
    }

    const weekdays = {
      'شنبه': 'Saturday',
      'یکشنبه': 'Sunday',
      'دوشنبه': 'Monday',
      'سه‌شنبه': 'Tuesday',
      'سه شنبه': 'Tuesday',
      'چهارشنبه': 'Wednesday',
      'پنجشنبه': 'Thursday',
      'جمعه': 'Friday',
    };
    final singleDay = weekdays[value];
    if (singleDay != null) return singleDay;

    final dayParts = value.split('،').map((day) => day.trim()).toList();
    if (dayParts.length > 1 && dayParts.every(weekdays.containsKey)) {
      return dayParts.map((day) => weekdays[day]!).join(', ');
    }

    final greeting = RegExp(r'^سلام،?\s*(.+)! 👋$').firstMatch(value);
    if (greeting != null) return 'Hello, ${greeting.group(1)}! 👋';

    return value;
  }

  static String _normalizeDigits(String value) {
    const digits = {
      '۰': '0', '۱': '1', '۲': '2', '۳': '3', '۴': '4',
      '۵': '5', '۶': '6', '۷': '7', '۸': '8', '۹': '9',
      '٠': '0', '١': '1', '٢': '2', '٣': '3', '٤': '4',
      '٥': '5', '٦': '6', '٧': '7', '٨': '8', '٩': '9',
    };
    return value.replaceAllMapped(
      RegExp('[۰-۹٠-٩]'),
      (match) => digits[match.group(0)]!,
    );
  }
}
