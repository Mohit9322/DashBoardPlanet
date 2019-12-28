//
//  UIHelper.h
//  dashBoardDetail
//
//  Created by Planet on 2/17/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UINotificationAlertView.h" 

@interface UIHelper : NSObject
+ (UIColor *)colorWithHexString:(NSString *)hexStr;
+(void)hideSpinner;
+(void) showSpinnerWithMessage:(NSString *) message;
+(void) showNotificationWithType:(UINotificationAlertType) type message:(NSString *) message duration:(NSTimeInterval) duration;
@end
