//
//  BasicDetailVC.m
//  DashBoardDetail
//
//  Created by Planet on 9/19/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "BasicDetailVC.h"
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
#import "RegDetailVC.h"
#import "SoldVoucherDetailVC.h"
#import "InstallUninstallVC.h"
#import "InventoryDetailVC.h"

@interface BasicDetailVC ()<UITableViewDelegate, UITableViewDataSource>
{
    int newUserRow;
    int newUserSoldVoucher;
    int existUserRow;
    int existUserSoldVoucher;
    NSString *newUserValueStr;
    NSString *existUserValueStr;
    UILabel                                               *dateLabel;
    UIButton                                              *IncrementDateBtn;
    UIView                                                *baseView;
    UIView                                                *dateBaseView;
    UIButton                                              *decrementDateBtn;
 
    UITableView                                           *detailTableView;
    UIImageView                                           *icsLogoImageView;
    NSString                                             *DateOFInventoryDetail;
    int                                                  firstTimeDetailFetch;
    NSMutableArray                                        *userRegAllArray;
    NSDictionary                                          *responseDict8;
    
    NSString *voucherValueStr;
    NSString *LmdValueStr;
    NSString *AmexValueStr;
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
@property (nonatomic, strong)  NSDictionary          *responseDict;
@property (nonatomic, strong)  NSString   *totalRefundPreviousMonthValue;
@property (nonatomic, strong)  NSString   *totalRefundBeforePreviousMonthValue;
@property (nonatomic, strong)  NSString   *totalRefundBeforeTwoPreviousMonthValue;
@property (nonatomic, strong)  NSString *totalrefundMonthwise;
@property (nonatomic, strong)  NSString *totalrefundYearwise;
@property (nonatomic, strong)  NSString *refundRequestDayWise;

@property (nonatomic, strong)  NSMutableArray    *keyArrForTableView;
@property (nonatomic, strong)  NSMutableArray    *valueArrForTableView;
@property (nonatomic, strong)  NSMutableArray    *voucherSoldExistingUser;

@end

@implementation BasicDetailVC
@synthesize responseDict;
@synthesize keyArrForTableView;
@synthesize valueArrForTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
    userRegAllArray = [[NSMutableArray alloc]init];
    responseDict8  = [[NSDictionary alloc]init];
    firstTimeDetailFetch = 0;
    valueArrForTableView = [[NSMutableArray alloc]init];
    keyArrForTableView = [[NSMutableArray alloc]init];
    responseDict = [[NSDictionary alloc]init];
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
   
