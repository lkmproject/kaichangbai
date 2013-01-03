//
//  DetailsViewController.m
//  KaiChangBai
//
//  Created by app-pot on 26/12/12.
//
//

#import "DetailsViewController.h"

//vendor
#import "UIImageView+WebCache.h"

//db
#import "TopicDao.h"

//model
#import "Topic.h"
#import "BodyModel.h"

//category
#import "UILabel+Extension.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
    
    
    //添加UIScrollView    
    self.myScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, gViewWidth, gViewHeight-20)];
    self.myScrollview.delegate = self;
    self.myScrollview.pagingEnabled = YES;
    self.myScrollview.showsVerticalScrollIndicator = NO;
    self.myScrollview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.myScrollview];
    
    arrDataList = [[[TopicDao sharedInstance] getAllResult:strCategoryID] mutableCopy];
    
      
    //初始化内容
    int width = self.myScrollview.frame.size.width;
    int height = self.myScrollview.frame.size.height;

    for (int i = 0 ; i < arrDataList.count; i++)
    {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(i*width, 0, width, height)];
        scrollView.contentSize = CGSizeMake(width, height);
        [self.myScrollview addSubview:scrollView];
        
        Topic *topic = (Topic*)[arrDataList objectAtIndex:i];
        
        int y = 10;
        //加入title
        UILabel* labTitle = [[UILabel alloc] init];
        labTitle.textAlignment = UITextAlignmentCenter;
        labTitle.font = [UIFont boldSystemFontOfSize:24];
        [labTitle setBackgroundColor:[UIColor clearColor]];
        labTitle.text = [NSString stringWithFormat:@"“%@”",topic.strTitle];
        [labTitle setDynamicHeight:CGPointMake(10, y) width:width-40];
        [scrollView addSubview:labTitle];
    
        
        //加入作者
        UILabel* labAuthor = [[UILabel alloc] init];
        labAuthor.font = [UIFont systemFontOfSize:14];
        labAuthor.textColor = [UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:1.0];
        [labAuthor setBackgroundColor:[UIColor clearColor]];
        labAuthor.text = [NSString stringWithFormat:@"作者：%@",topic.strOwn];
        y = [labTitle getLabelHeight] +40;
        [labAuthor setDynamicHeight:CGPointMake(10, y) width:width];
        [scrollView addSubview:labAuthor];
        
        //加入分割线
        y = y+ [labAuthor getLabelHeight]+2;
        UIView *breakLine = [[UIView alloc] initWithFrame:CGRectMake(10, y, 250, 1)];
        [breakLine setBackgroundColor:[UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:0.55]];
        [scrollView addSubview:breakLine];
        
        //加入聊天内容
        y = y + [labAuthor getLabelHeight] +17;
        NSArray *array = [[topic.strBodyJsonFormat objectFromJSONString] copy];
        for (int i = 0; i <array.count; i++)
        {
            BodyModel *bodyModel = [[BodyModel alloc] init:[array objectAtIndex:i]];
            UILabel* labContent = [[UILabel alloc] init];
            labContent.backgroundColor = [UIColor clearColor];
            labContent.font = [UIFont systemFontOfSize:18];
            labContent.text = bodyModel.strBody;
            
            int padding = 50;
            if ([bodyModel.strGender isEqualToString:@"f"])
            {
                
                labContent.textColor = [UIColor colorWithRed:255/255.0 green:0/255.0 blue:102/255.0 alpha:1.0];
                
                UIImage* bgImage = [[UIImage imageNamed:@"bg_msgbox_right"] stretchableImageWithLeftCapWidth:20  topCapHeight:15];
                [labContent setDynamicHeight:CGPointMake(padding/2-15, 10) width:width-padding];
                UIImageView *labelBackground = [[UIImageView alloc] initWithFrame:CGRectMake(320 - [labContent getLabelWidth] - padding, y, [labContent getLabelWidth]+padding/2, [labContent getLabelHeight]+padding/2)];
                [labelBackground setImage:bgImage];
                [labelBackground addSubview:labContent];
                [scrollView addSubview:labelBackground];
                y = y + labelBackground.frame.size.height +10;
                 
          
            }else
            {
                 labContent.textColor = [UIColor colorWithRed:0/255.0 green:144/255.0 blue:255/255.0 alpha:1.0];
                
                 [labContent setDynamicHeight:CGPointMake(15, 10) width:width-padding];
                 UIImage* bgImage = [[UIImage imageNamed:@"bg_msgbox_02"] stretchableImageWithLeftCapWidth:20  topCapHeight:15];
                 UIImageView *labelBackground = [[UIImageView alloc] initWithFrame:CGRectMake(10, y, [labContent getLabelWidth]+padding/2, [labContent getLabelHeight]+padding/2)];
                 [labelBackground setImage:bgImage];
                 [labelBackground addSubview:labContent];
                 [scrollView addSubview:labelBackground];
                 y = y + labelBackground.frame.size.height +10;
                 

            }
        
            
        }
        
        //加入提议图片
        y = y + 15;
        UIImageView *imageRecommend = [[UIImageView alloc] initWithFrame:CGRectMake(10, y, 40, 35)];
        [imageRecommend setImage:[UIImage imageNamed:@"recommend.png"]];
        [scrollView addSubview:imageRecommend];
        
        int labRecommendX = imageRecommend.frame.origin.x + imageRecommend.frame.size.width + 5;
        UILabel *labRecommend = [[UILabel alloc] initWithFrame:CGRectMake(labRecommendX, y+5, 250, 20)];
        labRecommend.textColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
        [labRecommend setBackgroundColor:[UIColor clearColor]];
        labRecommend.font = [UIFont boldSystemFontOfSize:20];
        labRecommend.text = @"点评：";
        [scrollView addSubview:labRecommend];
        y = y + imageRecommend.frame.size.height + 15;

        
        //加入提议内容

        UILabel* labRecommendContent = [[UILabel alloc] init];
        labRecommendContent.font = [UIFont systemFontOfSize:18];
        [labRecommendContent setBackgroundColor:[UIColor clearColor]];
        labRecommendContent.text = topic.strRecommend;
        [labRecommendContent setDynamicHeight:CGPointMake(10, y) width:width-15];
        [scrollView addSubview:labRecommendContent];
        
        
        y = y + [labRecommendContent getLabelHeight]+10;
        [scrollView setContentSize:CGSizeMake(320, y)];

        
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
        
        UIButton *buttonPhone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonPhone addTarget:self
                   action:@selector(actPhoneCall)
         forControlEvents:UIControlEventTouchDown];
        [buttonPhone setBackgroundImage:[UIImage imageNamed:@"btnPhone"] forState:UIControlStateNormal];
        buttonPhone.frame = CGRectMake(80, height-44 , 161.0, 42.0);
        
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(count*width, 0, width, height)];
        scrollView.contentSize = CGSizeMake(width, image.frame.size.height);
        [scrollView addSubview:image];
        
        [scrollView addSubview:buttonPhone];
        
        [self.myScrollview addSubview:scrollView];
        count++;

    }
    [myScrollview setContentSize:CGSizeMake((width*count), height)];
    
    //添加UIPageControl
    // Init Page Control
    
    UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, self.myScrollview.frame.size.height, gViewWidth, 20)];
    viewBG.backgroundColor = [UIColor blackColor];
    [self.view addSubview:viewBG];
    
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

#pragma mark - local method

- (void)actPhoneCall
{
    NSString *strPhoneNumber = [NSString stringWithFormat:@"tel:%@",[dicAdvertising objectForKey:@"phone"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strPhoneNumber]];

}

@end
