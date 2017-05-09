//
//  TezAlertView.h
//  TezAlertViewExample
//
//  Created by Taesun Park on 2015. 5. 27..
//  Copyright (c) 2015년 TezLab. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertDismissBlock) (void);
typedef void (^AlertCancelBlock) (void);


@interface TezAlertView : UIView

@property(nonatomic, copy) AlertDismissBlock dismissBlock;
@property(nonatomic, copy) AlertCancelBlock cancelBlock;

/**
 *  TezAlertView singleton
 *
 *  @return Singleton object
 */
+ (TezAlertView *)sharedInstance;

/**
 *  Title only & one button
 *
 *  @param title              Title text
 *  @param dismissButtonTitle Dismiss button text
 *  @param dismissBlock       Dismiss block
 */
- (void)showAlertViewWithTitle:(NSString *)title
            dismissButtonTitle:(NSString *)dismissButtonTitle
                  dismissBlock:(AlertDismissBlock)dismissBlock;

/**
 *  Message only & one button
 *
 *  @param message            Message text
 *  @param dismissButtonTitle Dismiss button text
 *  @param dismissBlock       Dismiss block
 */
- (void)showAlertViewWithMessage:(NSString *)message
              dismissButtonTitle:(NSString *)dismissButtonTitle
                    dismissBlock:(AlertDismissBlock)dismissBlock;

/**
 *  Title, message and one button
 *
 *  @param title              Title text
 *  @param message            Message text
 *  @param dismissButtonTitle Dismiss button text
 *  @param dismissBlock       Dismiss block
 */
- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
            dismissButtonTitle:(NSString *)dismissButtonTitle
                  dismissBlock:(AlertDismissBlock)dismissBlock;

/**
 *  Title only & two button
 *
 *  @param title              Title text
 *  @param dismissButtonTitle Dismiss button text
 *  @param cancelButtonTitle  Cancel button text
 *  @param dismissBlock       Dismiss block
 *  @param cancelBlock        Cancel block
 */
- (void)showAlertViewWithTitle:(NSString *)title
            dismissButtonTitle:(NSString *)dismissButtonTitle
             cancelButtonTitle:(NSString *)cancelButtonTitle
                  dismissBlock:(AlertDismissBlock)dismissBlock
                   cancelBlock:(AlertCancelBlock)cancelBlock;

/**
 *  Message only & two button
 *
 *  @param message            Message text
 *  @param dismissButtonTitle Dismiss button text
 *  @param cancelButtonTitle  Cancel button text
 *  @param dismissBlock       Dismiss block
 *  @param cancelBlock        Cancel block
 */
- (void)showAlertViewWithMessage:(NSString *)message
              dismissButtonTitle:(NSString *)dismissButtonTitle
               cancelButtonTitle:(NSString *)cancelButtonTitle
                    dismissBlock:(AlertDismissBlock)dismissBlock
                     cancelBlock:(AlertCancelBlock)cancelBlock;

/**
 *  Title, message and two button
 *
 *  @param title              Title text
 *  @param message            Message text
 *  @param dismissButtonTitle Dismiss button text
 *  @param cancelButtonTitle  Cancel button text
 *  @param dismissBlock       Dismiss block
 *  @param cancelBlock        Cancel block
 */
- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
            dismissButtonTitle:(NSString *)dismissButtonTitle
             cancelButtonTitle:(NSString *)cancelButtonTitle
                  dismissBlock:(AlertDismissBlock)dismissBlock
                   cancelBlock:(AlertCancelBlock)cancelBlock;
@end
