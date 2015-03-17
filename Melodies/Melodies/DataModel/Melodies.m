//
//  Melodies.m
//
//  Created by Evgeny Zorin on 17/03/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Melodies.h"
#import "Tags.h"


NSString *const kMelodiesId = @"id";
NSString *const kMelodiesNecTag = @"necTag";
NSString *const kMelodiesFPrice = @"fPrice";
NSString *const kMelodiesActive = @"active";
NSString *const kMelodiesPicUrl = @"picUrl";
NSString *const kMelodiesTags = @"tags";
NSString *const kMelodiesTitle = @"title";
NSString *const kMelodiesCode = @"code";
NSString *const kMelodiesPrice = @"price";
NSString *const kMelodiesPurchasePeriod = @"purchasePeriod";
NSString *const kMelodiesDemoUrl = @"demoUrl";
NSString *const kMelodiesArtistId = @"artistId";
NSString *const kMelodiesRelevance = @"relevance";
NSString *const kMelodiesValidDate = @"validDate";
NSString *const kMelodiesArtist = @"artist";
NSString *const kMelodiesBonusCode = @"bonusCode";


@interface Melodies ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Melodies

@synthesize melodiesIdentifier = _melodiesIdentifier;
@synthesize necTag = _necTag;
@synthesize fPrice = _fPrice;
@synthesize active = _active;
@synthesize picUrl = _picUrl;
@synthesize tags = _tags;
@synthesize title = _title;
@synthesize code = _code;
@synthesize price = _price;
@synthesize purchasePeriod = _purchasePeriod;
@synthesize demoUrl = _demoUrl;
@synthesize artistId = _artistId;
@synthesize relevance = _relevance;
@synthesize validDate = _validDate;
@synthesize artist = _artist;
@synthesize bonusCode = _bonusCode;


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
            self.melodiesIdentifier = [[self objectOrNilForKey:kMelodiesId fromDictionary:dict] doubleValue];
            self.necTag = [[self objectOrNilForKey:kMelodiesNecTag fromDictionary:dict] doubleValue];
            self.fPrice = [[self objectOrNilForKey:kMelodiesFPrice fromDictionary:dict] doubleValue];
            self.active = [[self objectOrNilForKey:kMelodiesActive fromDictionary:dict] boolValue];
            self.picUrl = [self objectOrNilForKey:kMelodiesPicUrl fromDictionary:dict];
    NSObject *receivedTags = dict[kMelodiesTags];
    NSMutableArray *parsedTags = [NSMutableArray array];
    if ([receivedTags isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTags) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTags addObject:[Tags modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTags isKindOfClass:[NSDictionary class]]) {
       [parsedTags addObject:[Tags modelObjectWithDictionary:(NSDictionary *)receivedTags]];
    }

    self.tags = [NSArray arrayWithArray:parsedTags];
            self.title = [self objectOrNilForKey:kMelodiesTitle fromDictionary:dict];
            self.code = [self objectOrNilForKey:kMelodiesCode fromDictionary:dict];
            self.price = [self objectOrNilForKey:kMelodiesPrice fromDictionary:dict];
            self.purchasePeriod = [[self objectOrNilForKey:kMelodiesPurchasePeriod fromDictionary:dict] doubleValue];
            self.demoUrl = [self objectOrNilForKey:kMelodiesDemoUrl fromDictionary:dict];
            self.artistId = [[self objectOrNilForKey:kMelodiesArtistId fromDictionary:dict] doubleValue];
            self.relevance = [[self objectOrNilForKey:kMelodiesRelevance fromDictionary:dict] doubleValue];
            self.validDate = [self objectOrNilForKey:kMelodiesValidDate fromDictionary:dict];
            self.artist = [self objectOrNilForKey:kMelodiesArtist fromDictionary:dict];
            self.bonusCode = [self objectOrNilForKey:kMelodiesBonusCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:@(self.melodiesIdentifier) forKey:kMelodiesId];
    [mutableDict setValue:@(self.necTag) forKey:kMelodiesNecTag];
    [mutableDict setValue:@(self.fPrice) forKey:kMelodiesFPrice];
    [mutableDict setValue:@(self.active) forKey:kMelodiesActive];
    [mutableDict setValue:self.picUrl forKey:kMelodiesPicUrl];
    NSMutableArray *tempArrayForTags = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tags) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTags addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTags addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:kMelodiesTags];
    [mutableDict setValue:self.title forKey:kMelodiesTitle];
    [mutableDict setValue:self.code forKey:kMelodiesCode];
    [mutableDict setValue:self.price forKey:kMelodiesPrice];
    [mutableDict setValue:@(self.purchasePeriod) forKey:kMelodiesPurchasePeriod];
    [mutableDict setValue:self.demoUrl forKey:kMelodiesDemoUrl];
    [mutableDict setValue:@(self.artistId) forKey:kMelodiesArtistId];
    [mutableDict setValue:@(self.relevance) forKey:kMelodiesRelevance];
    [mutableDict setValue:self.validDate forKey:kMelodiesValidDate];
    [mutableDict setValue:self.artist forKey:kMelodiesArtist];
    [mutableDict setValue:self.bonusCode forKey:kMelodiesBonusCode];

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

    self.melodiesIdentifier = [aDecoder decodeDoubleForKey:kMelodiesId];
    self.necTag = [aDecoder decodeDoubleForKey:kMelodiesNecTag];
    self.fPrice = [aDecoder decodeDoubleForKey:kMelodiesFPrice];
    self.active = [aDecoder decodeBoolForKey:kMelodiesActive];
    self.picUrl = [aDecoder decodeObjectForKey:kMelodiesPicUrl];
    self.tags = [aDecoder decodeObjectForKey:kMelodiesTags];
    self.title = [aDecoder decodeObjectForKey:kMelodiesTitle];
    self.code = [aDecoder decodeObjectForKey:kMelodiesCode];
    self.price = [aDecoder decodeObjectForKey:kMelodiesPrice];
    self.purchasePeriod = [aDecoder decodeDoubleForKey:kMelodiesPurchasePeriod];
    self.demoUrl = [aDecoder decodeObjectForKey:kMelodiesDemoUrl];
    self.artistId = [aDecoder decodeDoubleForKey:kMelodiesArtistId];
    self.relevance = [aDecoder decodeDoubleForKey:kMelodiesRelevance];
    self.validDate = [aDecoder decodeObjectForKey:kMelodiesValidDate];
    self.artist = [aDecoder decodeObjectForKey:kMelodiesArtist];
    self.bonusCode = [aDecoder decodeObjectForKey:kMelodiesBonusCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_melodiesIdentifier forKey:kMelodiesId];
    [aCoder encodeDouble:_necTag forKey:kMelodiesNecTag];
    [aCoder encodeDouble:_fPrice forKey:kMelodiesFPrice];
    [aCoder encodeBool:_active forKey:kMelodiesActive];
    [aCoder encodeObject:_picUrl forKey:kMelodiesPicUrl];
    [aCoder encodeObject:_tags forKey:kMelodiesTags];
    [aCoder encodeObject:_title forKey:kMelodiesTitle];
    [aCoder encodeObject:_code forKey:kMelodiesCode];
    [aCoder encodeObject:_price forKey:kMelodiesPrice];
    [aCoder encodeDouble:_purchasePeriod forKey:kMelodiesPurchasePeriod];
    [aCoder encodeObject:_demoUrl forKey:kMelodiesDemoUrl];
    [aCoder encodeDouble:_artistId forKey:kMelodiesArtistId];
    [aCoder encodeDouble:_relevance forKey:kMelodiesRelevance];
    [aCoder encodeObject:_validDate forKey:kMelodiesValidDate];
    [aCoder encodeObject:_artist forKey:kMelodiesArtist];
    [aCoder encodeObject:_bonusCode forKey:kMelodiesBonusCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    Melodies *copy = [[Melodies alloc] init];
    
    if (copy) {

        copy.melodiesIdentifier = self.melodiesIdentifier;
        copy.necTag = self.necTag;
        copy.fPrice = self.fPrice;
        copy.active = self.active;
        copy.picUrl = [self.picUrl copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.purchasePeriod = self.purchasePeriod;
        copy.demoUrl = [self.demoUrl copyWithZone:zone];
        copy.artistId = self.artistId;
        copy.relevance = self.relevance;
        copy.validDate = [self.validDate copyWithZone:zone];
        copy.artist = [self.artist copyWithZone:zone];
        copy.bonusCode = [self.bonusCode copyWithZone:zone];
    }
    
    return copy;
}


@end
