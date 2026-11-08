import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamsafar/core/widgets/hs_app_bar.dart';
import 'package:hamsafar/core/widgets/hs_note.dart';
import 'package:hamsafar/features/trip_coordination/enums/payment_member_status.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TripBudgetPage extends StatefulWidget {
 const TripBudgetPage({super.key});
 @override State<TripBudgetPage> createState()=>_TripBudgetPageState();
}
class _TripBudgetPageState extends State<TripBudgetPage>{
 final _client=Supabase.instance.client;
 Map<String,dynamic>? _budget;
 bool _loading=true,_busy=false;
 @override void initState(){super.initState();_load();}
 Future<void> _load() async {
  if(mounted)setState(()=>_loading=true);
  try{final rows=await _client.rpc('get_my_trip_budget');if(!mounted)return;setState(()=>_budget=(rows as List).isEmpty?null:Map<String,dynamic>.from(rows.first as Map));}
  catch(_){if(mounted)_message('دریافت اطلاعات بودجه انجام نشد.',false);}
  if(mounted)setState(()=>_loading=false);
 }
 void _message(String text,bool success)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(text),backgroundColor:success?Colors.green:null));
 String _money(dynamic value)=>((value as num?)?.toInt()??0).toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'),(_)=>'٬');
 String _name(Map<String,dynamic> m){final n=(m['first_name']??'').toString()+' '+(m['last_name']??'').toString();return n.trim().isEmpty?'عضو سفر':n.trim();}
 Widget _copyRow(BuildContext context,String label,String value)=>Padding(padding:EdgeInsets.only(bottom:8.h),child:Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(label,style:Theme.of(context).textTheme.bodySmall),SelectableText(value.isEmpty?'ثبت نشده':value)])),IconButton(onPressed:value.isEmpty?null:()=>Clipboard.setData(ClipboardData(text:value)),icon:const Icon(Icons.copy))]));
 Future<void> _openPaymentSheet() async {
  final ref=TextEditingController();String method='bank_transfer';final data=_budget!;
  final result=await showModalBottomSheet<String>(context:context,isScrollControlled:true,showDragHandle:true,builder:(ctx)=>StatefulBuilder(builder:(ctx,setSheetState)=>Padding(
   padding:EdgeInsets.fromLTRB(20.w,8.h,20.w,MediaQuery.of(ctx).viewInsets.bottom+24.h),
   child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text('پرداخت سهم سفر',style:Theme.of(ctx).textTheme.titleLarge),SizedBox(height:8.h),
    Text('مبلغ سهم شما: '+_money(data['my_share'])+' تومان'),SizedBox(height:16.h),
    SegmentedButton<String>(segments:const [ButtonSegment(value:'bank_transfer',label:Text('کارت‌به‌کارت'),icon:Icon(Icons.credit_card)),ButtonSegment(value:'cash',label:Text('نقدی به لیدر'),icon:Icon(Icons.payments_outlined))],selected:{method},onSelectionChanged:(v)=>setSheetState(()=>method=v.first)),
    if(method=='bank_transfer')...[
     SizedBox(height:16.h),_copyRow(ctx,'شماره کارت',(data['bank_card_number']??'').toString()),_copyRow(ctx,'نام صاحب حساب',(data['bank_account_name']??'').toString()),
     TextField(controller:ref,decoration:const InputDecoration(labelText:'شماره پیگیری تراکنش',hintText:'شماره پیگیری را وارد کنید')),
    ]else const Padding(padding:EdgeInsets.only(top:16),child:HsNote(note:'سهم خود را نقداً به لیدر تحویل دهید. پس از ثبت، پرداخت برای تأیید لیدر ارسال می‌شود.')),
    SizedBox(height:18.h),SizedBox(width:double.infinity,child:FilledButton(onPressed:()=>Navigator.pop(ctx,method),child:const Text('ثبت پرداخت برای بررسی'))),
   ]),
  )));
  final reference=ref.text.trim();ref.dispose();if(result==null)return;
  if(result=='bank_transfer'&&reference.isEmpty){_message('شماره پیگیری را وارد کنید.',false);return;}
  await _submitPayment(result,result=='bank_transfer'?reference:null);
 }
 Future<void> _submitPayment(String method,String? reference) async {
  setState(()=>_busy=true);
  try{await _client.rpc('submit_trip_payment',params:{'p_trip_id':_budget!['trip_id'],'p_method':method,'p_reference':reference});await _load();if(mounted)_message('پرداخت ثبت شد و در انتظار تأیید لیدر است.',true);}
  catch(_){if(mounted)_message('ثبت پرداخت انجام نشد. دوباره تلاش کنید.',false);}
  if(mounted)setState(()=>_busy=false);
 }
 Future<void> _confirm(String userId) async {
  setState(()=>_busy=true);
  try{await _client.rpc('confirm_trip_payment',params:{'p_trip_id':_budget!['trip_id'],'p_user_id':userId});await _load();if(mounted)_message('پرداخت عضو تأیید شد.',true);}
  catch(_){if(mounted)_message('تأیید پرداخت انجام نشد.',false);}
  if(mounted)setState(()=>_busy=false);
 }
 Widget _memberTile(Map<String,dynamic> member,bool leader){
  final status=PaymentMemberStatus.fromValue(member['pay_status'] as String?);
  final canConfirm=leader&&member['member_type']!='leader'&&member['pay_status']=='under_review';
  return Card(margin:EdgeInsets.only(bottom:10.h),child:Padding(padding:EdgeInsets.all(12.w),child:Row(children:[
   Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text(_name(member),style:const TextStyle(fontWeight:FontWeight.w700)),Text(_money(member['share'])+' تومان'),
    Text(status.label,style:TextStyle(color:status==PaymentMemberStatus.paid?Colors.green:Theme.of(context).colorScheme.primary,fontSize:12.sp)),
    if(member['payment_method']=='bank_transfer'&&(member['payment_reference']??'').toString().isNotEmpty)Text('شماره پیگیری: '+member['payment_reference'].toString()),
    if(member['payment_method']=='cash')const Text('پرداخت نقدی'),
   ])),
   if(canConfirm)TextButton(onPressed:_busy?null:()=>_confirm(member['user_id'] as String),child:const Text('تأیید پرداخت')),
  ])));
 }
 @override Widget build(BuildContext context){
  final data=_budget;final leader=data?['is_leader']==true;
  final members=(data?['members'] as List? ?? const []).map((e)=>Map<String,dynamic>.from(e as Map)).toList();
  final myStatus=PaymentMemberStatus.fromValue(data?['my_pay_status'] as String?);
  return Scaffold(body:SafeArea(child:RefreshIndicator(onRefresh:_load,child:ListView(padding:EdgeInsets.symmetric(horizontal:20.w,vertical:16.h),children:[
   const HsAppBar(title:'پرداخت و بودجه',hasBack:true),SizedBox(height:18.h),
   if(_loading)const Center(child:Padding(padding:EdgeInsets.all(40),child:CircularProgressIndicator()))
   else if(data==null)const HsNote(note:'در حال حاضر سفر فعالی برای نمایش بودجه وجود ندارد.')
   else...[
    Card(child:Padding(padding:EdgeInsets.all(16.w),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
     Text(data['trip_name'] as String? ?? 'سفر',style:Theme.of(context).textTheme.titleMedium),
     SizedBox(height:8.h),Text('بودجه کل: '+_money(data['total_budget'])+' تومان'),Text('تعداد اعضا: '+members.length.toString()+' نفر'),
     const Divider(),Text('سهم شما: '+_money(data['my_share'])+' تومان',style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.bold)),
     if(!leader)Padding(padding:EdgeInsets.only(top:8.h),child:Text('وضعیت شما: '+myStatus.label,style:const TextStyle(fontWeight:FontWeight.w700))),
    ]))),
    SizedBox(height:12.h),
    if(!leader&&myStatus!=PaymentMemberStatus.paid)...[
     if(myStatus==PaymentMemberStatus.underReview)const HsNote(note:'پرداخت شما ثبت شده و در انتظار تأیید لیدر است.')
     else SizedBox(width:double.infinity,child:FilledButton(onPressed:_busy?null:_openPaymentSheet,child:_busy?const CircularProgressIndicator():const Text('پرداخت سهم'))),
    ],
    if(leader)const HsNote(note:'پرداخت‌های ثبت‌شده اعضا را بررسی و پس از دریافت وجه تأیید کنید.'),
    SizedBox(height:20.h),Text('وضعیت پرداخت اعضا',style:Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight:FontWeight.w800)),SizedBox(height:10.h),
    ...members.map((m)=>_memberTile(m,leader)),
   ],
   SizedBox(height:24.h),
  ]))));
 }
}