//
//  Melodies.h
//
//  Created by Evgeny Zorin on 17/03/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Melodies : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double melodiesIdentifier;
@property (nonatomic, assign) double necTag;
@property (nonatomic, assign) double fPrice;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) double purchasePeriod;
@property (nonatomic, strong) NSString *demoUrl;
@property (nonatomic, assign) double artistId;
@property (nonatomic, assign) double relevance;
@property (nonatomic, strong) NSString *validDate;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *bonusCode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
- (NSDictionary *)dictionaryRepresentation;

@end
