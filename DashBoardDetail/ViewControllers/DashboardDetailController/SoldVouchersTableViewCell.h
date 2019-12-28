//
//  SoldVouchersTableViewCell.h
//  DashBoardDetail
//
//  Created by Planet on 6/2/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoldVouchersTableViewCell : UITableViewCell
@property (strong, nonatomic)                      UILabel *keyLbl;
@property (strong, nonatomic)                      UILabel *valueLbl;
@property (strong, nonatomic)                      UILabel *NewUserKeyLbl;
@property (strong, nonatomic)                      UILabel *NewUserValueLbl;
@property (strong, nonatomic)                      UILabel *existUserKeyLbl;
@property (strong, nonatomic)                      UILabel *existUserValueLbl;
@property (strong, nonatomic)                      UILabel *VoucherLbl;
@property (strong, nonatomic)                      UILabel *VoucherValueLbl;
@property (strong, nonatomic)                      UILabel *LMDLbl;
@property (strong, nonatomic)                      UILabel *LMDValueLbl;
@property (strong, nonatomic)                      UILabel *AmexKeyLbl;
@property (strong, nonatomic)                      UILabel *AmexValueLbl;

@property (strong, nonatomic)                      UIView  *entryBaseview;
@end
