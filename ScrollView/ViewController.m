//
//  ViewController.m
//  ScrollView
//
//  Created by M on 16/7/17.
//  Copyright © 2016年 M. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,assign)BOOL isDrow;
@property (strong, nonatomic)UIScrollView *myScrollV;

@property (strong, nonatomic)UIView *myview;
@property (strong, nonatomic)UIButton *button;
@property (strong, nonatomic)UIGestureRecognizer *recon;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recon = [[UIGestureRecognizer alloc] init];
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    UIView *contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    contentView.backgroundColor = [UIColor redColor];
    scrollView.contentSize = contentView.bounds.size;
    scrollView.delegate = self;
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 250, 20)];
    label.text = @"我是应该固定在左上角的";
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(150, 150, 50, 50)];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitle:@"拖动" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(drowMove:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [btn addTarget:self action:@selector(drowEnd:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.button = btn;
    self.myScrollV = scrollView;
    self.myview = contentView;
    
    [contentView addSubview:label];
    [contentView addSubview:btn];
    [scrollView addSubview:contentView];
    [self.view addSubview:scrollView];
}


- (void)drowMove:(UIButton *)sender withEvent:(UIEvent *)ev{
    self.isDrow = YES;
    
    UITouch *aTouch = [[ev allTouches] anyObject];
    CGPoint loc = [aTouch locationInView:self.myview];
    CGPoint prevloc = [aTouch previousLocationInView:self.myview];
    
    
    sender.center = [aTouch locationInView:self.myview];
    CGSize size = {self.myScrollV.contentSize.width , self.myScrollV.contentSize.height + (loc.y - prevloc.y)};
    
    self.myview.frame = CGRectMake(0, 0, self.view.bounds.size.width, size.height);
    self.myScrollV.contentSize = size;
  
    
    [self.view layoutIfNeeded];
    NSLog(@"拖动了%f",loc.y-prevloc.y);
}
- (void)drowEnd:(UIButton *)sender {
    
    if (!self.isDrow) {
        NSLog(@"点击了");
    }
    self.isDrow = NO;
}
@end
