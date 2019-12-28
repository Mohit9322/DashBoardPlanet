//
//  UINotificationAlertView.m
//  ePazer
//
//  Created by akshay on 8/30/16.
//  Copyright © 2016 ruby. All rights reserved.
//

#import "UINotificationAlertView.h"
#import "CWStatusBarNotification.h"


#pragma mar -CustomAlertView class Defination
/**CustomAlertView use to customize the notification view*/
@interface CustomAlertView : UIView
@property (nonatomic, strong) UIButton *titleBtn;

-(void) setAlertWithType:(UINotificationAlertType)  alertType message:(NSString *) message;
@end

@implementation CustomAlertView
@synthesize titleBtn;

- (id)init {
    if ((self = [super init])) {
        self.frame = CGRectMake(0, 0, 320, 64);
        
        [self setBackgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9]];
        
        titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, [[UIScreen mainScreen] bounds].size.width - 10, 55)];
        titleBtn.userInteractionEnabled = NO;
        [titleBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleBtn setImage:[UIImage imageNamed: @"ErrorIcon"] forState:UIControlStateNormal];
        [titleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 25)];
        titleBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview: titleBtn];
    }
    
    return self;
}

-(void) dealloc {
    titleBtn = nil;
}

#pragma mark - set alert type
-(void) setAlertWithType:(UINotificationAlertType)  alertType message:(NSString *) message  {
    switch (alertType) {
        case UINotificationAlertTypeError:
            [titleBtn setImage:[UIImage imageNamed: @"ErrorIcon"] forState:UIControlStateNormal];
            break;
        case UINotificationAlertTypeWarning:
            [titleBtn setImage:[UIImage imageNamed: @"WarningIcon"] forState:UIControlStateNormal];
            break;
        case UINotificationAlertTypeNetworkError:
            [titleBtn setImage:[UIImage imageNamed: @"ErrorIcon"] forState:UIControlStateNormal];
            break;
        case UINotificationAlertTypeMessage:
            [titleBtn setImage:[UIImage imageNamed: @"MessageIcon"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    [titleBtn setTitle:message forState:UIControlStateNormal];
}
@end



#pragma mar -UINotificationAlertView class Defination
@interface  UINotificationAlertView ()

@property (nonatomic, strong)            CWStatusBarNotification    *_CWSNotificationView;
@property (nonatomic, strong)            CustomAlertView            *_customAlertView;
@end

@implementation UINotificationAlertView
@synthesize _CWSNotificationView;
@synthesize _customAlertView;

static UINotificationAlertView  *_NotificationAlertView;

+ (UINotificationAlertView*)notificationView {
    if (_NotificationAlertView == nil) {
        _NotificationAlertView = [[UINotificationAlertView alloc] init];
    }
    return _NotificationAlertView;
}

- (id)init {
    if ((self = [super init])) {
        [self setupNotificationView];
    }
    return self;
}

-(void)dealloc  {
    _NotificationAlertView      = nil;
    _CWSNotificationView        = nil;
    _customAlertView            = nil;
}

#pragma mark - Setup Notification View to show the alerts
-(void) setupNotificationView   {
    _CWSNotificationView = [CWStatusBarNotification new];
    _CWSNotificationView.notificationLabelBackgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
    _CWSNotificationView.notificationAnimationInStyle      = CWNotificationAnimationStyleTop;
    _CWSNotificationView.notificationAnimationOutStyle     = CWNotificationAnimationStyleTop;
    _CWSNotificationView.notificationStyle                 = CWNotificationStyleNavigationBarNotification;
    _customAlertView                                       = [[CustomAlertView alloc] init];
}

/**
 * Displays a notification with the indicated message for the indicated
 * duration.
 * @param message
 *        The content of the message to be displayed.
 * @param duration
 *        The amount of seconds for which the notification should be displayed,
 *        not including the animate in and out times.
 */

-(void) displayNotificationWithType:(UINotificationAlertType) type message:(NSString *) message duration:(NSTimeInterval) duration  {
    [_customAlertView setAlertWithType:type message:message];
    [self._CWSNotificationView displayNotificationWithView:_customAlertView forDuration:duration];
}
@end
