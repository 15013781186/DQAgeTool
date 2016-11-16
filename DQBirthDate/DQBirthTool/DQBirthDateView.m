//
//  DQBirthDateView.m
//  YBCommunity
//
//  Created by 邓琪 dengqi on 16/9/9.
//  Copyright © 2016年 com.NiceMoment. All rights reserved.
//

#import "DQBirthDateView.h"
#import "DQCanCerEnsureView.h"
#import "CalculateTool.h"
#import "DQAgeModel.h"  

static NSString *EditPath = @"/api/user/edit";

@interface DQBirthDateView ()<DQCanCerEnsureViewDelegate>
@property (nonatomic, strong) DQCanCerEnsureView *CancerEnsure;
@property (strong,nonatomic) UIPickerView * pickerView;
@property (nonatomic, strong) NSMutableArray *yearArr;
@property (nonatomic, copy) NSMutableArray *monthArr;
@property (nonatomic, strong) NSMutableArray *dayArr;
@property (nonatomic, copy) NSString *BirthStr;//保存出生年月日的时间戳
@property (nonatomic, strong) UITapGestureRecognizer *ges;
@property (nonatomic, strong) UIView *backView;

@end
@implementation DQBirthDateView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0,0, nc_ScreenWidth, nc_ScreenHeight);
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [window addSubview:self];
        UIView *blackView1 = [UIView new];
        blackView1.backgroundColor = HEX_COLOR(0x000000);
        blackView1.alpha = 0.6f;
        blackView1.frame = CGRectMake(0, 0, nc_ScreenWidth, nc_ScreenHeight);
        [self addSubview:blackView1];
        self.ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GestureCloseSelectViewAnimation:)];
        [self.window bringSubviewToFront:self];
        [blackView1 addGestureRecognizer:self.ges];
        self.backView = [UIView new];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.frame = CGRectMake(0, nc_ScreenHeight, nc_ScreenWidth, 260);
        //self.backView.center = CGPointMake(nc_ScreenWidth/2.0f, nc_ScreenHeight+130);
        [self addSubview:self.backView];
        [self creadtionSub];
        self.hidden = YES;
    }
    return self;
}
- (NSMutableArray *)dayArr{
    if (!_dayArr) {
        _dayArr = [NSMutableArray new];
    }
    return _dayArr;
}
- (NSMutableArray *)yearArr{
    if (!_yearArr) {
        _yearArr = [NSMutableArray new];
    }
    return _yearArr;
}
- (NSMutableArray *)monthArr{
    if (!_monthArr) {
        _monthArr = [NSMutableArray new];
    }
    return _monthArr;
}
- (void)creadtionSub{
    _CancerEnsure = [[DQCanCerEnsureView alloc]init];//WithFrame:CGRectMake(0, 0, nc_ScreenWidth, 45)];
    [_CancerEnsure setTitleText:@"出生年月日"];
    _CancerEnsure.delegate = self;
    UIView *sub = self.backView;
    [sub  addSubview:_CancerEnsure];
    [_CancerEnsure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub);
        make.left.equalTo(sub);
        make.right.equalTo(sub);
        make.height.mas_equalTo(45);
    }];
    self.pickerView = [UIPickerView new];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    [sub addSubview:self.pickerView];
    [self.pickerView selectRow:[self.yearArr count] inComponent:0 animated:YES];
    [self.pickerView selectRow:[self.monthArr count] inComponent:1 animated:YES];
    [self.pickerView selectRow:[self.dayArr count] inComponent:2 animated:YES];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(45);
        make.left.equalTo(sub);
        make.right.equalTo(sub);
        make.bottom.equalTo(sub);
    }];

    for (NSInteger i=0; i<12*100; i++) {
        NSString *monthStr = [NSString stringWithFormat:@"%.2zd月",(i)%12+1];
        [self.monthArr addObject:monthStr];
    }
    
    for (NSInteger i=0; i<31*100; i++) {
        NSString *dayStr = [NSString stringWithFormat:@"%.2zd日",(i)%31+1];
        [self.dayArr addObject:dayStr];
    }
    
    for (NSInteger i=1800; i<2300; i++) {
        NSString *yearStr = [NSString stringWithFormat:@"%zd年",i];
        [self.yearArr addObject:yearStr];
    }
    
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:190 inComponent:0 animated:YES];
    [self.pickerView selectRow:660 inComponent:1 animated:YES];
    [self.pickerView selectRow:15+3100/2 inComponent:2 animated:YES];
}
- (void)setBirthDateStatusFromString:(NSString *)timStr{

    if (![timStr isKindOfClass:[NSNull class]]) {
        NSTimeInterval _interval = [timStr longLongValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval/1000];
        // 出生日期转换 年月日
        NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
        NSInteger brithDateYear  = [components1 year];
        NSInteger brithDateDay   = [components1 day];
        NSInteger brithDateMonth = [components1 month];
        
        NSInteger yearSpace = brithDateYear - 1800;
        if (yearSpace>=0&&yearSpace<=500) {
            [self.pickerView selectRow:yearSpace inComponent:0 animated:YES];
        }else{
            [self.pickerView selectRow:190 inComponent:0 animated:YES];
        }
        [self.pickerView selectRow:brithDateMonth+600-1 inComponent:1 animated:YES];
        if (brithDateDay>0) {
            [self.pickerView selectRow:brithDateDay-1+1550 inComponent:2 animated:YES];
        }
        [self.pickerView reloadAllComponents];

    }
}
- (void)ClickCancerDelegateFunction{
    [self CloseAnimationFunction];
}
- (void)ClickEnsureDelegateFunction{

    DQAgeModel *model = [DQAgeModel new];
    NSString *YearStr = self.yearArr[[self.pickerView selectedRowInComponent:0]];
    NSInteger monthRow = [self.pickerView selectedRowInComponent:1]%(self.monthArr.count);
    NSString *monthStr = self.monthArr[monthRow];
    NSInteger dayRow =  [self.pickerView selectedRowInComponent:2]%(self.dayArr.count);
    NSString *datStr = self.dayArr[dayRow];
    
    NSInteger year = [YearStr integerValue];
    NSInteger month = [monthStr integerValue];
    NSInteger day = [datStr integerValue];
    model.year = [NSString stringWithFormat:@"%zd",year];
    model.month = [NSString stringWithFormat:@"%zd",month];
    model.day = [NSString stringWithFormat:@"%zd",day];
    NSString *constellationStr = [CalculateTool calculateConstellationWithMonth:month day:day];
    if ([self.delegate respondsToSelector:@selector(clickDQBirthDateViewEnsureBtnActionAgeModel:andConstellation:)]) {
        
        [self.delegate clickDQBirthDateViewEnsureBtnActionAgeModel:model andConstellation:constellationStr];
    }
    [self CloseAnimationFunction];
 
}
#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearArr.count;
        
    }else if(component == 1){
        
        return self.monthArr.count*50;
    }else{
        
        return self.dayArr.count*50;
    }
    
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable=[[UILabel alloc]init];
    lable.textAlignment=NSTextAlignmentCenter;
    if (component == 0) {
        lable.text=[self.yearArr objectAtIndex:row];
    }else if(component == 1){
        lable.text = self.monthArr[row%[self.monthArr count]];
    }else{
        lable.text = self.dayArr[row%[self.dayArr count]];
    }
    
    return lable;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return nc_ScreenWidth/3.0f-20;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 31;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 1) {
        NSInteger max = 0;
        NSInteger base = 0;
        max = [self.monthArr count]*50;
        base = (max/2)-(max/2)%[self.monthArr count];
        [pickerView selectRow:[pickerView selectedRowInComponent:component]%[self.monthArr count]+base inComponent:component animated:false];
    }else if(component == 2){
        NSInteger max = 0;
        NSInteger base = 0;
        max = [self.dayArr count]*50;
        base = (max/2)-(max/2)%[self.dayArr count];
        [pickerView selectRow:[pickerView selectedRowInComponent:component]%[self.dayArr count]+base inComponent:component animated:false];
        [self calculateIsShowNextRow];
    }
    
}
- (void)calculateIsShowNextRow{
    
    NSString *YearStr = self.yearArr[[self.pickerView selectedRowInComponent:0]];
    NSInteger monthRow = [self.pickerView selectedRowInComponent:1]%(self.monthArr.count);
    NSString *monthStr = self.monthArr[monthRow];
    NSInteger dayRow =  [self.pickerView selectedRowInComponent:2]%(self.dayArr.count);
    NSString *datStr = self.dayArr[dayRow];
    
    NSInteger year = [YearStr integerValue];
    NSInteger month = [monthStr integerValue];
    NSInteger day = [datStr integerValue];
    
    BOOL ret = NO;
    if (((year%4==0)&&(year%100!=0))||(year%400==0)) {//是否闰年
        ret = YES;
    }
    if (ret == YES) {
        if (month == 2) {
            if (day>29) {
                
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:[self.pickerView selectedRowInComponent:2]-(day-29) inComponent:2 animated:year];
            }
        }
    }else{
        if (month == 2) {
            if (day>28) {
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:[self.pickerView selectedRowInComponent:2]-(day-28) inComponent:2 animated:year];
            }
        }
        
    }
    
    if ((month==4)||(month == 6)||(month == 9)||(month == 11)) {
        
        if (day>30) {
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:[self.pickerView selectedRowInComponent:2]-1 inComponent:2 animated:year];
        }
    }
    
}
- (void)startAnimationFunction{
    UIView *AnView = self.backView;
    self.hidden = NO;
    CGRect rect = AnView.frame;
    rect.origin.y = nc_ScreenHeight-260;
    [self.window bringSubviewToFront:self];
    [UIView animateWithDuration:0.4 animations:^{
        
        AnView.frame = rect;
    }];
    
}
- (void)CloseAnimationFunction{
    
    UIView *AnView = self.backView;
    CGRect rect = AnView.frame;
    rect.origin.y = nc_ScreenHeight;
    [UIView animateWithDuration:0.4f animations:^{
        AnView.frame = rect;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}

- (void)GestureCloseSelectViewAnimation:(UIGestureRecognizer *)ges{
    
    [self CloseAnimationFunction];
}

- (void)dealloc{
    
    self.ges = nil;
    
}
@end
