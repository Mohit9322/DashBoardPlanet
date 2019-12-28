//
//  DashboardDetailViewController.m
//  DashBoardDetail
//
//  Created by Planet on 2/17/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "DashboardDetailViewController.h"
#import "ModelManager.h"
#import "UIHelper.h"
#import "UIConstant.h"
#import "DetailTableViewCell.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>
#import "MNMBottomPullToRefreshManager.h"
#import "SoldVouchersTableViewCell.h"
#import "InventroyDetailTableViewCell.h"
#import "PreviousMonthWiseTableViewCell.h"



@interface DashboardDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel                                               *dateLabel;
    UIButton                                              *IncrementDateBtn;
    NSMutableArray                                        *responseArr;
    UIView                                                *baseView;
    UIView                                                *dateBaseView;
    UIButton                                              *decrementDateBtn;
    NSDictionary                                          *responseDict;
    NSMutableArray                                        *keyArrForTableView;
    NSMutableArray                                        *valueArrForTableView;
    UITableView                                           *detailTableView;
    UIImageView                                           *icsLogoImageView;
    UIButton                                              *dismissControllerBtn;
    NSMutableArray                                        *responseArr2;
    NSMutableArray                                        *responseArr3;
    NSMutableArray                                        *responseArr4;
 
    NSDictionary                                          *responseDict5;
    NSDictionary                                          *responseDict6;
    NSDictionary                                          *responseDict7;
    NSDictionary                                          *responseDict8;
    NSDictionary                                          *responseDict9;
    NSDictionary                                          *responseDict2;
    NSDictionary                                          *responseDict3;
    NSDictionary                                          *responseDict4;
    NSDictionary                                          *responseDict10;

    
    NSMutableArray                                        *reportArray;
//    NSMutableArray                                        *reportMonthArray;
//    NSMutableArray                                        *reportYearArray;
    NSMutableArray                                        *userRegDayWiseArray;
    NSMutableArray                                        *userRegMonthWiseArray;
    NSMutableArray                                        *userRegYearWiseArray;
    NSMutableArray                                        *userRegAllArray;
    NSMutableArray                                        *voucherSaleAllArray;
    NSMutableArray                                        *appDownlaodsArray;
    NSMutableArray                                        *voucherSoldExistingUser;
    
//    NSMutableArray                                        *soldTotalArray;

    
    int                                                   firstTimeVar;
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
  //  int reloads_;
    int newUserRow;
    int newUserSoldVoucher;
    int existUserRow;
    int existUserSoldVoucher;
    int firsttimeInventoryDetailFetchData;
    
    NSString *newUserValueStr;
    NSString *existUserValueStr;
    NSString *DateOFInventoryDetail;
    
    NSMutableArray *inventoryDetailArr;
    NSMutableArray *inventoryDetailArrTomorrow;
    NSMutableArray *inventoryDetailArrDayAfterTomorrow;
    
    NSString *tomorrowDateOFInventoryDetail;
    NSString *dayAfterTomorrowDateOFInventoryDetail;
    
   
    
    NSString *totalRegisteredPreviousMonthValue;
    NSString *totalRegisterdMonthBeforeValue;
    NSString *totalRegisteredMonthTwoBeforeValue;
    
    NSString *totalSoldPreviousMonthValue;
    NSString *totalSoldMonthBeforeValue;
    NSString *totalSoldMonthTwoBeforeValue;

    
    NSString *previousMonthDateStr;
    NSString *beforePreviousMonthDateStr;
    NSString *twoBeforePreviousMonthDateStr;
    
    NSMutableArray *totalSoldPreviousMonthArr;
    NSMutableArray *totalSoldBeforePreviousMonthArr;
    NSMutableArray *totalSoldTwoBeforePreviousMonthArr;
    NSMutableDictionary *voucherSoldReprtDictThisMonth;
    
    NSMutableArray *totalRegisterdPreviousMonthArr;
    NSMutableArray *totalRegisteredBeforePreviousMonthArr;
    NSMutableArray *totalRegisteredTwoBeforePreviousMonthArr;
    
    NSString *previousMonthName;
    NSString *BeforePreviousMonthName;
    NSString *TwoBeforePreviousMonthName;
    
    NSString *totalRefundPreviousMonthValue;
    NSString *totalRefundBeforePreviousMonthValue;
    NSString *totalRefundBeforeTwoPreviousMonthValue;
    
    NSString *corporateRegAll;
    NSString *webSaleAll;
    NSString *wapSaleAll;
    NSString *appSaleAll;
    NSString *corporateSaleAll;
    
    NSString *CorporateB2BAll;
    
    NSString *noTagingSaleDaywise;
    NSString *noTagingSaleMonthWise;
    NSString *noTagingSaleYearWise;
    NSString *noTaggingSaleAll;
    
    
    NSString *naVoucherSaleDayWise;
    NSString *naVoucherSaleMonthWise;
    NSString *naVoucherSaleyearWise;
    NSString *naVoucherSaleAll;
    
    NSString *naUserRegDayWise;
    NSString *naUserRegMonthWise;
    NSString *naUserRegYearWise;
    NSString *naUserRegAll;
    
    NSString *amexuserRegDaywise;
    NSString *amexuserRegMonthWise;
    NSString *amexuserRegYearWise;
    NSString *amexuserRegAll;
    
    
    NSString *fbLeaduserRegDaywise;
    NSString *fbLeaduserRegMonthWise;
    NSString *fbLeaduserRegYearWise;
    NSString *fbLeaduserRegAll;

    
    }
@property (nonatomic, strong) UIRefreshControl            *bottomRefreshControl;
@property (nonatomic, strong) NSMutableDictionary         *VoucherSaleReportDaywiseDict;
@property (nonatomic, strong) NSMutableDictionary         *VoucherSaleReportYearwiseDict;
@property  int  reload;
@end

@implementation DashboardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reload  = 32;
    firstTimeVar = 1;
    
    
    firsttimeInventoryDetailFetchData = 0;
    reportArray =  [[NSMutableArray alloc]init];
//    reportDayArray = [[NSMutableArray alloc]init];
//    reportMonthArray = [[NSMutableArray alloc]init];
//    reportYearArray = [[NSMutableArray alloc]init];
    inventoryDetailArr = [[NSMutableArray alloc]init];
    inventoryDetailArrTomorrow = [[NSMutableArray alloc]init];
    inventoryDetailArrDayAfterTomorrow = [[NSMutableArray alloc]init];
    
    responseArr2 = [[NSMutableArray alloc]init];
    responseArr3 = [[NSMutableArray alloc]init];
    responseArr4 = [[NSMutableArray alloc]init];
    responseDict2 = [[NSDictionary alloc]init];
    responseDict3 = [[NSDictionary alloc]init];
    responseDict4 = [[NSDictionary alloc]init];
    responseDict8 = [[NSDictionary alloc]init];
    responseDict9 = [[NSDictionary alloc]init];
    
    voucherSoldReprtDictThisMonth = [[NSMutableDictionary alloc]init];
    
    userRegAllArray =       [[NSMutableArray alloc]init];
    voucherSaleAllArray =   [[NSMutableArray alloc]init];
    appDownlaodsArray  =      [[NSMutableArray alloc]init];
    voucherSoldExistingUser = [[NSMutableArray alloc]init];
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];

    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    responseArr = [[NSMutableArray alloc]init];
    responseDict = [[NSDictionary alloc]init];
    
    NSInteger day = [components day];
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *todayDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year,(long)week,(long)day];
 
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
   DateOFInventoryDetail = [formatter stringFromDate:[NSDate date]];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *dateObjectForDecrement=[dateFormatter dateFromString:DateOFInventoryDetail];
    
    NSDate *dateAfterDecrement=[dateObjectForDecrement addTimeInterval: + (24*60*60)];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd"]; // Date formater
   tomorrowDateOFInventoryDetail = [dateformate stringFromDate:dateAfterDecrement];
    
    NSDate *dateAfterDecrementTwoDays=[dateObjectForDecrement addTimeInterval: + (24*60*60 *2)];
    NSDateFormatter *dateformateT=[[NSDateFormatter alloc]init];
    [dateformateT setDateFormat:@"yyyy-MM-dd"]; // Date formater
    dayAfterTomorrowDateOFInventoryDetail = [dateformate stringFromDate:dateAfterDecrementTwoDays];
    
    NSInteger month = [components month];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
   
    
    [df setDateFormat:@"MMM"];
    NSString *myMonthString = [df stringFromDate:[NSDate date]];
   
  
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [NSDateComponents new];
    comps.month = 0;
    NSDate *date = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSDateComponents *componentsTemp = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date]; // Get necessary date components
   
    
    comps.month = -2;
    date = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
    componentsTemp = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
 
 
    
    NSDateFormatter *dfe = [[NSDateFormatter alloc] init];
    NSString *monthName = [[dfe monthSymbols] objectAtIndex:[componentsTemp month] + 1];
   previousMonthName          = [[dfe monthSymbols] objectAtIndex:[componentsTemp month]];
   BeforePreviousMonthName    = [[dfe monthSymbols] objectAtIndex:[componentsTemp month] - 1 ];
   TwoBeforePreviousMonthName = [[dfe monthSymbols] objectAtIndex:[componentsTemp month] - 2 ];
    
   
    
    
    
    
    NSCalendar *calendarTemp = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    
    NSDateComponents *componentsTempd = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:currentDate];
    
    components.month = components.month - 1;
    components.day = 1;
    
    NSDate *newDate = [calendar dateFromComponents:components];
    
    NSDateFormatter *dateformateTemp=[[NSDateFormatter alloc]init];
    [dateformateTemp setDateFormat:@"yyyy-MM-dd"]; // Date formater
    previousMonthDateStr = [dateformate stringFromDate:newDate];
    
   
    components.month = components.month - 1;
    components.day = 1;
    
    NSDate *newDateTemp = [calendar dateFromComponents:components];
    
    NSDateFormatter *dateformateTempeBefore=[[NSDateFormatter alloc]init];
    [dateformateTempeBefore setDateFormat:@"yyyy-MM-dd"]; // Date formater
    beforePreviousMonthDateStr = [dateformate stringFromDate:newDateTemp];
    
    components.month = components.month - 1;
    components.day = 1;
    
    NSDate *newDateTempTemp = [calendar dateFromComponents:components];
    
    NSDateFormatter *dateformateTempTwoBefore=[[NSDateFormatter alloc]init];
    [dateformateTempTwoBefore setDateFormat:@"yyyy-MM-dd"]; // Date formater
    twoBeforePreviousMonthDateStr = [dateformate stringFromDate:newDateTempTemp];
    
    
    [self IntegrateFourWebService:todayDateStr];
    }


