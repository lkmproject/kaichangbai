//
//  DetailViewAdvertising.h
//  KaiChangBai
//
//  Created by app-pot on 28/2/13.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewAdvertising : UIView
{
   __weak UINavigationController *navController_;
    NSString *strLink_;
}


- (id)initWithFrame:(CGRect)frame andViewController:(UINavigationController *)navController;
@end
