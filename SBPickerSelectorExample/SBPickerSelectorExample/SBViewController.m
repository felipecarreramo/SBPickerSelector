//
//  SBViewController.m
//  SBPickerSelectorExample
//
//  Created by Santiago Bustamante on 1/24/14.
//  Copyright (c) 2014 Busta117. All rights reserved.
//

#import "SBViewController.h"


@interface SBViewController ()
{
    UILabel *resultLbl_;
}


@end

@implementation SBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake(0, 0, 200, 50);
    but.center = self.view.center;
    but.center = CGPointMake(but.center.x, but.center.y - 100);
    [but setTitle:@"show picker" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    resultLbl_ = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    resultLbl_.text = @"result here";
    resultLbl_.textAlignment = NSTextAlignmentCenter;
    resultLbl_.center = CGPointMake(but.center.x, but.center.y + 50);
    [self.view addSubview:resultLbl_];
    
    
}


- (void) showPicker:(id)sender{
    
    
    
    //*********************
    //setup here your picker
    //*********************
    
    
    SBPickerSelector *picker = [SBPickerSelector picker];
    
//    picker.pickerData = [@[@"one",@"two",@"three",@"four",@"five",@"six"] mutableCopy]; //picker content
    picker.delegate = self;
//    picker.pickerType = SBPickerSelectorTypeText;
    picker.doneButtonTitle = @"Done";
    picker.cancelButtonTitle = @"Cancel";
    
    picker.pickerType = SBPickerSelectorTypeDate; //select date(needs implements delegate method with date)
    picker.datePickerType = SBPickerSelectorDateTypeOnlyMonthAndYear;
    picker.dateOnlyMonthYearPickerView.pickerDelegate = self;

//    [picker showPickerOver:self];
    
    CGPoint point = [self.view convertPoint:[sender frame].origin fromView:[sender superview]];
    CGRect frame = [sender frame];
    frame.origin = point;
    [picker showPickerIpadFromRect:frame inView:self.view];
    
    
}

-(void) datePickerMonthAndYear:(UIPickerView *)picker value:(int)value forUnitType:(SBPickerSelectorDateTypeUnit)typeUnit {
    if (typeUnit == SBPickerSelectorDateTypeUnitMonth) {
        NSLog(@"month %d", value);
    }
}


#pragma mark - SBPickerSelectorDelegate
-(void) pickerSelector:(SBPickerSelector *)selector selectedValue:(NSString *)value index:(NSInteger)idx{
    resultLbl_.text = value;
}

-(void) pickerSelector:(SBPickerSelector *)selector dateSelected:(NSDate *)date{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    resultLbl_.text = [dateFormat stringFromDate:date];
}

-(void) pickerSelector:(SBPickerSelector *)selector cancelPicker:(BOOL)cancel{
    NSLog(@"press cancel");
}

-(void) pickerSelector:(SBPickerSelector *)selector intermediatelySelectedValue:(id)value atIndex:(NSInteger)idx{
    if ([value isMemberOfClass:[NSDate class]]) {
        [self pickerSelector:selector dateSelected:value];
    }else{
        [self pickerSelector:selector selectedValue:value index:idx];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
