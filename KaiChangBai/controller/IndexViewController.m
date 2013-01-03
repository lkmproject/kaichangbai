//
//  IndexViewController.m
//  KaiChangBai
//
//  Created by kwongming lau on 12-12-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IndexViewController.h"

//vendor
#import "SVPullToRefresh.h"

//db
#import "CategoryDao.h"

//model
#import "Category.h"

//controller
#import "DetailsViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize myTableView;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.titleView = [self setTitleView:@"请选择你所在的场景" iconPositionX:44];
    
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
    NSDictionary *dicCategory = [NSDictionary dictionaryWithObjectsAndKeys:category.strCategoryId,@"id",category.strName,@"category", nil];
    [MobClick event:@"kaichangbai_category" attributes:dicCategory];
    
    [self.navigationController pushViewController:detail animated:YES];
}

@end
