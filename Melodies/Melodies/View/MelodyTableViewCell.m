//
//  MelodyTableViewCell.m
//  Melodies
//
//  Created by Evgeny Zorin on 17/03/15.
//  Copyright (c) 2015 Evgeny Zorin. All rights reserved.
//

#import "MelodyTableViewCell.h"

@implementation MelodyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
