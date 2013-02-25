//
//  UMSocialSnsService.m
//  SocialSDK
//
//  Created by yeahugo on 13-1-8.
//  Copyright (c) 2013年 Umeng. All rights reserved.
//

#import "UMSocialSnsService.h"
#import "UMSocialAccountEntity.h"
#import "UMSocialMacroDefine.h"
#import "UMSocialIconActionSheet.h"
#import "UMSocialSnsPlatformManager.h"
#import "WXApi.h"

#import <Social/Social.h>

@implementation UMSocialSnsService
#define SLServiceTypeFacebook @"com.apple.social.facebook"
#define SLServiceTypeTwitter @"com.apple.social.twitter"

#define UMShareToWechatSession @"wxsession"
#define UMShareToWechatTimeline @"wxtimeline"

-(void)dealloc
{
    SAFE_ARC_RELEASE(_socialControllerService);
    _socialControllerService = nil;
    SAFE_ARC_RELEASE(_snsArray);
    SAFE_ARC_SUPER_DEALLOC();
}

+ (UMSocialSnsService *)sharedInstance
{
	static UMSocialSnsService *_instance = nil;
    
	@synchronized(self) {
		if (_instance == nil) {            
			_instance = [[self alloc] init];
		}
	}
    
	return _instance;
}

+(void)presentSnsController:(UIViewController *)controller appKey:(NSString *)appKey shareText:(NSString *)shareText shareImage:(UIImage *)shareImage shareToSnsNames:(NSArray *)snsNames delegate:(id <UMSocialUIDelegate>)delegate
{
    [[UMSocialSnsService sharedInstance] presentSnsController:controller appKey:appKey shareText:shareText shareImage:shareImage shareToSnsStrings:snsNames delegate:delegate];
}

+(void)presentSnsIconSheetView:(UIViewController *)controller appKey:(NSString *)appKey shareText:(NSString *)shareText shareImage:(UIImage *)shareImage shareToSnsNames:(NSArray *)snsNames delegate:(id <UMSocialUIDelegate>)delegate
{
    [[UMSocialSnsService sharedInstance] showSnsIconSheetView:controller appKey:appKey shareText:shareText shareImage:shareImage shareToSnsStrings:snsNames delegate:delegate];
}

-(void)setSocialDataWithController:(UIViewController *)controller appKey:(NSString *)appKey shareText:(NSString *)shareText shareImage:(UIImage *)shareImage delegate:(id <UMSocialUIDelegate>)delegate
{
    _presentingViewController = controller;
    if (appKey != nil) {
        [UMSocialData setAppKey:appKey];        
    }
    UMSocialData *socialData = [UMSocialData defaultData];
    socialData.shareText = shareText;
    socialData.shareImage = shareImage;
    _socialControllerService = [[UMSocialControllerService alloc] initWithUMSocialData:socialData];
    _socialControllerService.socialUIDelegate = delegate;
}

-(void)presentSnsController:(UIViewController *)controller appKey:(NSString *)appKey shareText:(NSString *)shareText shareImage:(UIImage *)shareImage shareToSnsStrings:(NSArray *)snsStrings delegate:(id <UMSocialUIDelegate>)delegate
{
    [self setSocialDataWithController:controller appKey:appKey shareText:shareText shareImage:shareImage delegate:delegate];
    UINavigationController *snsListController = [_socialControllerService getSocialShareListController];
    [snsListController.visibleViewController performSelector:@selector(setAllSnsArray:) withObject:snsStrings];
    [_presentingViewController presentModalViewController:snsListController animated:YES];
}

-(void)showSnsIconSheetView:(UIViewController *)controller appKey:(NSString *)appKey shareText:(NSString *)shareText shareImage:(UIImage *)shareImage shareToSnsStrings:(NSArray *)snsStrings delegate:(id <UMSocialUIDelegate>)delegate
{
    [self setSocialDataWithController:controller appKey:appKey shareText:shareText shareImage:shareImage delegate:delegate];

    UMSocialIconActionSheet *snsIconSheet = (UMSocialIconActionSheet *)[_socialControllerService getSocialIconActionSheetInController:controller];
    if (snsStrings != nil) {
        [snsIconSheet setSnsNames:snsStrings];        
    }
    [snsIconSheet showInView:controller.view];
}

