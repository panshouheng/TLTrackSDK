
#import "UIScrollView+TinecoLifeData.h"
#include <objc/runtime.h>

@implementation UIScrollView (TinecoLifeData)

- (void)setTinecoLifeData_delegateProxy:(TLAnalyticsDelegateProxy *)TinecoLifeData_delegateProxy {
    objc_setAssociatedObject(self, @selector(setTinecoLifeData_delegateProxy:), TinecoLifeData_delegateProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TLAnalyticsDelegateProxy *)TinecoLifeData_delegateProxy {
    return objc_getAssociatedObject(self, @selector(TinecoLifeData_delegateProxy));
}

@end
