//
//  DQBirthDateView.h
//  YBCommunity
//
//  Created by 邓琪 dengqi on 16/9/9.
//  Copyright © 2016年 com.NiceMoment. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DQAgeModel;
@protocol DQBirthDateViewDelegate <NSObject>
@optional
/**
 DQAgeModel
 Str 星座
 */
//点击选中哪一行 的代理方法
- (void)clickDQBirthDateViewEnsureBtnActionAgeModel:(DQAgeModel *)ageModel andConstellation:(NSString *)str;

@end

@interface DQBirthDateView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, weak) id<DQBirthDateViewDelegate> delegate;

@property (nonatomic, strong) UIViewController *ctl;

/**
    根据出生年月日的时间戳 来设置默认选项
 */
- (void)setBirthDateStatusFromString:(NSString *)timStr;

//开启动画
- (void)startAnimationFunction;
//关闭动画
- (void)CloseAnimationFunction;

@end
