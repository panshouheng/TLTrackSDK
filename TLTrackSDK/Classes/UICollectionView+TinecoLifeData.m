
#import "UICollectionView+TinecoLifeData.h"
#import "TLAnalyticsDelegateProxy.h"
#import "UIScrollView+TinecoLifeData.h"
#import "NSObject+TLSwizzler.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "TLAnalyticsSDK.h"
#import "UIView+TinecoLifeData.h"

@implementation UICollectionView (TinecoLifeData)

+ (void)load {
    [UICollectionView TinecoLifeData_swizzleMethod:@selector(setDelegate:) withMethod:@selector(TinecoLifeData_setDelegate:)];
}

- (void)TinecoLifeData_setDelegate:(id<UICollectionViewDelegate>)delegate
{
//    [self preSwizzleForDelegate:delegate];
    [self TinecoLifeData_setDelegate:delegate];
    [self TinecoLifeData_swizzleDidSelectRowAtIndexPathMethodWithDelegate:delegate];
}

static void TinecoLifeData_collectionViewDidSelectItem(id object, SEL selector, UICollectionView *collectionView, NSIndexPath *indexPath) {
    SEL destinationSelector = NSSelectorFromString(@"TinecoLifeData_collectionView:didSelectItemAtIndexPath:");
    
    ((void(*)(id, SEL, id, id))objc_msgSend)(object, destinationSelector, collectionView, indexPath);

    // TODO: 触发 $AppClick 事件
    [[TLAnalyticsSDK sharedInstance] trackAppClickWithCollectionView:collectionView didSelectItemAtIndexPath:indexPath properties:nil];

}

- (void)TinecoLifeData_swizzleDidSelectRowAtIndexPathMethodWithDelegate:(id)delegate {
    // 获取 delegate 的类
    Class delegateClass = [delegate class];
    SEL sourceSelector = @selector(collectionView:didSelectItemAtIndexPath:);
    if (![delegate respondsToSelector:sourceSelector]) {
        return;
    }

    SEL destinationSelector = NSSelectorFromString(@"TinecoLifeData_collectionView:didSelectItemAtIndexPath:");
    if ([delegate respondsToSelector:destinationSelector]) {
        return;
    }

    Method sourceMethod = class_getInstanceMethod(delegateClass, sourceSelector);
    const char * encoding = method_getTypeEncoding(sourceMethod);
    // 当该类中已经存在了相同的方法时，会失败。但是前面已经判断过是否存在，因此，此处一定会添加成功。
    if (!class_addMethod([delegate class], destinationSelector, (IMP)TinecoLifeData_collectionViewDidSelectItem, encoding)) {
        NSLog(@"Add %@ to %@ error", NSStringFromSelector(sourceSelector), [delegate class]);
        return;
    }
    // 添加成功之后，进行方法交换
    [delegateClass TinecoLifeData_swizzleMethod:sourceSelector withMethod:destinationSelector];
}

@end
