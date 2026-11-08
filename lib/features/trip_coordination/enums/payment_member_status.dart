import 'package:flutter/material.dart';
import 'package:hamsafar/core/enums/hs_badge_type.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
enum PaymentMemberStatus {
 pending(label:'در انتظار پرداخت',badgeType:HsBadgeType.warning,icon:LucideIcons.clock),
 underReview(label:'درحال بررسی',badgeType:HsBadgeType.info,icon:LucideIcons.hourglass),
 paid(label:'پرداخت شده',badgeType:HsBadgeType.success,icon:LucideIcons.creditCardCheck);
 final String label; final HsBadgeType badgeType; final IconData icon;
 const PaymentMemberStatus({required this.label,required this.badgeType,required this.icon});
 static PaymentMemberStatus fromValue(String? value)=>switch(value){'paid'=>paid,'under_review'=>underReview,_=>pending};
}