//
//  UMSocialDelegate.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 12-8-6.
//  Copyright (c) umeng.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialResponseEntity.h"

/**
 进行网络请求之后的回调函数，你可以通过返回的`UMSocialResponseEntity`对象的`responseType`类型来对不同的请求来做处理。
 
 @see `UMSocialResponseEntity.h`
 
 */
@protocol UMSocialDataDelegate <NSObject>

/**
 进行网络请求之后得到的回调方法
 
 @param response 回调返回一个`UMSResponseEntity`对象
 
 */
-(void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response;

@end
