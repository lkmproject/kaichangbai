//
//  BaseViewController.m
//  KaiChangBai
//
//  Created by app-pot on 2/1/13.
//
//

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:4/255.0 green:146/255.0 blue:255/255.0 alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navIndex.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    gViewWidth = self.view.frame.size.width;
    gViewHeight = self.view.frame.size.height-44;
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIView*)setTitleView:(NSString*)text iconPositionX:(int)pointX
{
    
    UIImageView *titleIcon = [[UIImageView alloc] initWithFrame:CGRectMake(pointX, 9, 42, 27)];
    [titleIcon setImage:[UIImage imageNamed:@"titleIcon"]];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(pointX+44, 0, 320-90, 44)];
    title.text = text;
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    
    __autoreleasing UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [titleView addSubview:titleIcon];
    [titleView addSubview:title];
    
    return titleView;
}


@end
