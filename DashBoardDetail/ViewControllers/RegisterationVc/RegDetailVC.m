//
//  RegDetailVC.m
//  DashBoardDetail
//
//  Created by Planet on 9/19/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "RegDetailVC.h"
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

@interface RegDetailVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UILabel                                               *dateLabel;
    UIButton                                              *IncrementDateBtn;
    UIView                                                *baseView;
    UIView                                                *dateBaseView;
    UIButton                                              *decrementDateBtn;
    UITableView                                           *detailTableView;
    UIImageView                                           *icsLogoImageView;
    NSString                                             *DateOFInventoryDetail;
    int                                                  firstTimeDetailFetch;
    UILabel *controllerDetailLbl;
    UIButton *backButton;
    NSMutableArray                                        *userRegDayWiseArray;
    NSMutableArray                                        *userRegMonthWiseArray;
    NSMutableArray                                        *userRegYearWiseArray;
    NSMutableArray                                        *userRegAllArray;
    NSMutableArray *totalRegisterdPreviousMonthArr;
    NSMutableArray *totalRegisteredBeforePreviousMonthArr;
    NSMutableArray *totalRegisteredTwoBeforePreviousMonthArr;
    NSString *totalRegisteredPreviousMonthValue;
    NSString *totalRegisterdMonthBeforeValue;
    NSString *totalRegisteredMonthTwoBeforeValue;
    
     NSDictionary                                          *responseDict8;
    NSDictionary                                          *responseDict5;
    NSDictionary                                          *responseDict6;
    NSDictionary                                          *responseDict7;
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
@property (nonatomic, strong)  NSString *previousMonthDateStr;
@property (nonatomic, strong)  NSString *beforePreviousMonthDateStr;
@property (nonatomic, strong)  NSString *twoBeforePreviousMonthDateStr;
@property (nonatomic, strong)  NSString *previousMonthName;
@property (nonatomic,strong)   NSString *BeforePreviousMonthName;
@property (nonatomic, strong)  NSString *TwoBeforePreviousMonthName;
//@property (nonatomic, strong)  NSString *newUserValueStr;
@property (nonatomic, strong)  NSString *existUserValueStr;
@property (nonatomic, strong)  NSString *DateOFInventoryDetail;
@property (nonatomic, strong)  NSString *tomorrowDateOFInventoryDetail;
@property (nonatomic, strong)  NSString *dayAfterTomorrowDateOFInventoryDetail;
@property (nonatomic, strong)  NSMutableArray    *keyArrForTableView;
@property (nonatomic, strong)  NSMutableArray    *valueArrForTableView;

@end

@implementation RegDetailVC
@synthesize keyArrForTableView;
@synthesize valueArrForTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
    
    userRegAllArray = [[NSMutableArray alloc]init];
    userRegDayWiseArray = [[NSMutableArray alloc]init];
    userRegMonthWiseArray = [[NSMutableArray alloc]init];
    userRegYearWiseArray = [[NSMutableArray alloc]init];
    
    responseDict5 = [[NSDictionary alloc]init];
    responseDict6 = [[NSDictionary alloc]init];
    responseDict7 = [[NSDictionary alloc]init];
    responseDict8 = [[NSDictionary alloc]init];
    
    
    firstTimeDetailFetch = 0;
    valueArrForTableView = [[NSMutableArray alloc]init];
    keyArrForTableView = [[NSMutableArray alloc]init];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *todayDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year,(long)week,(long)day];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    self.DateOFInventoryDetail = [formatter stringFromDate:[NSDate date]];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *dateObjectForDecrement=[dateFormatter dateFromString:self.DateOFInventoryDetail];
    
    NSDate *dateAfterDecrement=[dateObjectForDecrement addTimeInterval: + (24*60*60)];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd"]; // Date formater
    self.tomorrowDateOFInventoryDetail = [dateformate stringFromDate:dateAfterDecrement];
    
    NSDate *dateAfterDecrementTwoDays=[dateObjectForDecrement addTimeInterval: + (24*60*60 *2)];
    NSDateFormatter *dateformateT=[[NSDateFormatter alloc]init];
    [dateformateT setDateFormat:@"yyyy-MM-dd"]; // Date formater
    self.dayAfterTomorrowDateOFInventoryDetail = [dateformate stringFromDate:dateAfterDecrementTwoDays];
    
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
    self.previousMonthName          = [[dfe monthSymbols] objectAtIndex:[componentsTemp month]];
    self.BeforePreviousMonthName    = [[dfe monthSymbols] objectAtIndex:[componentsTemp month] - 1 ];
    self.TwoBeforePreviousMonthName = [[dfe monthSymbols] objectAtIndex:[componentsTemp month] - 2 ];
    
    
    
    
    
    
    NSCalendar *calendarTemp = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    
    NSDateComponents *componentsTempd = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:currentDate];
    
    components.month = components.month - 1;
    components.day = 1;
    
    NSDate *newDate = [calendar dateFromComponents:components];
    
    NSDateFormatter *dateformateTemp=[[NSDateFormatter alloc]init];
    [dateformateTemp setDateFormat:@"yyyy-MM-dd"]; // Date formater
    self.previousMonthDateStr = [dateformate stringFromDate:newDate];
    
    
    components.month = components.month - 1;
    components.day = 1;
    
    NSDate *newDateTemp = [calendar dateFromComponents:components];
    
    NSDateFormatter *dateformateTempeBefore=[[NSDateFormatter alloc]init];
    [dateformateTempeBefore setDateFormat:@"yyyy-MM-dd"]; // Date formater
    self.beforePreviousMonthDateStr = [dateformate stringFromDate:newDateTemp];
    
    components.month = components.month - 1;
    components.day = 1;
    
    NSDate *newDateTempTemp = [calendar dateFromComponents:components];
    
    NSDateFormatter *dateformateTempTwoBefore=[[NSDateFormatter alloc]init];
    [dateformateTempTwoBefore setDateFormat:@"yyyy-MM-dd"]; // Date formater
    self.twoBeforePreviousMonthDateStr = [dateformate stringFromDate:newDateTempTemp];
    
        [self callUserRegDayWiseAPIWithStartDate:todayDateStr];
}


