//
//  MelodyTableViewCell.h
//  Melodies
//
//  Created by Evgeny Zorin on 17/03/15.
//  Copyright (c) 2015 Evgeny Zorin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface MelodyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *coverPhoto;
@property (weak, nonatomic) IBOutlet UILabel *melodyTitle;
@property (weak, nonatomic) IBOutlet UILabel *melodyArtist;

@end
