//
//  SoldVouchersTableViewCell.m
//  DashBoardDetail
//
//  Created by Planet on 6/2/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "SoldVouchersTableViewCell.h"

@implementation SoldVouchersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        _entryBaseview = [[UIView alloc] init];
        _keyLbl = [[UILabel alloc]init];
        _keyLbl.font = [UIFont systemFontOfSize:18];
        [_entryBaseview addSubview:_keyLbl];
        _valueLbl  = [[UILabel alloc] init];
        _valueLbl.textAlignment = NSTextAlignmentRight;
        _valueLbl.font = [UIFont systemFontOfSize:18];
        
        _keyLbl.adjustsFontSizeToFitWidth = YES;
        _keyLbl.numberOfLines = 1;
        _valueLbl.adjustsFontSizeToFitWidth = YES;
        _valueLbl.numberOfLines = 1;
        [_entryBaseview addSubview:_valueLbl];
        
        self.NewUserKeyLbl = [[UILabel alloc]init];
        self.NewUserKeyLbl.font = [UIFont systemFontOfSize:15];
        self.NewUserKeyLbl.textAlignment = NSTextAlignmentLeft;
        [self.entryBaseview addSubview:self.NewUserKeyLbl];
        
        
        self.NewUserValueLbl = [[UILabel alloc]init];
        self.NewUserValueLbl.font = [UIFont systemFontOfSize:15];
        self.NewUserValueLbl.textAlignment = NSTextAlignmentLeft;
        [self.entryBaseview addSubview:self.NewUserValueLbl];
        
        self.existUserKeyLbl = [[UILabel alloc]init];
        self.existUserKeyLbl.font = [UIFont systemFontOfSize:15];
        self.existUserKeyLbl.textAlignment = NSTextAlignmentLeft;
        [self.entryBaseview addSubview:self.existUserKeyLbl];
        
        self.existUserValueLbl = [[UILabel alloc]init];
        self.existUserValueLbl.font = [UIFont systemFontOfSize:15];
        self.existUserValueLbl.textAlignment = NSTextAlignmentLeft;
        [self.entryBaseview addSubview:self.existUserValueLbl];
        
        self.VoucherLbl = [[UILabel alloc]init];
        self.VoucherLbl.font = [UIFont systemFontOfSize:15];
        self.VoucherLbl.textAlignment = NSTextAlignmentLeft;
        [self.entryBaseview addSubview:self.VoucherLbl];
        
        self.VoucherValueLbl = [[UILabel alloc]init];
        self.VoucherValueLbl.font = [UIFont systemFontOfSize:15];
        self.VoucherValueLbl.textAlignment = NSTextAlignmentRight;
        [self.entryBaseview addSubview:self.VoucherValueLbl];
        
        self.LMDLbl = [[UILabel alloc]init];
        self.LMDLbl.font = [UIFont systemFontOfSize:15];
        self.LMDLbl.textAlignment = NSTextAlignmentLeft;
        [self.entryBaseview addSubview:self.LMDLbl];
        
        self.LMDValueLbl = [[UILabel alloc]init];
        self.LMDValueLbl.font = [UIFont systemFontOfSize:15];
        self.LMDValueLbl.textAlignment = NSTextAlignmentRight;
        [self.entryBaseview addSubview:self.LMDValueLbl];
        
        self.AmexKeyLbl = [[UILabel alloc]init];
        self.AmexKeyLbl.font = [UIFont systemFontOfSize:15];
        self.AmexKeyLbl.textAlignment = NSTextAlignmentLeft;
        [self.entryBaseview addSubview:self.AmexKeyLbl];
        
        self.AmexValueLbl = [[UILabel alloc]init];
        self.AmexValueLbl.font = [UIFont systemFontOfSize:15];
        self.AmexValueLbl.textAlignment = NSTextAlignmentRight;
        [self.entryBaseview addSubview:self.AmexValueLbl];
        
       [self.contentView  addSubview:_entryBaseview];
       
        
        
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