-(void)IntegrateFourWebService:(NSString *)startDate    {
    
          [self callReportAPIWithStartDate:startDate endDate:startDate];
}
-(void) callReportAPIWithStartDate:(NSString *) startDate endDate:(NSString *) endDate   {
    
    
    NSString *URLStr = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/Report?startdate=%@&Enddate=%@",startDate,endDate];
    [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
    [[ModelManager modelManager] dashBoardDetailApiWithoutParameters:URLStr success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            reportArray = responseObject;
            //Call 2nd API
            
            totalRefundPreviousMonthValue = [[reportArray objectAtIndex:0] objectForKey:@"totalrefundMonthwise_minusone"];
            totalRefundBeforePreviousMonthValue = [[reportArray objectAtIndex:0] objectForKey:@"totalrefundMonthwise_minustwo"];
            totalRefundBeforeTwoPreviousMonthValue = [[reportArray objectAtIndex:0] objectForKey:@"totalrefundMonthwise_minusthree"];
          //  [self callSoldTotalAPIWithStartDate:startDate];
            
             [self callMonthWiseVoucherSaleReportAPIWithStartDate:startDate];
          
        }else{
            NSLog(@"Not Valid User");
        }
    }
                                                             failure:^(Status iStatus, NSString *errorMessage) {
                                                                 [UIHelper hideSpinner];
                                                                 [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                             }];
}

//-(void) callDayWiseReportAPIWithStartDate:(NSString *) startDate {
//    NSString *URLStr2 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/AllSoldVoucherRecords_SourceWise_DayWise?startdate=%@",startDate];
//    
//  
//    [[ModelManager modelManager] VoucherSaleReportDaywise:URLStr2 success:^(Status iStatus,id  _Nullable responseObject ) {
//        if(iStatus == StatusSuccess && responseObject){
//            reportDayArray = responseObject;
//            //Call 3rd API
//            [self callSoldTotalAPIWithStartDate:startDate];
//        }else{
//            NSLog(@"Not Valid User");
//        }
//    }
//                                                  failure:^(Status iStatus, NSString *errorMessage) {
//                                                      [UIHelper hideSpinner];
//                                                      [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
//                                                  }];
//}

//-(void) callSoldTotalAPIWithStartDate:(NSString *) startDate {
//    NSString *URLStr2 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/AllSoldVoucherRecords_SourceWise_ALL?startdate=%@",startDate];
//    
//    
//    [[ModelManager modelManager] VoucherSaleReportDaywise:URLStr2 success:^(Status iStatus,id  _Nullable responseObject ) {
//        if(iStatus == StatusSuccess && responseObject){
//            soldTotalArray = responseObject;
//          
//          webSaleAll        = [[soldTotalArray objectAtIndex:0]objectForKey:@"TotalWebVouchers_All" ];
//          wapSaleAll        = [[soldTotalArray objectAtIndex:0]objectForKey:@"TotalWapVouchers_All" ];
//          appSaleAll        = [[soldTotalArray objectAtIndex:0]objectForKey:@"TotalAppVouchers_All" ];
//          corporateSaleAll  = [[soldTotalArray objectAtIndex:0]objectForKey:@"TotalCorporateVouchers_All" ];
//          CorporateB2BAll   = [[soldTotalArray objectAtIndex:0]objectForKey:@"TotalCorporateB2B_All" ];
//            noTaggingSaleAll = [[soldTotalArray objectAtIndex:0]objectForKey:@"TotalNullVouchers_All" ];
//          
//            //Call 3rd API
//             [self callMonthWiseVoucherSaleReportAPIWithStartDate:startDate];
//        }else{
//            NSLog(@"Not Valid User");
//        }
//    }
//                                                  failure:^(Status iStatus, NSString *errorMessage) {
//                                                      [UIHelper hideSpinner];
//                                                      [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
//                                                  }];
//}
//

//-(void) callMonthWiseReportAPIWithStartDate:(NSString *) startDate   {
//    NSString *URLStr3 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/AllSoldVoucherRecords_SourceWise_MonthWise?startdate=%@",startDate];
//    [[ModelManager modelManager] VoucherSaleReportMonthwise:URLStr3 success:^(Status iStatus,id  _Nullable responseObject ) {
//        if(iStatus == StatusSuccess && responseObject){
//            reportMonthArray = responseObject;
//            //Call 4th API
//            [self callMonthWiseVoucherSaleReportAPIWithStartDate:startDate];
//        }else{
//            NSLog(@"Not Valid User");
//        }
//    }
//                                                    failure:^(Status iStatus, NSString *errorMessage) {
//                                                        [UIHelper hideSpinner];
//                                                        [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
//                                                    }];
//}

-(void) callMonthWiseVoucherSaleReportAPIWithStartDate:(NSString *) startDate   {
    NSString *URLStr3 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSaleReport_Monthwise?startdate=%@",startDate];
    [[ModelManager modelManager] VoucherSaleReportPreviousMonthwise:URLStr3 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
          voucherSoldReprtDictThisMonth = [responseObject objectAtIndex:0];
            //Call 4th API
            
           
            [self callPreviousMonthWiseReportAPIWithStartDate:startDate];
        }else{
            NSLog(@"Not Valid User");
        }
    }
                                                            failure:^(Status iStatus, NSString *errorMessage) {
                                                                [UIHelper hideSpinner];
                                                                [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                            }];
}
-(void) callPreviousMonthWiseReportAPIWithStartDate:(NSString *) startDate   {
    NSString *URLStr3 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSaleReport_Monthwise?startdate=%@",previousMonthDateStr];
    [[ModelManager modelManager] VoucherSaleReportPreviousMonthwise:URLStr3 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            totalSoldPreviousMonthArr = responseObject;
            //Call 4th API
            
            totalSoldPreviousMonthValue = [[totalSoldPreviousMonthArr objectAtIndex:0]objectForKey:@"TotalPaidVouchers_Monthwise"];
            [self callBeforePreviousMonthWiseReportAPIWithStartDate:startDate];
        }else{
            NSLog(@"Not Valid User");
        }
    }
                                                    failure:^(Status iStatus, NSString *errorMessage) {
                                                        [UIHelper hideSpinner];
                                                        [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                    }];
}

-(void) callBeforePreviousMonthWiseReportAPIWithStartDate:(NSString *) startDate   {
    NSString *URLStr3 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSaleReport_Monthwise?startdate=%@",beforePreviousMonthDateStr];
    [[ModelManager modelManager] VoucherSaleReportBeforePreviousMonthwise:URLStr3 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            totalSoldBeforePreviousMonthArr = responseObject;
            
             totalSoldMonthBeforeValue = [[totalSoldBeforePreviousMonthArr objectAtIndex:0]objectForKey:@"TotalPaidVouchers_Monthwise"];
            //Call 4th API
            [self callTwoBeforePreviousMonthWiseReportAPIWithStartDate:startDate];
        }else{
            NSLog(@"Not Valid User");
        }
    }
                                                    failure:^(Status iStatus, NSString *errorMessage) {
                                                        [UIHelper hideSpinner];
                                                        [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                    }];
}

-(void) callTwoBeforePreviousMonthWiseReportAPIWithStartDate:(NSString *) startDate   {
    NSString *URLStr3 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSaleReport_Monthwise?startdate=%@",twoBeforePreviousMonthDateStr];
    [[ModelManager modelManager] VoucherSaleReportTwoBeforePreviousMonthwise:URLStr3 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            totalSoldTwoBeforePreviousMonthArr = responseObject;
            
            totalSoldMonthTwoBeforeValue = [[totalSoldTwoBeforePreviousMonthArr objectAtIndex:0]objectForKey:@"TotalPaidVouchers_Monthwise"];
            //Call 4th API
        //    [self callYearWiseReportAPIWithStartDate:startDate];
            
             [self callUserRegDayWiseAPIWithStartDate:startDate];
        }else{
            NSLog(@"Not Valid User");
        }
    }
                                                                  failure:^(Status iStatus, NSString *errorMessage) {
                                                                      [UIHelper hideSpinner];
                                                                      [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                                  }];
}


//-(void) callYearWiseReportAPIWithStartDate:(NSString *) startDate {
//    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/AllSoldVoucherRecords_SourceWise_YearWise?startdate=%@",startDate];
//    [[ModelManager modelManager] VoucherSaleReportYearwise:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
//        if(iStatus == StatusSuccess && responseObject){
//            reportYearArray = responseObject;
//            
//            [self callUserRegDayWiseAPIWithStartDate:startDate];
//            
//                        
//        }else{
//            [UIHelper hideSpinner];
//               }
//    }
//                                                   failure:^(Status iStatus, NSString *errorMessage) {
//                                                       [UIHelper hideSpinner];
//                                                       [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
//                                                   }];
//}

-(void) callUserRegDayWiseAPIWithStartDate:(NSString *) startDate {
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/UserRegReport_Daywise?startdate=%@",startDate];
    [[ModelManager modelManager] userRegDayWise:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            userRegDayWiseArray = responseObject;
            
            [self callUserRegMonthWiseAPIWithStartDate:startDate];
        }else{
            [UIHelper hideSpinner];
        }
    }
                                                   failure:^(Status iStatus, NSString *errorMessage) {
                                                       [UIHelper hideSpinner];
                                                       [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                   }];
}

-(void) callUserRegMonthWiseAPIWithStartDate:(NSString *) startDate {
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/UserRegReport_Monthwise?startdate=%@",startDate];
    [[ModelManager modelManager] userRegMonthWise:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            userRegMonthWiseArray = responseObject;
            
            [self callUserRegPreviousMonthWiseAPIWithStartDate:startDate];
            
        }else{
            [UIHelper hideSpinner];
        }
    }
                                                   failure:^(Status iStatus, NSString *errorMessage) {
                                                       [UIHelper hideSpinner];
                                                       [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                   }];
}

-(void) callUserRegPreviousMonthWiseAPIWithStartDate:(NSString *) startDate {
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/UserRegReport_Monthwise?startdate=%@",previousMonthDateStr];
    [[ModelManager modelManager] userRegPreviousMonthWise:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            totalRegisterdPreviousMonthArr = responseObject;
          
            totalRegisteredPreviousMonthValue = [[totalRegisterdPreviousMonthArr objectAtIndex:0]objectForKey:@"TotalUserReg_Monthwise"];
            
            [self callUserRegBeforePreviousMonthWiseAPIWithStartDate:startDate];
            
        }else{
            [UIHelper hideSpinner];
        }
    }
                                          failure:^(Status iStatus, NSString *errorMessage) {
                                              [UIHelper hideSpinner];
                                              [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                          }];
}

-(void) callUserRegBeforePreviousMonthWiseAPIWithStartDate:(NSString *) startDate {
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/UserRegReport_Monthwise?startdate=%@",beforePreviousMonthDateStr];
    [[ModelManager modelManager] userRegBeforePreviousMonthWise:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            totalRegisteredBeforePreviousMonthArr = responseObject;
            
             totalRegisterdMonthBeforeValue = [[totalRegisteredBeforePreviousMonthArr objectAtIndex:0]objectForKey:@"TotalUserReg_Monthwise"];
            
            [self callUserRegTwoBeforePreviousMonthWiseAPIWithStartDate:startDate];
            
        }else{
            [UIHelper hideSpinner];
        }
    }
                                          failure:^(Status iStatus, NSString *errorMessage) {
                                              [UIHelper hideSpinner];
                                              [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                          }];
}

-(void) callUserRegTwoBeforePreviousMonthWiseAPIWithStartDate:(NSString *) startDate {
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/UserRegReport_Monthwise?startdate=%@",twoBeforePreviousMonthDateStr];
    [[ModelManager modelManager] userRegTwoBeforePreviousMonthWise:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            totalRegisteredTwoBeforePreviousMonthArr = responseObject;
            
            totalRegisteredMonthTwoBeforeValue = [[totalRegisteredTwoBeforePreviousMonthArr objectAtIndex:0]objectForKey:@"TotalUserReg_Monthwise"];
            
            [self callUserRegYearWiseAPIWithStartDate:startDate];
            
        }else{
            [UIHelper hideSpinner];
        }
    }
                                                        failure:^(Status iStatus, NSString *errorMessage) {
                                                            [UIHelper hideSpinner];
                                                            [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                        }];
}


