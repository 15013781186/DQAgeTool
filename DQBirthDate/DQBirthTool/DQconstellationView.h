//
//  DQconstellationView.h
//  YBCommunity
//
//  Created by 邓琪 dengqi on 16/9/8.
//  Copyright © 2016年 com.NiceMoment. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DQconstellationViewDelegate <NSObject>
@optional

//点击选中哪一行 的代理方法
- (void)clickDQconstellationEnsureBtnActionConstellationStr:(NSString *)str;
@end
@interface DQconstellationView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, weak)id<DQconstellationViewDelegate> delegate;

@property (nonatomic, copy)NSString *constellationStr;
@property (nonatomic, strong) UIViewController *ctl;

- (void)startAnimationFunction;

- (void)CloseAnimationFunction;
@end
