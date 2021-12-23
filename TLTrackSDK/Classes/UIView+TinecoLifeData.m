
#import "UIView+TinecoLifeData.h"
#import "NSObject+TLSwizzler.h"
#import <objc/runtime.h>
#pragma mark - UIView
@implementation UIView (TinecoLifeData)

- (NSString *)TinecoLifeData_elementType {
    return NSStringFromClass([self class]);
}

- (NSString *)TinecoLifeData_elementContent {
    // 如果是隐藏控件，则不获取控件内容
    if (self.isHidden) {
        return nil;
    }
    // 初始化数组，用于保存子控件的内容
    NSMutableArray *contents = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        // 获取子控件的内容
        // 如果子类有内容，例如：UILabel 的 text，获取到的就是 text 属性；
        // 如果没有就递归调用此方法，获取其子控件的内容。
        NSString *content = view.TinecoLifeData_elementContent;
        if (content.length > 0) {
            // 当该子控件中有内容时，保存在数组中
            [contents addObject:content];
        }
    }
    
    // 当未获取到子控件内容时返回 accessibilityLabel。如果获取到多个子控件内容时，使用 - 拼接
    return contents.count == 0 ? self.accessibilityLabel : [contents componentsJoinedByString:@"-"];
}

- (UIViewController *)TinecoLifeData_viewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass: [UIViewController class]]){
            return (UIViewController *)responder;
        }
    }
    // 如果没有找到则返回 nil
    return nil;
}

@end

#pragma mark - UILabel
@implementation UILabel (TinecoLifeData)

- (NSString *)TinecoLifeData_elementContent {
    return self.text ?: super.TinecoLifeData_elementContent;
}

@end

#pragma mark - UIButton
@implementation UIButton (TinecoLifeData)

+ (void)load {
    [UIButton TinecoLifeData_swizzleMethod:@selector(setImage:forState:) withMethod:@selector(tl_setImage:forState:)];
    [UIButton TinecoLifeData_swizzleMethod:@selector(setBackgroundImage:forState:) withMethod:@selector(tl_setBackgroundImage:forState:)];
}
- (NSString *)TinecoLifeData_elementContent {
    return self.titleLabel.text ?: super.TinecoLifeData_elementContent ?: [self accessibilityIdentifier];
}
- (void)tl_setImage:(UIImage *)image forState:(UIControlState)state {
    [self tl_setImage:image forState:state];
    [self setAccessibilityIdentifier:[NSString stringWithFormat:@"image>%@",image.tl_imageName]];
}
- (void)tl_setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [self tl_setBackgroundImage:image forState:state];
    if ([self accessibilityIdentifier] == nil) {
        [self setAccessibilityIdentifier:[NSString stringWithFormat:@"image>%@",image.tl_imageName]];
    }
}
@end

#pragma mark - UISwitch
@implementation UISwitch (TinecoLifeData)

- (NSString *)TinecoLifeData_elementContent {
    return self.on ? @"checked" : @"unchecked";
}

@end

#pragma mark - UISlider
@implementation UISlider (TinecoLifeData)

- (NSString *)TinecoLifeData_elementContent {
    return [NSString stringWithFormat:@"%.2f", self.value];
}

@end

#pragma mark - UISegmentedControl
@implementation UISegmentedControl (TinecoLifeData)

- (NSString *)TinecoLifeData_elementContent {
    return [self titleForSegmentAtIndex:self.selectedSegmentIndex];
}

@end

#pragma mark - UIStepper
@implementation UIStepper (TinecoLifeData)

- (NSString *)TinecoLifeData_elementContent {
    return [NSString stringWithFormat:@"%g", self.value];
}

@end
#pragma mark - UIImage
static NSString *imageNameKey = @"tl_imageNameKey";
@implementation UIImage (TinecoLifeData)

-(void)setTl_imageName:(NSString *)tl_imageName
{
    objc_setAssociatedObject(self, &imageNameKey, tl_imageName, OBJC_ASSOCIATION_COPY);
}
-(NSString *)tl_imageName
{
    return objc_getAssociatedObject(self, &imageNameKey);
}

+ (void)load {
    Method imageNameMethod = class_getClassMethod([self class], @selector(imageNamed:));
    Method tl_imageNamedMethod = class_getClassMethod([UIImage class], @selector(tl_imageNamed:));
    method_exchangeImplementations(imageNameMethod, tl_imageNamedMethod);
    [UIImage TinecoLifeData_swizzleMethod:@selector(imageWithRenderingMode:) withMethod:@selector(tl_imageWithRenderingMode:)];
}
+ (UIImage *)tl_imageNamed:(NSString *)name {
    UIImage *image = [self tl_imageNamed:name];
    image.tl_imageName = name;
    return  image;
}
- (UIImage *)tl_imageWithRenderingMode:(UIImageRenderingMode)renderingMode {
    UIImage *image = [self tl_imageWithRenderingMode:renderingMode];
    image.tl_imageName = self.tl_imageName;
    return image;
}
@end
