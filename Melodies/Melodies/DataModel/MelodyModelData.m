//
//  MelodyModelData.m
//
//  Created by Evgeny Zorin on 17/03/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MelodyModelData.h"
#import "Melodies.h"


NSString *const kMelodyModelDataMelodies = @"melodies";


@interface MelodyModelData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MelodyModelData

@synthesize melodies = _melodies;


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
    NSObject *receivedMelodies = [dict objectForKey:kMelodyModelDataMelodies];
    NSMutableArray *parsedMelodies = [NSMutableArray array];
    if ([receivedMelodies isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMelodies) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMelodies addObject:[Melodies modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMelodies isKindOfClass:[NSDictionary class]]) {
       [parsedMelodies addObject:[Melodies modelObjectWithDictionary:(NSDictionary *)receivedMelodies]];
    }

    self.melodies = [NSArray arrayWithArray:parsedMelodies];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForMelodies = [NSMutableArray array];
    for (NSObject *subArrayObject in self.melodies) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMelodies addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMelodies addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMelodies] forKey:kMelodyModelDataMelodies];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.melodies = [aDecoder decodeObjectForKey:kMelodyModelDataMelodies];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_melodies forKey:kMelodyModelDataMelodies];
}

- (id)copyWithZone:(NSZone *)zone
{
    MelodyModelData *copy = [[MelodyModelData alloc] init];
    
    if (copy) {

        copy.melodies = [self.melodies copyWithZone:zone];
    }
    
    return copy;
}


@end
