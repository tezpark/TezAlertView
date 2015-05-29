//
//  TezAlertView.m
//  TezAlertViewExample
//
//  Created by Taesun Park on 2015. 5. 27..
//  Copyright (c) 2015년 TezLab. All rights reserved.
//

#import "TezAlertView.h"
#import "NSString+TezSize.h"
#import "UIImage+TezStetch.h"


#define font(size)      [UIFont systemFontOfSize:size]
#define kMargin(size)   size
#define UIColorFromRGBAlpha50(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.5]

static const CGFloat alertViewWidth = 280;
static const CGFloat buttonWidth = 126;
static const CGFloat buttonHeight = 32;

@interface TezAlertView ()

@end

@implementation TezAlertView

#pragma mark - Singleton
+(TezAlertView *)sharedInstance {
    static TezAlertView *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[TezAlertView alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark - Show alert
- (void)showAlertViewWithTitle:(NSString *)title
            dismissButtonTitle:(NSString *)dismissButtonTitle
                  dismissBlock:(AlertDismissBlock)dismissBlock {
    [self showAlertViewWithTitle:title message:nil dismissButtonTitle:dismissButtonTitle cancelButtonTitle:nil dismissBlock:dismissBlock cancelBlock:nil];
}

- (void)showAlertViewWithMessage:(NSString *)message
              dismissButtonTitle:(NSString *)dismissButtonTitle
                    dismissBlock:(AlertDismissBlock)dismissBlock {
    [self showAlertViewWithTitle:nil message:message dismissButtonTitle:dismissButtonTitle cancelButtonTitle:nil dismissBlock:dismissBlock cancelBlock:nil];
}

- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
            dismissButtonTitle:(NSString *)dismissButtonTitle
                  dismissBlock:(AlertDismissBlock)dismissBlock {
    [self showAlertViewWithTitle:title message:message dismissButtonTitle:dismissButtonTitle cancelButtonTitle:nil dismissBlock:dismissBlock cancelBlock:nil];
}

- (void)showAlertViewWithTitle:(NSString *)title
            dismissButtonTitle:(NSString *)dismissButtonTitle
             cancelButtonTitle:(NSString *)cancelButtonTitle
                  dismissBlock:(AlertDismissBlock)dismissBlock
                   cancelBlock:(AlertCancelBlock)cancelBlock {
    [self showAlertViewWithTitle:title message:nil dismissButtonTitle:dismissButtonTitle cancelButtonTitle:cancelButtonTitle dismissBlock:dismissBlock cancelBlock:cancelBlock];
}

- (void)showAlertViewWithMessage:(NSString *)message
            dismissButtonTitle:(NSString *)dismissButtonTitle
             cancelButtonTitle:(NSString *)cancelButtonTitle
                  dismissBlock:(AlertDismissBlock)dismissBlock
                   cancelBlock:(AlertCancelBlock)cancelBlock {
    [self showAlertViewWithTitle:nil message:message dismissButtonTitle:dismissButtonTitle cancelButtonTitle:cancelButtonTitle dismissBlock:dismissBlock cancelBlock:cancelBlock];
}

- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
            dismissButtonTitle:(NSString *)dismissButtonTitle
             cancelButtonTitle:(NSString *)cancelButtonTitle
                  dismissBlock:(AlertDismissBlock)dismissBlock
                   cancelBlock:(AlertCancelBlock)cancelBlock {
    
    // Setting blocks
    self.dismissBlock = dismissBlock;
    self.cancelBlock = cancelBlock;
    
    
    // If already added this view, remove from super view.
    [self removeFromSuperview];
    
    
    // Create background alpha view.
    CGRect frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    [self setFrame:frame];
    self.backgroundColor = UIColorFromRGBAlpha50(0x000000);
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
    // Setting default sizes.
    CGSize titleSize = [title getSizeWithFont:font(16) maxSize:CGSizeMake(alertViewWidth - kMargin(20)*2, [[UIScreen mainScreen] bounds].size.height/2)];
    CGSize messageSize = [message getSizeWithFont:font(14) maxSize:CGSizeMake(alertViewWidth - kMargin(20)*2, [[UIScreen mainScreen] bounds].size.height/2)];
    
    // Create alert background view.
    CGFloat alertBgViewHeight = kMargin(38) + titleSize.height + (title?kMargin(10):0) + messageSize.height + kMargin(32) + buttonHeight + kMargin(12);
    
    UIView* alertBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertViewWidth, alertBgViewHeight)];
    [alertBgView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:alertBgView];
    
    
    // Create title & message label
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((alertViewWidth-titleSize.width)/2, kMargin(38), titleSize.width, titleSize.height)];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setFont:font(16)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setNumberOfLines:0];
    [alertBgView addSubview:titleLabel];
    
    UILabel* messageLabel = [[UILabel alloc] initWithFrame:CGRectMake((alertViewWidth-messageSize.width)/2, title?CGRectGetMaxY(titleLabel.frame)+kMargin(10):kMargin(38), messageSize.width, messageSize.height)];
    [messageLabel setText:message];
    [messageLabel setTextColor:[UIColor blackColor]];
    [messageLabel setFont:font(14)];
    [messageLabel setTextAlignment:NSTextAlignmentCenter];
    [messageLabel setNumberOfLines:0];
    [alertBgView addSubview:messageLabel];
    
    
    // Create buttons
    UIButton* cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMargin(10), CGRectGetMaxY(messageLabel.frame)+kMargin(32), cancelButtonTitle?buttonWidth:0, buttonHeight)];
    [cancelBtn setBackgroundImage:[[UIImage imageNamed:@"login_btn"] stretchableImageForAnyOSwithCenterCap] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[[UIImage imageNamed:@"login_btn_prs"] stretchableImageForAnyOSwithCenterCap] forState:UIControlStateHighlighted];
    [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [cancelBtn.titleLabel setFont:font(14)];
    [cancelBtn addTarget:self action:@selector(onClickCancel) forControlEvents:UIControlEventTouchUpInside];
    [alertBgView addSubview:cancelBtn];
    
    UIButton* dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame)+ (cancelButtonTitle?kMargin(8):kMargin(4)), CGRectGetMaxY(messageLabel.frame)+kMargin(32), cancelButtonTitle?buttonWidth:buttonWidth*2, buttonHeight)];
    [dismissBtn setBackgroundImage:[[UIImage imageNamed:@"login_btn_02"] stretchableImageForAnyOSwithCenterCap] forState:UIControlStateNormal];
    [dismissBtn setBackgroundImage:[[UIImage imageNamed:@"login_btn_prs"] stretchableImageForAnyOSwithCenterCap] forState:UIControlStateHighlighted];
    [dismissBtn setTitle:dismissButtonTitle forState:UIControlStateNormal];
    [dismissBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dismissBtn.titleLabel setFont:font(14)];
    [dismissBtn addTarget:self action:@selector(onClickDismiss) forControlEvents:UIControlEventTouchUpInside];
    [alertBgView addSubview:dismissBtn];
    
    
    // Background view align center.
    UIWindow* topWindow = [[UIApplication sharedApplication] keyWindow];
    alertBgView.center = topWindow.center;
    
    [self show];
}

#pragma mark - Show & Dismiss

- (void)show {
    UIWindow* topWindow = [[UIApplication sharedApplication] keyWindow];
    
    [topWindow addSubview:self];
}

- (void)dismiss {
    [self removeFromSuperview];
}

#pragma mark - Click actions
- (void)onClickDismiss {
    _dismissBlock();
    
    [self dismiss];
}

- (void)onClickCancel {
    _cancelBlock();
    
    [self dismiss];
}

@end
