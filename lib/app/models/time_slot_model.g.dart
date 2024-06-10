// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      timeSlotId: json['timeSlotId'] as String?,
      timeSlot: TimeSlot._dateTimeFromJson(json['timeSlot'] as Timestamp?),
      duration: json['duration'] as int?,
      price: json['price'] as int?,
      link: json['link'] ?? 'null',
      available: json['available'] as bool?,
      doctorid: json['doctorId'] as String?,
      doctor: json['doctor'] == null
          ? null
          : Doctor.fromJson(json['doctor'] as Map<String, dynamic>),
      purchaseTime:
          TimeSlot._dateTimeFromJson(json['purchaseTime'] as Timestamp?),
      status: json['status'] as String?,
    )
      ..doctorUserId = json['doctorUserId'] as String?
      ..availableForCall = json['availableForCall'] as bool?;

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'timeSlotId': instance.timeSlotId,
      'link': instance.link,
      'timeSlot': TimeSlot._dateTimeToJson(instance.timeSlot),
      'duration': instance.duration,
      'price': instance.price,
      'available': instance.available,
      'doctorId': instance.doctorid,
      'doctorUserId': instance.doctorUserId,
      'availableForCall': instance.availableForCall,
      'doctor': TimeSlot.doctorToJson(instance.doctor),
      'purchaseTime': TimeSlot._dateTimeToJson(instance.purchaseTime),
      'status': instance.status,
    };