-(void) callUserRegYearWiseAPIWithStartDate:(NSString *) startDate {
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/UserRegReport_Yearwise?startdate=%@",startDate];
    [[ModelManager modelManager] userRegYearWise:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            userRegYearWiseArray = responseObject;
            
            [self callUserRegReportAllAPIWithStartDate:startDate];
            
        }else{
            [UIHelper hideSpinner];
        }
    }
                                                   failure:^(Status iStatus, NSString *errorMessage) {
                                                       [UIHelper hideSpinner];
                                                       [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                   }];
}


-(void) callUserRegReportAllAPIWithStartDate:(NSString *) startDate {
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/UserRegReport_All?startdate=%@",startDate];
    
   
    [[ModelManager modelManager] UserRegReportAll:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            userRegAllArray = responseObject;
            
            [self callVoucherSaleAllAPIWithStartDate:startDate];
        }else{
            [UIHelper hideSpinner];
        }
    }
                                         failure:^(Status iStatus, NSString *errorMessage) {
                                             [UIHelper hideSpinner];
                                             [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                         }];
}

-(void) callVoucherSaleAllAPIWithStartDate:(NSString *) startDate {
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSaleReport_All?startdate=%@",startDate];
    [[ModelManager modelManager] VoucherSaleReportAll:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            voucherSaleAllArray = responseObject;
            
            webSaleAll        = [[voucherSaleAllArray objectAtIndex:0]objectForKey:@"TotalWebVouchers_All" ];
            wapSaleAll        = [[voucherSaleAllArray objectAtIndex:0]objectForKey:@"TotalWapVouchers_All" ];
            appSaleAll        = [[voucherSaleAllArray objectAtIndex:0]objectForKey:@"TotalAppVouchers_All" ];
            corporateSaleAll  = [[voucherSaleAllArray objectAtIndex:0]objectForKey:@"TotalCorporateVouchers_All" ];
            CorporateB2BAll   = [[voucherSaleAllArray objectAtIndex:0]objectForKey:@"TotalCorporateB2B_All" ];
            noTaggingSaleAll = [[voucherSaleAllArray objectAtIndex:0]objectForKey:@"TotalNullVouchers_All" ];
            
            [self VoucherSoldNewExistingUserCheckWithDate:startDate];
            
            
        }else{
            [UIHelper hideSpinner];
        }
    }
                                         failure:^(Status iStatus, NSString *errorMessage) {
                                             [UIHelper hideSpinner];
                                             [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                         }];
}

-(void) VoucherSoldNewExistingUserCheckWithDate:(NSString *) startDate {
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSoldNewExistingUserCheck?startdate=%@",startDate];
    [[ModelManager modelManager] VoucherSoldNewExistingUserCheck:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            voucherSoldExistingUser = responseObject;
            
            [self VoucherSaleReportDaywise:startDate];
            
            
        }else{
            [UIHelper hideSpinner];
        }
    }
                                              failure:^(Status iStatus, NSString *errorMessage) {
                                                  [UIHelper hideSpinner];
                                                  [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                              }];
}

-(void) VoucherSaleReportDaywise:(NSString *) startDate {
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSaleReport_Daywise?startdate=%@",startDate];
    [[ModelManager modelManager] VoucherSoldNewExistingUserCheck:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            
            
            self.VoucherSaleReportDaywiseDict = [responseObject objectAtIndex:0];
            [self VoucherSaleReportYearwise:startDate];
            
            
            
        }else{
            [UIHelper hideSpinner];
        }
    }
                                                         failure:^(Status iStatus, NSString *errorMessage) {
                                                             [UIHelper hideSpinner];
                                                             [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                         }];
}

-(void) VoucherSaleReportYearwise:(NSString *) startDate {
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSaleReport_Yearwise?startdate=%@",startDate];
    [[ModelManager modelManager] VoucherSoldNewExistingUserCheck:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
                       
            self.VoucherSaleReportYearwiseDict = [responseObject objectAtIndex:0];
            
            [self callAppDownloadsAPIWithStartDate];
            
            
        }else{
            [UIHelper hideSpinner];
        }
    }
                                                         failure:^(Status iStatus, NSString *errorMessage) {
                                                             [UIHelper hideSpinner];
                                                             [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                         }];
}

-(void) callAppDownloadsAPIWithStartDate{
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/Api/DashboardApi/MobileApp"];
    [[ModelManager modelManager] AppDownLoadsDetailApi:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            appDownlaodsArray = responseObject;
            
            if(reportArray  &&userRegDayWiseArray&&userRegMonthWiseArray&&userRegYearWiseArray&&voucherSaleAllArray&&userRegAllArray && appDownlaodsArray)    {
                 [UIHelper hideSpinner];
                [self setupUiDesign];
             
            
            }
            else    {
                
                [UIHelper showNotificationWithType:UINotificationAlertTypeError message:@"WebservIce Data not correct" duration:2.0];
                [UIHelper hideSpinner];
            }
            
        }else{
            [UIHelper hideSpinner];
        }
    }
                                              failure:^(Status iStatus, NSString *errorMessage) {
                                                  [UIHelper hideSpinner];
                                                  [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                              }];
}

- (void) orientationChanged:(NSNotification *)note
{
    [self layoutChanged];
}


-(void)managelayoutIphone:(float)height
{
    
    icsLogoImageView.frame = CGRectMake(self.view.frame.size.width/4,15,self.view.frame.size.width *0.5,50);
    dateBaseView.frame = CGRectMake(10, icsLogoImageView.frame.size.height+icsLogoImageView.frame.origin.y +10, (self.view.frame.size.width - 20), self.view.frame.size.height *height);
    decrementDateBtn.frame = CGRectMake(0, 0, dateBaseView.frame.size.width/4, self.view.frame.size.height *height);
    dateLabel.frame =  CGRectMake(dateBaseView.frame.size.width/4, 0, dateBaseView.frame.size.width/2, self.view.frame.size.height *height);
    IncrementDateBtn.frame = CGRectMake(dateLabel.frame.origin.x +dateLabel.frame.size.width, 0, dateBaseView.frame.size.width/4, self.view.frame.size.height *height);
    detailTableView.frame = CGRectMake(dateBaseView.frame.origin.x, dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10, dateBaseView.frame.size.width, self.view.frame.size.height - (dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10));
    [detailTableView reloadData];
}



-(void)managelayout:(float)height
{
   
    icsLogoImageView.frame = CGRectMake((self.view.frame.size.width - (self.view.frame.size.width *0.25))/2,15,self.view.frame.size.width *0.25,self.view.frame.size.height *height);
   
    dateBaseView.frame = CGRectMake(self.view.frame.size.width/4, icsLogoImageView.frame.size.height+icsLogoImageView.frame.origin.y +10, (self.view.frame.size.width/2), self.view.frame.size.height *height);
    decrementDateBtn.frame = CGRectMake(0, 0, dateBaseView.frame.size.width/4, self.view.frame.size.height *height);
    dateLabel.frame =  CGRectMake(dateBaseView.frame.size.width/4, 0, dateBaseView.frame.size.width/2, self.view.frame.size.height *height);
    IncrementDateBtn.frame = CGRectMake(dateLabel.frame.origin.x +dateLabel.frame.size.width, 0, dateBaseView.frame.size.width/4, self.view.frame.size.height *height);
    dismissControllerBtn.frame = CGRectMake(self.view.frame.size.width - 100, icsLogoImageView.frame.origin.y, 50, self.view.frame.size.height *height);
    detailTableView.frame = CGRectMake(dateBaseView.frame.origin.x, dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10, dateBaseView.frame.size.width, self.view.frame.size.height - (dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10));
    [detailTableView reloadData];
    
    
               }

- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"App comming");
}
-(void)viewDidDisappear:(BOOL)animated {
    
    NSLog(@"App comming");
}