//-(void) callReportAPIWithStartDate:(NSString *) startDate endDate:(NSString *) endDate   {
//    
//    
//    NSString *URLStr = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/Report?startdate=%@&Enddate=%@",startDate,endDate];
//    [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
//    [[ModelManager modelManager] dashBoardDetailApiWithoutParameters:URLStr success:^(Status iStatus,id  _Nullable responseObject ) {
//        if(iStatus == StatusSuccess && responseObject){
//            responseDict = [responseObject objectAtIndex:0];
//            
//            self.totalRefundPreviousMonthValue = [responseDict objectForKey:@"totalrefundMonthwise_minusone"];
//            self.totalRefundBeforePreviousMonthValue = [responseDict objectForKey:@"totalrefundMonthwise_minustwo"];
//            self.totalRefundBeforeTwoPreviousMonthValue = [responseDict objectForKey:@"totalrefundMonthwise_minusthree"];
//            //  [self callSoldTotalAPIWithStartDate:startDate];
//            
//             [self callUserRegDayWiseAPIWithStartDate:startDate];
//            
//        }else{
//            NSLog(@"Not Valid User");
//        }
//    }
//                                                             failure:^(Status iStatus, NSString *errorMessage) {
//                                                                 [UIHelper hideSpinner];
//                                                                 [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
//                                                             }];
//}

