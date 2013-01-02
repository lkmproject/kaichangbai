//
//  BaseViewController.h
//  KaiChangBai
//
//  Created by app-pot on 2/1/13.
//
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
    float gViewWidth;
    float gViewHeight;
}


- (UIView*)setTitleView:(NSString*)text iconPositionX:(int)pointX;

@end
