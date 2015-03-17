//
//  Tags.m
//
//  Created by Evgeny Zorin on 17/03/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Tags.h"


NSString *const kTagsPosition = @"position";
NSString *const kTagsIsBlockDisplayMode = @"isBlockDisplayMode";
NSString *const kTagsId = @"id";
NSString *const kTagsTitle = @"title";
NSString *const kTagsTopMelodiesCount = @"topMelodiesCount";
NSString *const kTagsLimitedVisibility = @"limitedVisibility";
NSString *const kTagsIsFullCatalogEnabled = @"isFullCatalogEnabled";


@interface Tags ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Tags

@synthesize position = _position;
@synthesize isBlockDisplayMode = _isBlockDisplayMode;
@synthesize tagsIdentifier = _tagsIdentifier;
@synthesize title = _title;
@synthesize topMelodiesCount = _topMelodiesCount;
@synthesize limitedVisibility = _limitedVisibility;
@synthesize isFullCatalogEnabled = _isFullCatalogEnabled;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.position = [[self objectOrNilForKey:kTagsPosition fromDictionary:dict] doubleValue];
            self.isBlockDisplayMode = [[self objectOrNilForKey:kTagsIsBlockDisplayMode fromDictionary:dict] boolValue];
            self.tagsIdentifier = [[self objectOrNilForKey:kTagsId fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kTagsTitle fromDictionary:dict];
            self.topMelodiesCount = [[self objectOrNilForKey:kTagsTopMelodiesCount fromDictionary:dict] doubleValue];
            self.limitedVisibility = [[self objectOrNilForKey:kTagsLimitedVisibility fromDictionary:dict] boolValue];
            self.isFullCatalogEnabled = [[self objectOrNilForKey:kTagsIsFullCatalogEnabled fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:@(self.position) forKey:kTagsPosition];
    [mutableDict setValue:@(self.isBlockDisplayMode) forKey:kTagsIsBlockDisplayMode];
    [mutableDict setValue:@(self.tagsIdentifier) forKey:kTagsId];
    [mutableDict setValue:self.title forKey:kTagsTitle];
    [mutableDict setValue:@(self.topMelodiesCount) forKey:kTagsTopMelodiesCount];
    [mutableDict setValue:@(self.limitedVisibility) forKey:kTagsLimitedVisibility];
    [mutableDict setValue:@(self.isFullCatalogEnabled) forKey:kTagsIsFullCatalogEnabled];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = dict[aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.position = [aDecoder decodeDoubleForKey:kTagsPosition];
    self.isBlockDisplayMode = [aDecoder decodeBoolForKey:kTagsIsBlockDisplayMode];
    self.tagsIdentifier = [aDecoder decodeDoubleForKey:kTagsId];
    self.title = [aDecoder decodeObjectForKey:kTagsTitle];
    self.topMelodiesCount = [aDecoder decodeDoubleForKey:kTagsTopMelodiesCount];
    self.limitedVisibility = [aDecoder decodeBoolForKey:kTagsLimitedVisibility];
    self.isFullCatalogEnabled = [aDecoder decodeBoolForKey:kTagsIsFullCatalogEnabled];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_position forKey:kTagsPosition];
    [aCoder encodeBool:_isBlockDisplayMode forKey:kTagsIsBlockDisplayMode];
    [aCoder encodeDouble:_tagsIdentifier forKey:kTagsId];
    [aCoder encodeObject:_title forKey:kTagsTitle];
    [aCoder encodeDouble:_topMelodiesCount forKey:kTagsTopMelodiesCount];
    [aCoder encodeBool:_limitedVisibility forKey:kTagsLimitedVisibility];
    [aCoder encodeBool:_isFullCatalogEnabled forKey:kTagsIsFullCatalogEnabled];
}

- (id)copyWithZone:(NSZone *)zone
{
    Tags *copy = [[Tags alloc] init];
    
    if (copy) {

        copy.position = self.position;
        copy.isBlockDisplayMode = self.isBlockDisplayMode;
        copy.tagsIdentifier = self.tagsIdentifier;
        copy.title = [self.title copyWithZone:zone];
        copy.topMelodiesCount = self.topMelodiesCount;
        copy.limitedVisibility = self.limitedVisibility;
        copy.isFullCatalogEnabled = self.isFullCatalogEnabled;
    }
    
    return copy;
}


@end
