//
//  BaseViewController.h
//  KaiChangBai
//
//  Created by app-pot on 2/1/13.
//
//

#import <UIKit/UIKit.h>
#import "NSObject+HttpCallback.h"

//vendor
#import "ASIHTTPRequest.h"
#import "SVProgressHUD.h"
#import "JSONKit.h"
#import "MobClick.h"
#import "SVPullToRefresh.h"
#import "UMFeedback.h"
#import "UIImageView+WebCache.h"
#import "SVWebViewController.h"

//controller
#import "AppDelegate.h"

//network
#import "HttpHandle.h"

@interface BaseViewController : UIViewController
{
    float gViewWidth;
    float gViewHeight;
}


- (UIView*)setTitleView:(NSString*)text iconPositionX:(int)pointX;

@end
