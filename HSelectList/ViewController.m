//
//  ViewController.m
//  HSelectList
//
//  Created by JuanFelix on 4/18/16.
//  Copyright © 2016 JuanFelix. All rights reserved.
//

#import "ViewController.h" 
#import "HSelectList.h"

@interface ViewController ()
{
    HSelectList * select;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstriant;
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    select = [[HSelectList alloc] init];
    [self.view addSubview:select];
    select.dataList = @[@"男",@"女"];
    select.currentSelected = 1;
    
    NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:select attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:40];
    
    NSLayoutConstraint * right = [NSLayoutConstraint constraintWithItem:select attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-40];
    
    NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:select attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:40];
    
    NSLayoutConstraint * height = [NSLayoutConstraint constraintWithItem:select attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    
    [self.view addConstraint:top];
    [self.view addConstraint:left];
    [self.view addConstraint:right];
    [self.view addConstraint:height];
    
    HSelectList * select2 = [[HSelectList alloc] initWithFrame:CGRectMake(100, 150, 100, 40)];
    [self.view addSubview:select2];
    select2.dataList = @[@"中国",@"美国",@"其他"];
    select2.currentSelected = 1;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"you select at index:%d",select.currentSelected);
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[HSelectList class]]) {
            [obj showList:false];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
