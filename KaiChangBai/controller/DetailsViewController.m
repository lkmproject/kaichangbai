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
        
        DetailContentView *detailsContent = [[DetailContentView alloc] initWithFrame:CGRectMake(i*320, 0, 320, gViewHeight) viewController:self topic:topic];

        [self.myScrollview addSubview:detailsContent];
        
        
    }//完结scrollview for loop
    
    //加入广告
    //读取广告资料
    NSUserDefaults *userData = [NSUserDefaults
                                standardUserDefaults];
    NSData *data = [userData objectForKey:k_key_advertising];
    if (userData != nil)
    {
        dicAdvertising = [NSKeyedUnarchiver
                          unarchiveObjectWithData:data];
        
    }

    int count = arrDataList.count;
    if (dicAdvertising)
    {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 526)];
        NSURL *url =[NSURL URLWithString:[dicAdvertising objectForKey:@"image"]];
        [image setImageWithURL:url];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(count*width, 0, width, height)];
        scrollView.contentSize = CGSizeMake(width, image.frame.size.height);
        [scrollView addSubview:image];
        [self.myScrollview addSubview:scrollView];
        count++;
        
    }
    [myScrollview setContentSize:CGSizeMake((width*count), height)];
    
    
    //添加UIPageControl
    // Init Page Control
    
    UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, gViewHeight-20, gViewWidth, 20)];
    viewBG.backgroundColor = [UIColor clearColor];
  //  [self.view addSubview:viewBG];
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, 3, viewBG.frame.size.width, viewBG.frame.size.height);
    pageControl.numberOfPages = count;
    pageControl.currentPage = 0;
    [viewBG addSubview:pageControl];
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
        pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;

    }
}

- (void)dealloc
{
    arrDataList = nil;
}





@end
