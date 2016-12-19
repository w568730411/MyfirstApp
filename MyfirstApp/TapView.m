//
//  TapView.m
//  MyfirstApp
//
//  Created by 吴立翔 on 16/7/14.
//  Copyright © 2016年 吴立翔. All rights reserved.
//

#import "TapView.h"

#define Dbname @"Test.sqlite"

@interface TapView ()
{
    UITextField *getText1;
    UITextField *getText2;
    UITextField *getText3;
    UITextField *getText4;
    UITextField *getText5;
    UIButton *commit;
    UIButton *cancel;
    UIDatePicker *datePicker;
}

@end

@implementation TapView

- (void)viewDidLoad
{
    //和A视图差不多的东西，不解释啦！！
    [super viewDidLoad];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [path objectAtIndex:0];
    NSString *db_path = [documents stringByAppendingPathComponent:Dbname];
    
    if (sqlite3_open([db_path UTF8String],&db) != SQLITE_OK) {
        sqlite3_close(db);
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(30,30,50,20)];
    [button setTitle:@"back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button2 setFrame:CGRectMake(30, 70, 50, 20)];
//    //[button2 setBackgroundColor:[UIColor redColor]];
//    [button2 setTitle:@"add" forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(addDate) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:b utton2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button3 setFrame:CGRectMake(WIDTH/2, SP_H(20), 50, 20)];
    //[button2 setBackgroundColor:[UIColor redColor]];
    [button3 setTitle:@"date" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(datePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
//    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button3 setFrame:CGRectMake(80, 70, 50, 20)];
//    //[button3 setBackgroundColor:[UIColor greenColor]];
//    [button3 setTitle:@"delete" forState:UIControlStateNormal];
//    [button3 addTarget:self action:@selector(deleteDate) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button3];
    
    UILabel *date1 = [[UILabel alloc] init];
    [date1 setFrame:CGRectMake(30, 100, 100, 20)];
    [date1 setText:@"开始时间"];
    [self.view addSubview:date1];

    getText1 = [[UITextField alloc] init];
    getText1.frame = CGRectMake(110, 100, 100, 20);
    //getText1.backgroundColor = [UIColor grayColor];
    [getText1 setBorderStyle:UITextBorderStyleLine];
    getText1.clearButtonMode=UITextFieldViewModeWhileEditing;
    getText1.delegate = self;
    getText1.tag = 1;
    [self.view addSubview:getText1];
    
    UILabel *date2 = [[UILabel alloc] init];
    [date2 setFrame:CGRectMake(30, 130, 100, 20)];
    [date2 setText:@"结束时间"];
    [self.view addSubview:date2];
    //
    getText2 = [[UITextField alloc] init];
    getText2.frame = CGRectMake(110, 130, 100, 20);
    //getText1.backgroundColor = [UIColor grayColor];
    [getText2 setBorderStyle:UITextBorderStyleLine];
    getText2.clearButtonMode=UITextFieldViewModeWhileEditing;
    getText2.delegate = self;
    getText2.tag = 2;
    [self.view addSubview:getText2];
    
    datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(chooseDate) forControlEvents:UIControlEventValueChanged];
    
    UILabel *event = [[UILabel alloc] init];
    [event setFrame:CGRectMake(30, 160, 40, 20)];
    [event setText:@"事件"];
    [self.view addSubview:event];
    
    getText3 = [[UITextField alloc] init];
    getText3.frame = CGRectMake(110, 160, 100, 20);
    //getText2.backgroundColor = [UIColor grayColor];
    [getText3 setBorderStyle:UITextBorderStyleLine];
    getText3.clearButtonMode=UITextFieldViewModeWhileEditing;
    getText3.delegate = self;
    getText3.tag =4;
    [self.view addSubview:getText3];
    
    UILabel *location = [[UILabel alloc] init];
    [location setFrame:CGRectMake(30, 190, 40, 20)];
    [location setText:@"地点"];
    [self.view addSubview:location];
    
    getText4 = [[UITextField alloc] init];
    getText4.frame = CGRectMake(110, 190, 100, 20);
    //getText3.backgroundColor = [UIColor grayColor];
    [getText4 setBorderStyle:UITextBorderStyleLine];
    getText4.clearButtonMode=UITextFieldViewModeWhileEditing;
    getText4.delegate = self;
    getText4.tag = 5;
    [self.view addSubview:getText4];
    
    UILabel *date5 = [[UILabel alloc] init];
    [date5 setFrame:CGRectMake(30, 220, 100, 20)];
    [date5 setText:@"日期"];
    [self.view addSubview:date5];
    
    getText5 = [[UITextField alloc] init];
    getText5.frame = CGRectMake(110, 220, 100, 20);
    //getText1.backgroundColor = [UIColor grayColor];
    [getText5 setBorderStyle:UITextBorderStyleLine];
    getText5.clearButtonMode=UITextFieldViewModeWhileEditing;
    getText5.delegate = self;
    getText5.tag = 3;
    [self.view addSubview:getText5];
    
    UIButton *commitbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [commitbutton setBackgroundColor:[UIColor blueColor]];
    [commitbutton setFrame:CGRectMake(30, 250, 60, 20)];
    [commitbutton setTitle:@"add" forState:UIControlStateNormal];
    [commitbutton setTintColor:[UIColor blackColor]];
    [commitbutton addTarget:self action:@selector(addevent) forControlEvents:UIControlEventTouchUpInside];
    [self .view addSubview:commitbutton];
    
}

-(void)addevent
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    //实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"HHMM"];//设定时间格式
    NSDate *timeString = [dateFormat stringFromDate:getText1.text];
    NSLog(@"%@",timeString);
    NSDate *timeString2 = [dateFormat stringFromDate:getText2.text];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormat stringFromDate:getText5.text];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Data (StartTime,Event,State,Location,EndTime) VALUES ('%@','%@','0','%@','%@')",getText1.text,getText3.text,getText4.text,getText2.text];
    NSLog(@"%@",sql);
    NSLog(@"FUCK");
}

