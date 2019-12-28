//
//  SoldVoucherDetailVC.m
//  DashBoardDetail
//
//  Created by Planet on 9/19/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "SoldVoucherDetailVC.h"
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
@interface SoldVoucherDetailVC ()<UITableViewDelegate, UITableViewDataSource>
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
   
    NSDictionary                                          *responseDict2;
    NSDictionary                                          *responseDict3;
    NSDictionary                                          *responseDict4;
     NSMutableDictionary *voucherSoldReprtDictThisMonth;
    NSString *webSaleAll;
    NSString *wapSaleAll;
    NSString *appSaleAll;
    NSString *corporateSaleAll;
    NSString *CorporateB2BAll;
    NSString *totalSoldVoucherAll;
    NSString *noTaggingSaleAll;
    NSString *totalSoldPreviousMonthValue;
    NSString *totalSoldMonthBeforeValue;
    NSString *totalSoldMonthTwoBeforeValue;
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
@property (nonatomic, strong) NSMutableDictionary         *VoucherSaleReportDaywiseDict;
@property (nonatomic, strong) NSMutableDictionary         *VoucherSaleReportYearwiseDict;
@end

@implementation SoldVoucherDetailVC
@synthesize keyArrForTableView;
@synthesize valueArrForTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
     [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
    
    self.VoucherSaleReportDaywiseDict = [[NSMutableDictionary alloc]init];
    self.VoucherSaleReportYearwiseDict = [[NSMutableDictionary alloc]init];
    voucherSoldReprtDictThisMonth = [[NSMutableDictionary alloc]init];
    responseDict2 = [[NSDictionary alloc]init];
    responseDict3 = [[NSDictionary alloc]init];
    responseDict4 = [[NSDictionary alloc]init];
    
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
    
    [self VoucherSaleReportDaywise:todayDateStr];
}

-(void) VoucherSaleReportDaywise:(NSString *) startDate {
    
    
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSaleReport_Daywise?startdate=%@",startDate];
    [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
    [[ModelManager modelManager] VoucherSoldNewExistingUserCheck:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            
            [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
            self.VoucherSaleReportDaywiseDict = [responseObject objectAtIndex:0];
            [self VoucherSaleReportYearwise:startDate];
            
            
            
        }else{
         //   [UIHelper hideSpinner];
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
           
            
            webSaleAll        = [[responseObject objectAtIndex:0]objectForKey:@"TotalWebVouchers_All" ];
            wapSaleAll        = [[responseObject objectAtIndex:0] objectForKey:@"TotalWapVouchers_All" ];
            appSaleAll        = [[responseObject objectAtIndex:0] objectForKey:@"TotalAppVouchers_All" ];
            corporateSaleAll  = [[responseObject objectAtIndex:0] objectForKey:@"TotalCorporateVouchers_All" ];
            CorporateB2BAll   = [[responseObject objectAtIndex:0] objectForKey:@"TotalCorporateB2B_All" ];
            noTaggingSaleAll = [[responseObject objectAtIndex:0] objectForKey:@"TotalNullVouchers_All" ];
             totalSoldVoucherAll = [[responseObject objectAtIndex:0] objectForKey:@"TotalPaidVouchers_All"];
          
            [self callMonthWiseVoucherSaleReportAPIWithStartDate:startDate];
            
            
        }else{
            [UIHelper hideSpinner];
        }
    }
                                              failure:^(Status iStatus, NSString *errorMessage) {
                                                  [UIHelper hideSpinner];
                                                  [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                              }];
}
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
    NSString *URLStr3 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSaleReport_Monthwise?startdate=%@",_previousMonthDateStr];
    [[ModelManager modelManager] VoucherSaleReportPreviousMonthwise:URLStr3 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
                        //Call 4th API
            
            totalSoldPreviousMonthValue = [[responseObject objectAtIndex:0] objectForKey:@"TotalPaidVouchers_Monthwise"];
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
    NSString *URLStr3 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSaleReport_Monthwise?startdate=%@",_beforePreviousMonthDateStr];
    [[ModelManager modelManager] VoucherSaleReportBeforePreviousMonthwise:URLStr3 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
           
            
            totalSoldMonthBeforeValue = [[responseObject objectAtIndex:0] objectForKey:@"TotalPaidVouchers_Monthwise"];
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
    NSString *URLStr3 = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/VoucherSaleReport_Monthwise?startdate=%@",_twoBeforePreviousMonthDateStr];
    [[ModelManager modelManager] VoucherSaleReportTwoBeforePreviousMonthwise:URLStr3 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            
            totalSoldMonthTwoBeforeValue = [[responseObject objectAtIndex:0] objectForKey:@"TotalPaidVouchers_Monthwise"];
               [UIHelper hideSpinner];
            [self createDatasource];
            if (firstTimeDetailFetch == 0) {
                [self setupUiDesign];
                firstTimeDetailFetch = 1;
                
            }else if (firstTimeDetailFetch == 1){
                
                [detailTableView reloadData];
                
            }

           
        }else{
            NSLog(@"Not Valid User");
        }
    }
                                                                     failure:^(Status iStatus, NSString *errorMessage) {
                                                                         [UIHelper hideSpinner];
                                                                         [UIHelper showNotificationWithType:UINotificationAlertTypeError message:errorMessage duration:2.0];
                                                                     }];
}