- (BOOL)shouldAutorotate{
    return NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return self.reload;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
  
    if (indexPath.row == 1) {
        static NSString *CellIdentifier1      = @"SoldVoucher";
        SoldVouchersTableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if (cell == nil)
        {
            cell                             = [[SoldVouchersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                          reuseIdentifier:CellIdentifier1];
            [[cell contentView] setFrame:[cell bounds]];
            [[cell contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            cell.frame = CGRectMake(0, 0, detailTableView.frame.size.width, 100);
            cell.entryBaseview.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, 100);
            cell.keyLbl.frame = CGRectMake(0, 0, cell.contentView.frame.size.width * 0.55, 30);
            cell.valueLbl.frame = CGRectMake(cell.contentView.frame.size.width * 0.55, 0, cell.contentView.frame.size.width * 0.45, 30);
            cell.NewUserKeyLbl.frame = CGRectMake(0, 30, cell.contentView.frame.size.width * 0.45, 30);
            cell.NewUserValueLbl.frame = CGRectMake(cell.contentView.frame.size.width * 0.55, 30, cell.contentView.frame.size.width * 0.45, 30);
            cell.existUserKeyLbl.frame = CGRectMake(0, 60, cell.contentView.frame.size.width * 0.45, 30);
            cell.existUserValueLbl.frame = CGRectMake(cell.contentView.frame.size.width * 0.55, 60, cell.contentView.frame.size.width * 0.45, 30);
            
            
            
        }
        cell.keyLbl.text      = [keyArrForTableView objectAtIndex:indexPath.row];
        cell.valueLbl.text    =  [valueArrForTableView objectAtIndex:indexPath.row];
        cell.NewUserKeyLbl.text = @"New User";
        cell.NewUserValueLbl.text = newUserValueStr;
        cell.existUserKeyLbl.text = @"Existing User";
        cell.existUserValueLbl.text = existUserValueStr;
        return cell;
    }else if (indexPath.row > 10 && indexPath.row < 14) {
        
        static NSString *CellIdentifier3      = @"ThreeMonthCell";
        PreviousMonthWiseTableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        
        if (cell == nil)
        {
            cell                             = [[PreviousMonthWiseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                                reuseIdentifier:CellIdentifier3];
            [[cell contentView] setFrame:[cell bounds]];
            [[cell contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            cell.frame = CGRectMake(0, 0, detailTableView.frame.size.width, 120);
            cell.entryBaseview.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, 120);
            cell.keyLbl.frame = CGRectMake(0, 0, cell.contentView.frame.size.width * 0.55, 30);
            cell.valueLbl.frame = CGRectMake(cell.contentView.frame.size.width * 0.55, 0, cell.contentView.frame.size.width * 0.45, 30);
            cell.previousMonthKeyLbl.frame = CGRectMake(0, 30, cell.contentView.frame.size.width * 0.45, 30);
            cell.PreviousMonthValueLbl.frame = CGRectMake(cell.contentView.frame.size.width * 0.55, 30, cell.contentView.frame.size.width * 0.45, 30);
            cell.beforePreviousMonthKeyLbl.frame = CGRectMake(0, 60, cell.contentView.frame.size.width * 0.45, 30);
            cell.beforePreviousMonthValueLbl.frame = CGRectMake(cell.contentView.frame.size.width * 0.55, 60, cell.contentView.frame.size.width * 0.45, 30);
            
            cell.TwobeforePreviousMonthKeyLbl.frame = CGRectMake(0, 90, cell.contentView.frame.size.width * 0.45, 30);
            cell.TwobeforePreviousMonthValueLbl.frame = CGRectMake(cell.contentView.frame.size.width * 0.55, 90, cell.contentView.frame.size.width * 0.45, 30);
        
        }
        cell.keyLbl.text      = [keyArrForTableView objectAtIndex:indexPath.row];
        cell.valueLbl.text    =  [valueArrForTableView objectAtIndex:indexPath.row];
               if (indexPath.row == 11) {
                   
                   
                   
                   cell.previousMonthKeyLbl.text = previousMonthName;
                   cell.PreviousMonthValueLbl.text = totalRegisteredPreviousMonthValue;
                   cell.beforePreviousMonthKeyLbl.text = BeforePreviousMonthName;
                   cell.beforePreviousMonthValueLbl.text = totalRegisterdMonthBeforeValue;
                   cell.TwobeforePreviousMonthKeyLbl.text = TwoBeforePreviousMonthName;
                   cell.TwobeforePreviousMonthValueLbl.text = totalRegisteredMonthTwoBeforeValue;

        }
        
        if (indexPath.row == 12) {
            cell.previousMonthKeyLbl.text = previousMonthName;
            cell.PreviousMonthValueLbl.text = totalSoldPreviousMonthValue;
            cell.beforePreviousMonthKeyLbl.text = BeforePreviousMonthName;
            cell.beforePreviousMonthValueLbl.text = totalSoldMonthBeforeValue;
            cell.TwobeforePreviousMonthKeyLbl.text = TwoBeforePreviousMonthName;
            cell.TwobeforePreviousMonthValueLbl.text = totalSoldMonthTwoBeforeValue;

        }
        
        if (indexPath.row == 13) {
            cell.previousMonthKeyLbl.text = previousMonthName;
            cell.PreviousMonthValueLbl.text = totalRefundPreviousMonthValue;
            cell.beforePreviousMonthKeyLbl.text = BeforePreviousMonthName;
            cell.beforePreviousMonthValueLbl.text = totalRefundBeforePreviousMonthValue;
            cell.TwobeforePreviousMonthKeyLbl.text = TwoBeforePreviousMonthName;
            cell.TwobeforePreviousMonthValueLbl.text = totalRefundBeforeTwoPreviousMonthValue;
            
        }
    
       
        
        return cell;

    }else if (indexPath.row > 32 ){
        static NSString *CellIdentifier2      = @"InventoryDetail";
        InventroyDetailTableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell == nil)
        {
            cell                             = [[InventroyDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                          reuseIdentifier:CellIdentifier2];
            [[cell contentView] setFrame:[cell bounds]];
            [[cell contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            cell.frame = CGRectMake(0, 0, detailTableView.frame.size.width, 50);
            cell.entryBaseview.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
            cell.keyLbl.frame = CGRectMake(0, 0, cell.contentView.frame.size.width * 0.70, cell.contentView.frame.size.height);
            cell.valueLbl.frame = CGRectMake(cell.contentView.frame.size.width * 0.70, 0, cell.contentView.frame.size.width * 0.30, cell.contentView.frame.size.height);
            [cell.keyLbl setTag:1];
            [cell.valueLbl setTag:2];
            
            
        }
        
        NSString *availableRoom = [valueArrForTableView objectAtIndex:indexPath.row ];
        NSString *firstLetter = [availableRoom substringToIndex:1];
             int availableRoomValue = [firstLetter intValue];
             if (availableRoomValue < 3) {
                [(UILabel *)[cell.contentView viewWithTag:1] setText:[keyArrForTableView objectAtIndex:indexPath.row] ];
                [(UILabel *)[cell.contentView viewWithTag:2] setText:[valueArrForTableView objectAtIndex:indexPath.row] ];
                 [(UILabel *)[cell.contentView viewWithTag:1]setTextColor:[UIColor redColor] ];
                [(UILabel *)[cell.contentView viewWithTag:2]setTextColor:[UIColor redColor] ];
//                 [(UILabel *)[cell.contentView viewWithTag:1]setFont:[UIFont systemFontOfSize:16] ];
//                 [(UILabel *)[cell.contentView viewWithTag:2]setFont:[UIFont systemFontOfSize:16] ];
                
            }else{
                [(UILabel *)[cell.contentView viewWithTag:1] setText:[keyArrForTableView objectAtIndex:indexPath.row] ];
                [(UILabel *)[cell.contentView viewWithTag:2] setText:[valueArrForTableView objectAtIndex:indexPath.row] ];
                [(UILabel *)[cell.contentView viewWithTag:1]setTextColor:[UIColor blackColor] ];
                [(UILabel *)[cell.contentView viewWithTag:2]setTextColor:[UIColor blackColor] ];
//                [(UILabel *)[cell.contentView viewWithTag:1]setFont:[UIFont systemFontOfSize:16] ];
//                [(UILabel *)[cell.contentView viewWithTag:2]setFont:[UIFont systemFontOfSize:16] ];

            }
             return cell;

    }else if (!(indexPath.row == 11) && !(indexPath.row == 12)){
        static NSString *CellIdentifier      = @"ContactCell";
        DetailTableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell                             = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                                          reuseIdentifier:CellIdentifier];
            [[cell contentView] setFrame:[cell bounds]];
            [[cell contentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            cell.frame = CGRectMake(0, 0, detailTableView.frame.size.width, 50);
            cell.entryBaseview.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
            cell.keyLbl.frame = CGRectMake(0, 0, cell.contentView.frame.size.width * 0.55, cell.contentView.frame.size.height);
            cell.valueLbl.frame = CGRectMake(cell.contentView.frame.size.width * 0.55, 0, cell.contentView.frame.size.width * 0.45, cell.contentView.frame.size.height);
            
            
        }
        cell.keyLbl.text      = [keyArrForTableView objectAtIndex:indexPath.row];
        cell.valueLbl.text    =  [valueArrForTableView objectAtIndex:indexPath.row];
        
        if (indexPath.row > 32) {
            NSString *availableRoom = [[inventoryDetailArr objectAtIndex:indexPath.row - 32] objectForKey:@"INVENTORY_AVAILABLE"];
            int availableRoomValue = [availableRoom intValue];
            if (availableRoomValue < 3) {
                cell.keyLbl.textColor = [UIColor redColor];
                cell.valueLbl.textColor = [UIColor redColor];
            }
        }
         return cell;
    }
    
    
    return nil;
   
}



#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    if (indexPath.row == 31  ) {
        
        
        NSLog(@"Inventory Details Selected");
         [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
        
        NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/ViewStateWiseCityWiseHotelWiseInventoryDetail_datewise?startdate=%@",DateOFInventoryDetail];
        [[ModelManager modelManager] ViewStateWiseCityWiseHotelWiseInventoryDetail:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
            if(iStatus == StatusSuccess && responseObject){
                inventoryDetailArr = responseObject;
                
                NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"HOTEL_NAME" ascending:YES];
                NSArray * sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
                NSArray * sortedArray = [inventoryDetailArr sortedArrayUsingDescriptors:sortDescriptors];
                NSLog(@"sortedArray %@",sortedArray);
                
             
                
                NSMutableArray *hotelNamearray = [[NSMutableArray alloc]init];
                
                
                for (id dict in sortedArray) {
                    
                    [hotelNamearray addObject:[dict objectForKey:@"HOTEL_NAME"]];
                }
                
               NSArray *uniqueArray = [[NSSet setWithArray:hotelNamearray] allObjects];
                NSLog(@"%@", uniqueArray);
                
               
                NSMutableArray *uniqueHotelArr = [[NSMutableArray alloc]initWithArray:uniqueArray];
                
                
                [uniqueHotelArr sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                
                NSMutableArray *manufacturedArr = [[NSMutableArray alloc]init];
                for (NSString *str in uniqueHotelArr) {
                     NSArray *filtered = [sortedArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(HOTEL_NAME == %@)", str]];
                    [manufacturedArr addObject:filtered];
                    
                }
                firsttimeInventoryDetailFetchData = 1;
         //   NSMutableArray * finalArrayToParse =[[[manufacturedArr reverseObjectEnumerator] allObjects] mutableCopy];
                
                for (id array in manufacturedArr) {
    
                   
                    
                    NSString *valueStr = @"";
                    
                    for (id dict in array) {
                        
                        NSString *dictDateValue = @"";
                        dictDateValue = [dict objectForKey:@"inventorydate"];
                         dictDateValue = [dictDateValue substringWithRange:NSMakeRange(0, 10)];
                        
                        if ([dictDateValue isEqualToString:DateOFInventoryDetail]) {
                            valueStr = [NSString stringWithFormat:@"%@/%@", [dict objectForKey:@"INVENTORY_AVAILABLE"], [dict objectForKey:@"INVENTORY_TOTAL"]];
                        }

                        if ([dictDateValue isEqualToString:tomorrowDateOFInventoryDetail]) {
                            
                            valueStr = [NSString stringWithFormat:@"%@-%@/%@",valueStr, [dict objectForKey:@"INVENTORY_AVAILABLE"], [dict objectForKey:@"INVENTORY_TOTAL"]];
                        }
                        
                        if ([dictDateValue isEqualToString:dayAfterTomorrowDateOFInventoryDetail]) {
                             valueStr = [NSString stringWithFormat:@"%@-%@/%@",valueStr, [dict objectForKey:@"INVENTORY_AVAILABLE"], [dict objectForKey:@"INVENTORY_TOTAL"]];
                        }
                    }
                    
                    NSArray *subStrings = [[[array objectAtIndex:0]objectForKey:@"HOTEL_NAME"]componentsSeparatedByString:@" " ];
                    NSString *hotelNameStr;
                     NSString *firstName = [subStrings objectAtIndex:0];
                    
                    if ([subStrings count] > 1) {
                       
                        NSString *secondHotelName = [subStrings objectAtIndex:1];
                        hotelNameStr = [NSString stringWithFormat:@"%@ %@",firstName, secondHotelName];
                    }else{
                        hotelNameStr = [NSString stringWithFormat:@"%@",firstName];
                    }
//                    NSString *firstName = [subStrings objectAtIndex:0];
//                    NSString *secondHotelName = [subStrings objectAtIndex:1];
                   
                    
                    NSArray *subStringsCityName = [[[array objectAtIndex:0] objectForKey:@"CITY_NAME"] componentsSeparatedByString:@" "];
                    NSString *firstNameCity = [subStringsCityName objectAtIndex:0];
                    NSString *secondHotelNameCity;
                    if ([subStringsCityName count] > 1) {
                        secondHotelNameCity = [subStringsCityName objectAtIndex:1];
                        
                    }else{
                        secondHotelNameCity = @"";
                        
                    }
                    
                    if ([subStringsCityName count] > 2) {
                        if ([subStringsCityName count] == 4) {
                            firstNameCity = [subStringsCityName objectAtIndex:3];
                            secondHotelNameCity = @"";
                            
                        }
                        if ([subStringsCityName count] == 5) {
                            firstNameCity = [subStringsCityName objectAtIndex:3];
                            secondHotelNameCity = [subStringsCityName objectAtIndex:4];
                            
                        }
                        
                        
                        
                    }
                    
                    NSString *hotelCityName = [NSString stringWithFormat:@"%@ %@",firstNameCity, secondHotelNameCity];
                    
                    
                    NSString *keyToAdd = [NSString stringWithFormat:@"%@ - %@", hotelNameStr, hotelCityName];
                    [valueArrForTableView addObject:valueStr];
                    [keyArrForTableView addObject:keyToAdd];
                    [detailTableView setAllowsSelection: NO];
                    
                    
                }
                
                 [UIHelper hideSpinner];
                self.reload = self.reload +  ([manufacturedArr count] );
                [detailTableView reloadData];
                
            }else{
                [UIHelper hideSpinner];
            }
        }
    failure:^(Status iStatus, NSString *errorMessage) {
                                                                 [UIHelper hideSpinner];
                                                                 [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                             }];
    }
  
}

-(void)todayInventoryDetailApi{
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/ViewStateWiseCityWiseHotelWiseInventoryDetail?startdate=%@",DateOFInventoryDetail];
    [[ModelManager modelManager] ViewStateWiseCityWiseHotelWiseInventoryDetail:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            inventoryDetailArr = responseObject;
            [self tomorrowInventoryDetailApi];
            
        }else{
            [UIHelper hideSpinner];
        }

        
        
        }failure:^(Status iStatus, NSString *errorMessage) {
            
            [UIHelper hideSpinner];
            [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                                       }];

}

-(void)tomorrowInventoryDetailApi
{

    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/ViewStateWiseCityWiseHotelWiseInventoryDetail_Tomorrow?startdate=%@",DateOFInventoryDetail];
  
    
    [[ModelManager modelManager] ViewStateWiseCityWiseHotelWiseInventoryDetail_Tomorrow:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            inventoryDetailArrTomorrow = responseObject;
            [self dayAfterTomorrowInventoryDetailApi];
            
        }else{
            [UIHelper hideSpinner];
        }
        
        
        
    }failure:^(Status iStatus, NSString *errorMessage) {
        
        [UIHelper hideSpinner];
        [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
    }];
}

-(void)dayAfterTomorrowInventoryDetailApi
{
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/ViewStateWiseCityWiseHotelWiseInventoryDetail_DayAfterTomorrow?startdate=%@",DateOFInventoryDetail];
    [[ModelManager modelManager] ViewStateWiseCityWiseHotelWiseInventoryDetail_DayAfterTomorrow:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            inventoryDetailArrDayAfterTomorrow = responseObject;
            
        NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"HOTEL_NAME" ascending:YES];
        NSArray * sortDescriptors = [NSArray arrayWithObject:brandDescriptor];
        NSArray * sortedArray = [inventoryDetailArr sortedArrayUsingDescriptors:sortDescriptors];
        NSArray * sortedArrayTomorrow = [inventoryDetailArrTomorrow sortedArrayUsingDescriptors:sortDescriptors];
        NSArray * sortedArrayDayAfterTomorrow = [inventoryDetailArrDayAfterTomorrow sortedArrayUsingDescriptors:sortDescriptors];
            for (id dict  in sortedArray) {
                NSArray *subStrings = [[dict objectForKey:@"HOTEL_NAME"] componentsSeparatedByString:@" "];
                NSString *firstName = [subStrings objectAtIndex:0];
                NSString *secondHotelName = [subStrings objectAtIndex:1];
                NSString *hotelNameStr = [NSString stringWithFormat:@"%@ %@",firstName, secondHotelName];
                
                NSArray *subStringsCityName = [[dict objectForKey:@"CITY_NAME"] componentsSeparatedByString:@" "];
                NSString *firstNameCity = [subStringsCityName objectAtIndex:0];
                NSString *secondHotelNameCity;
                if ([subStringsCityName count] > 1) {
                    secondHotelNameCity = [subStringsCityName objectAtIndex:1];
                    
                }else{
                    secondHotelNameCity = @"";
                    
                }
                
                if ([subStringsCityName count] > 2) {
                    if ([subStringsCityName count] == 4) {
                        firstNameCity = [subStringsCityName objectAtIndex:3];
                        secondHotelNameCity = @"";
                        
                    }
                    if ([subStringsCityName count] == 5) {
                        firstNameCity = [subStringsCityName objectAtIndex:3];
                        secondHotelNameCity = [subStringsCityName objectAtIndex:4];
                        
                    }
                    
                    
                    
                }
                
                NSString *hotelCityName = [NSString stringWithFormat:@"%@ %@",firstNameCity, secondHotelNameCity];
                
                NSString *valuetoadd1;
                NSString *valuetoadd2;
                NSString *keyToAdd = [NSString stringWithFormat:@"%@ - %@", hotelNameStr, hotelCityName];
                for (id dict1  in sortedArrayTomorrow) {
                    
                    if ([[dict objectForKey:@"HOTEL_NAME"] isEqualToString:[dict1 objectForKey:@"HOTEL_NAME"]]) {
                      
                        valuetoadd1 = [NSString stringWithFormat:@"%@/%@",[dict1 objectForKey:@"INVENTORY_AVAILABLE"], [dict1 objectForKey:@"INVENTORY_TOTAL"]];
                    }
                    
                }
                
                for (id dict2  in sortedArrayDayAfterTomorrow) {
                    
                    if ([[dict objectForKey:@"HOTEL_NAME"] isEqualToString:[dict2 objectForKey:@"HOTEL_NAME"]]) {
                        
                        valuetoadd2 = [NSString stringWithFormat:@"%@/%@",[dict2 objectForKey:@"INVENTORY_AVAILABLE"], [dict2 objectForKey:@"INVENTORY_TOTAL"]];
                    }
                    
                }
                
                NSString *valuetoadd = [NSString stringWithFormat:@"%@/%@",[dict objectForKey:@"INVENTORY_AVAILABLE"], [dict objectForKey:@"INVENTORY_TOTAL"]];
                NSString *finalStr = [NSString stringWithFormat:@"%@-%@-%@", valuetoadd, valuetoadd1, valuetoadd2];
                [keyArrForTableView addObject:keyToAdd];
                [valueArrForTableView addObject:finalStr];
                [detailTableView setAllowsSelection: NO];
            }
             [detailTableView setAllowsSelection: NO];
            self.reload = self.reload +  ([sortedArray count] );
            [detailTableView reloadData];
            
        }else{
            [UIHelper hideSpinner];
        }
        
        
        
    }failure:^(Status iStatus, NSString *errorMessage) {
        
        [UIHelper hideSpinner];
        [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 100.0;
    }else if (indexPath.row == 11 || indexPath.row == 12 || indexPath.row == 13)
    {
        return 120.0;
    }
    else{
        return 50.0;
    }
    
}

-(void)setupUiDesign
{
    if (firstTimeVar == 1) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        
        NSInteger day = [components day];
        NSInteger week = [components month];
        NSInteger year = [components year];
        
        NSString *string = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)day, (long)week, (long)year];
        
        
        icsLogoImageView = [[UIImageView alloc]init];
        [icsLogoImageView setImage:[UIImage imageNamed:@"icanstyLogo"]];
        [self.view addSubview:icsLogoImageView];
        
        
        dateBaseView = [[UIView alloc]init];
        [self.view addSubview:dateBaseView];
        decrementDateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [decrementDateBtn setTitle:@"<< " forState:UIControlStateNormal];
        decrementDateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        decrementDateBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [decrementDateBtn addTarget:self action:@selector(decrementDate:) forControlEvents:UIControlEventTouchUpInside];
        decrementDateBtn.font = [UIFont systemFontOfSize:30];
        decrementDateBtn.layer.masksToBounds = YES;
        [decrementDateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [dateBaseView addSubview:decrementDateBtn];
        
        
        dateLabel = [[UILabel alloc]init];
        dateLabel.text = string;
        dateLabel.font = [UIFont systemFontOfSize:30];
        dateLabel.textAlignment = UITextAlignmentCenter;
        [dateBaseView addSubview:dateLabel];
        
        IncrementDateBtn = [[UIButton alloc]init];
        IncrementDateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        IncrementDateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        IncrementDateBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [IncrementDateBtn setTitle:@">>" forState:UIControlStateNormal];
        [IncrementDateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        IncrementDateBtn.userInteractionEnabled = NO;
        [IncrementDateBtn addTarget:self action:@selector(IncrementDate:) forControlEvents:UIControlEventTouchUpInside];
        IncrementDateBtn.font = [UIFont systemFontOfSize:30];
        IncrementDateBtn.layer.masksToBounds = YES;
        [dateBaseView addSubview:IncrementDateBtn];

    }
    
    firstTimeVar = 0;
    [self createDatasourceForTableViewAsKeyArrayAndValueArray];
    [self layoutChanged];
    detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(dateBaseView.frame.origin.x, dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10, dateBaseView.frame.size.width, self.view.frame.size.height - (dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10) ) style:UITableViewStylePlain];
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    [detailTableView setShowsVerticalScrollIndicator:NO];
    
//    pullToRefreshManager_ = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f tableView:detailTableView withClient:self];

  
   
    [self.view addSubview:detailTableView];
    
        }
- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [pullToRefreshManager_ relocatePullToRefreshView];
}
- (void)loadTable {
    
    if (self.reload == 32) {
        
    
        [detailTableView reloadData];
        
        [pullToRefreshManager_ tableViewReloadFinished];
    }else{
        [pullToRefreshManager_ tableViewReloadFinished];
        
    }
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    self.reload = 28;
//    [pullToRefreshManager_ tableViewScrolled];
//}
//
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    reloads_ = 28;
//    [pullToRefreshManager_ tableViewReleased];
//}
//
//- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager {
//    reloads_ = 28;
//    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
//}
//
//- (void)refresh {
// 
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                [detailTableView reloadData];
//         [self.bottomRefreshControl endRefreshing];
//    });
//   
//   
//}

//-(void)stopPullToRefresh
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [detailTableView.pullToRefreshView stopAnimating];
//    });
//   
//}
-(void)layoutChanged
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        NSLog(@"Landscape");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [self managelayout:0.07];
            
        }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            
            [self managelayoutIphone:0.05];
        }
    }else {
        NSLog(@"Portrait");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [self managelayout:0.05];
            
            
        }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [self managelayoutIphone:0.05];
        }
    }

}

