//
//  UMSocialConfigDelegate.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 12-8-21.
//  Copyright (c) umeng.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialSnsPlatform.h"
#import <UIKit/UIKit.h>
#import "UMSocialData.h"

/**
 在UI层的api中进行的一些设置，例如出现的分享平台等。
 */
@protocol UMSocialConfigDelegate <NSObject>

@optional


-(UMSocialSnsPlatform *)socialSnsPlatformWithSnsName:(NSString *)snsName;


-(void)didSelectSnsPlatformWithSnsName:(NSString *)snsName showController:(UIViewController *)showViewController withSocialData:(UMSocialData *)socialData;

/** 
 设置显示的sns平台类型
 
 @return  返回由`UMSocialEnum.h`定义的UMShareToSina、UMShareToTencent、UMShareToQzone、UMShareToRenren、UMShareToDouban、UMShareToEmail、UMShareToSms组成的NSArray
 */
- (NSArray *)shareToPlatforms;


/**
 设置官方微博账号,设置之后可以在授权页面有关注微博的选项，默认勾选，授权之后用户即关注官方微博，仅支持新浪微博和腾讯微博
 
 @return  腾讯微博和新浪微博的key分别是`UMShareToSina`和`UMShareToTenc`,值分别是官方微博的uid
 */
-(NSDictionary *)followSnsUids;

/** 
 设置评论页面是否出现分享按钮,默认为出现所有支持的平台，可以用shareToPlatforms设置

 */
- (BOOL)shouldCommentWithShare;

/** 
 设置评论页面是否出现分享地理位置信息的按钮，默认出现
 
 */
- (BOOL)shouldCommentWithLocation;

/**
 设置分享编辑页面是否等待完成之后再关闭页面还是立即关闭，如果设置成YES，就是等待分享完成之后再关闭，否则立即关闭。默认等待分享完成之后再关闭。如果设置成立即关闭的话，需要用`UMSocialDataServie`的`- (void)setUMSoicalDelegate:(id <UMSocialDataDelegate>)delegate;`来设置回调对象来获取分享是否成功，如果回调对象的`responseCode`为`UMSResponseCodeAccessTokenExpired`的话是授权过期，新浪微博对于不同应用的过期时间不一样，这种情况下要利用sdk提供的授权页面需要重新授权。
 
 */
- (BOOL)shouldShareSynchronous;

/** 
 设置所有页面背景颜色，默认的颜色是[UIColor colorWithRed:0.22 green:0.24  blue:0.27 alpha:1.0]，如果想改变上面导航栏的颜色，可以换相应的图片
 */
- (UIColor *)defaultColor;

/**
 设置sdk所有页面需要支持屏幕方向.
 
 @return 一个bit map（位掩码），ios 6定义的`UIInterfaceOrientationMask`
 */
- (NSUInteger)supportedInterfaceOrientationsForUMSocialSDK;

@end
