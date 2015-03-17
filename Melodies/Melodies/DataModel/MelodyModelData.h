//
//  MelodyModelData.h
//
//  Created by Evgeny Zorin on 17/03/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MelodyModelData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *melodies;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
- (NSDictionary *)dictionaryRepresentation;

@end
