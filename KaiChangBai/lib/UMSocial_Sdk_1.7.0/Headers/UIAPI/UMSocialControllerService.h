//
//  UMSocialUIController.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 12-9-12.
//  Copyright (c) umeng.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialDataService.h"
#import "UMSocialConfigDelegate.h"

/**
 `UMSocialControllerService`对象用到的一些回调方法，包括分享完成、授权完成、评论完成等事件，和关闭授权页面、分享页面、评论页面等事件。
 */
@protocol UMSocialUIDelegate <NSObject>

@optional

/**
 关闭当前页面之前
 
 @param fromViewControllerType 关闭的页面类型
 
 */
-(void)willCloseUIViewController:(UMSViewControllerType)fromViewControllerType;


/**
 关闭当前页面之后
 
 @param fromViewControllerType 关闭的页面类型
 
 */
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType;

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param response 返回`UMSocialResponseEntity`对象，`UMSocialResponseEntity`里面的viewControllerType属性可以获得页面类型
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response;

@end

/**
 用此类的方法可以得到分享的有关UI对象，例如分享列表、评论列表、分享编辑页、分享授权页、个人中心页面等。返回都是`UINavigationController`对象，建议把这个对象present到你要添加到的`UIViewController`上
 */

@class UMSocialIconActionSheet;
@interface UMSocialControllerService : NSObject
{
    id <UMSocialUIDelegate> _socialUIDelegate;
    UMSocialDataService     *_socialDataService;
    UINavigationController  *_currentNavigationController;
    UIViewController        *_currentViewController;
    UMSocialSnsPlatform     *_currentSnsPlatform;
    UMSViewControllerType     _nextViewController;
    UMSViewControllerType _currentViewControllerType;
    UIColor *_defaultColor;
}

@property (nonatomic, retain) UIColor *defaultColor;

/**
 与`UMSocialControllerService`对象对应的`UMSocialData`对象，可以通过该对象设置分享内嵌文字、图片，获取分享数等属性
 */
@property (nonatomic, readonly) UMSocialData *socialData;

/**
 用`UMSocialDataService`对象，可以调用发送微博、评论等数据级的方法
 */
@property (nonatomic, readonly) UMSocialDataService *socialDataService;

/**
 当前返回的`UINavigationController`对象
 */
@property (nonatomic, assign) UIViewController *currentViewController;

/**
 当前返回的`UIViewController`对象
 */
@property (nonatomic, assign) UINavigationController *currentNavigationController;


/**
 当前`<UMSocialUIDelegate>`对象,此对象可以获取到授权完成，关闭页面等状态，详情看`UMSocialUIDelegate`的定义
 */
@property (nonatomic, assign) id <UMSocialUIDelegate> socialUIDelegate;

/**
 当前sns平台对象
 */
@property (nonatomic, retain) UMSocialSnsPlatform *currentSnsPlatform;

@property (nonatomic, assign) UMSViewControllerType nextViewController;

///---------------------------------------
/// @name 初始化方法和设置
///---------------------------------------

/**
 初始化一个`UMSocialControllerService`对象
 
 @param socialData `UMSocialData`对象
 
 @return 初始化对象
 */
- (id)initWithUMSocialData:(UMSocialData *)socialData;

/**
 设置实现了`<UMSocialConfigDelegate>`的对象，类方法，表示该对象对全部`UMSocialControllerService`对象起作用
 
 @param delegate 实现了`<UMSocialConfigDelegate>`的对象
 
 */
+ (void)setSocialConfigDelegate:(id <UMSocialConfigDelegate>)delegate;

///---------------------------------------
/// @name 获得评论列表、分享列表等UINavigationController
///---------------------------------------

/**
 分享列表页面，该列表出现的分享列表可以通过实现`UMSocialConfigDelegate`的方法来自定义
 
 @return `UINavigationController`对象
 */
- (UINavigationController *)getSocialShareListController;

/**
 个人中心页面，该页面包括用户各个微博授权信息和选择的登录账号
 
 @return `UINavigationController`对象
 */
- (UINavigationController *)getSocialAccountController;


/**
 sns账号设置页面，该页面包括个人的各个微博授权信息
 
 @return `UINavigationController`对象
 */
- (UINavigationController *)getSnsAccountController;

/**
 登录账号页面，该页面包括个人选择的绑定账号的用户名和头像，如果没有登录的话可以点击登录
 
 @return `UINavigationController`对象
 */
- (UINavigationController *)getLoginAccountController;

/**
 分享编辑页面
 
 @param shareToType 要编辑的微博平台,并支持UMSocialSnsTypeEmail和UMSocialSnsTypeSms返回编辑Email页面和短信页面，不支持邮箱或者短信的设备分别返回nil
 
 @return `UINavigationController`对象
 */
- (UINavigationController *)getSocialShareEditController:(UMSocialSnsType)shareToType;

/**
 授权页面，如果你要想得到授权完成之后的事件，你可以实现`UMSocialUIDelegate`里面的`-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType;`方法，当授权关闭页面会调用此方法。另外授权完成之后sdk会自动去取个人账户信息，你可以在回调函数里面去到刚刚授权的微博平台的账户信息。
 
 @param shareToType 要授权的微博平台
 
 @return `UINavigationController`对象
 */
- (UINavigationController *)getSocialOauthController:(UMSocialSnsType)shareToType;

/**
 登录页面,出现你配置出现的所有sns平台，授权之后设置为sdk的登录账号。使用评论功能时会取此登录账号的昵称和头像。
 
 @return `UINavigationController`对象
 */
- (UINavigationController *)getSocialLoginController;

/**
 获取用以sns各平台icon平铺来展示的分享列表页面对象
 
 @param controller 弹出的分享列表页面，点击sns平台icon之后，出现的分享页面或者授权页面所在的UIViewController
 
 @return 分享列表页面
 */
- (UMSocialIconActionSheet *)getSocialIconActionSheetInController:(UIViewController *)controller;

-(UIViewController *)getSocialViewController:(UMSViewControllerType)viewControllerType withSnsType:(UMSocialSnsType)shareToType;

@end


