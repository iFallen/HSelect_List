//
//  HSelectList.h
//  TestConstraints
//
//  Created by JuanFelix on 4/17/16.
//  Copyright © 2016 JuanFelix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSelectList : UIView

@property (nonatomic,strong) NSArray<NSString *> * dataList;
@property (nonatomic,assign) NSInteger currentSelected;

-(void)showList:(BOOL)bShow;

@end