-(void) callUserRegDayWiseAPIWithStartDate:(NSString *) startDate {
    
    
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/UserRegReport_Daywise?startdate=%@",startDate];
    [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
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
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/UserRegReport_Monthwise?startdate=%@",self.previousMonthDateStr];
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
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/UserRegReport_Monthwise?startdate=%@",self.beforePreviousMonthDateStr];
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
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/UserRegReport_Monthwise?startdate=%@",self.twoBeforePreviousMonthDateStr];
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
            [self createDataSource];
            [UIHelper hideSpinner];
            
            if (firstTimeDetailFetch == 0) {
                [self setupUiDesign];
                firstTimeDetailFetch = 1;
                
            }else if (firstTimeDetailFetch == 1){
                
                [detailTableView reloadData];
                
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

-(void)createDataSource
{
    keyArrForTableView =   [[NSMutableArray alloc]initWithObjects:@"Total Registered",@"Web Registration",@"WAP Registration",@"App Registration",@"Corporate Registration",@"FB Lead registration", @"N/A registration",@"Amex Registration", nil];
    // @"Corporate Sales",
    valueArrForTableView = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    
    
    
    NSString *TotalreguserYearwise;
    NSString *Totalregusermonthwise;
    NSString *registerdUserDayWise;
 
    NSString *webRegistrationDayWise;
    NSString *WAPRegistrationDayWise;
    NSString *webRegistrationMonthWise;
    NSString *WAPRegistrationMonthWise;
    NSString *webRegistrationYearWise;
    NSString *WAPRegistarationYearWise;
    NSString *appRegDayWise;
    NSString *appRegMonthWise;
    NSString *appRegYearWise;
    
    NSString *corporateRegDayWise;
    NSString *corporateRegMonthWise;
    NSString *corporateRegYearWise;
    
    
    NSString *totalRegAll;
   
    NSString *totalRefundAll;
    NSString *webRegistrationAll;
    NSString *wapRegAll;
    NSString *appRegAll;
 NSString *corporateRegAll;

    
    responseDict5   = [userRegDayWiseArray objectAtIndex:0];
    responseDict6   = [userRegMonthWiseArray objectAtIndex:0];
    responseDict7   = [userRegYearWiseArray objectAtIndex:0];
    responseDict8   = [userRegAllArray objectAtIndex:0];
    
   
    
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


    
    NSString *totalRegisteredUser = [NSString stringWithFormat:@"%@/%@/%@/%@",registerdUserDayWise,Totalregusermonthwise,TotalreguserYearwise,totalRegAll];
    [valueArrForTableView replaceObjectAtIndex:0 withObject:totalRegisteredUser];
    
    
        
    NSString *totalWebReg = [NSString stringWithFormat:@"%@/%@/%@/%@", webRegistrationDayWise,webRegistrationMonthWise,webRegistrationYearWise,webRegistrationAll];
    [valueArrForTableView replaceObjectAtIndex:1 withObject:totalWebReg];
    
    NSString *totalWAPReg = [NSString stringWithFormat:@"%@/%@/%@/%@",WAPRegistrationDayWise ,WAPRegistrationMonthWise,WAPRegistarationYearWise,wapRegAll];
    [valueArrForTableView replaceObjectAtIndex:2 withObject:totalWAPReg];
    
    NSString *appReg  = [NSString stringWithFormat:@"%@/%@/%@/%@", appRegDayWise,appRegMonthWise,appRegYearWise,appRegAll];
    [valueArrForTableView replaceObjectAtIndex:3 withObject:appReg];
    
    NSString *totalCorporateRegStr = [NSString stringWithFormat:@"%@/%@/%@/%@",corporateRegDayWise,corporateRegMonthWise,corporateRegYearWise,corporateRegAll];
    [valueArrForTableView replaceObjectAtIndex:4 withObject:totalCorporateRegStr];
    
    NSString *totalFbLeadRegUser = [NSString stringWithFormat:@"%@/%@/%@/%@",fbLeaduserRegDaywise,fbLeaduserRegMonthWise,fbLeaduserRegYearWise,fbLeaduserRegAll];
    [valueArrForTableView replaceObjectAtIndex:5 withObject:totalFbLeadRegUser];
    
    NSString *totalNARegStr = [NSString stringWithFormat:@"%@/%@/%@/%@",naUserRegDayWise,naUserRegMonthWise,naUserRegYearWise,naUserRegAll];
    [valueArrForTableView replaceObjectAtIndex:6 withObject:totalNARegStr];
    
    NSString *totalAmexRegStr = [NSString stringWithFormat:@"%@/%@/%@/%@",amexuserRegDaywise,amexuserRegMonthWise,amexuserRegYearWise,amexuserRegAll];
    [valueArrForTableView replaceObjectAtIndex:7 withObject:totalAmexRegStr];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUiDesign
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *string = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)day, (long)week, (long)year];
    
    
    icsLogoImageView = [[UIImageView alloc]init];
    [icsLogoImageView setImage:[UIImage imageNamed:@"icanstyLogo"]];
    [self.view addSubview:icsLogoImageView];
    
    backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    controllerDetailLbl = [[UILabel alloc]init];
    controllerDetailLbl.text = @"User Registration Details";
    controllerDetailLbl.textColor = [UIColor blackColor];
    controllerDetailLbl.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:controllerDetailLbl];
    
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
    
    
    detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(dateBaseView.frame.origin.x, dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10, dateBaseView.frame.size.width, self.view.frame.size.height - (dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10) ) style:UITableViewStylePlain];
    
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    [detailTableView setShowsVerticalScrollIndicator:NO];
    [self layoutChanged];
    
    //    pullToRefreshManager_ = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f tableView:detailTableView withClient:self];
    
    
    
    [self.view addSubview:detailTableView];
    
}


-(void)backButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return [valueArrForTableView count] ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
         return 120.0;
    }else{
        return 50.0;
    }
    
    return 50.0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    
  if (indexPath.row == 0) {
        
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
        if (indexPath.row == 0) {
            
            
            
            cell.previousMonthKeyLbl.text = _previousMonthName;
            cell.PreviousMonthValueLbl.text = totalRegisteredPreviousMonthValue;
            cell.beforePreviousMonthKeyLbl.text = _BeforePreviousMonthName;
            cell.beforePreviousMonthValueLbl.text = totalRegisterdMonthBeforeValue;
            cell.TwobeforePreviousMonthKeyLbl.text = _TwoBeforePreviousMonthName;
            cell.TwobeforePreviousMonthValueLbl.text = totalRegisteredMonthTwoBeforeValue;
            
        }
        
        
        return cell;
        
  }else {
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
      return cell;
  }
    return nil;
}



