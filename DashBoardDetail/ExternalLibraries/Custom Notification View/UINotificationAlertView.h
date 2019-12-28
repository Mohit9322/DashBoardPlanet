//
//  UINotificationAlertView.h
//  ePazer
//
//  Created by akshay on 8/30/16.
//  Copyright © 2016 ruby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum    {
    UINotificationAlertTypeMessage         = 1231,
    UINotificationAlertTypeWarning         = 1232,
    UINotificationAlertTypeError           = 1233,
    UINotificationAlertTypeNetworkError    = 1234,
} UINotificationAlertType;

@interface UINotificationAlertView : UIView

/**To acess the singleton notificationView object*/
+ (UINotificationAlertView*)notificationView;

/**
 * Displays a notification with the indicated message for the indicated
 * duration.
 * @param message
 *        The content of the message to be displayed.
 * @param duration
 *        The amount of seconds for which the notification should be displayed,
 *        not including the animate in and out times.
 */
-(void) displayNotificationWithType:(UINotificationAlertType) type message:(NSString *) message duration:(NSTimeInterval) duration;
@end