-(void)createDatasourceForTableViewAsKeyArrayAndValueArray
{
    
    keyArrForTableView =   [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"Total Registered",@"Total Sold Vouchers",@"Total Refund",@"Web Registration",@"WAP Registration",@"App Registration",@"Corporate Registration",@"FB Lead registration", @"N/A registration",@"Amex Registration",@"Web Sales",@"WAP Sales",@"App Sales",@"Corporate Retail Sales",@"Corporate B2B Sales",@"N/A Tagging Sales",@"Ios App Install",@"Ios App Uninstall",@"Android App Install",@"Android App Uninstall",@"Inventory Details", nil];
   // @"Corporate Sales",
    valueArrForTableView = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    NSString        *hotelBookedValue;
    responseDict    = [reportArray objectAtIndex:0];
    responseDict2   = self.VoucherSaleReportDaywiseDict;
    responseDict3   = voucherSoldReprtDictThisMonth;
    responseDict4   = self.VoucherSaleReportYearwiseDict;
    
    responseDict5   = [userRegDayWiseArray objectAtIndex:0];
    responseDict6   = [userRegMonthWiseArray objectAtIndex:0];
    responseDict7   = [userRegYearWiseArray objectAtIndex:0];
    responseDict8   = [userRegAllArray objectAtIndex:0];
    responseDict9   = [voucherSaleAllArray objectAtIndex:0];
    responseDict10  = [appDownlaodsArray objectAtIndex:0];
    
    existUserRow = 0;
    existUserSoldVoucher = 0;
    newUserRow = 0;
    newUserSoldVoucher = 0;
    
    for (id dict in voucherSoldExistingUser) {
        int transaction = [[dict objectForKey:@"totalnooftransaction"] intValue];
        if (transaction > 1) {
            existUserRow += 1;
            existUserSoldVoucher += [[dict objectForKey:@"totalsoldvouchers"] intValue];
        }else{
            newUserRow += 1;
            newUserSoldVoucher += [[dict objectForKey:@"totalsoldvouchers"] intValue];
        }
    }
    
    newUserValueStr = [NSString stringWithFormat:@"%d (%d)", newUserRow, newUserSoldVoucher];
    existUserValueStr = [NSString stringWithFormat:@"%d (%d)", existUserRow, existUserSoldVoucher];
    
    for(id key in responseDict){
        NSLog(@"key=%@ value=%@", key, [responseDict objectForKey:key]);
        if ([key isEqualToString:@"HotelBooked"]) {
            hotelBookedValue = [responseDict objectForKey:key];
        }
    }
    
    NSString  *hotelWishlist;
    for(id key in responseDict){
        NSLog(@"key=%@ value=%@", key, [responseDict objectForKey:key]);
        if ([key isEqualToString:@"WishlistRedeemed"]) {
            hotelWishlist = [responseDict objectForKey:key];
        }
    }
    
    int checkSnoVar = 0;
    
   
   
    NSString *TotalreguserYearwise;
    NSString *Totalregusermonthwise;
    NSString *registerdUserDayWise;
    NSString *totalAppReguserYearwise;
    NSString *totalAppReguserdaywise;
    NSString *totalAppRegusermonthwise;
    NSString *totalrefundMonthwise;
    NSString *totalrefundYearwise;
    NSString *refundRequestDayWise;
    NSString *webRegistrationDayWise;
    NSString *WAPRegistrationDayWise;
    NSString *webRegistrationMonthWise;
    NSString *WAPRegistrationMonthWise;
    NSString *webRegistrationYearWise;
    NSString *WAPRegistarationYearWise;
    NSString *appRegDayWise;
    NSString *appRegMonthWise;
    NSString *appRegYearWise;
    
    NSString *totalSoldVouchersMonthWise;
    NSString *totalSoldVoucherYearwise;
    
    NSString *totalSoldVouchersDaywise;
    NSString *CorporateB2BDaywise;
    NSString *CorporateB2BMonthWise;
    NSString *CorporateB2BYearWise;
    
    NSString *webSaleDayWise;
    NSString *webSaleMonthWise;
    NSString *webSaleyearWise;
    NSString *wapSaleDayWise;
    NSString *wapSaleMonthWise;
    NSString *wapSaleYearWise;
    NSString *appSaleDayWise;
    NSString *appSaleMonthWise;
    NSString *appSaleYearWise;
    NSString *corporateSaleDayWise;
    NSString *corporateSaleMonthWise;
    NSString *corporateSaleYearWise;
    
    NSString *corporateRegDayWise;
    NSString *corporateRegMonthWise;
    NSString *corporateRegYearWise;
    
    
    NSString *totalRegAll;
    NSString *totalSoldVoucherAll;
    NSString *totalRefundAll;
    NSString *webRegistrationAll;
    NSString *wapRegAll;
    NSString *appRegAll;
//    NSString *corporateRegAll;
//    NSString *webSaleAll;
//    NSString *wapSaleAll;
//    NSString *appSaleAll;
//    NSString *corporateSaleAll;
    
     //  NSString *CorporateB2BAll;
    
    
    NSString *iosAppInstallToday;
    NSString *iosAppInstallMonth;
    NSString *iosAppInstallYear;
    NSString *iosAppInstallTotal;
    NSString *iosAppUnistallToday;
    NSString *iosAppUnistallMonth;
    NSString *iosAppUnistallYear;
    NSString *iosAppUnistallTotal;
    NSString *androidAppInstallToday;
    NSString *androidAppInstallMonth;
    NSString *androidAppInstallYear;
    NSString *androidAppInstallTotal;
    NSString *andoridAppUninstallToday;
    NSString *andoridAppUninstallMonth;
    NSString *andoridAppUninstallYear;
    NSString *andoridAppUninstallTotal;
    
    
    
    for (id key in responseDict10) {
        NSString *keyToSwitch = key;
        
        if ([keyToSwitch isEqualToString:@"TodayIOSInstall"])
        {
            iosAppInstallToday = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"MonthlyIOSInstall"])
        {
            iosAppInstallMonth = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"YearlyIOSInstall"])
        {
            iosAppInstallYear = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalIOSInstall"])
        {
            iosAppInstallTotal = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TodayAndroid"])
        {
            androidAppInstallToday = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"MonthlyAndroid"])
        {
            androidAppInstallMonth = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"YearlyAndroid"])
        {
            androidAppInstallYear = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalAndroid"])
        {
            androidAppInstallTotal = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TodayAndroidUnstall"])
        {
            andoridAppUninstallToday = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"MonthlyAndroidUnstall"])
        {
            andoridAppUninstallMonth = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"YearlyAndroidUnstall"])
        {
            andoridAppUninstallYear = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalAndroidUnstall"])
        {
            andoridAppUninstallTotal = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TodayIOSUnstall"])
        {
            iosAppUnistallToday = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"MonthlyIOSUnstall"])
        {
            iosAppUnistallMonth = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"YearlyIOSUnstall"])
        {
            iosAppUnistallYear = [responseDict10 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalIOSUnstall"])
        {
            iosAppUnistallTotal = [responseDict10 objectForKey:keyToSwitch];
        }

    }
    
    for(id key in responseDict8){
        NSLog(@"key=%@ value=%@", key, [responseDict8 objectForKey:key]);
        
        NSString *keyToSwitch = key;
        
        if ([keyToSwitch isEqualToString:@"TotalUserReg_All"])
        {
            totalRegAll = [responseDict8 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWebUserReg_All"])
        {
            webRegistrationAll = [responseDict8 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWapUserReg_All"])
        {
            wapRegAll = [responseDict8 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalAppUserReg_All"])
        {
            appRegAll = [responseDict8 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateUserReg_All"])
        {
            corporateRegAll = [responseDict8 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalRefund_All"])
        {
            totalRefundAll = [responseDict8 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalRecord_NULL_All"])
        {
            naUserRegAll = [responseDict8 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalRecord_Amex_All"])
        {
             amexuserRegAll = [responseDict8 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalFBLeadUserReg_All"])
        {
            fbLeaduserRegAll = [responseDict8 objectForKey:keyToSwitch];
        }
        
    }

    
    for(id key in responseDict9){
        NSLog(@"key=%@ value=%@", key, [responseDict9 objectForKey:key]);
        
        NSString *keyToSwitch = key;
        
        if ([keyToSwitch isEqualToString:@"TotalWebVouchers_All"])
        {
         //   webSaleAll = [responseDict9 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWapVouchers_All"])
        {
           // wapSaleAll = [responseDict9 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalAppVouchers_All"])
        {
         //   appSaleAll = [responseDict9 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateVouchers_All"])
        {
          //  corporateSaleAll = [responseDict9 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalPaidVouchers_All"])
        {
            totalSoldVoucherAll = [responseDict9 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateB2B_All"])
        {
            //CorporateB2BAll = [responseDict9 objectForKey:keyToSwitch];
        }
        
    }

    
    for(id key in responseDict2){
        NSLog(@"key=%@ value=%@", key, [responseDict2 objectForKey:key]);
        
        NSString *keyToSwitch = key;
      
        if ([keyToSwitch isEqualToString:@"TotalPaidVouchers_Daywise"])
        {
            totalSoldVouchersDaywise = [responseDict2 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWebVouchers_Daywise"])
        {
            webSaleDayWise = [responseDict2 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWapVouchers_Daywise"])
        {
            wapSaleDayWise = [responseDict2 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalAppVouchers_Daywise"])
        {
            appSaleDayWise = [responseDict2 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateVouchers_Daywise"])
        {
            corporateSaleDayWise = [responseDict2 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateB2B_Daywise"])
        {
            CorporateB2BDaywise = [responseDict2 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalNullVouchers_DayWise"])
        {
            noTagingSaleDaywise = [responseDict2 objectForKey:keyToSwitch];
        }
        
    }
    
    for(id key in responseDict3){
        NSLog(@"key=%@ value=%@", key, [responseDict3 objectForKey:key]);
        
        NSString *keyToSwitch = key;
        
        if ([keyToSwitch isEqualToString:@"TotalPaidVouchers_Monthwise"])
        {
            totalSoldVouchersMonthWise = [responseDict3 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWebVouchers_Monthwise"])
        {
            webSaleMonthWise = [responseDict3 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWapVouchers_Monthwise"])
        {
            wapSaleMonthWise = [responseDict3 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalAppVouchers_Monthwise"])
        {
            appSaleMonthWise = [responseDict3 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateVouchers_Monthwise"])
        {
            corporateSaleMonthWise = [responseDict3 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateB2B_Monthwise"])
        {
            CorporateB2BMonthWise = [responseDict3 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalNullVouchers_MonthWise"])
        {
            noTagingSaleMonthWise = [responseDict3 objectForKey:keyToSwitch];
        }
        
    }

    for(id key in responseDict4){
        NSLog(@"key=%@ value=%@", key, [responseDict4 objectForKey:key]);
        
        NSString *keyToSwitch = key;
        
        if ([keyToSwitch isEqualToString:@"TotalPaidVouchers_Yearwise"])
        {
            totalSoldVoucherYearwise = [responseDict4 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWebVouchers_Yearwise"])
        {
            webSaleyearWise = [responseDict4 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWapVouchers_Yearwise"])
        {
            wapSaleYearWise = [responseDict4 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalAppVouchers_Yearwise"])
        {
            appSaleYearWise = [responseDict4 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateVouchers_Yearwise"])
        {
            corporateSaleYearWise = [responseDict4 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateB2B_Yearwise"])
        {
            CorporateB2BYearWise = [responseDict4 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalNullVouchers_YearWise"])
        {
            noTagingSaleYearWise = [responseDict4 objectForKey:keyToSwitch];
            
    }
    
    for(id key in responseDict5){
        NSLog(@"key=%@ value=%@", key, [responseDict5 objectForKey:key]);
        
        NSString *keyToSwitch = key;
        
        if ([keyToSwitch isEqualToString:@"TotalUserReg_Daywise"])
        {
            registerdUserDayWise = [responseDict5 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWebUserReg_Daywise"])
        {
          webRegistrationDayWise  = [responseDict5 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWapUserReg_Daywise"])
        {
            WAPRegistrationDayWise = [responseDict5 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalAppUserReg_Daywise"])
        {
            appRegDayWise = [responseDict5 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateUserReg_Daywise"])
        {
            corporateRegDayWise = [responseDict5 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalRecord_NULL_Daywise"])
        {
            naUserRegDayWise = [responseDict5 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalRecord_Amex_Daywise"])
        {
            amexuserRegDaywise = [responseDict5 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalFBLeadUserReg_Daywise"])
        {
            fbLeaduserRegDaywise = [responseDict5 objectForKey:keyToSwitch];
        }
        
    }
    
    for(id key in responseDict6){
        NSLog(@"key=%@ value=%@", key, [responseDict6 objectForKey:key]);
        
        NSString *keyToSwitch = key;
        
        if ([keyToSwitch isEqualToString:@"TotalUserReg_Monthwise"])
        {
            Totalregusermonthwise = [responseDict6 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWebUserReg_Monthwise"])
        {
            webRegistrationMonthWise = [responseDict6 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWapUserReg_Monthwise"])
        {
            WAPRegistrationMonthWise = [responseDict6 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalAppUserReg_Monthwise"])
        {
            appRegMonthWise = [responseDict6 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateUserReg_Monthwise"])
        {
            corporateRegMonthWise = [responseDict6 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalRecord_Amex_Monthwise"])
        {
            amexuserRegMonthWise = [responseDict6 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalRecord_NULL_Monthwise"])
        {
            naUserRegMonthWise = [responseDict6 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalFBLeadUserReg_Monthwise"])
        {
            fbLeaduserRegMonthWise = [responseDict6 objectForKey:keyToSwitch];
        }
        
    }
    
    for(id key in responseDict7){
        NSLog(@"key=%@ value=%@", key, [responseDict7 objectForKey:key]);
        
        NSString *keyToSwitch = key;
        
        if ([keyToSwitch isEqualToString:@"TotalUserReg_Yearwise"])
        {
            TotalreguserYearwise = [responseDict7 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWebUserReg_Yearwise"])
        {
            webRegistrationYearWise = [responseDict7 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalWapUserReg_Yearwise"])
        {
            WAPRegistarationYearWise = [responseDict7 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalAppUserReg_Yearwise"])
        {
            appRegYearWise = [responseDict7 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalCorporateUserReg_Yearwise"])
        {
            corporateRegYearWise = [responseDict7 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalRecord_Amex_Yearwise"])
        {
            amexuserRegYearWise = [responseDict7 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalRecord_NULL_Yearwise"])
        {
            naUserRegYearWise = [responseDict7 objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TotalFBLeadUserReg_Yearwise"])
        {
            fbLeaduserRegYearWise = [responseDict7 objectForKey:keyToSwitch];
        }
        
    }


    
    for(id key in responseDict){
        NSLog(@"key=%@ value=%@", key, [responseDict objectForKey:key]);
        
        NSString *keyToSwitch = key;
        NSString *keyToDisplay;
        NSString *valueOfKey;
        
        checkSnoVar = 0;
        
        if ([keyToSwitch isEqualToString:@"Datewise"]) {
           checkSnoVar = 0;
//            keyToDisplay = @"Date";
//            valueOfKey =   [responseDict objectForKey:keyToSwitch];
//             [keyArrForTableView replaceObjectAtIndex:2 withObject:keyToDisplay];
//             [valueArrForTableView replaceObjectAtIndex:2 withObject:valueOfKey];
                   }
        else if ([keyToSwitch isEqualToString:@"HotelAvailableWishlistwise"])
        {
            checkSnoVar = 1;
            keyToDisplay = @"Hotel Available";
            valueOfKey =  [NSString stringWithFormat:@"%@ (%@)", [responseDict objectForKey:keyToSwitch],hotelBookedValue];
            [keyArrForTableView replaceObjectAtIndex:6 withObject:keyToDisplay];
            [valueArrForTableView replaceObjectAtIndex:6 withObject:valueOfKey];
        }else if ([keyToSwitch isEqualToString:@"Regusers"])
        {
            checkSnoVar = 1;
            keyToDisplay = @"Registered Users";
            valueOfKey =   [responseDict objectForKey:keyToSwitch];
            [keyArrForTableView replaceObjectAtIndex:0 withObject:keyToDisplay];
            [valueArrForTableView replaceObjectAtIndex:0 withObject:valueOfKey];
          //  registerdUserDayWise = [responseDict objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"TodayWishlist"])
        {
            checkSnoVar = 1;
            keyToDisplay = @"Today Wishlist";
            valueOfKey =  [NSString stringWithFormat:@"%@ (%@)", [responseDict objectForKey:keyToSwitch],hotelWishlist];
            [keyArrForTableView replaceObjectAtIndex:5 withObject:keyToDisplay];
            [valueArrForTableView replaceObjectAtIndex:5 withObject:valueOfKey];
        }else if ([keyToSwitch isEqualToString:@"VRStayingToday"])
        {
            checkSnoVar = 1;
            keyToDisplay = @"Staying Today";
            valueOfKey =   [responseDict objectForKey:keyToSwitch];
            [keyArrForTableView replaceObjectAtIndex:3 withObject:keyToDisplay];
            [valueArrForTableView replaceObjectAtIndex:3 withObject:valueOfKey];
        }else if ([keyToSwitch isEqualToString:@"VoucherRedeemed"])
        {
            checkSnoVar = 1;
            keyToDisplay = @"Redeemed Vouchers";
            valueOfKey =   [responseDict objectForKey:keyToSwitch];
            [keyArrForTableView replaceObjectAtIndex:2 withObject:keyToDisplay];
            [valueArrForTableView replaceObjectAtIndex:2 withObject:valueOfKey];
        }else if ([keyToSwitch isEqualToString:@"voucherGifted"])
        {
            checkSnoVar = 1;
            keyToDisplay = @"Gifted";
            valueOfKey =   [responseDict objectForKey:keyToSwitch];
            [keyArrForTableView replaceObjectAtIndex:7 withObject:keyToDisplay];
            [valueArrForTableView replaceObjectAtIndex:7 withObject:[self.VoucherSaleReportDaywiseDict objectForKey:@"TotalPaidVouchers_Daywise"]];
        }else if ([keyToSwitch isEqualToString:@"voucherpurchased"])
        {
            checkSnoVar = 1;
            keyToDisplay = @"Sold Vouchers";
            valueOfKey =   [responseDict objectForKey:keyToSwitch];
            [keyArrForTableView replaceObjectAtIndex:1 withObject:keyToDisplay];
            [valueArrForTableView replaceObjectAtIndex:1 withObject:valueOfKey];
        //    purchaseVouchersDaywise =  [responseDict objectForKey:keyToSwitch];
        }else if ([keyToSwitch isEqualToString:@"vouchertransferred"])
        {
            checkSnoVar = 1;
            keyToDisplay = @"Transferred";
            valueOfKey =   [responseDict objectForKey:keyToSwitch];
            [keyArrForTableView replaceObjectAtIndex:8 withObject:keyToDisplay];
            [valueArrForTableView replaceObjectAtIndex:8 withObject:valueOfKey];
           
        }else if ([keyToSwitch isEqualToString:@"wishlistcreated"])
        {
            checkSnoVar = 1;
            keyToDisplay = @"Wishlist Created";
            valueOfKey =   [responseDict objectForKey:keyToSwitch];
            [keyArrForTableView replaceObjectAtIndex:4 withObject:keyToDisplay];
            [valueArrForTableView replaceObjectAtIndex:4 withObject:valueOfKey];
        }else if ([keyToSwitch isEqualToString:@"RefundRequest"])
        {
            checkSnoVar = 1;
            keyToDisplay = @"Refund Request";
            valueOfKey =   [responseDict objectForKey:keyToSwitch];
            [keyArrForTableView replaceObjectAtIndex:9 withObject:keyToDisplay];
            [valueArrForTableView replaceObjectAtIndex:9 withObject:valueOfKey];
        }else if ([keyToSwitch isEqualToString:@"Refunded"])
        {
            checkSnoVar = 1;
            keyToDisplay = @"Refunded";
            valueOfKey =   [responseDict objectForKey:keyToSwitch];
            [keyArrForTableView replaceObjectAtIndex:10 withObject:keyToDisplay];
            [valueArrForTableView replaceObjectAtIndex:10 withObject:valueOfKey];
         //   refunded = [valueArrForTableView objectAtIndex:10];
        }else if ([keyToSwitch isEqualToString:@"sno"])
        {
            checkSnoVar = 0;
            continue;
        }else if ([keyToSwitch isEqualToString:@"HotelBooked"])
        {
            checkSnoVar = 0;
            continue;
        }else if ([keyToSwitch isEqualToString:@"TotalPurchasedVoucherMonthwise"])
        {
            checkSnoVar = 0;
         //   totalPurchasedVouchersMonthWise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }else if ([keyToSwitch isEqualToString:@"TotalPurchasedVoucherYearwise"])
        {
            checkSnoVar = 0;
         //   totalPurchasedVoucherYearwise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }else if ([keyToSwitch isEqualToString:@"TotalreguserYearwise"])
        {
            checkSnoVar = 0;
        //    TotalreguserYearwise  =   [responseDict objectForKey:keyToSwitch];
            continue;
        }else if ([keyToSwitch isEqualToString:@"Totalregusermonthwise"])
        {
            checkSnoVar = 0;
         //   Totalregusermonthwise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }else if ([keyToSwitch isEqualToString:@"TotalAppsaleDaywise"])
        {
            checkSnoVar = 0;
            continue;
        }else if ([keyToSwitch isEqualToString:@"TotalAppsaleMonthwise"])
        {
            checkSnoVar = 0;
            continue;
        }else if ([keyToSwitch isEqualToString:@"TotalAppsaleYearwise"])
        {
            checkSnoVar = 0;
            continue;
        }else if ([keyToSwitch isEqualToString:@"TotalAppReguserdaywise"])
        {
            checkSnoVar = 0;
            totalAppReguserdaywise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }else if ([keyToSwitch isEqualToString:@"TotalAppRegusermonthwise"])
        {
            checkSnoVar = 0;
            totalAppRegusermonthwise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }else if ([keyToSwitch isEqualToString:@"TotalAppReguserYearwise"])
        {
            checkSnoVar = 0;
            totalAppReguserYearwise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }else if ([keyToSwitch isEqualToString:@"totalrefundMonthwise"])
        {
            checkSnoVar = 0;
            totalrefundMonthwise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }else if ([keyToSwitch isEqualToString:@"totalrefundYearwise"])
        {
            checkSnoVar = 0;
            totalrefundYearwise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }else if ([keyToSwitch isEqualToString:@"totalrefunddaywise"])
        {
            checkSnoVar = 0;
            refundRequestDayWise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }

}
    NSString *totalRegisteredUser = [NSString stringWithFormat:@"%@/%@/%@/%@",registerdUserDayWise,Totalregusermonthwise,TotalreguserYearwise,totalRegAll];
    [valueArrForTableView replaceObjectAtIndex:11 withObject:totalRegisteredUser];
    
  
    
    
    NSString *totalSoldUser  = [NSString  stringWithFormat:@"%@/%@/%@/%@", totalSoldVouchersDaywise, totalSoldVouchersMonthWise,totalSoldVoucherYearwise,totalSoldVoucherAll];
    [valueArrForTableView replaceObjectAtIndex:12 withObject:totalSoldUser];
    
  
    
    NSString *totalRefundStr = [NSString stringWithFormat:@"%d/%@/%@/%@", [refundRequestDayWise intValue],totalrefundMonthwise,totalrefundYearwise,totalRefundAll];
    [valueArrForTableView replaceObjectAtIndex:13 withObject:totalRefundStr];
    
    
    
    NSString *totalWebReg = [NSString stringWithFormat:@"%@/%@/%@/%@", webRegistrationDayWise,webRegistrationMonthWise,webRegistrationYearWise,webRegistrationAll];
    [valueArrForTableView replaceObjectAtIndex:14 withObject:totalWebReg];
    
    NSString *totalWAPReg = [NSString stringWithFormat:@"%@/%@/%@/%@",WAPRegistrationDayWise ,WAPRegistrationMonthWise,WAPRegistarationYearWise,wapRegAll];
    [valueArrForTableView replaceObjectAtIndex:15 withObject:totalWAPReg];
    
    NSString *appReg  = [NSString stringWithFormat:@"%@/%@/%@/%@", appRegDayWise,appRegMonthWise,appRegYearWise,appRegAll];
    [valueArrForTableView replaceObjectAtIndex:16 withObject:appReg];
    
    NSString *totalCorporateRegStr = [NSString stringWithFormat:@"%@/%@/%@/%@",corporateRegDayWise,corporateRegMonthWise,corporateRegYearWise,corporateRegAll];
    [valueArrForTableView replaceObjectAtIndex:17 withObject:totalCorporateRegStr];
    
    NSString *totalFbLeadRegUser = [NSString stringWithFormat:@"%@/%@/%@/%@",fbLeaduserRegDaywise,fbLeaduserRegMonthWise,fbLeaduserRegYearWise,fbLeaduserRegAll];
    [valueArrForTableView replaceObjectAtIndex:18 withObject:totalFbLeadRegUser];
    
    NSString *totalNARegStr = [NSString stringWithFormat:@"%@/%@/%@/%@",naUserRegDayWise,naUserRegMonthWise,naUserRegYearWise,naUserRegAll];
    [valueArrForTableView replaceObjectAtIndex:19 withObject:totalNARegStr];
    
    NSString *totalAmexRegStr = [NSString stringWithFormat:@"%@/%@/%@/%@",amexuserRegDaywise,amexuserRegMonthWise,amexuserRegYearWise,amexuserRegAll];
    [valueArrForTableView replaceObjectAtIndex:20 withObject:totalAmexRegStr];
    
    
    
    NSString *totalWebSeles = [NSString stringWithFormat:@"%@/%@/%@/%@",webSaleDayWise,webSaleMonthWise,webSaleyearWise,webSaleAll];
    [valueArrForTableView replaceObjectAtIndex:21 withObject:totalWebSeles];
    
    NSString *totalWEPSeles = [NSString stringWithFormat:@"%@/%@/%@/%@",wapSaleDayWise,wapSaleMonthWise,wapSaleYearWise,wapSaleAll];
    [valueArrForTableView replaceObjectAtIndex:22 withObject:totalWEPSeles];
    
    NSString *totalAppSales = [NSString stringWithFormat:@"%@/%@/%@/%@",appSaleDayWise,appSaleMonthWise,appSaleYearWise,appSaleAll];
    [valueArrForTableView replaceObjectAtIndex:23 withObject:totalAppSales];
    
    NSString *totalCorporateSales = [NSString stringWithFormat:@"%@/%@/%@/%@",corporateSaleDayWise,corporateSaleMonthWise,corporateSaleYearWise,corporateSaleAll];
    [valueArrForTableView replaceObjectAtIndex:24 withObject:totalCorporateSales];
    
    NSString *totalCorporateSalesB2b = [NSString stringWithFormat:@"%@/%@/%@/%@",CorporateB2BDaywise,CorporateB2BMonthWise,CorporateB2BYearWise,CorporateB2BAll];
    [valueArrForTableView replaceObjectAtIndex:25 withObject:totalCorporateSalesB2b];
    
    NSString *totalNoTagingSale = [NSString stringWithFormat:@"%@/%@/%@/%@",noTagingSaleDaywise,noTagingSaleMonthWise,noTagingSaleYearWise,noTaggingSaleAll];
    [valueArrForTableView replaceObjectAtIndex:26 withObject:totalNoTagingSale];
   
    
    
    NSString *iosAppInstallDetail = [NSString stringWithFormat:@"%@/%@/%@/%@",iosAppInstallToday,iosAppInstallMonth,iosAppInstallYear,iosAppInstallTotal];
    [valueArrForTableView replaceObjectAtIndex:27 withObject:iosAppInstallDetail];
    
    NSString *iosAppUninstall = [NSString stringWithFormat:@"%@/%@/%@/%@",iosAppUnistallToday,iosAppUnistallMonth,iosAppUnistallYear,iosAppUnistallTotal];
    [valueArrForTableView replaceObjectAtIndex:28 withObject:iosAppUninstall];
    
    NSString *androidAppInstall = [NSString stringWithFormat:@"%@/%@/%@/%@",androidAppInstallToday,androidAppInstallMonth,androidAppInstallYear,androidAppInstallTotal];
    [valueArrForTableView replaceObjectAtIndex:29 withObject:androidAppInstall];
    
    NSString *androidAppUninstall = [NSString stringWithFormat:@"%@/%@/%@/%@",andoridAppUninstallToday,andoridAppUninstallMonth,andoridAppUninstallYear,andoridAppUninstallTotal];
    [valueArrForTableView replaceObjectAtIndex:30 withObject:androidAppUninstall];

    
    }
}

-(int)noOfDaysBetweenCurrentAndLblDate
{
    NSString *dateStr = dateLabel.text;
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *lblDate = [dateFormat dateFromString:dateStr];
    
    NSDate *currentDate = [NSDate date];
    
    NSInteger day = [self daysBetweenStartDate:lblDate andEndDate:currentDate];
    int noOfDays = (int)day;
    NSLog(@"%d", noOfDays);
    return noOfDays;
}
-(void)decrementDate:(id)sender
{
       if ([self noOfDaysBetweenCurrentAndLblDate] >= 0) {
        
        
        [IncrementDateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        IncrementDateBtn.userInteractionEnabled = YES;
        NSString *dateForDecrement= dateLabel.text;
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
        NSDate *dateObjectForDecrement=[dateFormatter dateFromString:dateForDecrement];
        
        NSDate *dateAfterDecrement=[dateObjectForDecrement addTimeInterval:-(24*60*60)];
           NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
           [dateformate setDateFormat:@"yyyy-MM-dd"]; // Date formater
           NSString *lblDate = [dateformate stringFromDate:dateAfterDecrement]; // Convert date to string
           NSLog(@"date :%@",lblDate);
           [self nilPreviousObject];
           self.reload = 32;
           DateOFInventoryDetail = lblDate;
           
          
        
           NSDate *dateObjectForIncrement=[dateformate dateFromString:DateOFInventoryDetail];
           
           NSDate *tomorrowDate =[dateObjectForIncrement addTimeInterval: + (24*60*60)];
           NSDateFormatter *dateformateTemp=[[NSDateFormatter alloc]init];
           [dateformateTemp setDateFormat:@"yyyy-MM-dd"]; // Date formater
           tomorrowDateOFInventoryDetail = [dateformateTemp stringFromDate:tomorrowDate];
           
           NSDate *dateAfterDecrementTwoDays=[dateObjectForIncrement addTimeInterval: + (24*60*60 *2)];
           NSDateFormatter *dateformateT=[[NSDateFormatter alloc]init];
           [dateformateT setDateFormat:@"yyyy-MM-dd"]; // Date formater
           dayAfterTomorrowDateOFInventoryDetail = [dateformate stringFromDate:dateAfterDecrementTwoDays];
           
           [self IntegrateFourWebService:lblDate];
           firsttimeInventoryDetailFetchData = 0;
           
        dateLabel.text = @"";
        dateLabel.text =  [dateFormatter stringFromDate:dateAfterDecrement];
        
    }
}
-(void)nilPreviousObject
{
    dateLabel.text = @"";
    responseArr = nil;
    responseDict = nil;
    keyArrForTableView = nil;
    valueArrForTableView = nil;
    detailTableView = nil;
    responseDict2 = nil;
    responseDict3 = nil;
    responseDict4 = nil;
 //   reportYearArray = nil;
    reportArray = nil;
//    reportMonthArray = nil;
//    reportDayArray = nil;
    inventoryDetailArr = nil;
}

-(void)IncrementDate:(id)sender
{
       if ([self noOfDaysBetweenCurrentAndLblDate] >= 1) {
        IncrementDateBtn.userInteractionEnabled = YES;
        NSString *dateForDecrement= dateLabel.text;
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
        NSDate *dateObjectForDecrement=[dateFormatter dateFromString:dateForDecrement];
        
        NSDate *dateAfterIncrement=[dateObjectForDecrement addTimeInterval:+(24*60*60)];
           
           NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
           [dateformate setDateFormat:@"yyyy-MM-dd"]; // Date formater
           NSString *lblDate = [dateformate stringFromDate:dateAfterIncrement]; // Convert date to string
           NSLog(@"date :%@",lblDate);
          
           [self nilPreviousObject];
           self.reload = 32;
           DateOFInventoryDetail = lblDate;
           
           NSDate *dateObjectForIncrement=[dateformate dateFromString:DateOFInventoryDetail];
           
           NSDate *tomorrowDate =[dateObjectForIncrement addTimeInterval: + (24*60*60)];
           NSDateFormatter *dateformateTemp=[[NSDateFormatter alloc]init];
           [dateformateTemp setDateFormat:@"yyyy-MM-dd"]; // Date formater
           tomorrowDateOFInventoryDetail = [dateformateTemp stringFromDate:tomorrowDate];
           
           NSDate *dateAfterDecrementTwoDays=[dateObjectForIncrement addTimeInterval: + (24*60*60 *2)];
           NSDateFormatter *dateformateT=[[NSDateFormatter alloc]init];
           [dateformateT setDateFormat:@"yyyy-MM-dd"]; // Date formater
           dayAfterTomorrowDateOFInventoryDetail = [dateformate stringFromDate:dateAfterDecrementTwoDays];

           [self IntegrateFourWebService:lblDate];
           firsttimeInventoryDetailFetchData = 0;
           dateLabel.text = @"";
        dateLabel.text =  [dateFormatter stringFromDate:dateAfterIncrement];
        
    }else{
        [IncrementDateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        IncrementDateBtn.userInteractionEnabled = NO;
    }
    
    if ([self noOfDaysBetweenCurrentAndLblDate] == 0){
        [IncrementDateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        IncrementDateBtn.userInteractionEnabled = NO;
    }
    
}


- (NSInteger) daysBetweenStartDate: (NSDate*) lblDate andEndDate: (NSDate*) currentDate;
{
    
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* dateComponents = [gregorian components: NSDayCalendarUnit fromDate:lblDate  toDate:currentDate options: 0];
    return dateComponents.day;
}

-(void)dismissControllerButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
