//
//  SCSnsDescriptor.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 5/3/12.
//  Copyright (c) umeng.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialEnum.h"

@class UMSocialControllerService;

/** 定义响应点击平台后的block对象
 @param presentingController 点击后弹出的分享页面或者授权页面所在的UIViewController对象
 @param socialControllerService 可以用此对象的socialControllerService.socialData可以获取分享内嵌文字、内嵌图片，分享次数等
 @param isPresentInController 如果YES代表弹出(present)到当前UIViewController，否则push到UIViewController的navigationController
 
 */
typedef void (^UMSocialSnsPlatformClickHandler)(UIViewController *presentingController, UMSocialControllerService * socialControllerService, BOOL isPresentInController);

/*
 Sns平台类，用`platformName`作为标识，指定显示名称、显示的图片，点击之后的响应。
 */
@interface UMSocialSnsPlatform : NSObject
{
	NSString	*_platformName;         // sns平台标识字符串
	NSString	*_oauthBaseURLString;	//
	NSString	*_oauthCallBackPath;
	NSString	*_displayName;			// 显示名称
    NSString    *_loginName;            // 登陆显示名称
    NSString    *_bigImageName;         // 大图片的文件名,用于`UMSocialIconActionSheet`
    NSString    *_smallImageName;       // 小图片的文件名，用于分享列表、登录、个人中心、评论编辑页面等
    NSString    *_smallImageOffName;    // 无色的小图片文件名，用于评论编辑页面显示没有授权状态
	UMSocialSnsType _shareToType;
    UMSocialSnsPlatformClickHandler _snsClickHandler;
}

///---------------------------------------
/// @name 平台属性
///---------------------------------------

/**
 平台标示符
 */
@property (nonatomic, copy) NSString	*platformName;

/**
 显示名称
 */
@property (nonatomic, copy) NSString	*displayName;

/**
 登录名称
 */
@property (nonatomic, copy) NSString    *loginName;

/**
 分享类型
 */
@property (nonatomic, assign) UMSocialSnsType shareToType;

/**
 大图片的文件名,用于`UMSocialIconActionSheet`
 */
@property (nonatomic, copy) NSString    *bigImageName;

/**
 小图片的文件名，用于分享列表、登录、个人中心、评论编辑页面等
 */
@property (nonatomic, copy) NSString    *smallImageName;

/**
 无色的小图片文件名，用于评论编辑页面显示没有授权状态
*/
@property (nonatomic ,copy) NSString    *smallImageOffName;

/**
 授权url
 */
@property (nonatomic, copy) NSString	*oauthBaseURLString;

/**
 授权回调url
 */
@property (nonatomic, copy) NSString	*oauthCallBackPath;

/**
 处理点击事件后的block对象
 */
@property(nonatomic, copy) UMSocialSnsPlatformClickHandler snsClickHandler;

/**
 初始化方法
 
 @param platformName 作为该对象标识的平台名
 */
-(id)initWithPlatformName:(NSString *)platformName;
@end