//
//  APINetController.h
//  FriendsCaller
//
//  Created by Zorin Evgeny on 07.02.15.
//  Copyright (c) 2015 Evgeny Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APINetController : NSObject

//Server authorization

+(void)requestListDataFrom:(NSInteger)from forLimit:(NSInteger)limit withSuccess:(void(^)(NSArray* dataList))successProcess andErrorFail:(void(^)(NSError* error))errorProcess;


@end
