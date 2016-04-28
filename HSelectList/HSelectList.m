//
//  HSelectList.m
//  TestConstraints
//
//  Created by JuanFelix on 4/17/16.
//  Copyright © 2016 JuanFelix. All rights reserved.
//

#import "HSelectList.h"

static float showHeight = 30;

@interface HSelectList ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel * lbSelectedText;
    UIImageView * imgArrow;
    UITableView * tblSelList;
    BOOL isListShow;
    CGRect originFrame;
    BOOL isAnimating;
}

@end

@implementation HSelectList

-(instancetype)init{
    if (self = [super init]) {
        [self UIInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self UIInit];
    }
    return self;
}

-(void)UIInit{
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    lbSelectedText = [[UILabel alloc] init];
    lbSelectedText.textAlignment = NSTextAlignmentCenter;
    imgArrow = [[UIImageView alloc] init];
    
    
    tblSelList = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tblSelList.delegate = self;
    tblSelList.dataSource = self;
    
    [lbSelectedText setBackgroundColor:[UIColor grayColor]];
    [lbSelectedText.layer setBorderColor:[UIColor blackColor].CGColor];
    [lbSelectedText.layer setBorderWidth:1.0];
    [lbSelectedText.layer setCornerRadius:5.0];
    [lbSelectedText.layer setMasksToBounds:true];
    
    [imgArrow setBackgroundColor:[UIColor magentaColor]];
    
    [tblSelList setBackgroundColor:[UIColor lightGrayColor]];
    [tblSelList.layer setBorderColor:[UIColor grayColor].CGColor];
    [tblSelList.layer setBorderWidth:1.0];
    [tblSelList.layer setCornerRadius:5.0];
    [tblSelList.layer setMasksToBounds:true];
    
    [self addSubview:lbSelectedText];
    [self addSubview:tblSelList];
    [lbSelectedText addSubview:imgArrow];
    
    isListShow = false;
    isAnimating = false;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [lbSelectedText addGestureRecognizer:tap];
    [lbSelectedText setUserInteractionEnabled:true];
    
    [self setClipsToBounds:YES];
}

-(void)tapAction{
    [self showList:!isListShow];
}

-(void)layoutSubviews{
    NSLog(@"layout list ...");
    [super layoutSubviews];
    CGRect frame = self.frame;
    if (frame.size.width < 60) {
        frame.size.width = 60;
    }
    self.frame = frame;
    if (_dataList == nil || _dataList.count == 0) {
        frame.size.height = showHeight;
    }else{
        int count = _dataList.count + 1;
        count = count <= 6 ? count : 6;
        frame.size.height = count * showHeight;
    }
    originFrame = frame;
    
    [lbSelectedText setFrame:CGRectMake(0, 0, frame.size.width, showHeight)];
    [imgArrow setFrame:CGRectMake(lbSelectedText.frame.size.width - showHeight, 0, showHeight, showHeight)];
    [tblSelList setFrame:CGRectMake(0, showHeight, frame.size.width, frame.size.height - showHeight)];
    
    if (!isAnimating) {
        if (isListShow) {
            self.frame = originFrame;
        }else{
            frame.size.height = showHeight;
            self.frame = frame;
        }
    }
}

-(void)showList:(BOOL)bShow{
    if (_dataList == nil || _dataList.count == 0) {
        NSLog(@"无数据源");
        return;
    }
    if (isAnimating || isListShow == bShow) {
        return;
    }else{
        isAnimating = true;
        if (bShow) {
            [UIView animateWithDuration:0.35 animations:^{
                [self setFrame:originFrame];
                
            } completion:^(BOOL finished) {
                isListShow = true;
                isAnimating = false;
            }];
        }else{
            [UIView animateWithDuration:0.35 animations:^{
                CGRect frame = originFrame;
                frame.size.height = showHeight;
                [self setFrame:frame];
            } completion:^(BOOL finished) {
                isListShow = false;
                isAnimating = false;
            }];
        }
    }
}

#pragma mark set datalist
-(void)setDataList:(NSArray<NSString *> *)dataList{
    if (_dataList != dataList) {
        _dataList = dataList;
    }
    [tblSelList reloadData];
}

#pragma mark set current select
-(void)setCurrentSelected:(NSInteger)currentSelected{
    _currentSelected = currentSelected;
    if (_dataList && _dataList.count) {
        [lbSelectedText setText:_dataList[_currentSelected]];
    }
}

#pragma mark - UITablView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataList && _dataList.count) {
        return _dataList.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14.0];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = _dataList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    lbSelectedText.text = cell.textLabel.text;
    _currentSelected = indexPath.row;
    [tblSelList deselectRowAtIndexPath:indexPath animated:false];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30.0;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
