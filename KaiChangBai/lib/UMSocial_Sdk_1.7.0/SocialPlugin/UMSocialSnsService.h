//
//  UMSocialSnsService.h
//  SocialSDK
//
//  Created by yeahugo on 13-1-8.
//  Copyright (c) 2013年 Umeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialControllerService.h"

/*
 实现快速分享，类方法传入相应的参数，既可以弹出分享列表。现在提供两种列表样式。
 */
@interface UMSocialSnsService : NSObject
<
    UIActionSheetDelegate,
    UMSocialConfigDelegate,
    UIActionSheetDelegate
>
{
    UMSocialControllerService *_socialControllerService;
    UIViewController *_presentingViewController;
    NSMutableArray *_snsArray;
}

+ (UMSocialSnsService *)sharedInstance;

///---------------------------------------
/// @name 快速分享
///---------------------------------------

/**
 弹出一个分享列表的UITableViewController
 
 @param controller 在该controller弹出分享列表的UIActionSheet
 @param appKey 友盟appKey
 @param shareText  分享编辑页面的内嵌文字
 @param shareImage 分享内嵌图片,用户可以在编辑页面删除
 @param snsNames 你要分享到的sns平台类型，该NSArray值是`UMSocialEnum.h`定义的平台名的字符串常量，有UMShareToSina，UMShareToTencent，UMShareToRenren，UMShareToDouban，UMShareToQzone，UMShareToEmail，UMShareToSms等
 @param delegate 实现分享完成后的回调对象，如果不关注分享完成的状态，可以设为nil
 */
+(void)presentSnsController:(UIViewController *)controller appKey:(NSString *)appKey shareText:(NSString *)shareText shareImage:(UIImage *)shareImage shareToSnsNames:(NSArray *)snsNames delegate:(id <UMSocialUIDelegate>)delegate;

/**
 弹出一个分享列表的类似iOS6的UIActivityViewController控件
 
 @param controller 在该controller弹出分享列表的UIActionSheet
 @param appKey 友盟appKey
 @param shareText  分享编辑页面的内嵌文字
 @param shareImage 分享内嵌图片,用户可以在编辑页面删除
 @param snsNames 你要分享到的sns平台类型，该NSArray值是`UMSocialEnum.h`定义的平台名的字符串常量，有UMShareToSina，UMShareToTencent，UMShareToRenren，UMShareToDouban，UMShareToQzone，UMShareToEmail，UMShareToSms等
 @param delegate 实现分享完成后的回调对象，如果不关注分享完成的状态，可以设为nil
 */
+(void)presentSnsIconSheetView:(UIViewController *)controller appKey:(NSString *)appKey shareText:(NSString *)shareText shareImage:(UIImage *)shareImage shareToSnsNames:(NSArray *)snsNames delegate:(id <UMSocialUIDelegate>)delegate;
@end