#pragma mark - UMSocialConfigDelegate
- (NSArray *)shareToPlatforms
{
    return _snsArray;
}

-(UMSocialSnsPlatform *)socialSnsPlatformWithSnsName:(NSString *)snsName
{
    UMSocialSnsPlatform *customSnsPlatform = [[UMSocialSnsPlatform alloc] initWithPlatformName:snsName];
    if ([snsName isEqualToString:UMShareToWechat]) {
        customSnsPlatform.bigImageName = @"UMSocialSDKResources.bundle/UMS_wechart_icon";
        customSnsPlatform.smallImageName = @"UMSocialSDKResources.bundle/UMS_wechart_on.png";
        customSnsPlatform.displayName = @"微信";
        customSnsPlatform.loginName = @"微信账号";
        customSnsPlatform.snsClickHandler = ^(UIViewController *presentingController, UMSocialControllerService * socialControllerService, BOOL isPresentInController){
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享到微信" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享给好友",@"分享到朋友圈",nil];
            if (presentingController.tabBarController != nil) {
                [actionSheet showInView:presentingController.tabBarController.tabBar];
            }
            else{
                [actionSheet showInView:presentingController.view];
            }
            _socialControllerService = socialControllerService;
            SAFE_ARC_RELEASE(actionSheet);
        };
    }
    else if ([snsName isEqualToString:UMShareToFacebook]) {
        customSnsPlatform.bigImageName = @"UMSocialSDKResources.bundle/UMS_facebook_icon";
        customSnsPlatform.smallImageName = @"UMSocialSDKResources.bundle/UMS_facebook_on.png";
        customSnsPlatform.displayName = @"Facebook";
        
        customSnsPlatform.snsClickHandler = ^(UIViewController *presentingController, UMSocialControllerService * socialControllerService, BOOL isPresentInController){
            
            if([NSClassFromString(@"SLComposeViewController") class] != nil)
            {
                if ([NSClassFromString(@"SLComposeViewController") isAvailableForServiceType:SLServiceTypeFacebook]) {
                    SLComposeViewController *slcomposeViewController =  [NSClassFromString(@"SLComposeViewController") composeViewControllerForServiceType:SLServiceTypeFacebook];
                    if (socialControllerService != nil) {
                        [slcomposeViewController setInitialText:socialControllerService.socialData.shareText];
                        [slcomposeViewController addImage:socialControllerService.socialData.shareImage];
                        slcomposeViewController.completionHandler = ^(SLComposeViewControllerResult result){
                            [presentingController dismissModalViewControllerAnimated:YES];
                        };
                        [presentingController presentModalViewController:slcomposeViewController animated:YES];
                    }
                    
                }
                else{
                    UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"账号未登录" message:[NSString stringWithFormat:@"您的Facebook账号尚未登录，请在系统设置中登录"] delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
                    [loginAlert show];
                    SAFE_ARC_RELEASE(loginAlert);
                }
            }
            else{
                UIAlertView *osAlert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[NSString stringWithFormat:@"您的设备系统不支持分享到Facebook的功能"] delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
                [osAlert show];
                SAFE_ARC_RELEASE(osAlert);
            }
        };
         
    }
    else if ([snsName isEqualToString:UMShareToTwitter])
    {
        customSnsPlatform.bigImageName = @"UMSocialSDKResources.bundle/UMS_twitter_icon";
        customSnsPlatform.smallImageName = @"UMSocialSDKResources.bundle/UMS_twitter_on.png";
        customSnsPlatform.displayName = @"Twitter";
        customSnsPlatform.snsClickHandler = ^(UIViewController *presentingController, UMSocialControllerService * socialControllerService, BOOL isPresentInController){

            if([NSClassFromString(@"SLComposeViewController") class] != nil){
                if ([NSClassFromString(@"SLComposeViewController") isAvailableForServiceType:SLServiceTypeTwitter]) {
                    SLComposeViewController *slcomposeViewController =  [NSClassFromString(@"SLComposeViewController") composeViewControllerForServiceType:SLServiceTypeTwitter];
                    if (socialControllerService != nil) {
                        [slcomposeViewController setInitialText:socialControllerService.socialData.shareText];
                        [slcomposeViewController addImage:socialControllerService.socialData.shareImage];
                        slcomposeViewController.completionHandler = ^(SLComposeViewControllerResult result){
                            [presentingController.presentingViewController dismissModalViewControllerAnimated:YES];
                        };
                        [presentingController presentModalViewController:slcomposeViewController animated:YES];
                    }
                }
                else{
                    UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"账号未登录" message:[NSString stringWithFormat:@"您的Twitter账号尚未登录，请在系统设置中登录"] delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
                    [loginAlert show];
                    SAFE_ARC_RELEASE(loginAlert);
                }                
            }
            else{
                UIAlertView *osAlert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[NSString stringWithFormat:@"您的设备系统不支持分享到Twitter的功能"] delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
                [osAlert show];
                SAFE_ARC_RELEASE(osAlert);
            }
        };
    }
    SAFE_ARC_AUTORELEASE(customSnsPlatform);
    return customSnsPlatform;
}

