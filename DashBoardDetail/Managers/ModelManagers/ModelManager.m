//
//  ModelManager.m
//  displayDeviceContact
//
//  Created by Planet on 2/15/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "ModelManager.h"
#import "APIManager.h"
@implementation ModelManager
+(ModelManager*)modelManager    {
    static ModelManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ModelManager alloc] init];
    });
    return sharedInstance;
}

+(void)initializeModelManager {
    [ModelManager modelManager];
}

-(id)init {
    if(self = [super init]) {
        
    }
    return self;
}

-(void) dealloc {
   }

#pragma mark - Get Reachablity Status
/**get network Status*/
-(BOOL) getNetworkStatus   {
    return [[APIManager APIManager] getNetworkStatus];
}


/********************  Login Api **********************/
- (void)loginApiWithoutParameters:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] loginApiWithoutParameters:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });           } failure:^(Status iStatus, NSString *errorMessage) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                failure(iStatus, errorMessage);
            });
        }];
}


- (void)dashBoardDetailApiWithoutParameters:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] dashBoardDetailApiWithoutParameters:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)VoucherSaleReportDaywise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] VoucherSaleReportDaywise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)VoucherSaleReportMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] VoucherSaleReportMonthwise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}
- (void)VoucherSaleReportPreviousMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] VoucherSaleReportMonthwise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}
- (void)VoucherSaleReportBeforePreviousMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] VoucherSaleReportMonthwise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)VoucherSaleReportTwoBeforePreviousMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] VoucherSaleReportTwoBeforePreviousMonthwise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)VoucherSaleReportYearwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] VoucherSaleReportYearwise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)userRegDayWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] userRegDayWise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)userRegMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] userRegMonthWise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)userRegPreviousMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] userRegPreviousMonthWise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)userRegBeforePreviousMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] userRegBeforePreviousMonthWise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}
- (void)userRegTwoBeforePreviousMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] userRegTwoBeforePreviousMonthWise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}
- (void)userRegYearWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] userRegYearWise:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)VoucherSaleReportAll:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] VoucherSaleReportAll:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}
- (void)VoucherSoldNewExistingUserCheck:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] VoucherSaleReportAll:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)ViewStateWiseCityWiseHotelWiseInventoryDetail:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] VoucherSaleReportAll:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}
- (void)ViewStateWiseCityWiseHotelWiseInventoryDetail_Tomorrow:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] ViewStateWiseCityWiseHotelWiseInventoryDetail_Tomorrow:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)ViewStateWiseCityWiseHotelWiseInventoryDetail_DayAfterTomorrow:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] ViewStateWiseCityWiseHotelWiseInventoryDetail_DayAfterTomorrow:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}
- (void)UserRegReportAll:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] UserRegReportAll:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}

- (void)AppDownLoadsDetailApi:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure   {
    
    [[APIManager APIManager] AppDownLoadsDetailApi:apiURL success:^(Status iStatus, id response) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            success(iStatus, response);
        });
    } failure:^(Status iStatus, NSString *errorMessage) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            failure(iStatus, errorMessage);
        });
    }];
}
@end
