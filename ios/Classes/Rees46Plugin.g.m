// Autogenerated from Pigeon (v18.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "Rees46Plugin.g.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}

static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@implementation TrackEventBox
- (instancetype)initWithValue:(TrackEvent)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

NSObject<FlutterMessageCodec> *Rees46SenderGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  sSharedObject = [FlutterStandardMessageCodec sharedInstance];
  return sSharedObject;
}

void SetUpRees46Sender(id<FlutterBinaryMessenger> binaryMessenger, NSObject<Rees46Sender> *api) {
  SetUpRees46SenderWithSuffix(binaryMessenger, api, @"");
}

void SetUpRees46SenderWithSuffix(id<FlutterBinaryMessenger> binaryMessenger, NSObject<Rees46Sender> *api, NSString *messageChannelSuffix) {
  messageChannelSuffix = messageChannelSuffix.length > 0 ? [NSString stringWithFormat: @".%@", messageChannelSuffix] : @"";
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.rees64_plugin.Rees46Sender.initialize", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:Rees46SenderGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(initializeShopID:apiDomain:token:error:)], @"Rees46Sender api (%@) doesn't respond to @selector(initializeShopID:apiDomain:token:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_shopID = GetNullableObjectAtIndex(args, 0);
        NSString *arg_apiDomain = GetNullableObjectAtIndex(args, 1);
        NSString *arg_token = GetNullableObjectAtIndex(args, 2);
        FlutterError *error;
        [api initializeShopID:arg_shopID apiDomain:arg_apiDomain token:arg_token error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.rees64_plugin.Rees46Sender.track", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:Rees46SenderGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(trackTrackEvent:itemID:amount:error:)], @"Rees46Sender api (%@) doesn't respond to @selector(trackTrackEvent:itemID:amount:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_trackEvent = GetNullableObjectAtIndex(args, 0);
        NSString *arg_itemID = GetNullableObjectAtIndex(args, 1);
        NSNumber *arg_amount = GetNullableObjectAtIndex(args, 2);
        FlutterError *error;
        [api trackTrackEvent:arg_trackEvent itemID:arg_itemID amount:arg_amount error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.rees64_plugin.Rees46Sender.recommend", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:Rees46SenderGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(recommendRecommenderCode:extended:itemID:categoryID:completion:)], @"Rees46Sender api (%@) doesn't respond to @selector(recommendRecommenderCode:extended:itemID:categoryID:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_recommenderCode = GetNullableObjectAtIndex(args, 0);
        BOOL arg_extended = [GetNullableObjectAtIndex(args, 1) boolValue];
        NSString *arg_itemID = GetNullableObjectAtIndex(args, 2);
        NSString *arg_categoryID = GetNullableObjectAtIndex(args, 3);
        [api recommendRecommenderCode:arg_recommenderCode extended:arg_extended itemID:arg_itemID categoryID:arg_categoryID completion:^(NSArray<NSString *> *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.rees64_plugin.Rees46Sender.setProfile", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:Rees46SenderGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setProfileUserId:email:phone:error:)], @"Rees46Sender api (%@) doesn't respond to @selector(setProfileUserId:email:phone:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_userId = GetNullableObjectAtIndex(args, 0);
        NSString *arg_email = GetNullableObjectAtIndex(args, 1);
        NSString *arg_phone = GetNullableObjectAtIndex(args, 2);
        FlutterError *error;
        [api setProfileUserId:arg_userId email:arg_email phone:arg_phone error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
NSObject<FlutterMessageCodec> *Rees46ReceiverGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  sSharedObject = [FlutterStandardMessageCodec sharedInstance];
  return sSharedObject;
}

@interface Rees46Receiver ()
@property(nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@property(nonatomic, strong) NSString *messageChannelSuffix;
@end

@implementation Rees46Receiver

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  return [self initWithBinaryMessenger:binaryMessenger messageChannelSuffix:@""];
}
- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger messageChannelSuffix:(nullable NSString*)messageChannelSuffix{
  self = [self init];
  if (self) {
    _binaryMessenger = binaryMessenger;
    _messageChannelSuffix = [messageChannelSuffix length] == 0 ? @"" : [NSString stringWithFormat: @".%@", messageChannelSuffix];
  }
  return self;
}
@end

