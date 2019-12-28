//
//  InventroyDetailTableViewCell.m
//  DashBoardDetail
//
//  Created by Planet on 6/2/17.
//  Copyright © 2017 Planet_Ecom. All rights reserved.
//

#import "InventroyDetailTableViewCell.h"

@implementation InventroyDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        _entryBaseview = [[UIView alloc] init];
        _keyLbl = [[UILabel alloc]init];
//        _keyLbl.font = [UIFont systemFontOfSize:16];
        [_entryBaseview addSubview:_keyLbl];
        _valueLbl  = [[UILabel alloc] init];
        _valueLbl.textAlignment = NSTextAlignmentRight;
//        _valueLbl.font = [UIFont systemFontOfSize:16];
        
//        _keyLbl.adjustsFontSizeToFitWidth = YES;
//        _keyLbl.numberOfLines = 1;
//        _valueLbl.adjustsFontSizeToFitWidth = YES;
//        _valueLbl.numberOfLines = 1;
        [_entryBaseview addSubview:_valueLbl];
        [self.contentView  addSubview:_entryBaseview];
        
        
        
    }
    
    return self;
}
@end
