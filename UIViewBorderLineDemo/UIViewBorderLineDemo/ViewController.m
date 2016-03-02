//
//  ViewController.m
//  UIViewBorderLineDemo
//
//  Created by 王四的mac air on 16/3/2.
//  Copyright © 2016年 王四的mac air. All rights reserved.
//

#import "ViewController.h"
#import "UIView+BorderLine.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *handleView;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.handleView.borderLineWidth = 1.0;
    self.handleView.borderLineColor = [UIColor blueColor].CGColor;
    self.handleView.borderLineStyle = BorderLineStyleNone;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)topChange:(id)sender {
    self.handleView.borderLineStyle = BorderLineStyleTop;
}

- (IBAction)bottomChange:(id)sender {
    self.handleView.borderLineStyle = BorderLineStyleBottom;
}

- (IBAction)leftChange:(id)sender {
    self.handleView.borderLineStyle = BorderLineStyleLeft;
}

- (IBAction)rightChange:(id)sender {
    self.handleView.borderLineStyle = BorderLineStyleRight;
}

@end
