//
//  UIHelper.m
//  dashBoardDetail
//
//  Created by Planet on 2/17/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper

+ (UIColor *)colorWithHexString:(NSString *)hexStr
{
    float alpha;
    NSString *newHexStr;
    NSCharacterSet *cSet = [NSCharacterSet characterSetWithCharactersInString:@"/-_,~^*&\\ "];
    if(![hexStr hasPrefix:@"#"]) hexStr = [NSString stringWithFormat:@"#%@", hexStr];
    if([hexStr rangeOfCharacterFromSet:cSet].location != NSNotFound) {
        
        NSScanner *scn = [NSScanner scannerWithString:hexStr];
        [scn scanUpToCharactersFromSet:cSet intoString:&newHexStr];
        alpha = [[[hexStr componentsSeparatedByCharactersInSet:cSet] lastObject] floatValue];
        
    } else {
        
        newHexStr = hexStr;
        alpha = 1.0f;
        
    }
    
    const char *cStr = [newHexStr cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [self colorWithHex:x andAlpha:alpha];
}
+ (UIColor *)colorWithHex:(UInt32)color andAlpha:(float)alpha
{
    unsigned char r, g, b;
    b = color & 0xFF;
    g = (color >> 8) & 0xFF;
    r = (color >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:alpha];
}
+(void)hideSpinner  {
    [SVProgressHUD dismiss];
}
/**show Spinner with message*/
+(void) showSpinnerWithMessage:(NSString *) message {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:message];
}

+(void) showNotificationWithType:(UINotificationAlertType) type message:(NSString *) message duration:(NSTimeInterval) duration {
    [[UINotificationAlertView notificationView] displayNotificationWithType:type
                                                                    message:message
                                                                   duration:duration];
}
@end