-(void)createDatasource
{
    
    keyArrForTableView =   [[NSMutableArray alloc]initWithObjects:@"Total Sold Vouchers",@"Web Sales",@"WAP Sales",@"App Sales",@"Corporate Retail Sales",@"Corporate B2B Sales",@"N/A Tagging Sales", nil];
    // @"Corporate Sales",
    valueArrForTableView = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    
    responseDict2   = self.VoucherSaleReportDaywiseDict;
    responseDict3   = voucherSoldReprtDictThisMonth;
    responseDict4   = self.VoucherSaleReportYearwiseDict;
    
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
    NSString *noTagingSaleDaywise;
    NSString *noTagingSaleMonthWise;
    NSString *noTagingSaleYearWise;
    
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

}
    NSString *totalSoldUser  = [NSString  stringWithFormat:@"%@/%@/%@/%@", totalSoldVouchersDaywise, totalSoldVouchersMonthWise,totalSoldVoucherYearwise,totalSoldVoucherAll];
    [valueArrForTableView replaceObjectAtIndex:0 withObject:totalSoldUser];

    NSString *totalWebSeles = [NSString stringWithFormat:@"%@/%@/%@/%@",webSaleDayWise,webSaleMonthWise,webSaleyearWise,webSaleAll];
    [valueArrForTableView replaceObjectAtIndex:1 withObject:totalWebSeles];
    
    NSString *totalWEPSeles = [NSString stringWithFormat:@"%@/%@/%@/%@",wapSaleDayWise,wapSaleMonthWise,wapSaleYearWise,wapSaleAll];
    [valueArrForTableView replaceObjectAtIndex:2 withObject:totalWEPSeles];
    
    NSString *totalAppSales = [NSString stringWithFormat:@"%@/%@/%@/%@",appSaleDayWise,appSaleMonthWise,appSaleYearWise,appSaleAll];
    [valueArrForTableView replaceObjectAtIndex:3 withObject:totalAppSales];
    
    NSString *totalCorporateSales = [NSString stringWithFormat:@"%@/%@/%@/%@",corporateSaleDayWise,corporateSaleMonthWise,corporateSaleYearWise,corporateSaleAll];
    [valueArrForTableView replaceObjectAtIndex:4 withObject:totalCorporateSales];
    
    NSString *totalCorporateSalesB2b = [NSString stringWithFormat:@"%@/%@/%@/%@",CorporateB2BDaywise,CorporateB2BMonthWise,CorporateB2BYearWise,CorporateB2BAll];
    [valueArrForTableView replaceObjectAtIndex:5 withObject:totalCorporateSalesB2b];
    
    NSString *totalNoTagingSale = [NSString stringWithFormat:@"%@/%@/%@/%@",noTagingSaleDaywise,noTagingSaleMonthWise,noTagingSaleYearWise,noTaggingSaleAll];
    [valueArrForTableView replaceObjectAtIndex:6 withObject:totalNoTagingSale];
    
   
    
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
    controllerDetailLbl.text = @"Sold Voucher Detail";
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
    if (indexPath.row ==  0) {
        
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
                cell.PreviousMonthValueLbl.text = totalSoldPreviousMonthValue;
                cell.beforePreviousMonthKeyLbl.text = _BeforePreviousMonthName;
                cell.beforePreviousMonthValueLbl.text = totalSoldMonthBeforeValue;
                cell.TwobeforePreviousMonthKeyLbl.text = _TwoBeforePreviousMonthName;
                cell.TwobeforePreviousMonthValueLbl.text = totalSoldMonthTwoBeforeValue;
                
            
            
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
         [self VoucherSaleReportDaywise:DateOFInventoryDetail];
        
        
        
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
        [self nilPreviousObject];
        DateOFInventoryDetail = lblDate;
      
        [self VoucherSaleReportDaywise:DateOFInventoryDetail];
        
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
