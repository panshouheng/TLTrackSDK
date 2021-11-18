
#import "UICollectionView+TinecoLifeData.h"
#import "TLAnalyticsDelegateProxy.h"
#import "UIScrollView+TinecoLifeData.h"
#import "NSObject+TLSwizzler.h"

@implementation UICollectionView (TinecoLifeData)

+ (void)load {
    [UICollectionView TinecoLifeData_swizzleMethod:@selector(setDelegate:) withMethod:@selector(TinecoLifeData_setDelegate:)];
}

- (void)TinecoLifeData_setDelegate:(id<UICollectionViewDelegate>)delegate {
    self.TinecoLifeData_delegateProxy = nil;
    if (delegate) {
        TLAnalyticsDelegateProxy *proxy = [TLAnalyticsDelegateProxy proxyWithCollectionViewDelegate:delegate];
        self.TinecoLifeData_delegateProxy = proxy;
        [self TinecoLifeData_setDelegate:proxy];
    } else {
        [self TinecoLifeData_setDelegate:nil];
    }
}


@end
