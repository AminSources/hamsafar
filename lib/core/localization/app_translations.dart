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
    'سفر های من': 'My trips',
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
    'پروفایل با موفقیت به‌روزرسانی شد': 'Profile updated successfully',
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
    'جستجوی سفر...': 'Search trips...',
    'فیلتر': 'Filter',
    'اعمال': 'Apply',
    'پاک کردن': 'Clear',
    'تأیید و ادامه': 'Confirm and continue',
    'مرحله بعد': 'Next step',
    'مرحله قبل': 'Previous step',
    'نوع مشکل': 'Issue type',
    'موضوع': 'Subject',
    'توضیحات مشکل را با جزئیات بنویسید...': 'Describe the issue in detail...',
    'ارسال گزارش': 'Submit report',
    'بازخورد شما به بهتر شدن همسفر کمک می‌کند 💚':
        'Your feedback helps make Hamsafar better 💚',
  };

  static const Map<String, String> _additionalEnglish = {
    // Home and activity feed
    'اطلاعات صفحهٔ خانه هنوز بارگذاری نشده است.':
        'Home page data has not loaded yet.',
    'شما هنوز عضو سفری نشده اید': "You have not joined a trip yet",
    'برای عضویت یا ساخت سفر جدید به بخش سفرها مراجعه کنید':
        'Go to Trips to join or create a new trip',
    'سفر فعلی': 'Current trip',
    'فعالیت‌های اخیر': 'Recent activity',
    'جزئیات کامل': 'View details',
    'مقصد مشخص نشده': 'Destination not set',
    'در حال آماده‌سازی': 'Preparing',
    'درحال آماده سازی': 'Preparing',
    'درحال آماده‌سازی': 'Preparing',
    'در حال سفر': 'On the trip',
    '🚗 در حال سفر': '🚗 On the trip',
    'شروع سفر': 'Trip starts',
    'در حال اجرا': 'In progress',
    'پایان‌یافته': 'Completed',
    'لغوشده': 'Cancelled',
    'نامشخص': 'Unknown',
    'هنوز فعالیتی برای این سفر ثبت نشده است.':
        'No activity has been recorded for this trip yet.',
    'لحظاتی پیش': 'Just now',
    'عضو سفر': 'Trip member',
    'وظیفه سفر': 'Trip task',
    'فعالیت جدیدی در سفر ثبت شد': 'A new trip activity was recorded',
    'عضوگیری سفر را بست': 'closed trip registration',
    'عضوگیری سفر را باز کرد': 'reopened trip registration',
    'پرداخت': 'payment',
    'تسویه پرداخت شد ✓': 'Payment settled ✓',
    'رأی‌گیری زمان حرکت': 'Departure time poll',
    'وظایف و مسئولیت‌های اعضا': 'Members’ tasks and responsibilities',
    'پرداخت سهم': 'Pay your share',

    // Friends
    'پروفایل دوست': "Friend's profile",
    'حذف دوست': 'Remove friend',
    'آیا مطمئن هستید که می‌خواهید این کاربر را از فهرست دوستان حذف کنید؟':
        'Are you sure you want to remove this user from your friends?',
    'انصراف': 'Cancel',
    'دریافتی': 'Received',
    'درخواست دریافتیِ در انتظاری ندارید.':
        'You have no pending incoming requests.',
    'درخواست‌های ارسالی': 'Sent requests',
    'درخواست ارسالیِ در انتظاری ندارید.': 'You have no pending sent requests.',
    'پس از پذیرفته شدن درخواست، دوست به لیست «دوستان من» اضافه می‌شود':
        'After the request is accepted, the person will be added to My Friends.',
    'برای بارگذاری دوباره، این بخش را مجدداً باز کنید.':
        'Reopen this section to load it again.',
    'جستجوی نام کاربری...': 'Search username...',
    'برای جستجو، حداقل دو حرف از نام کاربری را وارد کنید.':
        'Enter at least two letters of a username to search.',
    'کاربری با این نام کاربری پیدا نشد.': 'No user found with this username.',
    'شما هنوز دوستی ندارید': 'You do not have any friends yet',
    'از قسمت جستجوی دوستان، دوستان خود را پیدا کنید و به لیست دوستان خود اضافه کنید':
        'Find people using friend search and add them to your friends list.',
    'روزهای آزاد هفته': 'Weekly availability',
    'درباره من': 'About me',
    'پذیرفتن': 'Accept',
    'رد کردن': 'Reject',
    'در انتظار': 'Pending',
    'لغو درخواست': 'Cancel request',
    'درخواست ارسال شد': 'Request sent',
    'ارسال درخواست دوستی': 'Send friend request',
    'امتیاز': 'Rating',
    'تعداد سفرها': 'Number of trips',
    'تعداد سفر': 'Number of trips',
    'وسایل من': 'My items',
    'درخواست دوستی ارسال شد.': 'Friend request sent.',
    'درخواست دوستی پذیرفته شد.': 'Friend request accepted.',
    'درخواست دوستی رد شد.': 'Friend request rejected.',
    'درخواست ارسالی لغو شد.': 'Friend request cancelled.',
    'دوست از فهرست شما حذف شد.': 'Friend removed from your list.',
    'برای انجام این کار ابتدا وارد حساب خود شوید.':
        'Please log in to perform this action.',
    'شما از قبل با این کاربر دوست هستید.':
        'You are already friends with this user.',
    'این کاربر قبلاً برای شما درخواست فرستاده است.':
        'This user has already sent you a request.',
    'یک درخواست دوستی در انتظار پاسخ است.':
        'A friend request is already awaiting a response.',
    'این درخواست دیگر در انتظار پاسخ نیست.':
        'This request is no longer pending.',
    'کاربر انتخاب‌شده معتبر نیست.': 'The selected user is invalid.',
    'این کاربر دیگر در فهرست دوستان شما نیست.':
        'This user is no longer in your friends list.',
    'عملیات انجام نشد. لطفاً دوباره تلاش کنید.':
        'The operation failed. Please try again.',
    'امتیاز من': 'My rating',
    'دوستان': 'Friends',
    'مشاهده': 'View',

    // Profile and onboarding
    'پروفایلت رو کامل کن ✨': 'Complete your profile ✨',
    'این اطلاعات به دوستانت کمک می‌کند تو را پیدا کنند':
        'This information helps your friends find you.',
    'انتخاب آواتار': 'Choose avatar',
    'انتخاب آواتار': 'Choose avatar',
    'انتخاب': 'Select',
    'بستن': 'Close',
    'روزهای آزاد من': 'My availability',
    'انتخاب نشده': 'Not selected',
    'روزهای آزاد هفته‌ات را انتخاب کن تا هماهنگی زمان سفرها راحت‌تر انجام شود.':
        'Select your available days to make trip planning easier.',
    'روزهای آزاد شما در پروفایلتان به دوستان نمایش داده می‌شود و لیدر هنگام برنامه‌ریزی سفر آن‌ها را در نظر می‌گیرد.':
        'Your availability is visible to friends and considered by the trip leader when planning a trip.',
    'ساعت پایان باید بعد از ساعت شروع باشد':
        'The end time must be after the start time.',
    'روزها و ساعت آزاد با موفقیت ذخیره شد':
        'Availability days and hours saved successfully.',
    'ذخیره تغییرات ناموفق بود': 'Failed to save changes.',
    'دریافت اطلاعات ناموفق بود': 'Failed to load information.',
    'این وسیله در فهرست شما وجود دارد': 'This item is already in your list.',
    'فهرست وسایل با موفقیت ذخیره شد': 'Items list saved successfully.',
    'وسایلی که می‌توانید در سفرها همراه بیاورید؛ لیدر بر اساس این لیست وظایف را تقسیم می‌کند.':
        'Items you can bring on trips. The trip leader can assign tasks based on this list.',
    'هنوز وسیله‌ای اضافه نکرده‌اید': 'You have not added any items yet.',
    'افزودن وسیله جدید': 'Add a new item',
    'عنوان وسیله را وارد کنید': 'Enter an item name.',
    'عنوان وسیله': 'Item name',
    'مثلاً چراغ قوه': 'e.g. Flashlight',
    'نام الزامی است': 'First name is required.',
    'نام طولانی است': 'First name is too long.',
    'نام خانوادگی الزامی است': 'Last name is required.',
    'نام خانوادگی طولانی است': 'Last name is too long.',
    'نام کاربری الزامی است': 'Username is required.',
    'نام کاربری نباید فاصله داشته باشد': 'Username cannot contain spaces.',
    'نام کاربری': 'Username',
    'نام': 'First name',
    'نام خانوادگی': 'Last name',
    'چند خط درباره خودت و سبک سفر کردنت بنویس...':
        'Write a few lines about yourself and your travel style...',
    'کارکتر های بیش از حد مجاز': 'The text is too long.',
    'پروفایل با موفقیت به‌روزرسانی شد': 'Profile updated successfully.',
    'ویرایش پروفایل ناموفق بود': 'Failed to update profile.',
    'پروفایل ذخیره شد اما دریافت آن ناموفق بود':
        'Profile was saved, but could not be loaded.',
    'دریافت پروفایل ناموفق بود': 'Failed to load profile.',
    'روزهای هفته': 'Days of the week',
    'بازه زمانی': 'Time range',
    'از ساعت': 'From',
    'تا ساعت': 'To',
    'شنبه': 'Saturday',
    'یکشنبه': 'Sunday',
    'دوشنبه': 'Monday',
    'سه‌شنبه': 'Tuesday',
    'سه شنبه': 'Tuesday',
    'چهارشنبه': 'Wednesday',
    'پنجشنبه': 'Thursday',
    'پنج‌شنبه': 'Thursday',
    'جمعه': 'Friday',
    'شنبه، یکشنبه، دوشنبه، سه‌شنبه، چهارشنبه، پنجشنبه، جمعه':
        'Saturday, Sunday, Monday, Tuesday, Wednesday, Thursday, Friday',
    'شنبه، یکشنبه، دوشنبه، سه شنبه، چهارشنبه، پنجشنبه، جمعه':
        'Saturday, Sunday, Monday, Tuesday, Wednesday, Thursday, Friday',
    'تأیید شده': 'Approved',
    'در انتظار پرداخت': 'Awaiting payment',
    'درحال بررسی': 'Under review',
    'پرداخت شده': 'Paid',
    'لیدر': 'Leader',
    'عضو': 'Member',
    'دردسترس نیست': 'Not available',
    'اماده برای سفر': 'Ready for trip',

    // Authentication
    'خوش برگشتی! 👋': 'Welcome back! 👋',
    'برای ادامه هماهنگی سفرها وارد حسابت شو':
        'Log in to continue planning trips together.',
    'لطفا ایمیل خود را وارد کنید': 'Please enter your email.',
    'ایمیل نامعتبر است': 'The email address is invalid.',
    'لطفا گذرواژه خود را وارد کنید': 'Please enter your password.',
    'ارقام گذرواژه نمیتواند کمتر از 8 باشد':
        'The password must be at least 8 characters long.',
    'فراموشی رمز عبور؟': 'Forgot password?',
    'ورود به حساب': 'Log in',
    'یا': 'OR',
    'ورود با گوگل': 'Continue with Google',
    'حساب کاربری ندارید؟': "Don't have an account?",
    'ایجاد حساب': 'Create account',
    'بازیابی رمز عبور': 'Password recovery',
    'ایمیل خود را وارد کنید تا کد بازیابی رمز عبور برایتان ارسال شود.':
        'Enter your email and we will send you a password recovery code.',
    'ارسال کد بازیابی': 'Send recovery code',
    'بازگشت به صفحه ورود': 'Back to login',
    'ایجاد حساب کاربری': 'Create an account',
    'با ایمیل خودت در چند ثانیه ثبت‌نام کن':
        'Sign up in seconds using your email.',
    'تأیید رمز عبور': 'Confirm password',
    'گذرواژه صحیح نیست': 'The password does not match.',
    'شرایط استفاده': 'Terms of Use',
    ' و ': ' and ',
    'حریم خصوصی': 'Privacy Policy',
    ' همسفر را مطالعه کرده و می‌پذیرم.':
        ' I have read and agree to Hamsafar’s.',
    'ایجاد حساب با گوگل': 'Sign up with Google',
    'حساب کاربری دارید؟': 'Already have an account?',
    'وارد شوید': 'Log in',

    // Trip creation and details
    'جزئیات عمومی سفر': 'Trip overview',
    'تاریخ و ساعت سفر': 'Trip date and time',
    'هزینه و بودجه سفر': 'Trip costs and budget',
    'قوانین سفر': 'Trip rules',
    'دعوت اعضا از لیست دوستان': 'Invite friends',
    'نام سفر را وارد کنید.': 'Enter a trip name.',
    'مقصد سفر را وارد کنید.': 'Enter a trip destination.',
    'برای رأی‌گیری حداقل دو بازهٔ پیشنهادی ثبت کنید.':
        'Add at least two proposed time slots for the poll.',
    'پایان هر بازه باید بعد از شروع آن باشد.':
        'Each time slot must end after it starts.',
    'زمان برگشت باید بعد از زمان رفت باشد.':
        'The return time must be after the departure time.',
    'ذخیره سفر انجام نشد.': 'Could not save the trip.',
    'ایجاد سفر جدید': 'Create a new trip',
    'ویرایش سفر': 'Edit trip',
    'ایجاد سفر': 'Create trip',
    'ادامه': 'Continue',
    'نام سفر *': 'Trip name *',
    'مثلاً سفر جنگل‌گردی شمال': 'e.g. A forest trip in northern Iran',
    'توضیح کوتاه': 'Short description',
    'درباره برنامه و فعالیت‌های سفر بنویسید...':
        'Describe the trip plan and activities...',
    'مقصد *': 'Destination *',
    'شهر یا مقصد سفر': 'Trip city or destination',
    'محل تجمع': 'Meeting point',
    'آدرس یا محل قرار اعضا': 'Address or meeting place',
    'هزینه تخمینی کل (تومان)': 'Estimated total cost (toman)',
    'مثلاً ۲۷۰۰۰۰۰': 'e.g. 2,700,000',
    'هزینه تخمینی پس از مشخص شدن تعداد اعضا قابل تقسیم خواهد بود.':
        'The estimated cost can be split once the number of members is known.',
    'اطلاعات کارت برای دریافت سهم': 'Card details for collecting payments',
    'شماره کارت': 'Card number',
    'شماره کارت ۱۶ رقمی': '16-digit card number',
    'نام صاحب حساب': 'Account holder name',
    'اعضای سفر برای کارت‌به‌کارت از این اطلاعات استفاده می‌کنند. پرداخت نقدی به لیدر هم امکان‌پذیر است.':
        'Members can use these details for bank transfers. Cash payment to the leader is also possible.',
    'آیتم‌های هزینه': 'Expense items',
    'مثلاً اقامت، سوخت، خوراک': 'e.g. Accommodation, fuel, food',
    'جستجو در دوستان...': 'Search friends...',
    'لیست دوستان': 'Friends list',
    'دوستی برای نمایش پیدا نشد.': 'No friends found to display.',
    'دوستان انتخاب‌شده پس از ثبت سفر، دعوت‌نامهٔ عضویت دریافت می‌کنند. دعوت‌کردن اختیاری است.':
        'Selected friends will receive an invitation after the trip is created. Inviting friends is optional.',
    'قانون جدید را بنویسید...': 'Write a new rule...',
    'قوانین تعیین‌شده': 'Configured rules',
    'هنوز قانونی اضافه نشده است.': 'No rules have been added yet.',
    'حذف قانون': 'Delete rule',
    'قوانین برای همه اعضای سفر نمایش داده می‌شوند و پس از عضویت قابل مشاهده هستند.':
        'Trip rules are visible to all members after they join.',
    'زمان قطعی': 'Fixed schedule',
    'رأی‌گیری اعضا': 'Member poll',
    'زمان شروع و پایان سفر را دقیق مشخص کنید. این زمان پس از ایجاد سفر برای اعضا نمایش داده می‌شود.':
        'Set the exact trip start and end times. Members can view them after the trip is created.',
    'برای هر پیشنهاد، یک بازهٔ شروع و پایان انتخاب کنید. اعضای پذیرفته‌شدهٔ سفر در صفحهٔ خانه یکی از این بازه‌ها را انتخاب می‌کنند.':
        'Choose a start and end time for each option. Accepted trip members can vote for one of these options on the Home page.',
    'پیشنهاد': 'Option',
    'پایان بازه باید بعد از شروع آن باشد.':
        'The end of the time slot must be after its start.',
    'افزودن بازهٔ پیشنهادی': 'Add proposed time slot',
    'حداقل ۲ و حداکثر ۱۰ بازه می‌توانید ثبت کنید.':
        'You can add at least 2 and at most 10 time slots.',
    'سفر شما ایجاد شد! 🎉': 'Your trip has been created! 🎉',
    'اطلاعات سفر ذخیره شد. می‌توانید جزئیات آن را مشاهده و مدیریت کنید.':
        'Your trip details have been saved. You can view and manage the trip.',
    'مشاهده جزئیات سفر': 'View trip details',
    'رفتن به خانه': 'Go to Home',
    'دوستانی که انتخاب کرده‌اید، پس از ایجاد سفر دعوت‌نامه دریافت می‌کنند.':
        'The friends you selected will receive invitations after the trip is created.',
    'کد دعوت سفر': 'Trip invitation code',
    'درخواست کاربر مورد نظر پذیرفته شد': 'The selected user was accepted',
    'سفر': 'Trip',
    'سفرها': 'Trips',
    'جزئیات سفر': 'Trip details',
    'هنوز عضو سفری نیستید': 'You have not joined a trip yet',
    'می‌توانید یک سفر جدید ایجاد کنید یا سفرهای دیگران را جستجو کنید.':
        'You can create a new trip or search for trips created by others.',
    'جستجوی سفر': 'Search trips',
    'نام سفر یا مقصد را وارد کنید...': 'Enter a trip name or destination...',
    'سفری با این نام یا مقصد پیدا نشد.':
        'No trip found with this name or destination.',
    'در حال حاضر سفری برای نمایش وجود ندارد.':
        'There are currently no trips to display.',
    'برای مشاهده جزئیات هر سفر، روی آن بزنید.':
        'Select a trip to view its details.',
    'دعوت دوستان به سفر': 'Invite friends to the trip',
    'دوستی برای دعوت وجود ندارد.': 'There are no friends to invite.',
    'ارسال دعوت': 'Send invitation',
    'دعوت‌ها ارسال شدند.': 'Invitations sent.',
    'ارسال دعوت ناموفق بود.': 'Failed to send invitations.',
    'حذف سفر': 'Delete trip',
    'عضوگیری سفر بسته شد.': 'Trip registration has been closed.',
    'عضوگیری سفر دوباره باز شد.': 'Trip registration has been reopened.',
    'تغییر وضعیت عضوگیری انجام نشد.':
        'Could not change the registration status.',
    'وضعیت سفر به «درحال سفر» تغییر کرد.':
        'Trip status changed to "In progress".',
    'شروع سفر انجام نشد.': 'Could not start the trip.',
    'اطلاعات سفر در دسترس نیست.': 'Trip information is unavailable.',
    'شما در حال حاضر عضو سفر دیگری هستید. برای عضویت در این سفر، ابتدا باید از سفر فعلی خود خارج شوید.':
        'You are already a member of another trip. Leave your current trip before joining this one.',
    'وضعیت': 'Status',
    'درحال سفر': 'On the trip',
    'لیدر سفر': 'Trip leader',
    'تاریخ رفت': 'Departure date',
    'تاریخ برگشت': 'Return date',
    'بودجه': 'Budget',
    'زمان‌بندی': 'Schedule',
    'قطعی': 'Fixed',
    'قانونی برای این سفر ثبت نشده است.':
        'No rules have been added for this trip.',
    'اعضا': 'Members',
    'همه': 'All',
    'عضو پذیرفته‌شده': 'Accepted member',
    'اخراج عضو': 'Remove member',
    'اخراج': 'Remove',
    'دعوت‌های در انتظار': 'Pending invitations',
    'در انتظار پاسخ': 'Awaiting response',
    'لغو دعوت': 'Cancel invitation',
    'دعوت دوستان': 'Invite friends',
    'برای پیوستن به این سفر دعوت شده‌اید.':
        'You have been invited to join this trip.',
    'پذیرفتن دعوت': 'Accept invitation',
    'رد دعوت': 'Decline invitation',
    'خروج از سفر': 'Leave trip',
    'پیوستن به سفر': 'Join trip',
    'مشاهده وظایف سفر': 'View trip tasks',
    'در حال تغییر وضعیت...': 'Updating status...',
    'باز کردن عضوگیری': 'Reopen registration',
    'بستن عضوگیری': 'Close registration',
    'در حال شروع سفر...': 'Starting trip...',
    'آیا مطمئن هستید؟': 'Are you sure?',
    'تلاش دوباره': 'Try again',

    // Trip tasks, payments and voting
    'وظایف سفر': 'Trip tasks',
    'عضوگیری بسته شده است.': 'Registration is closed.',
    'برای مدیریت وظایف ابتدا عضوگیری را ببندید.':
        'Close registration before managing tasks.',
    'وظیفه انجام شده و دیگر قابل تغییر نیست.':
        'This task is completed and can no longer be changed.',
    'فقط لیدر سفر می‌تواند این عملیات را انجام دهد.':
        'Only the trip leader can perform this action.',
    'به اطلاعات وظایف این سفر دسترسی ندارید.':
        'You do not have access to this trip’s tasks.',
    'مسئول انتخاب‌شده دیگر عضو فعال سفر نیست.':
        'The selected assignee is no longer an active trip member.',
    'عملیات وظیفه انجام نشد. دوباره تلاش کنید.':
        'The task operation failed. Please try again.',
    'برای تخصیص وظیفه، عضو پذیرفته‌شده‌ای وجود ندارد.':
        'There are no accepted members to assign this task to.',
    'وظیفه اضافه شد.': 'Task added.',
    'وظیفه ویرایش شد.': 'Task updated.',
    'حذف وظیفه': 'Delete task',
    'حذف': 'Delete',
    'وظیفه حذف شد.': 'Task deleted.',
    'وظیفه به‌عنوان انجام‌شده ثبت شد.': 'Task marked as completed.',
    'افزودن وظیفه': 'Add task',
    'اطلاعات وظایف این سفر در دسترس نیست.':
        'Task information for this trip is unavailable.',
    'وظایف پس از بسته شدن عضوگیری فعال می‌شوند. در حال حاضر فقط می‌توانید وضعیت وظایف ثبت‌شده را مشاهده کنید.':
        'Tasks become available after registration closes. For now, you can only view existing task statuses.',
    'مدیریت لیدر': 'Leader controls',
    'هنوز وظیفه‌ای برای این سفر ثبت نشده است.':
        'No tasks have been added to this trip yet.',
    'هنوز وظیفه‌ای ثبت نشده است. بعد از بسته شدن عضوگیری، لیدر می‌تواند وظایف را تقسیم کند.':
        'No tasks have been added yet. The leader can assign tasks after registration closes.',
    'ویرایش وظیفه': 'Edit task',
    'ایجاد وظیفه': 'Create task',
    'عنوان وظیفه': 'Task title',
    'مثلاً رزرو اقامتگاه': 'e.g. Book accommodation',
    'مسئول انجام وظیفه': 'Assigned to',
    'مدیریت وظیفه': 'Manage task',
    'بودجه کل سفر': 'Total trip budget',
    'سهم هر نفر': 'Share per person',
    'دریافت‌شده': 'Received',
    'باقی‌مانده': 'Remaining',
    'رأی شما': 'Your vote',
    'رأی‌گیری': 'Poll',
    'دریافت اطلاعات بودجه انجام نشد.': 'Failed to load budget information.',
    'ثبت نشده': 'Not submitted',
    'پرداخت ثبت شد و در انتظار تأیید لیدر است.':
        'Payment submitted and awaiting leader approval.',
    'ثبت پرداخت انجام نشد. دوباره تلاش کنید.':
        'Payment submission failed. Please try again.',
    'پرداخت عضو تأیید شد.': 'Member payment approved.',
    'تأیید پرداخت انجام نشد.': 'Failed to approve payment.',
    'شماره پیگیری': 'Tracking number',
    'پرداخت نقدی': 'Cash payment',
    'تأیید پرداخت': 'Confirm payment',
    'پرداخت و بودجه': 'Payments and budget',
    'در حال حاضر سفر فعالی برای نمایش بودجه وجود ندارد.':
        'There is no active trip with a budget to display.',
    'تعداد اعضا': 'Number of members',
    'وضعیت شما': 'Your status',
    'پرداخت شما ثبت شده و در انتظار تأیید لیدر است.':
        'Your payment has been submitted and is awaiting leader approval.',
    'پرداخت‌های ثبت‌شده اعضا را بررسی و پس از دریافت وجه تأیید کنید.':
        'Review members’ submitted payments and confirm them after receiving the money.',
    'وضعیت پرداخت اعضا': 'Member payment status',
    'شماره پیگیری را وارد کنید.': 'Enter the tracking number.',
    'پرداخت سهم سفر': 'Pay trip share',
    'مبلغ سهم شما': 'Your share amount',
    'کارت‌به‌کارت': 'Bank transfer',
    'نقدی به لیدر': 'Cash to leader',
    'شماره پیگیری تراکنش': 'Transaction tracking number',
    'سهم خود را نقداً به لیدر تحویل دهید. پس از ثبت، پرداخت برای تأیید لیدر ارسال می‌شود.':
        'Pay your share in cash to the leader. After submission, the payment will be sent for approval.',
    'ثبت پرداخت برای بررسی': 'Submit payment for review',
    'زمان حرکت چه موقع باشد؟': 'When should we depart?',
    'برای این سفر هنوز بازه‌ای ثبت نشده است.':
        'No time slots have been added for this trip yet.',
    'ثبت رأی': 'Submit vote',
    'ثبت تغییر رأی': 'Update vote',
    'رأی شما ثبت شده است': 'Your vote has been submitted',
    'رأی‌گیری سفرها': 'Trip polls',
    'تلاش مجدد': 'Try again',
    'رأی‌گیری فعالی وجود ندارد.': 'There are no active polls.',
    'وقتی برای یکی از سفرهای شما رأی‌گیری زمان حرکت ایجاد شود، اینجا نمایش داده می‌شود.':
        'When a departure-time poll is created for one of your trips, it will appear here.',
    'برای هر سفر یکی از بازه‌های پیشنهادی را انتخاب کنید. بعد از ثبت رأی هم می‌توانید انتخاب خود را تغییر دهید.':
        'Choose one of the proposed time slots for each trip. You can change your vote after submitting it.',
    'رأی شما با موفقیت ثبت شد.': 'Your vote was submitted successfully.',
    'ثبت رأی انجام نشد. دوباره تلاش کنید.':
        'Could not submit your vote. Please try again.',

    // Bug report, splash and common
    'مشکل در ثبت تأیید پرداخت': 'Payment confirmation issue',
    'هنگام تأیید پرداخت عضو، برنامه پیام خطا نمایش می‌دهد و وضعیت پرداخت به‌روز نمی‌شود...':
        'When confirming a member payment, the app shows an error and the payment status is not updated...',
    'مالی': 'Financial',
    'فنی': 'Technical',
    'رابط کاربری': 'User interface',
    'سایر': 'Other',
    'گزارش باگ و تماس': 'Bug report and contact',
    'موضوع *': 'Subject *',
    'مثال: مشکل در ثبت تأیید پرداخت': 'Example: Payment confirmation issue',
    'توضیحات *': 'Description *',
    'توضیحات مشکل را با جزئیات بنویسید...': 'Describe the issue in detail...',
    'ایمیل (اختیاری)': 'Email (optional)',
    'نوع مشکل': 'Issue type',
    'ارسال گزارش': 'Submit report',
    'همسفر · نسخه ۱.۰.۰': 'Hamsafar · Version 1.0.0',
    'ساخته‌شده با 💚 برای سفرهای دوستانه':
        'Made with 💚 for trips with friends',
    'همسفر': 'Hamsafar',
    'سفرِ کوتاه، هماهنگیِ آسان': 'Short trips, easy planning',
    'نسخه ۱.۰.۰': 'Version 1.0.0',
    'تبریز، کوه عینالی': 'Tabriz, Eynali Mountain',
    '۳ روز مانده': '3 days left',
    'درحال اماده سازی': 'Preparing',
    'ساعت: ۱۸:۰۰': 'Time: 18:00',
    'اعضا: ۶ نفر': 'Members: 6',
    '۶ نفر': '6 people',
    'تومان': 'toman',
    'سفر کوهنوردی عینالی': 'Eynali Mountain Hiking Trip',
    '۱۷ اردیبهشت': '17 Ordibehesht',

    'دوستان من': 'My friends',
    'درخواست‌ها': 'Requests',
    'رای‌گیری': 'Poll',
    'رای گیری': 'Poll',
    'اعضای سفر': 'Trip members',
    'اعضای سفر (۶)': 'Trip members (6)',
    'حضور به‌موقع در محل تجمع (۱۵ دقیقه قبل از حرکت)':
        'Arrive at the meeting point on time (15 minutes before departure)',
    'لغو برنامه کمتر از ۴۸ ساعت قبل از سفر ممنوع است':
        'Cancelling less than 48 hours before the trip is not allowed',
    'تقسیم مساوی هزینه‌ها و احترام به طبیعت 🌱':
        'Share expenses equally and respect nature 🌱',
    '۴۵۰٬۰۰۰ تومان': '450,000 toman',

    // Dynamic business-rule errors and status labels
    'تایید شده': 'Approved',
    'برای انجام این عملیات وارد حساب خود شوید.':
        'Log in to perform this action.',
    'عضوگیری این سفر بسته شده است و امکان تغییر عضویت وجود ندارد.':
        'Registration for this trip is closed, so membership cannot be changed.',
    'پس از شروع سفر، امکان تغییر وضعیت عضوگیری وجود ندارد.':
        'Registration status cannot be changed after the trip starts.',
    'شما در حال حاضر عضو سفر دیگری هستید؛ ابتدا از سفر فعلی خارج شوید.':
        'You are already in another trip. Leave your current trip first.',
    'فقط می‌توانید دوستان خود را به سفر دعوت کنید.':
        'You can only invite people from your friends list.',
    'سفر پیدا نشد، قبلاً شروع شده یا اجازهٔ انجام این عملیات را ندارید.':
        'The trip was not found, has already started, or you are not allowed to perform this action.',
    'عملیات سفر انجام نشد. اتصال اینترنت و اطلاعات را بررسی کنید.':
        'The trip operation failed. Check your internet connection and try again.',
    'دریافت رأی‌گیری‌ها انجام نشد. اتصال اینترنت را بررسی کنید.':
        'Could not load polls. Check your internet connection.',

    'پاک کردن جستجو': 'Clear search',
    'سارا محمدی': 'Sara Mohammadi',
    'مهدی رضایی': 'Mehdi Rezaei',
    'نگار احمدی': 'Negar Ahmadi',
    'علی کریمی': 'Ali Karimi',
  };

  static String translate(BuildContext context, String value) {
    if (Localizations.localeOf(context).languageCode != 'en') {
      return value;
    }

    final exact = _english[value] ?? _additionalEnglish[value];
    if (exact != null) return exact;

    final requiredField = RegExp(r'^(.+) الزامی است$').firstMatch(value);
    if (requiredField != null) {
      final field = requiredField.group(1)!;
      final translatedField =
          _english[field] ?? _additionalEnglish[field] ?? field;
      return '$translatedField is required.';
    }

    final western = _normalizeDigits(value);
    final itemCount = RegExp(r'^(\d+)\s+مورد$').firstMatch(western);
    if (itemCount != null) {
      final count = itemCount.group(1)!;
      return '$count ${count == "1" ? "item" : "items"}';
    }

    final memberCount = RegExp(r'^(\d+)\s+عضو$').firstMatch(western);
    if (memberCount != null) {
      final count = memberCount.group(1)!;
      return '$count ${count == "1" ? "member" : "members"}';
    }

    final peopleCount = RegExp(r'^(\d+)\s+نفر$').firstMatch(western);
    if (peopleCount != null) return '${peopleCount.group(1)} people';

    final tripCount = RegExp(r'^(\d+)\s+سفر$').firstMatch(western);
    if (tripCount != null) {
      final count = tripCount.group(1)!;
      return '$count ${count == "1" ? "trip" : "trips"}';
    }

    final voteCount = RegExp(r'^(\d+)\s+رأی$').firstMatch(western);
    if (voteCount != null) {
      final count = voteCount.group(1)!;
      return '$count ${count == "1" ? "vote" : "votes"}';
    }

    final daysLeft = RegExp(r'^(\d+)\s+روز مانده$').firstMatch(western);
    if (daysLeft != null) return '${daysLeft.group(1)} days left';

    final minutesAgo = RegExp(r'^(\d+)\s+دقیقه پیش$').firstMatch(western);
    if (minutesAgo != null) {
      final count = minutesAgo.group(1)!;
      return '$count ${count == "1" ? "minute" : "minutes"} ago';
    }

    final hoursAgo = RegExp(r'^(\d+)\s+ساعت پیش$').firstMatch(western);
    if (hoursAgo != null) {
      final count = hoursAgo.group(1)!;
      return '$count ${count == "1" ? "hour" : "hours"} ago';
    }

    final daysAgo = RegExp(r'^(\d+)\s+روز پیش$').firstMatch(western);
    if (daysAgo != null) {
      final count = daysAgo.group(1)!;
      return '$count ${count == "1" ? "day" : "days"} ago';
    }

    const weekdays = {
      'شنبه': 'Saturday',
      'یکشنبه': 'Sunday',
      'دوشنبه': 'Monday',
      'سه‌شنبه': 'Tuesday',
      'سه شنبه': 'Tuesday',
      'چهارشنبه': 'Wednesday',
      'پنجشنبه': 'Thursday',
      'پنج‌شنبه': 'Thursday',
      'جمعه': 'Friday',
    };
    final singleDay = weekdays[value];
    if (singleDay != null) return singleDay;
    final dayParts = value.split('،').map((day) => day.trim()).toList();
    if (dayParts.length > 1 && dayParts.every(weekdays.containsKey)) {
      return dayParts.map((day) => weekdays[day]!).join(', ');
    }

    final startDate = RegExp(r'^شروع (.+)$').firstMatch(western);
    if (startDate != null) return 'Starts ${startDate.group(1)}';

    final sharedTrips = RegExp(
      r'^(\d+) سفر مشترک · امتیاز (.+)$',
    ).firstMatch(western);
    if (sharedTrips != null) {
      return '${sharedTrips.group(1)} shared trips · rating ${sharedTrips.group(2)}';
    }

    final memberHeader = RegExp(r'^اعضا \((\d+)\)$').firstMatch(western);
    if (memberHeader != null) return 'Members (${memberHeader.group(1)})';

    final tripMembers = RegExp(r'^اعضای سفر \((\d+)\)$').firstMatch(western);
    if (tripMembers != null) return 'Trip members (${tripMembers.group(1)})';

    final budget = RegExp(r'^بودجه کل: (.+) تومان$').firstMatch(western);
    if (budget != null) return 'Total budget: ${budget.group(1)} toman';

    final amountShare = RegExp(
      r'^مبلغ سهم شما: (.+) تومان$',
    ).firstMatch(western);
    if (amountShare != null) {
      return 'Your share amount: ${amountShare.group(1)} toman';
    }

    final share = RegExp(r'^سهم شما: (.+) تومان$').firstMatch(western);
    if (share != null) return 'Your share: ${share.group(1)} toman';

    final money = RegExp(r'^(.+?) تومان$').firstMatch(western);
    if (money != null) return '${money.group(1)} toman';

    final abbreviatedMoney = RegExp(r'^([0-9,]+)\s*ت$').firstMatch(western);
    if (abbreviatedMoney != null) {
      return '${abbreviatedMoney.group(1)} toman';
    }

    final membersCount = RegExp(r'^تعداد اعضا: (\d+) نفر$').firstMatch(western);
    if (membersCount != null) return 'Members: ${membersCount.group(1)}';

    final status = RegExp(r'^وضعیت شما: (.+)$').firstMatch(value);
    if (status != null) {
      final translatedStatus =
          _english[status.group(1)] ??
          _additionalEnglish[status.group(1)] ??
          status.group(1);
      return 'Your status: $translatedStatus';
    }

    final taskProgress = RegExp(
      r'^وضعیت وظایف: (\d+) از (\d+) انجام شده$',
    ).firstMatch(western);
    if (taskProgress != null) {
      return 'Tasks: ${taskProgress.group(1)} of ${taskProgress.group(2)} completed';
    }

    final range = RegExp(r'^(.+) تا (.+)$').firstMatch(western);
    if (range != null && !value.contains('ساعت')) {
      return '${range.group(1)} to ${range.group(2)}';
    }

    final removeTrip = RegExp(
      r'^سفر «(.+)» و اطلاعات وابسته به آن حذف شود؟$',
    ).firstMatch(value);
    if (removeTrip != null) {
      return 'Delete trip "${removeTrip.group(1)}" and its related data?';
    }

    final removeMember = RegExp(
      r'^آیا (.+) از سفر اخراج شود؟$',
    ).firstMatch(value);
    if (removeMember != null) {
      return 'Remove ${removeMember.group(1)} from the trip?';
    }

    final removeTask = RegExp(r'^وظیفه «(.+)» حذف شود؟$').firstMatch(value);
    if (removeTask != null) {
      return 'Delete task "${removeTask.group(1)}"?';
    }

    final tracking = RegExp(r'^شماره پیگیری: (.+)$').firstMatch(western);
    if (tracking != null) return 'Tracking number: ${tracking.group(1)}';

    final greeting = RegExp(r'^سلام،?\s*(.+)! 👋$').firstMatch(value);
    if (greeting != null) return 'Hello, ${greeting.group(1)}! 👋';

    return western.replaceAll('٬', ',');
  }

  static String _normalizeDigits(String value) {
    const digits = {
      '۰': '0',
      '۱': '1',
      '۲': '2',
      '۳': '3',
      '۴': '4',
      '۵': '5',
      '۶': '6',
      '۷': '7',
      '۸': '8',
      '۹': '9',
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };
    return value
        .replaceAllMapped(
          RegExp('[۰-۹٠-٩]'),
          (match) => digits[match.group(0)]!,
        )
        .replaceAll('٬', ',');
  }
}
