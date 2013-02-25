//
//  DetailContentView.h
//  KaiChangBai
//
//  Created by app-pot on 24/2/13.
//
//

#import <UIKit/UIKit.h>
@class Topic;
@interface DetailContentView : UIView
{
    UIScrollView *scrollView_;
    int width_;
    int height_;
}
- (id)initWithFrame:(CGRect)frame viewController:(__weak id)delegate topic:(__weak Topic*)topicObject;
@end
