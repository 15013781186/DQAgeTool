//
//  CalculateTool.m
//  YBCommunity
//
//  Created by  on 16/9/12.
//  Copyright © 2016年 com.NiceMoment. All rights reserved.
//

#import "CalculateTool.h"
#import "DQAgeModel.h"

@implementation CalculateTool
/**
 *  根据生日计算星座
 *
 *  @param month 月份
 *  @param day   日期
 *
 *  @return 星座名称
 */

+ (NSString *)calculateConstellationWithMonth:(NSInteger)month day:(NSInteger)day{
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    
    if (month<1 || month>12 || day<1 || day>31){
        return @"错误日期格式!";
    }
    
    if(month==2 && day>29)
    {
        return @"错误日期格式!!";
    }else if(month==4 || month==6 || month==9 || month==11) {
        if (day>30) {
            return @"错误日期格式!!!";
        }
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    
    return [NSString stringWithFormat:@"%@座",result];
}

+ (NSInteger )calculateAge:(NSString *)time{
    if (![time isKindOfClass:[NSNull class]]) {
        NSTimeInterval _interval = [time longLongValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval/1000];
        // 出生日期转换 年月日
        NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
        NSInteger brithDateYear  = [components1 year];
        NSInteger brithDateDay   = [components1 day];
        NSInteger brithDateMonth = [components1 month];
        
        // 获取系统当前 年月日
        NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger currentDateYear  = [components2 year];
        NSInteger currentDateDay   = [components2 day];
        NSInteger currentDateMonth = [components2 month];
        
        // 计算年龄
        NSInteger iAge = currentDateYear - brithDateYear - 1;
        if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
            iAge++;
        }
        
        return iAge;
        
    }else{
        return 0;
    }
    
}
+ (NSInteger )calculateNowAge:(DQAgeModel *)ageModel{
    NSInteger brithDateYear  = [ageModel.year integerValue];
    NSInteger brithDateDay   = [ageModel.month integerValue];
    NSInteger brithDateMonth = [ageModel.day integerValue];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
    
}

@end
