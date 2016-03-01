//
//  ListTableViewCell.m
//  hello
//
//  Created by Fahad Muntaz on 2/29/16.
//  Copyright © 2016 Michael Ma. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

+ (NSString *) identifier {
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
