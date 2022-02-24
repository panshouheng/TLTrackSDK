
#import "UIViewController+TinecoLifeData.h"
#import "TLTrackSDK.h"
#import "NSObject+TLSwizzler.h"
#import <WebKit/WebKit.h>
static NSString * const kTinecoLifeDataBlackListFileName = @"TinecoLifeData_black_list";

@implementation UIViewController (TinecoLifeData)

+ (void)load {
    [UIViewController TinecoLifeData_swizzleMethod:@selector(viewDidAppear:) withMethod:@selector(TinecoLifeData_viewDidAppear:)];
}

- (BOOL)shouldTrackAppViewScreen {
    static NSSet *blackList = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 获取黑名单文件路径
//        NSString *path = [[NSBundle bundleForClass:TLAnalyticsSDK.class] pathForResource:kTinecoLifeDataBlackListFileName ofType:@"plist"];
        // 读取文件中黑名单类名的数组
//        NSArray *classNames = [NSArray arrayWithContentsOfFile:path];
        NSArray *classNames = @[@"UIInputWindowController",@"UINavigationController",@"UICompatibilityInputViewController",@"_UIRemoteInputViewController",@"UISystemInputAssistantViewController",@"UIPredictionViewController"];
        NSMutableSet *set = [NSMutableSet setWithCapacity:classNames.count];
        for (NSString *className in classNames) {
            if (NSClassFromString(className)) {
                [set addObject:NSClassFromString(className)];
            }
        }
        blackList = [set copy];
    });
    for (Class cla in blackList) {
        // 判断当前视图控制器是否为黑名单中的类或子类
        if ([self isKindOfClass:cla]) {
            return NO;
        }
    }
    return YES;
}

- (void)TinecoLifeData_viewDidAppear:(BOOL)animated {
    // 调用原始方法，即 viewDidAppear:
    [self TinecoLifeData_viewDidAppear:animated];

    if ([self shouldTrackAppViewScreen]) {
        // 触发 $AppViewScreen
        NSMutableDictionary *params = @{@"screen_name": NSStringFromClass([self class]),@"screen_title":self.title ? self.title:@""}.mutableCopy;
        NSString *urlString = [self webH5urlString];
        if (urlString.length) {
            params[@"url"] = urlString;
        }
        [[TLTrackSDK sharedInstance] track:@"AppViewScreen" properties:params];
    }
}
- (NSString *)webH5urlString {
    NSString *returnString = @"";
    for (int i = 0; i < self.view.subviews.count; i++) {
        if ([self.view.subviews[i] isKindOfClass:WKWebView.class]) {
            WKWebView *webView = (WKWebView *)self.view.subviews[i];
            returnString = webView.URL.absoluteString;
        }
    }
    return returnString;
}
- (NSString *)contentFromView:(UIView *)rootView {
    if (rootView.isHidden) {
        return nil;
    }

    NSMutableString *elementContent = [NSMutableString string];

    if ([rootView isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)rootView;
        NSString *title = button.titleLabel.text;
        if (title.length > 0) {
            [elementContent appendString:title];
        }
    } else if ([rootView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)rootView;
        NSString *title = label.text;
        if (title.length > 0) {
            [elementContent appendString:title];
        }
    } else if ([rootView isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)rootView;
        NSString *title = textView.text;
        if (title.length > 0) {
            [elementContent appendString:title];
        }
    } else {
        NSMutableArray<NSString *> *elementContentArray = [NSMutableArray array];

        for (UIView *subview in rootView.subviews) {
            NSString *temp = [self contentFromView:subview];
            if (temp.length > 0) {
                [elementContentArray addObject:temp];
            }
        }
        if (elementContentArray.count > 0) {
            [elementContent appendString:[elementContentArray componentsJoinedByString:@"-"]];
        }
    }

    return [elementContent copy];
}

@end
