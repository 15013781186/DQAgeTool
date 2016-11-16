//
//  CalculateTool.h
//  YBCommunity
//
//  Created by  on 16/9/12.
//  Copyright © 2016年 com.NiceMoment. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DQAgeModel;
@interface CalculateTool : NSObject
+ (NSString *)calculateConstellationWithMonth:(NSInteger)month day:(NSInteger)day;

+ (NSInteger )calculateAge:(NSString *)time;

+ (NSInteger )calculateNowAge:(DQAgeModel *)ageModel;
@end