    DateOFInventoryDetail = todayDateStr;
     [self callReportAPIWithStartDate:DateOFInventoryDetail endDate:DateOFInventoryDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) callReportAPIWithStartDate:(NSString *) startDate endDate:(NSString *) endDate   {
    
    
    NSString *URLStr = [NSString stringWithFormat:@"http://www.icanstay.com/api/Dashboardapi/Report?startdate=%@&Enddate=%@",startDate,endDate];
    [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
    [[ModelManager modelManager] dashBoardDetailApiWithoutParameters:URLStr success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            responseDict = [responseObject objectAtIndex:0];
            
            self.totalRefundPreviousMonthValue = [responseDict objectForKey:@"totalrefundMonthwise_minusone"];
            self.totalRefundBeforePreviousMonthValue = [responseDict objectForKey:@"totalrefundMonthwise_minustwo"];
            self.totalRefundBeforeTwoPreviousMonthValue = [responseDict objectForKey:@"totalrefundMonthwise_minusthree"];
            //  [self callSoldTotalAPIWithStartDate:startDate];
            
            [self callUserRegReportAllAPIWithStartDate:startDate];
            
        }else{
            NSLog(@"Not Valid User");
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
            self.voucherSoldExistingUser = responseObject;
            
            
            [UIHelper hideSpinner];
            if (firstTimeDetailFetch == 0) {
                [self cretaeDataSourceForFirstTime];
                [self setupUiDesign];
                firstTimeDetailFetch = 1;
 
            }else if (firstTimeDetailFetch == 1){
                [self cretaeDataSourceForFirstTime];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return 16;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 120.0;
    }else if (indexPath.row == 11){
        return 120.0;
    }else {
        return 50.0;
    }
    
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
            cell.frame = CGRectMake(0, 0, detailTableView.frame.size.width, cell.contentView.frame.size.height);
            cell.entryBaseview.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, 100);
            cell.keyLbl.frame = CGRectMake(0, 0, cell.contentView.frame.size.width * 0.55, 30);
            cell.valueLbl.frame = CGRectMake(cell.contentView.frame.size.width * 0.55, 0, cell.contentView.frame.size.width * 0.45, 30);
            cell.NewUserKeyLbl.frame = CGRectMake(0, 30, 90, 30);
         
            cell.NewUserValueLbl.frame = CGRectMake(cell.NewUserKeyLbl.frame.origin.x + cell.NewUserKeyLbl.frame.size.width +5, 30, 80, 30);
           
          
            cell.VoucherLbl.frame = CGRectMake(cell.NewUserValueLbl.frame.origin.x + cell.NewUserValueLbl.frame.size.width +5, 30, 80, 30);
            cell.VoucherValueLbl.frame = CGRectMake(cell.contentView.frame.size.width - 81, 30, 80, 30);
            
            cell.existUserKeyLbl.frame = CGRectMake(0, 60, 90, 30);
            cell.existUserValueLbl.frame = CGRectMake(cell.existUserKeyLbl.frame.origin.x + cell.existUserKeyLbl.frame.size.width +5, 60, 80, 30);
            
            cell.LMDLbl.frame = CGRectMake(cell.existUserValueLbl.frame.origin.x + cell.existUserValueLbl.frame.size.width +5, 60, 80, 30);
            cell.LMDValueLbl.frame = CGRectMake(cell.contentView.frame.size.width - 81, 60, 80, 30);
            
            cell.AmexKeyLbl.frame = CGRectMake(cell.existUserValueLbl.frame.origin.x + cell.existUserValueLbl.frame.size.width +5, 90, 80, 30);
            cell.AmexValueLbl.frame = CGRectMake(cell.contentView.frame.size.width - 81, 90, 80, 30);
            
            
            
        }
        cell.keyLbl.text      = [keyArrForTableView objectAtIndex:indexPath.row];
        cell.valueLbl.text    =  [valueArrForTableView objectAtIndex:indexPath.row];
        cell.NewUserKeyLbl.text = @"New User";
        cell.NewUserValueLbl.text = newUserValueStr;
        cell.existUserKeyLbl.text = @"Existing User";
        cell.existUserValueLbl.text = existUserValueStr;
        cell.VoucherLbl.text = @"Voucher";
        cell.VoucherValueLbl.text = voucherValueStr;
        cell.LMDLbl.text = @"LMD";
        cell.LMDValueLbl.text = LmdValueStr;
        cell.AmexKeyLbl.text = @"Amex";
        cell.AmexValueLbl.text = AmexValueStr;
        
        return cell;
    }else if (indexPath.row == 11){
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
            cell.previousMonthKeyLbl.text = _previousMonthName;
            cell.PreviousMonthValueLbl.text = _totalRefundPreviousMonthValue;
            cell.beforePreviousMonthKeyLbl.text = _BeforePreviousMonthName;
            cell.beforePreviousMonthValueLbl.text = _totalRefundBeforePreviousMonthValue;
            cell.TwobeforePreviousMonthKeyLbl.text = _TwoBeforePreviousMonthName;
            cell.TwobeforePreviousMonthValueLbl.text = _totalRefundBeforeTwoPreviousMonthValue;
            
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
    
    if (indexPath.row == 12) {
        RegDetailVC *registrationDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"RegDetailVC"];;
        [self presentViewController:registrationDetail animated:YES completion:nil];
    }
    if (indexPath.row == 13) {
        SoldVoucherDetailVC *voucherDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"SoldVoucherDetailVC"];;
        [self presentViewController:voucherDetail animated:YES completion:nil];
    }
    if (indexPath.row == 14) {
        InstallUninstallVC *installUnInstallDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"InstallUninstallVC"];;
        [self presentViewController:installUnInstallDetail animated:YES completion:nil];
    }

    if (indexPath.row == 15) {
        InventoryDetailVC *inventoryDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"InventoryDetailVC"];;
        [self presentViewController:inventoryDetail animated:YES completion:nil];
    }


   
    
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
    
    dateBaseView.frame = CGRectMake(self.view.frame.size.width/4, icsLogoImageView.frame.size.height+icsLogoImageView.frame.origin.y +10, (self.view.frame.size.width/2), self.view.frame.size.height *height);
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
    dateBaseView.frame = CGRectMake(10, icsLogoImageView.frame.size.height+icsLogoImageView.frame.origin.y +10, (self.view.frame.size.width - 20), self.view.frame.size.height *height);
    decrementDateBtn.frame = CGRectMake(0, 0, dateBaseView.frame.size.width/4, self.view.frame.size.height *height);
    dateLabel.frame =  CGRectMake(dateBaseView.frame.size.width/4, 0, dateBaseView.frame.size.width/2, self.view.frame.size.height *height);
    IncrementDateBtn.frame = CGRectMake(dateLabel.frame.origin.x +dateLabel.frame.size.width, 0, dateBaseView.frame.size.width/4, self.view.frame.size.height *height);
    detailTableView.frame = CGRectMake(dateBaseView.frame.origin.x, dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10, dateBaseView.frame.size.width, self.view.frame.size.height - (dateBaseView.frame.size.height + dateBaseView.frame.origin.y +10));
 }

