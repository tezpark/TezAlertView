//
//  TezAlertView.m
//  TezAlertViewExample
//
//  Created by Taesun Park on 2015. 5. 27..
//  Copyright (c) 2015년 TezLab. All rights reserved.
//

#import "TezAlertView.h"

#define titleFont   [UIFont systemFontOfSize:16]
#define messageFont [UIFont systemFontOfSize:14]

#define kMargin(size)   size
#define UIColorFromRGBAlpha50(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.5]

static const CGFloat alertViewWidth = 280;
static const CGFloat buttonWidth    = 126;
static const CGFloat buttonHeight   = 32;


@interface TezAlertView ()
@end

@implementation TezAlertView

#pragma mark - Singleton
+ (TezAlertView *)sharedInstance {
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
    [self showAlertViewWithTitle:title
                         message:nil
              dismissButtonTitle:dismissButtonTitle
               cancelButtonTitle:nil
                    dismissBlock:dismissBlock
                     cancelBlock:nil];
}

- (void)showAlertViewWithMessage:(NSString *)message
              dismissButtonTitle:(NSString *)dismissButtonTitle
                    dismissBlock:(AlertDismissBlock)dismissBlock {
    [self showAlertViewWithTitle:nil
                         message:message
              dismissButtonTitle:dismissButtonTitle
               cancelButtonTitle:nil
                    dismissBlock:dismissBlock
                     cancelBlock:nil];
}

- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
            dismissButtonTitle:(NSString *)dismissButtonTitle
                  dismissBlock:(AlertDismissBlock)dismissBlock {
    [self showAlertViewWithTitle:title
                         message:message
              dismissButtonTitle:dismissButtonTitle
               cancelButtonTitle:nil
                    dismissBlock:dismissBlock
                     cancelBlock:nil];
}

- (void)showAlertViewWithTitle:(NSString *)title
            dismissButtonTitle:(NSString *)dismissButtonTitle
             cancelButtonTitle:(NSString *)cancelButtonTitle
                  dismissBlock:(AlertDismissBlock)dismissBlock
                   cancelBlock:(AlertCancelBlock)cancelBlock {
    [self showAlertViewWithTitle:title
                         message:nil
              dismissButtonTitle:dismissButtonTitle
               cancelButtonTitle:cancelButtonTitle
                    dismissBlock:dismissBlock
                     cancelBlock:cancelBlock];
}

