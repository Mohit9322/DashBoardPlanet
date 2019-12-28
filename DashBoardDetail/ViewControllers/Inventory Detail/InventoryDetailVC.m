//
//  InventoryDetailVC.m
//  DashBoardDetail
//
//  Created by Planet on 9/19/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "InventoryDetailVC.h"
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
@interface InventoryDetailVC ()<UITableViewDataSource, UITableViewDelegate>
{
    UILabel                                               *dateLabel;
    UIButton                                              *IncrementDateBtn;
    UIView                                                *baseView;
    UIView                                                *dateBaseView;
    UIButton                                              *decrementDateBtn;
    UITableView                                           *detailTableView;
    UIImageView                                           *icsLogoImageView;
    int                                                  firstTimeDetailFetch;
    UILabel *controllerDetailLbl;
    UIButton *backButton;
    NSMutableArray *inventoryDetailArr;
    NSMutableArray *inventoryDetailArrTomorrow;
    NSMutableArray *inventoryDetailArrDayAfterTomorrow;
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

@implementation InventoryDetailVC
@synthesize keyArrForTableView;
@synthesize valueArrForTableView;
@synthesize tomorrowDateOFInventoryDetail;
@synthesize dayAfterTomorrowDateOFInventoryDetail;
@synthesize DateOFInventoryDetail;
- (void)viewDidLoad {
    [super viewDidLoad];
   [UIHelper showSpinnerWithMessage:kTitlePleaseWait];
       inventoryDetailArr = [[NSMutableArray alloc]init];
    inventoryDetailArrTomorrow = [[NSMutableArray alloc]init];
    inventoryDetailArrDayAfterTomorrow = [[NSMutableArray alloc]init];

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
    DateOFInventoryDetail = [formatter stringFromDate:[NSDate date]];
    
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
    
   // DateOFInventoryDetail = todayDateStr;
    [self CallInventoryApiWithDate:todayDateStr];

}

-(void)CallInventoryApiWithDate:(NSString *)dateStr
{
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
    controllerDetailLbl.text = @"Room Inventory Details";
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
        
        
        
                NSDate *dateObjectForIncrement=[dateformate dateFromString:DateOFInventoryDetail];
        
                NSDate *tomorrowDate =[dateObjectForIncrement addTimeInterval: + (24*60*60)];
                NSDateFormatter *dateformateTemp=[[NSDateFormatter alloc]init];
                [dateformateTemp setDateFormat:@"yyyy-MM-dd"]; // Date formater
                tomorrowDateOFInventoryDetail = [dateformateTemp stringFromDate:tomorrowDate];
        
                NSDate *dateAfterDecrementTwoDays=[dateObjectForIncrement addTimeInterval: + (24*60*60 *2)];
                NSDateFormatter *dateformateT=[[NSDateFormatter alloc]init];
                [dateformateT setDateFormat:@"yyyy-MM-dd"]; // Date formater
                dayAfterTomorrowDateOFInventoryDetail = [dateformate stringFromDate:dateAfterDecrementTwoDays];
        
    //    [self callReportAPIWithStartDate:DateOFInventoryDetail endDate:DateOFInventoryDetail];
        
         [self CallInventoryApiWithDate:DateOFInventoryDetail];
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
//    dateLabel.text = @"";
//    responseArr = nil;
//    responseDict = nil;
    [keyArrForTableView removeAllObjects];
    [valueArrForTableView removeAllObjects];
//    detailTableView = nil;
//    responseDict2 = nil;
//    responseDict3 = nil;
//    responseDict4 = nil;
//    //   reportYearArray = nil;
//    reportArray = nil;
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
        
          [self CallInventoryApiWithDate:DateOFInventoryDetail];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