-(void)didSelectSLComposeViewController:(NSString *)snsName showController:(UIViewController *)showViewController withSocialData:(UMSocialData *)socialData
{
    NSString *slServiceType = nil;
    NSString *slName = nil;
    if ([snsName isEqualToString:UMShareToFacebook]) {
        slServiceType = SLServiceTypeFacebook;
        slName = @"Facebook";
    }
    else if ([snsName isEqualToString:UMShareToTwitter]){
        slServiceType = SLServiceTypeTwitter;
        slName = @"Twitter";
    }

    if([NSClassFromString(@"SLComposeViewController") class] != nil)
    {
        if ([NSClassFromString(@"SLComposeViewController") isAvailableForServiceType:slServiceType]) {
            SLComposeViewController *slcomposeViewController =  [NSClassFromString(@"SLComposeViewController") composeViewControllerForServiceType:slServiceType];
            if (socialData != nil) {
                [slcomposeViewController setInitialText:socialData.shareText];
                [slcomposeViewController addImage:socialData.shareImage];                
            }
            [showViewController presentModalViewController:slcomposeViewController animated:YES];
        }
        else{
            UIAlertView *loginAlert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[NSString stringWithFormat:@"您的%@账号尚未登录，请在系统设置中登录",slName] delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [loginAlert show];
            SAFE_ARC_RELEASE(loginAlert);
        }
    }
    else{
        UIAlertView *osAlert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[NSString stringWithFormat:@"您的设备系统不支持分享到%@的功能",slName] delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        [osAlert show];
        SAFE_ARC_RELEASE(osAlert);
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        if (_socialControllerService.currentNavigationController != nil) {
            [_socialControllerService.currentNavigationController dismissModalViewControllerAnimated:YES];
        }
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.text = _socialControllerService.socialData.shareText;
        req.bText = YES;
        
        /*下面实现图片分享，只能分享文字或者分享图片，或者分享url，里面带有图片缩略图和描述文字
         WXMediaMessage * message = [WXMediaMessage message];
         WXImageObject *ext = [WXImageObject object];
         NSString *filePath = [[NSBundle mainBundle] pathForResource:@"yinxing0" ofType:@"jpg"];
         ext.imageData = [NSData dataWithContentsOfFile:filePath] ;
         
         message.mediaObject = ext;
         [message setThumbImage:[UIImage imageNamed:@"yinxing0"]];
         req.message = message;
         req.bText = NO;
         */
        
        if (buttonIndex == 0) {
            req.scene = WXSceneSession;
            [_socialControllerService.socialDataService postSNSWithTypes:@[UMShareToWechatSession] content:req.text image:nil location:nil];
        }
        if (buttonIndex == 1) {
            req.scene = WXSceneTimeline;
            [_socialControllerService.socialDataService postSNSWithTypes:@[UMShareToWechatTimeline] content:req.text image:nil location:nil];
        }
        [WXApi sendReq:req];
        SAFE_ARC_RELEASE(req);
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备没有安装微信" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alertView show];
        SAFE_ARC_RELEASE(alertView);
    }
}



@end
