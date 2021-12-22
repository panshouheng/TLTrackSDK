//
//  TLDeviceType.h
//  TLTrackSDK
//
//  Created by psh on 2021/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLDeviceType : NSObject
@property (class, nonatomic, copy,readonly) NSString *deviceName;
+ (NSString *)getCurrentDeviceModel;

@end

NS_ASSUME_NONNULL_END
