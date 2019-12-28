//
//  PreviousMonthWiseTableViewCell.m
//  DashBoardDetail
//
//  Created by Planet on 6/19/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "PreviousMonthWiseTableViewCell.h"

@implementation PreviousMonthWiseTableViewCell

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
        
        self.previousMonthKeyLbl = [[UILabel alloc]init];
        self.previousMonthKeyLbl.font = [UIFont systemFontOfSize:15];
        self.previousMonthKeyLbl.textAlignment = NSTextAlignmentLeft;
        [self.entryBaseview addSubview:self.previousMonthKeyLbl];
        
        
        self.PreviousMonthValueLbl = [[UILabel alloc]init];
        self.PreviousMonthValueLbl.font = [UIFont systemFontOfSize:15];
        self.PreviousMonthValueLbl.textAlignment = NSTextAlignmentRight;
        [self.entryBaseview addSubview:self.PreviousMonthValueLbl];
        
        self.beforePreviousMonthKeyLbl = [[UILabel alloc]init];
        self.beforePreviousMonthKeyLbl.font = [UIFont systemFontOfSize:15];
        self.beforePreviousMonthKeyLbl.textAlignment = NSTextAlignmentLeft;
        [self.entryBaseview addSubview:self.beforePreviousMonthKeyLbl];
        
        self.beforePreviousMonthValueLbl = [[UILabel alloc]init];
        self.beforePreviousMonthValueLbl.font = [UIFont systemFontOfSize:15];
        self.beforePreviousMonthValueLbl.textAlignment = NSTextAlignmentRight;
        [self.entryBaseview addSubview:self.beforePreviousMonthValueLbl];
        
        self.TwobeforePreviousMonthKeyLbl = [[UILabel alloc]init];
        self.TwobeforePreviousMonthKeyLbl.font = [UIFont systemFontOfSize:15];
        self.TwobeforePreviousMonthKeyLbl.textAlignment = NSTextAlignmentLeft;
        [self.entryBaseview addSubview:self.TwobeforePreviousMonthKeyLbl];
        
        self.TwobeforePreviousMonthValueLbl = [[UILabel alloc]init];
        self.TwobeforePreviousMonthValueLbl.font = [UIFont systemFontOfSize:15];
        self.TwobeforePreviousMonthValueLbl.textAlignment = NSTextAlignmentRight;
        [self.entryBaseview addSubview:self.TwobeforePreviousMonthValueLbl];

        
        [self.contentView  addSubview:_entryBaseview];
        
        
        
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
