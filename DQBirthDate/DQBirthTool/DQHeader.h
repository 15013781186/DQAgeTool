//
//  DQHeader.h
//  DQBirthDate
//
//  Created by DQ on.
//  Copyright © 2016年 GuanzhouDQ. All rights reserved.
//   作者:邓琪 QQ:350218638 gitHub:https://github.com/DQ-qi/DQAddress

#ifndef DQHeader_h
#define DQHeader_h
/** 16进制转RGB*/
#define HEX_COLOR(x_RGB) [UIColor colorWithRed:((float)((x_RGB & 0xFF0000) >> 16))/255.0 green:((float)((x_RGB & 0xFF00) >> 8))/255.0 blue:((float)(x_RGB & 0xFF))/255.0 alpha:1.0f]
/** 屏幕宽度*/
#define nc_ScreenHeight  [UIScreen mainScreen].bounds.size.height
/** 屏幕高度*/
#define nc_ScreenWidth  [UIScreen mainScreen].bounds.size.width


#endif /* DQHeader_h */
