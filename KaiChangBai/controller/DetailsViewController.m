//
//  DetailsViewController.m
//  KaiChangBai
//
//  Created by app-pot on 26/12/12.
//
//

#import "DetailsViewController.h"

//db
#import "TopicDao.h"

//model
#import "Topic.h"
#import "BodyModel.h"

//category
#import "UILabel+Extension.h"

//View
#import "DetailContentView.h"
#import "DetailViewAdvertising.h"
#import "DetailInstructionView.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize myScrollview;

- (id)initWithCategoryID:(NSString*)categoryID Title:(NSString*)title
{
    self = [super init];
    if (self) {
        strCategoryID = [[NSString alloc] initWithString:categoryID];
        strTitle = [[NSString alloc] initWithString:title];
    }
    return self;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationItem.titleView = [self setTitleView:strTitle iconPositionX:0];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationItem.titleView = nil;
    self.myScrollview = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];

    arrDataList = [[[TopicDao sharedInstance] getAllResult:strCategoryID] mutableCopy];
    
    //添加UIScrollView    
    self.myScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, gViewWidth, gViewHeight)];
    self.myScrollview.delegate = self;
    self.myScrollview.pagingEnabled = YES;
    self.myScrollview.showsVerticalScrollIndicator = NO;
    self.myScrollview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.myScrollview];
    

    //初始化内容
    int width = self.myScrollview.frame.size.width;
    int height = self.myScrollview.frame.size.height;

    for (int i = 0 ; i < arrDataList.count; i++)
    {
        
        Topic *topic = (Topic*)[arrDataList objectAtIndex:i];
        
        DetailContentView *detailsContent = [[DetailContentView alloc] initWithFrame:CGRectMake(i*width, 0, width, height) viewController:self topic:topic];

        [self.myScrollview addSubview:detailsContent];
        
        
    }//完结scrollview for loop
    
    DetailViewAdvertising *detailViewAdvertising = [[DetailViewAdvertising alloc] initWithFrame:CGRectMake(0, 0, width, height) andViewController:self.navigationController];
    int count = arrDataList.count;
    if (detailViewAdvertising)
    {
        [detailViewAdvertising setFrame:CGRectMake(count*width, 0, width, height)];
        [self.myScrollview addSubview:detailViewAdvertising];
        count++;

    }
    [myScrollview setContentSize:CGSizeMake((width*count), height)];
    
    
    
    //加入操作指示
    NSUserDefaults *instructionUserDefaults = [NSUserDefaults standardUserDefaults];
    BOOL bInstruction = [instructionUserDefaults boolForKey:@"detailInstruction"];
    if (!bInstruction) {
        DetailInstructionView *detailInstructionView = [[DetailInstructionView alloc] initWithFrame:CGRectMake(0, 0, gViewWidth, gViewHeight) andUIScrollView:self.myScrollview];
        [self.view addSubview:detailInstructionView];
        [instructionUserDefaults setBool:YES forKey:@"detailInstruction"];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.myScrollview)
    {
       // int currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
        

    }
}

- (void)dealloc
{
    arrDataList = nil;
}





@end