-(void)cretaeDataSourceForFirstTime
{
    keyArrForTableView =   [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"Total Refund",@"Registration Detail",@"Sold Voucher Detail",@"Install UnInstall Detail",@"Inventory Detail", nil];
    valueArrForTableView = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"   >>  ",@"   >>  ",@"   >>  ",@"   >>  ", nil];
    
    
    existUserRow = 0;
    existUserSoldVoucher = 0;
    newUserRow = 0;
    newUserSoldVoucher = 0;
    
      for (id dict in self.voucherSoldExistingUser) {
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
    
    
    responseDict8   = [userRegAllArray objectAtIndex:0];
    NSString *totalAppReguserYearwise;
    NSString *totalAppReguserdaywise;
    NSString *totalAppRegusermonthwise;
  NSString *totalRefundAll;
    
   
    NSString        *hotelBookedValue;
    
    for(id key in responseDict8){
        NSLog(@"key=%@ value=%@", key, [responseDict8 objectForKey:key]);
        
        NSString *keyToSwitch = key;
        
        if ([keyToSwitch isEqualToString:@"TotalRefund_All"])
        {
            totalRefundAll = [responseDict8 objectForKey:keyToSwitch];
        }
    }

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
    voucherValueStr = [responseDict valueForKey:@"TotalSelfVouchers"];
    LmdValueStr = [responseDict valueForKey:@"TotalLMDVouchers"];
    AmexValueStr = [responseDict valueForKey:@"TotalAmexVouchers"];
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
            [valueArrForTableView replaceObjectAtIndex:7 withObject:valueOfKey];
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
            self.totalrefundMonthwise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }else if ([keyToSwitch isEqualToString:@"totalrefundYearwise"])
        {
            checkSnoVar = 0;
            self.totalrefundYearwise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }else if ([keyToSwitch isEqualToString:@"totalrefunddaywise"])
        {
            checkSnoVar = 0;
            self.refundRequestDayWise =   [responseDict objectForKey:keyToSwitch];
            continue;
        }
        
    }
    
    NSString *totalRefundStr = [NSString stringWithFormat:@"%@/%@/%@/%@", self.refundRequestDayWise,self.totalrefundMonthwise,self.totalrefundYearwise,totalRefundAll];
    [valueArrForTableView replaceObjectAtIndex:11 withObject:totalRefundStr];
    
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
      //  [self nilPreviousObject];
    //    self.reload = 32;
        DateOFInventoryDetail = lblDate;
        
        
        
//        NSDate *dateObjectForIncrement=[dateformate dateFromString:DateOFInventoryDetail];
//        
//        NSDate *tomorrowDate =[dateObjectForIncrement addTimeInterval: + (24*60*60)];
//        NSDateFormatter *dateformateTemp=[[NSDateFormatter alloc]init];
//        [dateformateTemp setDateFormat:@"yyyy-MM-dd"]; // Date formater
//        tomorrowDateOFInventoryDetail = [dateformateTemp stringFromDate:tomorrowDate];
//        
//        NSDate *dateAfterDecrementTwoDays=[dateObjectForIncrement addTimeInterval: + (24*60*60 *2)];
//        NSDateFormatter *dateformateT=[[NSDateFormatter alloc]init];
//        [dateformateT setDateFormat:@"yyyy-MM-dd"]; // Date formater
//        dayAfterTomorrowDateOFInventoryDetail = [dateformate stringFromDate:dateAfterDecrementTwoDays];
        
         [self callReportAPIWithStartDate:DateOFInventoryDetail endDate:DateOFInventoryDetail];
        
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
//-(void)nilPreviousObject
//{
//    dateLabel.text = @"";
//    responseArr = nil;
//    responseDict = nil;
//    keyArrForTableView = nil;
//    valueArrForTableView = nil;
//    detailTableView = nil;
//    responseDict2 = nil;
//    responseDict3 = nil;
//    responseDict4 = nil;
//    //   reportYearArray = nil;
//    reportArray = nil;
//    //    reportMonthArray = nil;
//    //    reportDayArray = nil;
//    inventoryDetailArr = nil;
//}

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
        
//        NSDate *dateObjectForIncrement=[dateformate dateFromString:DateOFInventoryDetail];
//        
//        NSDate *tomorrowDate =[dateObjectForIncrement addTimeInterval: + (24*60*60)];
//        NSDateFormatter *dateformateTemp=[[NSDateFormatter alloc]init];
//        [dateformateTemp setDateFormat:@"yyyy-MM-dd"]; // Date formater
//        tomorrowDateOFInventoryDetail = [dateformateTemp stringFromDate:tomorrowDate];
//        
//        NSDate *dateAfterDecrementTwoDays=[dateObjectForIncrement addTimeInterval: + (24*60*60 *2)];
//        NSDateFormatter *dateformateT=[[NSDateFormatter alloc]init];
//        [dateformateT setDateFormat:@"yyyy-MM-dd"]; // Date formater
//        dayAfterTomorrowDateOFInventoryDetail = [dateformate stringFromDate:dateAfterDecrementTwoDays];
        
       [self callReportAPIWithStartDate:DateOFInventoryDetail endDate:DateOFInventoryDetail];
        
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
