
#import "UIApplication+TinecoLifeData.h"
#import "TLAnalyticsSDK.h"
#import "NSObject+TLSwizzler.h"
#import "UIView+TinecoLifeData.h"

@implementation UIApplication (TinecoLifeData)

//+ (void)load {
//    [UIApplication TinecoLifeData_swizzleMethod:@selector(sendAction:to:from:forEvent:) withMethod:@selector(TinecoLifeData_sendAction:to:from:forEvent:)];
//}

- (BOOL)TinecoLifeData_sendAction:(SEL)action to:(nullable id)target from:(nullable id)sender forEvent:(nullable UIEvent *)event {
    if ([sender isKindOfClass:UISwitch.class] ||
        [sender isKindOfClass:UISegmentedControl.class] ||
        [sender isKindOfClass:UIStepper.class] ||
        event.allTouches.anyObject.phase == UITouchPhaseEnded) {
        // 触发 $AppClick 事件
        [[TLAnalyticsSDK sharedInstance] trackAppClickWithView:sender properties:nil];
    }

    // 调用旧的实现，因为它们已经被替换了
    return [self TinecoLifeData_sendAction:action to:target from:sender forEvent:event];
}

@end
