
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - TinecoLifeDataElementProperty
@protocol TinecoLifeDataElementProperty

/// 控件的类型
@property (nonatomic, copy, readonly) NSString *TinecoLifeData_elementType;

/// 获取控件的内容
@property (nonatomic, copy, readonly) NSString *TinecoLifeData_elementContent;

@end

#pragma mark - UIView
@interface UIView (TinecoLifeData) <TinecoLifeDataElementProperty>

@property (nonatomic, copy, readonly) NSString *TinecoLifeData_elementType;

@property (nonatomic, copy, readonly) NSString *TinecoLifeData_elementContent;

/// 获取 view 所在的 viewController，或者当前的 viewController
@property (nonatomic, readonly) UIViewController *TinecoLifeData_viewController;

@end

#pragma mark - UILabel
@interface UILabel (TinecoLifeData)

@end

#pragma mark - UIButton
@interface UIButton (TinecoLifeData)

@end

#pragma mark - UISwitch
@interface UISwitch (TinecoLifeData)

@end

#pragma mark - UISlider
@interface UISlider (TinecoLifeData)

@end

#pragma mark - UISegmentedControl
@interface UISegmentedControl (TinecoLifeData)

@end

#pragma mark - UIStepper
@interface UIStepper (TinecoLifeData)

@end
#pragma mark - UIImage
@interface UIImage (TinecoLifeData)

@property(nonatomic,strong)NSString *tl_imageName;

@end


NS_ASSUME_NONNULL_END
