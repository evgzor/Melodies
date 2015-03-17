//
//  Tags.h
//
//  Created by Evgeny Zorin on 17/03/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Tags : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double position;
@property (nonatomic, assign) BOOL isBlockDisplayMode;
@property (nonatomic, assign) double tagsIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double topMelodiesCount;
@property (nonatomic, assign) BOOL limitedVisibility;
@property (nonatomic, assign) BOOL isFullCatalogEnabled;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
- (NSDictionary *)dictionaryRepresentation;

@end
