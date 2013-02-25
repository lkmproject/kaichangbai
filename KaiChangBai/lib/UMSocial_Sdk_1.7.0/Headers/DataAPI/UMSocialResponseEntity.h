//
//  UMSocialResponseEntity.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 12-7-21.
//  Copyright (c) umeng.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialEnum.h"

/**
 返回的状态对象，可以通过此对象获取返回类型、返回结果、返回数据等。
 */
@interface UMSocialResponseEntity : NSObject
{
    UMSResponseCode _responseCode;                        //错误代号
    UMSResponse _responseType;                            //返回的数据类型
    UMSViewControllerType _viewControllerType;     //返回的操作页面
    NSString *_message;             //返回的错误消息
    NSDictionary *_data;            //返回数据
    NSError *_error;
}

/**
 `UMSResponseCode`状态码,定义在`UMSocialEnum`
 
  @see `UMSocialEnum.h`
 */
@property (nonatomic) UMSResponseCode responseCode;

/**
 数据返回`UMSResponse`类型,定义在`UMSocialEnum`
 
 @see `UMSocialEnum.h`
 */
@property (nonatomic) UMSResponse responseType;

/**
 数据返回`UMViewControllerType`类型,定义在`UMSocialEnum`,如果是UI的回调函数，表示回调函数所在的页面
 
 @see `UMSocialEnum.h`
 */
@property (nonatomic) UMSViewControllerType viewControllerType;

/**
 错误原因
 */
@property (nonatomic, retain) NSString *message;

/**
 返回数据
 */
@property (nonatomic, retain) NSDictionary *data;

/**
 客户端发送出现的错误
 */
@property (nonatomic, retain) NSError *error;

/**
 把各属性编码成NSString
  
 @return 一个`NSString`对象
 */
-(NSString *)description;
@end
