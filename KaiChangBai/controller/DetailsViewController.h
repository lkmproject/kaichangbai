//
//  DetailsViewController.h
//  KaiChangBai
//
//  Created by app-pot on 26/12/12.
//
//

#import "BaseViewController.h"
@interface DetailsViewController : BaseViewController<UIScrollViewDelegate>
{
    UIScrollView *myScrollview;
    NSString *strCategoryID;
    NSString *strTitle;
    NSMutableArray *arrDataList;
}
@property(nonatomic,strong) UIScrollView *myScrollview;

- (id)initWithCategoryID:(NSString*)categoryID Title:(NSString*)title;


@end
