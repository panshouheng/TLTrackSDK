
#import "TLAnalyticsDelegateProxy.h"
#import "TLAnalyticsSDK.h"

@interface TLAnalyticsDelegateProxy ()

/// 保存 delegate 对象
@property (nonatomic, weak) id delegate;

@end

@implementation TLAnalyticsDelegateProxy

+ (instancetype)proxyWithTableViewDelegate:(id<UITableViewDelegate>)delegate {
    TLAnalyticsDelegateProxy *proxy = [TLAnalyticsDelegateProxy alloc];
    proxy.delegate = delegate;
    return proxy;
}

+ (instancetype)proxyWithCollectionViewDelegate:(id<UICollectionViewDelegate>)delegate {
    TLAnalyticsDelegateProxy *proxy = [TLAnalyticsDelegateProxy alloc];
    proxy.delegate = delegate;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    // 返回 delegate 对象中对应的方法签名
    return [(NSObject *)self.delegate methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    // 先执行 delegate 对象中的方法
    [invocation invokeWithTarget:self.delegate];
    // 判断是否是 cell 的点击事件的代理方法
    if (invocation.selector == @selector(tableView:didSelectRowAtIndexPath:)) {
        // 将方法名修改为进行数据采集的方法，即本类中的实例方法：TinecoLifeData_tableView:didSelectRowAtIndexPath:
        invocation.selector = NSSelectorFromString(@"TinecoLifeData_tableView:didSelectRowAtIndexPath:");
        // 执行数据采集相关的方法
        [invocation invokeWithTarget:self];
    } else if (invocation.selector == @selector(collectionView:didSelectItemAtIndexPath:)) {
        // 将方法名修改为进行数据采集的方法，即本类中的实例方法：TinecoLifeData_collectionView:didSelectRowAtIndexPath:
        invocation.selector = NSSelectorFromString(@"TinecoLifeData_collectionView:didSelectItemAtIndexPath:");
        // 执行数据采集相关的方法
        [invocation invokeWithTarget:self];
    }
}

- (void)TinecoLifeData_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[TLAnalyticsSDK sharedInstance] trackAppClickWithTableView:tableView didSelectRowAtIndexPath:indexPath properties:nil];
}

- (void)TinecoLifeData_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[TLAnalyticsSDK sharedInstance] trackAppClickWithCollectionView:collectionView didSelectItemAtIndexPath:indexPath properties:nil];
}

@end
