//
//  UMSocialUIHelper.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 5/9/12.
//  Copyright (c) umeng.com All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 此类用于自定义sdk出现的样式，例如导航栏和导航栏上的按钮。自定义的方式是需要写一个UMUIHelper的分类，然后覆盖你要自定义的方法。
 
 例如定义一个UMSocialUIHelper(UMSocial)，覆盖的方法是：
 
```

    +(void) customNavBackButton:(UIButton *)button WithTitle:(NSString *)title
    {
        button.frame = CGRectMake(0, 0, 50, 30);
        UIImage * normalImage = [UIImage imageNamed:@"UMS_nav_back_button_normal"];
        UIImage * tapImage = [UIImage imageNamed:@"UMS_nav_back_button_tap"];
        [button titleLabel].font = [UIFont boldSystemFontOfSize:13];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
        [button setBackgroundImage:[normalImage stretchableImageWithLeftCapWidth:16 topCapHeight:10] forState:UIControlStateNormal];
        [button setBackgroundImage:[tapImage stretchableImageWithLeftCapWidth:16 topCapHeight:10] forState:UIControlStateHighlighted];
    }
 
```
 
*/

@interface UMSocialUIHelper : NSObject

/**
 自定义导航栏的返回按钮
 
 @param button 返回按钮设置
 
 @param title 需要设置的title
 */
+ (void) customNavBackButton:(UIButton *)button WithTitle:(NSString *)title;

/**
 自定义导航栏非返回的按钮
 
 @param button 非返回按钮设置
 
 @param title 需要设置的title
 */
+ (void) customNavButton:(UIButton *)button WithTitle:(NSString *)title;

/**
 自定义导航栏
 
 @param bar 导航栏
 */
+ (void) customNavBar:(UINavigationBar *) bar;

/**
 自定以取消地理位置的按钮
 
 @param button 取消地理位置的按钮
 
 @param title 需要设置的title
 */
+ (void) customCancelLocationButton:(UIButton *) button WithTitle:(NSString *) title;

/**
 自定义分享列表cell的样式
 
 @param cell 分享列表的UITableViewCell
 
 */
+ (void) customShareListCell:(UITableViewCell*)cell;

@end
