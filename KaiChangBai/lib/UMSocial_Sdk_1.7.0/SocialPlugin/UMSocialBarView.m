//
//  UMSocialBarView.m
//  SocialSDK
//
//  Created by Jiahuan Ye on 4/19/12.
//  Copyright (c) umeng.com All rights reserved.
//

#import "UMSocialBarView.h"
#import "UMSocialBar.h"
#import "UMSocialMacroDefine.h"

@implementation UMSocialBarView

@synthesize socialBarActionDelegate = _socialBarDelegate;
@synthesize themeColor = _themeColor;

- (void)dealloc {
    SAFE_ARC_RELEASE(_statusLabel);
    SAFE_ARC_RELEASE(_colorString);
    SAFE_ARC_SUPER_DEALLOC();
}

-(void)setThemeColor:(UMSBarColor)themeColor
{
    if (themeColor == UMSBarColorBlack) {
        _colorString = [[NSString alloc] initWithFormat:@"black"];
    }
    else{
        _colorString = [[NSString alloc] initWithFormat:@"white"];
    }
    [self updateButtonColor];
}

-(id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 50)];
    if (self) {
        int xValue = 12;
        int xDelta = 77;
        int yValue = 7;
        int width = 65;
        int height = self.frame.size.height - 10;
        
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.frame = CGRectMake(xValue, yValue, width, height);
        _commentButton.titleEdgeInsets = UIEdgeInsetsMake(6, 6, 0, 0);
        _commentButton.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
        [self addSubview:_commentButton];
        [_commentButton addTarget:self action:@selector(commentButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.frame = CGRectMake(xValue + xDelta,yValue , width, height);
        _likeButton.titleEdgeInsets = UIEdgeInsetsMake(6, 6, 0, 0);
        [self addSubview:_likeButton];
        [_likeButton addTarget:self action:@selector(likeButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.frame = CGRectMake(xValue + 2*xDelta, yValue, width, height);
        [self addSubview:_shareButton];
        [_shareButton addTarget:self action:@selector(shareButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        _accountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _accountButton.frame = CGRectMake(xValue + 3*xDelta, yValue, width, height);
        [self addSubview:_accountButton];
        [_accountButton addTarget:self action:@selector(accountButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        //默认选择黑色主题
        self.themeColor = UMSBarColorBlack;
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        _statusLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.font =[UIFont systemFontOfSize:13];
        _statusLabel.text = nil;
        _statusLabel.textColor = [UIColor lightGrayColor];
        _statusLabel.textAlignment = UITextAlignmentCenter;
        _statusLabel.alpha = 0;
        [self addSubview:_statusLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_action-bar-bg_%@.png",_colorString]] drawInRect:
     CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
}

//更新操作栏上的数字
-(UMSButtonTypeMask)updateButtonNumber:(UMSocialResponseEntity *)response
{
    _statusLabel.alpha = 0.0;
    _commentButton.alpha = 1.0;
    _shareButton.alpha = 1.0;
    _accountButton.alpha = 1.0;
    _likeButton.alpha = 1.0;
    
    UMSButtonTypeMask actionTypeMask = 0;
    UMSocialBar *socialBar = (UMSocialBar *)self.socialBarActionDelegate;
    UMSocialData *socialData = socialBar.socialData;
    int shareCount = [socialData getNumber:UMSNumberShare];
    if (response!= nil && response.responseType == UMSResponseShareToMutilSNS) {
        shareCount = shareCount + 1;
    }
    
    if ([_commentButton.titleLabel.text intValue] != [socialData getNumber:UMSNumberComment]) {
        [_commentButton setTitle:[NSString stringWithFormat:@"%d", [socialData getNumber:UMSNumberComment]]
                        forState:UIControlStateNormal];
        actionTypeMask = actionTypeMask | UMSButtonTypeMaskAddComment;
    }
    if ([_shareButton.titleLabel.text intValue] != shareCount) {
        actionTypeMask = actionTypeMask | UMSButtonTypeMaskShareToSNS;
        [_shareButton setTitle:[NSString stringWithFormat:@"%d",[socialData getNumber:UMSNumberShare]] forState:UIControlStateNormal];
    }
    if ([_likeButton.titleLabel.text intValue] != [socialData getNumber:UMSNumberLike]) {
        if (_likeButton.titleLabel.text.intValue > [socialData getNumber:UMSNumberLike]) {
            actionTypeMask = actionTypeMask | UMSButtonTypeMaskDisLike;
        }
        else{
            actionTypeMask = actionTypeMask | UMSButtonTypeMaskAddLike;
        }
        [_likeButton setTitle:[NSString stringWithFormat:@"%d",[socialData getNumber:UMSNumberLike]]
                     forState:UIControlStateNormal];
    }
    [self changeLikeButtonImage];
    [_likeButton setEnabled:YES];
    return actionTypeMask;
}

//改变喜欢图片
- (void) changeLikeButtonImage
{
    UIImage *bgImage = nil;
    UIImage *hlImage = nil;

    UMSocialBar *socialBar = (UMSocialBar *)self.socialBarActionDelegate;
    if (socialBar.socialData.isLike == NO) {
        bgImage = [UIImage imageNamed:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_like_off_%@.png",_colorString]];
        hlImage = [UIImage imageNamed:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_like_off_%@.png",_colorString]];
        
    }
    else {
        bgImage = [UIImage imageNamed:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_like_on_%@.png",_colorString]];
        hlImage = [UIImage imageNamed:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_like_on_%@.png",_colorString]];
    }
    [_likeButton setImage:bgImage forState:UIControlStateNormal];
    [_likeButton setImage:hlImage forState:UIControlStateHighlighted];
}

//设置按钮的样式
- (void)setButton:(UIButton *)button
            title:(NSString *)title
      normalImage:(NSString*)normalImageName 
      selectImage:(NSString *)selectImageName
         selector:(SEL)selector
{    
    [button setTitle:title forState:UIControlStateNormal];

    [button setTitleColor:[UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.0] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:11.0f]];

    button.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentCenter;

    UIImage *iconImage = [UIImage imageNamed:normalImageName];
    [button setImage:iconImage forState:UIControlStateNormal];

    UIImage *highlightImage = [UIImage imageNamed:selectImageName];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
}

//更新按钮颜色
-(void)updateButtonColor
{
    UMSocialData *socialData = ((UMSocialBar *)self.socialBarActionDelegate).socialData;
    [self setButton:_commentButton title:[NSString stringWithFormat:@"%d", [socialData getNumber:UMSNumberComment]] normalImage:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_comment_normal_%@.png", _colorString]
        selectImage:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_comment_tap_%@.png", _colorString] selector:@selector(commentButtonPress:)];
    [self setButton:_likeButton title:[NSString stringWithFormat:@"%d",[socialData getNumber:UMSNumberLike]] normalImage:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_like_off_%@.png",_colorString]
        selectImage:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_like_off_%@.png",_colorString] selector:@selector(likeButtonPress:)];
    [self setButton:_shareButton title:[NSString stringWithFormat:@"%d",[socialData getNumber:UMSNumberShare]] normalImage:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_share_normal_%@.png",_colorString]
        selectImage:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_share_tap_%@.png",_colorString] selector:@selector(shareButtonPress:)];
    [self setButton:_accountButton title:@"" normalImage:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_account_normal_%@.png",_colorString] selectImage:[NSString stringWithFormat:@"UMSocialSDKResources.bundle/SocialSDKBarThemes/UMS_account_tap_%@.png",_colorString] selector:@selector(accountButtonPress:)];
}


-(void)likeButtonPress:(id)sender
{
    [_likeButton setEnabled:NO];
    [self changeLikeButtonImage];
    
    if ([self.socialBarActionDelegate respondsToSelector:@selector(likeButtonTouched)]) {
        [self.socialBarActionDelegate likeButtonTouched];
    }
}


-(void)commentButtonPress:(id)sender
{
    if (self.socialBarActionDelegate != nil && [self.socialBarActionDelegate respondsToSelector:@selector(commentButtonTouched)]) {
        [self.socialBarActionDelegate commentButtonTouched];
    }
}

-(void)shareButtonPress:(id)sender
{
    if (self.socialBarActionDelegate != nil && [self.socialBarActionDelegate respondsToSelector:@selector(shareButtonTouched)]) {
        [self.socialBarActionDelegate shareButtonTouched];
    }
}

-(void)accountButtonPress:(id)sender
{
    if (self.socialBarActionDelegate != nil && [self.socialBarActionDelegate respondsToSelector:@selector(accountButtonTouched)]) {
        [self.socialBarActionDelegate accountButtonTouched];
    }
}

-(void)showError{
    [UIView beginAnimations:@"hidebar" context:nil];
    _statusLabel.text = @"网络不可用，数据加载失败";
    _statusLabel.alpha = 1.0;
    _commentButton.alpha = 0.0;
    _likeButton.alpha = 0.0;
    _shareButton.alpha = 0.0;
    [UIView commitAnimations];
}
@end
