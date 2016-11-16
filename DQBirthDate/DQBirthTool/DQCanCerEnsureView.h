//
//  DQCanCerEnsureView.h
//  YBCommunity
//
//  Created by 广州玉贝网络科技有限公司 on 16/9/8.
//  Copyright © 2016年 com.NiceMoment. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DQCanCerEnsureViewDelegate <NSObject>
@optional
- (void)ClickCancerDelegateFunction;
- (void)ClickEnsureDelegateFunction;
@end
@interface DQCanCerEnsureView : UIView

@property (nonatomic, weak) id <DQCanCerEnsureViewDelegate> delegate;
- (void)setTitleText:(NSString *)title;


@end