#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    
    
    
    
}

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
-(void)managelayout:(float)height
{
    
    icsLogoImageView.frame = CGRectMake((self.view.frame.size.width - (self.view.frame.size.width *0.25))/2,15,self.view.frame.size.width *0.25,self.view.frame.size.height *height);
    
    backButton.frame = CGRectMake(icsLogoImageView.frame.origin.x -150, 25,self.view.frame.size.width/4 - 15 , 30);
    backButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    controllerDetailLbl.frame = CGRectMake(10, icsLogoImageView.frame.size.height+icsLogoImageView.frame.origin.y +10, (self.view.frame.size.width - 20), self.view.frame.size.height *height);
    controllerDetailLbl.textAlignment = NSTextAlignmentCenter;
    dateBaseView.frame = CGRectMake(self.view.frame.size.width/4, controllerDetailLbl.frame.size.height+controllerDetailLbl.frame.origin.y +10, (self.view.frame.size.width/2), self.view.frame.size.height *height);
    
    decrementDateBtn.frame = CGRectMake(0, 0, dateBaseView.frame.size.width/4, self.view.frame.size.height *height);
    dateLabel.frame =  CGRectMake(dateBaseView.frame.size.width/4, 0, dateBaseView.frame.size.width/2, self.view.frame.size.height *height);
    IncrementDateBtn.frame = CGRectMake(dateLabel.frame.origin.x +dateLabel.frame.size.width, 0, dateBaseView.frame.size.width/4, self.view.frame.size.height *height);
    //    dismissControllerBtn.frame = CGRectMake(self.view.frame.size.width - 100, icsLogoImageView.frame.origin.y, 50, self.view.frame.size.height *height);
    detailTableView.frame = CGRectMake(dateBaseView.frame.origin.x, dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10, dateBaseView.frame.size.width, self.view.frame.size.height - (dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10));
    [detailTableView reloadData];
    
    
}

-(void)managelayoutIphone:(float)height
{
    
    icsLogoImageView.frame = CGRectMake(self.view.frame.size.width/4,15,self.view.frame.size.width *0.5,50);
    backButton.frame = CGRectMake(10, 25,self.view.frame.size.width/4 - 15 , 30);
    backButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    controllerDetailLbl.frame = CGRectMake(10, icsLogoImageView.frame.size.height+icsLogoImageView.frame.origin.y +10, (self.view.frame.size.width - 20), self.view.frame.size.height *height);
    controllerDetailLbl.textAlignment = NSTextAlignmentCenter;
    dateBaseView.frame = CGRectMake(10, controllerDetailLbl.frame.size.height+controllerDetailLbl.frame.origin.y +10, (self.view.frame.size.width - 20), self.view.frame.size.height *height);
    decrementDateBtn.frame = CGRectMake(0, 0, dateBaseView.frame.size.width/4, self.view.frame.size.height *height);
    dateLabel.frame =  CGRectMake(dateBaseView.frame.size.width/4, 0, dateBaseView.frame.size.width/2, self.view.frame.size.height *height);
    IncrementDateBtn.frame = CGRectMake(dateLabel.frame.origin.x +dateLabel.frame.size.width, 0, dateBaseView.frame.size.width/4, self.view.frame.size.height *height);
    detailTableView.frame = CGRectMake(dateBaseView.frame.origin.x, dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10, dateBaseView.frame.size.width, self.view.frame.size.height - (dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10));
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
        //    self.reload = 32;
        DateOFInventoryDetail = lblDate;
        
       [self callUserRegDayWiseAPIWithStartDate:DateOFInventoryDetail];
        
       
        
        dateLabel.text = @"";
        dateLabel.text =  [dateFormatter stringFromDate:dateAfterDecrement];
        
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
-(void)nilPreviousObject
{
    [keyArrForTableView removeAllObjects];
    [valueArrForTableView removeAllObjects];
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
        
        DateOFInventoryDetail = lblDate;
        [self nilPreviousObject];
      [self callUserRegDayWiseAPIWithStartDate:DateOFInventoryDetail];
        //     [self callReportAPIWithStartDate:DateOFInventoryDetail endDate:DateOFInventoryDetail];
        
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


@end
