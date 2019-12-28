//
//  BaseObject.h
//  displayDeviceContact
//
//  Created by Planet on 2/15/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Status Constants
typedef enum {
    StatusSuccess                           = 0,
    StatusFail                              = 1,
    StatusReachLimit                        = 2,
    StatusNoChange                          = 3,
} Status;

typedef enum    {
    MediaTypeImage      = 1,
    MediaTypeAudio      = 2,
    MediaTypeVideo      = 3,
    MediaTypeFile       = 4
} MediaType;

#pragma mark - Block declaration
typedef void (^iCompletion)(Status iStatus,  id response); // if task fail than in response send the error message, If sucessfull, then send the data in response object.
typedef void (^iSuccess)    (Status iStatus, id response);
typedef void (^iFailure)    (Status iStatus, NSString *errorMessage);
typedef void (^iStatus)     (Status iStatus);
typedef void (^iFinished)   (BOOL isFinished);

#pragma mark String Constants
static NSString * const     kMessage                                       =     @"Message";
static NSString * const     kStatus                                        =     @"Status";
static NSString * const     kSeperator                                     =     @"__";
static NSString * const     kEmptyString                                   =     @"";
static NSString  * const    kAppDatabaseName                               = @"ePazer";
static NSString  * const    kAppDatabaseExtension                          = @".sqlite";
static NSString * const     kAppLaunchFirstTime                            = @"HasLaunchedOnce";

@interface BaseObject : NSObject
@end
