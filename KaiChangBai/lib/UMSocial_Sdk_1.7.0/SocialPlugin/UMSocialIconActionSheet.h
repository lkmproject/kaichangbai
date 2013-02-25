//
//  UMSocialIconActionSheet.h
//  SocialSDK
//
//  Created by yeahugo on 13-1-11.
//  Copyright (c) 2013年 Umeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialEnum.h"

typedef void (^UMIconActionSheetButtonClickHandler)(UMSocialSnsType snsType);

/*
 自定义的类似iOS6.0中`UIActivityViewController`样式的列表，每个sns平台由对应图片和名称组成。注意：如果你要此控件支持多方向，需要在自己的UIViewController中屏幕旋转的`didRotateFromInterfaceOrientation`调用`UMSocialIconActionSheet`的`setNeedsDisplay`方法，来重新布局。
 */
@interface UMSocialIconActionSheet : UIView
{
    UMIconActionSheetButtonClickHandler _actionSheetHandler;
    UIImageView *_actionSheetBackground;
    UIButton *_cancelButton;
    NSArray *_snsNames;
}


@property (nonatomic, retain) NSArray *snsNames;

/**
 处理点击每一项之后的处理器对象
 
 */
@property(nonatomic,copy) UMIconActionSheetButtonClickHandler actionSheetHandler;

/**
 初始化方法
 
 @param snsNames 每小格对应的sns平台名，在`UMSocialEnum.h`定义
 @param handler 处理点击之后的block处理对象
 */
-(id)initWithItems:(NSArray *)items withButtonHandler:(void (^)(UMSocialSnsType snsType))handler;

/**
 讲自己自下往上弹出来
 
 @param showView 在此父UIView自下往上弹出来的
 */
-(void)showInView:(UIView *)showView;

/**
 将自己移除
 
*/
-(void)dismiss;
@end
