//
//  APINetController.m
//  FriendsCaller
//
//  Created by Zorin Evgeny on 07.02.15.
//  Copyright (c) 2015 Evgeny Zorin. All rights reserved.
//
#import "APINetController.h"
#import "AFNetworking.h"
#import "DataModels.h"

#define LIMIT_KEY @"limit"
#define FROM_KEY  @"from"

#define BASE_URL @"http://api.content.mts.intech-global.com/public/marketplaces/10/tags/12/melodies"

@implementation APINetController




+(void)requestListDataFrom:(NSInteger)from forLimit:(NSInteger)limit withSuccess:(void(^)(NSArray* dataList))successProcess andErrorFail:(void(^)(NSError* error))errorProcess
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{LIMIT_KEY: @(limit),FROM_KEY: @(from)};
    [manager GET:BASE_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        successProcess([MelodyModelData modelObjectWithDictionary:responseObject].melodies);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        errorProcess(error);
    }];

}


@end
