//
//  PreviousMonthWiseTableViewCell.h
//  DashBoardDetail
//
//  Created by Planet on 6/19/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviousMonthWiseTableViewCell : UITableViewCell
@property (strong, nonatomic)                      UILabel *keyLbl;
@property (strong, nonatomic)                      UILabel *valueLbl;
@property (strong, nonatomic)                      UILabel *previousMonthKeyLbl;
@property (strong, nonatomic)                      UILabel *PreviousMonthValueLbl;
@property (strong, nonatomic)                      UILabel *beforePreviousMonthKeyLbl;
@property (strong, nonatomic)                      UILabel *beforePreviousMonthValueLbl;
@property (strong, nonatomic)                      UILabel *TwobeforePreviousMonthKeyLbl;
@property (strong, nonatomic)                      UILabel *TwobeforePreviousMonthValueLbl;

@property (strong, nonatomic)                      UIView  *entryBaseview;
@end
