//
//  UMSocialBar.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 12-9-13.
//  Copyright (c) umeng.com All rights reserved.
//
#import "UMSocialData.h"
#import "UMSocialControllerServiceComment.h"
#import "UMSocialBarView.h"

/**
 `UMSocialControllerService`对象用到的一些回调方法，可以对出现的分享列表进行设置，或者得到一些完成事件的回调方法。
 */
@protocol UMSocialBarDelegate <NSObject>

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param actionType 操作类型，返回是评论、分享微博或者喜欢,定义在`UMSocialBarView.h`
 */
-(void)didFinishUpdateBarNumber:(UMSButtonTypeMask)actionTypeMask;

@end

/**
 一个集成了多个社会化功能的工具栏，可以查看并添加评论、分享到微博、添加喜欢、查看用户信息等功能。
 你要用一个identifier标识符字符串和添加到的`UIViewController`对象来初始化，然后可以自己添加到你要添加到的`UIView`上，并自定义其位置。也可以通过他的socialData属性来获取分享数等。
 
 */
@interface UMSocialBar : UIView
<
    UMSocialDataDelegate,
    UMSocialUIDelegate
>
{
    UMSocialData *_socialData;
    UMSocialControllerServiceComment *_socialControllerService;
    UIViewController *_presentingViewController;
    id<UMSocialBarDelegate> __unsafe_unretained _socialBarDelegate;
    UMSocialBarView *_socialBarView;
}

///---------------------------------------
/// @name 对象属性
///---------------------------------------

/**
 `UMSocialData`对象，可以通过该对象设置分享内嵌文字、图片，获取分享数等属性
 */
@property (nonatomic, readonly) UMSocialData *socialData;

/**
 `UMSocialControllerService`对象，可以通过该对象得到分享编辑页面等
 */
@property (nonatomic, readonly) UMSocialControllerServiceComment *socialControllerService;

/**
 `UMSocialBar`所弹出的分享页面要添加到的`UIViewController`对象
 */
@property (nonatomic, assign) UIViewController *presentingViewController;

/**
 实现回调协议`<UMSocialBarDelegate>`的对象
 */
@property (nonatomic, unsafe_unretained) id<UMSocialBarDelegate> socialBarDelegate;

/**
 操作栏对应的视图对象
 */
@property (nonatomic, retain) UMSocialBarView *socialBarView;

///---------------------------------------
/// @name 初始化方法
///---------------------------------------

/**
 初始化方法
 
 @param socialData `UMSocialData`对象
 @param viewController `UMSocialBar`出现的分享列表、评论列表等`UINavigationCtroller`要添加到的`UIViewController`
 
 @return 初始化对象
 */
- (id)initWithUMSocialData:(UMSocialData *)socialData withViewController:(UIViewController *)viewController;

/**
 更新操作栏所对应的UMSocialData的identifier,获取此UMSocialData的数据，并重新刷新操作栏的数字
 
 @param identifier 标识此操作栏对应的UMSocialData的identifier字符串
 
 */
- (void)updateButtonNumberWithIdentifier:(NSString *)identifier;
@end