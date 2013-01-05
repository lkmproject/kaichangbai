//
//  IndexViewController.m
//  KaiChangBai
//
//  Created by kwongming lau on 12-12-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IndexViewController.h"

//db
#import "CategoryDao.h"

//model
#import "Category.h"

//controller
#import "DetailsViewController.h"
#import "SettingViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize myTableView;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.titleView = [self setTitleView:@"请选择你所在的场景" iconPositionX:44];
    
    UIButton *btnSetting= [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSetting addTarget:self
                   action:@selector(actSetting)
         forControlEvents:UIControlEventTouchDown];
    [btnSetting setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    btnSetting.frame = CGRectMake(0, 0, 28, 28);
    UIBarButtonItem *barBtnSetting = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    self.navigationItem.rightBarButtonItem = barBtnSetting;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [http cancelAllHttpRequest];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.myTableView];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    http = [[HttpHandle alloc] init];
    http.delegate = self;
    __weak HttpHandle *tempHttp = http;
    
    [self.myTableView addPullToRefreshWithActionHandler:^{
        [tempHttp cancelAllHttpRequest];
        [tempHttp downloadData];
    }];
    
    [self.myTableView.pullToRefreshView triggerRefresh];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (void)httpRequestFinish
{
    [self.myTableView.pullToRefreshView stopAnimating];
    arrDataList = [[[CategoryDao sharedInstance] getAllResult] mutableCopy];
    [self.myTableView reloadData];
}

- (void)httpRequestFail
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [arrDataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageTimeline  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 21, 75)];
        [imageTimeline setImage:[UIImage imageNamed:@"timeLine.png"]];
        [cell addSubview:imageTimeline];
        
        UIImageView *imageArrow  = [[UIImageView alloc] initWithFrame:CGRectMake(290, 30, 16, 20)];
        [imageArrow setImage:[UIImage imageNamed:@"arrow.png"]];
        [cell addSubview:imageArrow];
        
    }
    
    Category *obj = [arrDataList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"    %@",obj.strName];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Category *category = (Category*)[arrDataList objectAtIndex:indexPath.row];

    DetailsViewController *detail = [[DetailsViewController alloc] initWithCategoryID:category.strCategoryId Title:category.strName];
    
    //友盟数据统计
    NSDictionary *dicCategory = [NSDictionary dictionaryWithObjectsAndKeys:category.strCategoryId,@"categoryId",category.strName,@"categoryName", nil];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate MobClickId:@"kaichangbai_category" attributes:dicCategory];
        
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - Local Method
- (void)actSetting
{
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];
    
    
    
    //[UMFeedback showFeedback:self withAppkey:UMENG_APPKEY];
}

@end
