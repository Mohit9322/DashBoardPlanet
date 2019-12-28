//
//  ModelManager.h
//  displayDeviceContact
//
//  Created by Planet on 2/15/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface ModelManager : NSObject
+(ModelManager*)modelManager ;
+(void)initializeModelManager;                      // to initialize the Model Manager

#pragma mark - Get Reachablity Status
/**get network Status*/
-(BOOL) getNetworkStatus;
- (void)loginApiWithoutParameters:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)dashBoardDetailApiWithoutParameters:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)VoucherSaleReportDaywise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)VoucherSaleReportMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)VoucherSaleReportYearwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)userRegDayWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)userRegMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)userRegYearWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)VoucherSaleReportAll:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)UserRegReportAll:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)AppDownLoadsDetailApi:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)VoucherSoldNewExistingUserCheck:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)ViewStateWiseCityWiseHotelWiseInventoryDetail:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)ViewStateWiseCityWiseHotelWiseInventoryDetail_Tomorrow:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)ViewStateWiseCityWiseHotelWiseInventoryDetail_DayAfterTomorrow:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)VoucherSaleReportPreviousMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)VoucherSaleReportBeforePreviousMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)userRegBeforePreviousMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)userRegPreviousMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)VoucherSaleReportTwoBeforePreviousMonthwise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
- (void)userRegTwoBeforePreviousMonthWise:( NSString *)apiURL success:(iSuccess) success failure:(iFailure) failure;
@end