- (void)showAlertViewWithMessage:(NSString *)message
              dismissButtonTitle:(NSString *)dismissButtonTitle
               cancelButtonTitle:(NSString *)cancelButtonTitle
                    dismissBlock:(AlertDismissBlock)dismissBlock
                     cancelBlock:(AlertCancelBlock)cancelBlock {
    [self showAlertViewWithTitle:nil
                         message:message
              dismissButtonTitle:dismissButtonTitle
               cancelButtonTitle:cancelButtonTitle
                    dismissBlock:dismissBlock
                     cancelBlock:cancelBlock];
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
    for (id view in [self subviews]) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
    
    
    // Create background alpha view.
    CGRect frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    [self setFrame:frame];
    self.backgroundColor = UIColorFromRGBAlpha50(0x000000);
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
    // Setting default sizes.
    CGSize titleSize = [self getSizeWithString:title font:titleFont maxSize:CGSizeMake(alertViewWidth - kMargin(20)*2, [[UIScreen mainScreen] bounds].size.height/2)];
    CGSize messageSize = [self getSizeWithString:message font:messageFont maxSize:CGSizeMake(alertViewWidth - kMargin(20)*2, [[UIScreen mainScreen] bounds].size.height/2)];
    
    // Create alert background view.
    CGFloat alertBgViewHeight = kMargin(38) + titleSize.height + (title?kMargin(10):0) + messageSize.height + kMargin(32) + buttonHeight + kMargin(12);
    
    UIView* alertBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertViewWidth, alertBgViewHeight)];
    [alertBgView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:alertBgView];
    
    // Create title & message label
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((alertViewWidth-titleSize.width)/2, kMargin(38), titleSize.width, titleSize.height)];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setFont:titleFont];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setNumberOfLines:0];
    [alertBgView addSubview:titleLabel];
    
    UILabel* messageLabel = [[UILabel alloc] initWithFrame:CGRectMake((alertViewWidth-messageSize.width)/2, title?CGRectGetMaxY(titleLabel.frame)+kMargin(10):kMargin(38), messageSize.width, messageSize.height)];
    [messageLabel setText:message];
    [messageLabel setTextColor:[UIColor blackColor]];
    [messageLabel setFont:messageFont];
    [messageLabel setTextAlignment:NSTextAlignmentCenter];
    [messageLabel setNumberOfLines:0];
    [alertBgView addSubview:messageLabel];
    
    // Create buttons
    UIButton* cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMargin(10), CGRectGetMaxY(messageLabel.frame)+kMargin(32), cancelButtonTitle?buttonWidth:0, buttonHeight)];
    [cancelBtn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[self imageWithColor:[self darkerColor:[UIColor whiteColor]]] forState:UIControlStateHighlighted];
    [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [cancelBtn.titleLabel setFont:messageFont];
    [cancelBtn addTarget:self action:@selector(onClickCancel) forControlEvents:UIControlEventTouchUpInside];
    [self setMaskToRoundingRect:cancelBtn byRoundingCorners:UIRectCornerAllCorners cornerRadious:CGSizeMake(buttonWidth/2, buttonHeight/2) borderWidth:2 borderColor:[UIColor blackColor]];
    [alertBgView addSubview:cancelBtn];
    
    UIButton* dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame)+ (cancelButtonTitle?kMargin(8):kMargin(4)), CGRectGetMaxY(messageLabel.frame)+kMargin(32), cancelButtonTitle?buttonWidth:buttonWidth*2, buttonHeight)];
    [dismissBtn setBackgroundImage:[self imageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
    [dismissBtn setBackgroundImage:[self imageWithColor:[self lighterColor:[UIColor blackColor]]] forState:UIControlStateHighlighted];
    [dismissBtn setTitle:dismissButtonTitle forState:UIControlStateNormal];
    [dismissBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dismissBtn.titleLabel setFont:messageFont];
    [dismissBtn addTarget:self action:@selector(onClickDismiss) forControlEvents:UIControlEventTouchUpInside];
    [self setMaskToRoundingRect:dismissBtn byRoundingCorners:UIRectCornerAllCorners cornerRadious:CGSizeMake(buttonWidth/2, buttonHeight/2) borderWidth:2 borderColor:[UIColor blackColor]];
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

// Will be change -  import from the dependency store
#pragma mark - TezImage (Private)
- (void)setMaskToRoundingRect:(UIView*)view byRoundingCorners:(UIRectCorner)corners cornerRadious:(CGSize)size borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor {
    UIBezierPath* rectPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:size];
    
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rectPath.CGPath];
    
    view.layer.mask = shape;
    
    if(borderWidth > 0){
        CAShapeLayer* borderPath = [CAShapeLayer layer];
        borderPath.path = rectPath.CGPath;
        [borderPath setFillColor:[[UIColor clearColor]CGColor]];
        [borderPath setStrokeColor:[borderColor CGColor]];
        [borderPath setLineWidth:borderWidth];
        [view.layer addSublayer:borderPath];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIColor *)lighterColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2, 1.0)
                               green:MIN(g + 0.2, 1.0)
                                blue:MIN(b + 0.2, 1.0)
                               alpha:a];
    return nil;
}

- (UIColor *)darkerColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}

// Will be change -  import from the dependency store
#pragma mark - TezSize (Private)
- (CGSize)getSizeWithString:(NSString*)string font:(UIFont *)font maxSize:(CGSize)maxSize {
    // HTML tag
    NSString* refineStr = [string stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    refineStr = [refineStr stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    refineStr = [refineStr stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    
    CGRect textFrame = [refineStr boundingRectWithSize:maxSize
                                               options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:font}
                                               context:nil];
    CGSize stringSize = textFrame.size;
    return stringSize;
}


@end