-(void)show
{
    NSLog(@"%@",getText1.text);
}

-(void)back
{
    //下面这行代码作用就是将弹出的模态视图移除，第一个yes表示移除的时候有动画效果，第二参数是设置一个回调，当模态视图移除消失后，会回到这里，可以在这里随便写句话打个断点，试一下就知道确实会回调到这个方法
    //    [self dismissViewControllerAnimated:YES completion:nil]; 或带有回调的如下方法
    [self dismissViewControllerAnimated:YES completion:^{
        
        //NSLog(@"back");//这里打个断点，点击按钮模态视图移除后会回到这里
        //ios 5.0以上可以用该方法
    }];
}

-(void)addDate
{
//    NSString *date, *event, *location;
//    date = getText1.text;
//    event = getText2.text;
//    location = getText3.text;
//    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Data (Date,Event,State,Location) VALUES ('%@','%@','0','%@')",date,event,location];
//    [self execSql:sql];
    UIAlertController *addDate = [UIAlertController alertControllerWithTitle:@"input the message"
                                                                     message:@"please enter the events"
                                                              preferredStyle:UIAlertControllerStyleAlert];
    [addDate addTextFieldWithConfigurationHandler:^(UITextField *date){
        date.placeholder = @"时间";
        date.clearButtonMode=UITextFieldViewModeWhileEditing;
    }];
    [addDate addTextFieldWithConfigurationHandler:^(UITextField *event){
        event.placeholder = @"事件";
        event.clearButtonMode=UITextFieldViewModeWhileEditing;
    }];
    [addDate addTextFieldWithConfigurationHandler:^(UITextField *location){
        location.placeholder = @"地点";
        location.clearButtonMode=UITextFieldViewModeWhileEditing;
    }];
    UIAlertAction *okBuuton = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
    NSString *date, *event, *location;
    NSMutableArray *textArray = [[NSMutableArray alloc] init];
    NSEnumerator<UITextField *> *textfield = addDate.textFields.objectEnumerator;
    UITextField *next;
    while ((next = [textfield nextObject]) != nil) {
        [textArray addObject:next.text];
    }
    date = [textArray objectAtIndex:0];
    event = [textArray objectAtIndex:1];
    location = [textArray objectAtIndex:2];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Data (Date,Event,State,Location) VALUES ('%@','%@','0','%@')",date,event,location];
    [self execSql:sql];
    }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *actio){}];
    [addDate addAction:okBuuton];
    [addDate addAction:cancelButton];
    [self presentViewController:addDate animated:YES completion:^{ }];
}

-(void)deleteDate
{
    NSString *sql1 = [NSString stringWithFormat:@"delete from Data where date = '20160704'"];
    [self execSql:sql1];
}

-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db,[sql UTF8String],NULL,NULL,&err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"mission filed");
    }
}

-(void)chooseDate
{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    dateformat.dateFormat = @"HH:mm";
    NSString *dateString = [dateformat stringFromDate:datePicker.date];
    switch (datePicker.tag) {
        case 1:
            getText1.text = dateString;
            break;
        case 2:
            getText2.text = dateString;
            break;
        case 3:
            dateformat.dateFormat = @"yyyy/MM/dd";
            dateString = [dateformat stringFromDate:datePicker.date];
            getText5.text = dateString;
            break;
        default:
            break;
    }

}

-(void)commit
{
    if (datePicker.superview) {
        [datePicker removeFromSuperview];
    }
    commit.hidden = YES;
    cancel.hidden = YES;
}

-(void)cancel
{
    [datePicker removeFromSuperview];
    commit.hidden = YES;
    cancel.hidden = YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag!=1) {
        if (textField.tag!=2) {
            if (textField.tag!=3) {
                if (datePicker.superview) {
                    [datePicker removeFromSuperview];
                }
                return YES;
            }
        }
    }
    if (datePicker.superview == nil) {
        datePicker.datePickerMode = UIDatePickerModeTime;
        [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        datePicker.frame = CGRectMake(0, HEIGHT/2, WIDTH, HEIGHT/4);
        datePicker.tag = textField.tag;
        if (datePicker.tag == 3) {
            datePicker.datePickerMode = UIDatePickerModeDate;
        }

        [self.view addSubview:datePicker];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView commitAnimations];

        commit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [commit setFrame:CGRectMake(SP_W(20), HEIGHT/2, SP_W(50), SP_H(50))];
        [commit setTitle:@"ok" forState:UIControlStateNormal];
        [commit addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:commit];
        
        cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancel setFrame:CGRectMake(WIDTH-SP_W(70), HEIGHT/2, SP_W(50), SP_H(50))];
        [cancel setTitle:@"cancel" forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cancel];
        
    }
    
    if (datePicker.superview) {
        if (textField.tag == 3) {
            datePicker.datePickerMode = UIDatePickerModeDate;
        }
        else{
            datePicker.datePickerMode = UIDatePickerModeTime;
        }
    }
    
    return NO;
}

-(void)datePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [alert.view addSubview:datePicker];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        //实例化一个NSDateFormatter对象
        [dateFormat setDateFormat:@"yyyyMMdd"];//设定时间格式
        NSString *dateString = [dateFormat stringFromDate:datePicker.date];
        //求出当天的时间字符串
        NSLog(@"%@",dateString);
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *actio){}];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert
    animated:YES completion:^{ }];
}
@end
