//
//  TopicScrollView.h
//  KaiChangBai
//
//  Created by app-pot on 26/2/13.
//
//

#import <UIKit/UIKit.h>

@interface TopicScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    NSArray *arrPhotoInfo;
    UIPageControl *pageControl;
    __weak  UINavigationController *navController_;
}

- (id)initWithFrame:(CGRect)frame imageArr:(NSArray*)imageArray navViewController:(UINavigationController*)navController;

@end
