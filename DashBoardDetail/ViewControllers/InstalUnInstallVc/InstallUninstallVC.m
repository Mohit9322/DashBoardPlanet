//
//  InstallUninstallVC.m
//  DashBoardDetail
//
//  Created by Planet on 9/19/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "InstallUninstallVC.h"
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

@interface InstallUninstallVC ()<UITableViewDelegate, UITableViewDataSource>
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
     NSMutableArray                                        *appDownlaodsArray;
    NSDictionary                                          *responseDict10;
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

@implementation InstallUninstallVC
@synthesize keyArrForTableView;
@synthesize valueArrForTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    firstTimeDetailFetch = 0;
     [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
    responseDict10 = [[NSDictionary alloc]init];
    appDownlaodsArray = [[NSMutableArray alloc]init];
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
    
    DateOFInventoryDetail = todayDateStr;
    //    [self callReportAPIWithStartDate:DateOFInventoryDetail endDate:DateOFInventoryDetail];
     [self callAppDownloadsAPIWithStartDate];

}
-(void) callAppDownloadsAPIWithStartDate{
    
    [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
    NSString *URLStr4 = [NSString stringWithFormat:@"http://www.icanstay.com/Api/DashboardApi/MobileApp"];
    [[ModelManager modelManager] AppDownLoadsDetailApi:URLStr4 success:^(Status iStatus,id  _Nullable responseObject ) {
        if(iStatus == StatusSuccess && responseObject){
            appDownlaodsArray = responseObject;
            responseDict10  = [appDownlaodsArray objectAtIndex:0];
            
            [self fetchDetailFromResponse];
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


-(void)fetchDetailFromResponse
{
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
    
    keyArrForTableView =   [[NSMutableArray alloc]initWithObjects:@"Ios App Install",@"Ios App Uninstall",@"Android App Install",@"Android App Uninstall",nil];
    valueArrForTableView = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"", nil];
    
    NSString *iosAppInstallDetail = [NSString stringWithFormat:@"%@/%@/%@/%@",iosAppInstallToday,iosAppInstallMonth,iosAppInstallYear,iosAppInstallTotal];
    [valueArrForTableView replaceObjectAtIndex:0 withObject:iosAppInstallDetail];
    
    NSString *iosAppUninstall = [NSString stringWithFormat:@"%@/%@/%@/%@",iosAppUnistallToday,iosAppUnistallMonth,iosAppUnistallYear,iosAppUnistallTotal];
    [valueArrForTableView replaceObjectAtIndex:1 withObject:iosAppUninstall];
    
    NSString *androidAppInstall = [NSString stringWithFormat:@"%@/%@/%@/%@",androidAppInstallToday,androidAppInstallMonth,androidAppInstallYear,androidAppInstallTotal];
    [valueArrForTableView replaceObjectAtIndex:2 withObject:androidAppInstall];
    
    NSString *androidAppUninstall = [NSString stringWithFormat:@"%@/%@/%@/%@",andoridAppUninstallToday,andoridAppUninstallMonth,andoridAppUninstallYear,andoridAppUninstallTotal];
    [valueArrForTableView replaceObjectAtIndex:3 withObject:androidAppUninstall];

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
    controllerDetailLbl.text = @"Install And Un-Install Details";
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
    
    return 50.0;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    
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
        
        [self callAppDownloadsAPIWithStartDate];
        
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
        [self callAppDownloadsAPIWithStartDate];
      
        
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
