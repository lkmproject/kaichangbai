//
//  UMSocialBarView.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 4/19/12.
//  Copyright (c) umeng.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialResponseEntity.h"

/**
 按钮类型
 
 */
typedef enum {
    UMSButtonTypeAddComment = 1,              //添加评论
    UMSButtonTypeShareToSNS,                  //分享到微博
    UMSButtonTypeAddLike,                     //添加喜欢
    UMSButtonTypeDisLike,                     //取消喜欢
} UMSButtonType;

/**
 按钮类型组合
 
 */
typedef enum {
    UMSButtonTypeMaskAddComment = (1 << UMSButtonTypeAddComment),   //添加评论
    UMSButtonTypeMaskShareToSNS = (1 << UMSButtonTypeShareToSNS),   //分享到微博
    UMSButtonTypeMaskAddLike = (1 << UMSButtonTypeAddLike),         //添加喜欢
    UMSButtonTypeMaskDisLike = (1 << UMSButtonTypeDisLike),         //取消喜欢
    UMSButtonTypeMaskCommentAndShare = (UMSButtonTypeMaskAddComment | UMSButtonTypeMaskShareToSNS),
    //评论并分享
    UMSButtonTypeMaskAll = (UMSButtonTypeAddLike | UMSButtonTypeAddComment | UMSButtonTypeShareToSNS),
    //喜欢、评论、分享
} UMSButtonTypeMask;


/**
 操作栏主题颜色
 
 */
typedef enum {
    UMSBarColorWhite = 1,              //白色
    UMSBarColorBlack,                  //黑色
} UMSBarColor;

@protocol UMSocialBarActionDelegate <NSObject>

-(void)likeButtonTouched;

-(void)commentButtonTouched;

-(void)shareButtonTouched;

-(void)accountButtonTouched;

@end

/**
 社会化操作栏对应的视图，你可以对此视图源代码进行自定义修改，例如修改显示是否出现数字，出现哪些按钮和修改按钮的响应
 

 ## 按钮类型

    typedef enum {
        UMSButtonTypeAddComment = 1,              //添加评论
        UMSButtonTypeShareToSNS,                  //分享到微博
        UMSButtonTypeAddLike,                     //添加喜欢
        UMSButtonTypeDisLike,                     //取消喜欢
    } UMSButtonType;


 ## 按钮类型组合

    typedef enum {
        UMSButtonTypeMaskAddComment = (1 << UMSButtonTypeAddComment),   //添加评论
        UMSButtonTypeMaskShareToSNS = (1 << UMSButtonTypeShareToSNS),   //分享到微博
        UMSButtonTypeMaskAddLike = (1 << UMSButtonTypeAddLike),         //添加喜欢
        UMSButtonTypeMaskDisLike = (1 << UMSButtonTypeDisLike),         //取消喜欢
        UMSButtonTypeMaskCommentAndShare = (UMSButtonTypeMaskAddComment | UMSButtonTypeMaskShareToSNS),                               //评论并分享
        UMSButtonTypeMaskAll = (UMSButtonTypeAddLike | UMSButtonTypeAddComment | UMSButtonTypeShareToSNS),                                   //喜欢、评论、分享
    } UMSButtonTypeMask;

 */

@interface UMSocialBarView : UIView
{
    id<UMSocialBarActionDelegate> __unsafe_unretained _socialBarDelegate;
    UIButton *_likeButton;
    UIButton *_commentButton;
    UIButton *_shareButton;
    UIButton *_accountButton;
    UILabel * _statusLabel;
    NSString *_colorString;
    UMSBarColor _themeColor;
}

@property (nonatomic, unsafe_unretained) id<UMSocialBarActionDelegate> socialBarActionDelegate;

/**
 操作栏主题颜色，有白色和黑色
 */
@property (nonatomic, assign) UMSBarColor themeColor;

/**
 更新操作栏上的数字
 
 @param response 进行网络请求返回的对象，如果不是网络请求要刷新数字，可以设置为nil
 
 @return UMSButtonTypeMask 说明更新了哪几个操作栏的按钮,定义如上
 */
-(UMSButtonTypeMask)updateButtonNumber:(UMSocialResponseEntity *)response;

/**
 网络错误
 
 */
-(void) showError;

/**
 修改喜欢按钮的图片
 
 */
-(void) changeLikeButtonImage;
@end
