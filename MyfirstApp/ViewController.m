//
//  ViewController.m
//  MyfirstApp
//
//  Created by 吴立翔 on 16/6/29.
//  Copyright © 2016年 吴立翔. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
#import "MsgModel.h"
#import "TapView.h"

@interface ViewController (){
    UIScrollView * scrollView;
    MyView * myView;
    NSString *dateString;
    //UIView * dataPiker;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    dateString=[dateformatter stringFromDate:senddate];
    
    [self readDb:dateString];
    
}

-(void)scroViewRelode
{
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    scrollView.backgroundColor=RGBACOLOR(240, 240, 240, 1);
    //dataPiker=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, SP_W(30))];
    myView.frame=CGRectMake(0,SP_W(30), WIDTH, SP_W(70)*myView.msgModelArray.count+50);
    scrollView.contentSize=CGSizeMake(0, SP_W(70)*(myView.msgModelArray.count+3)+SP_W(30));
    //[scrollView addSubview:dataPiker];
    [scrollView addSubview:myView];
    [self.view addSubview:scrollView];
    CGPoint endPoint;
    
    for(int i=0;i<myView.msgModelArray.count;i++){
        endPoint.x=WIDTH-SP_W(60);
        endPoint.y=SP_W(60)+SP_W(70)*i;
        MsgModel * model=[myView.msgModelArray objectAtIndex:i];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setFrame:CGRectMake(endPoint.x+SP_W(5), endPoint.y+SP_W(15), SP_W(15), SP_W(8))];
//      [button setTitle:model.starttime forState:UIControlStateReserved];
        [button setBackgroundColor:[UIColor blackColor]];
        int ingTag = [model.starttime intValue];
        [button setTag:ingTag];
        [button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        
        UIButton * stateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [stateButton setFrame:CGRectMake(endPoint.x+SP_W(5), endPoint.y+SP_W(30), SP_W(15), SP_W(8))];
        int state = [model.state intValue];
        int stateTag = ingTag * 10 +state;
        [stateButton setTag:stateTag];
        if ([model.state isEqualToString:@"1"]) {
            [stateButton setBackgroundColor:[UIColor greenColor]];
        }
        else{
            [stateButton setBackgroundColor:[UIColor redColor]];
        }
        [stateButton addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:stateButton];
        
        UIButton * changeEvnet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [changeEvnet setFrame:CGRectMake(endPoint.x+SP_W(5), endPoint.y+SP_W(45), SP_W(15), SP_W(8))];
        [changeEvnet setBackgroundColor:[UIColor blueColor]];
        [changeEvnet setTag:ingTag];
        [changeEvnet addTarget:self action:@selector(changeEvent:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:changeEvnet];
    }
    
    UIButton *addButton = [[UIButton alloc] init];
    CGRect size = CGRectMake(SP_H(15), SP_W(30), SP_H(40), SP_W(20));
    [addButton setFrame:size];
    [addButton setTitle:@"add" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor redColor]];
//    [addButton setTitle:@"oh" forState:UIControlStateHighlighted];
    [addButton addTarget:self action:@selector(modelViewGO/*addDate*/) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:addButton];
    
    UIButton *datePicker = [[UIButton alloc] init];
    CGRect size2 = CGRectMake(SP_H(15), SP_W(60), SP_H(40), SP_W(20));
    [datePicker setFrame:size2];
    [datePicker setTitle:@"date" forState:UIControlStateNormal];
    [datePicker setBackgroundColor:[UIColor blueColor]];
    [datePicker addTarget:self action:@selector(datePicker) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:datePicker];
    
    UIImageView * imageDate=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/4+SP_W(20), SP_W(30), SP_W(15), SP_W(15))];
    imageDate.image=[UIImage imageNamed:@"date"];
    UILabel * dateLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageDate.frame)+SP_W(5), SP_W(30), WIDTH/2, SP_W(20))];
    dateLab.text = dateString;
    dateLab.textColor=[UIColor blackColor];
    dateLab.font=[UIFont systemFontOfSize:18];
    [dateLab sizeToFit];
    
    [scrollView addSubview:imageDate];
    [scrollView addSubview:dateLab];
}


-(void)viewWillAppear:(BOOL)animated{
    [self readDb:dateString];
    [self scroViewRelode];
    
//    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
//    scrollView.backgroundColor=RGBACOLOR(240, 240, 240, 1);
//    //dataPiker=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, SP_W(30))];
//    myView.frame=CGRectMake(0,SP_W(30), WIDTH, SP_W(70)*myView.msgModelArray.count+50);
//    scrollView.contentSize=CGSizeMake(0, SP_W(70)*(myView.msgModelArray.count+3)+SP_W(30));
//    //[scrollView addSubview:dataPiker];
//    [scrollView addSubview:myView];
//    [self.view addSubview:scrollView];
//    
//    CGPoint endPoint;
//    
//    for(int i=0;i<myView.msgModelArray.count;i++){
//        endPoint.x=WIDTH-SP_W(60);
//        endPoint.y=SP_W(60)+SP_W(70)*i;
//        MsgModel * model=[myView.msgModelArray objectAtIndex:i];
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [button setFrame:CGRectMake(endPoint.x+SP_W(5), endPoint.y+SP_W(15), SP_W(15), SP_W(8))];
//        [button setTitle:model.date forState:UIControlStateReserved];
//        [button setBackgroundColor:[UIColor redColor]];
//        int ingTag = [model.date intValue];
//        [button setTag:ingTag];
//        [button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
//        [scrollView addSubview:button];
//    }
//    
//    UIButton *addButton = [[UIButton alloc] init];
//    CGRect size = CGRectMake(SP_H(15), SP_W(30), SP_H(30), SP_W(20));
//    [addButton setFrame:size];
//    [addButton setTitle:@"add" forState:UIControlStateNormal];
//    [addButton setBackgroundColor:[UIColor redColor]];
//    [addButton setTitle:@"oh" forState:UIControlStateHighlighted];
//    [addButton addTarget:self action:@selector(modelViewGO) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:addButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) modelViewGO
{
    TapView * modalView = [[TapView alloc]init];
    modalView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:modalView animated:YES completion:nil];
    //    [modalView release];
}

-(void)addDate
{
    UIAlertController *addDate = [UIAlertController alertControllerWithTitle:@"input the message"
                                                                     message:@"please enter the events"
                                                              preferredStyle:UIAlertControllerStyleAlert];
    [addDate addTextFieldWithConfigurationHandler:^(UITextField *date){
        date.placeholder = @"开始时间(格式0800)";
        date.clearButtonMode=UITextFieldViewModeWhileEditing;
    }];
    [addDate addTextFieldWithConfigurationHandler:^(UITextField *date2){
        date2.placeholder = @"结束时间(格式0800)";
        date2.clearButtonMode=UITextFieldViewModeWhileEditing;
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
                                                         NSString *starttime, *event, *location,*endtime;
                                                         NSMutableArray *textArray = [[NSMutableArray alloc] init];
                                                         NSEnumerator<UITextField *> *textfield = addDate.textFields.objectEnumerator;
                                                         UITextField *next;
                                                         while ((next = [textfield nextObject]) != nil) {
                                                             [textArray addObject:next.text];
                                                         }
                                                         starttime = [textArray objectAtIndex:0];
                                                         endtime = [textArray objectAtIndex:1];
                                                         event = [textArray objectAtIndex:2];
                                                         location = [textArray objectAtIndex:3];
                                                         NSString *sql = [NSString stringWithFormat:@"INSERT INTO Data (StartTime,Event,State,Location,EndTime) VALUES ('%@','%@','0','%@','%@')",starttime,event,location,endtime];
                                                         char *err;
                                                         if (sqlite3_exec(db,[sql UTF8String],NULL,NULL,&err) != SQLITE_OK) {
                                                             sqlite3_close(db);
                                                             NSLog(@"mission filed");
                                                         }
                                                         [self readDb:dateString];
                                                         [self scroViewRelode];
                                                     }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *actio){}];
    [addDate addAction:okBuuton];
    [addDate addAction:cancelButton];
    [self presentViewController:addDate animated:YES completion:^{ }];
}

-(void)readDb:(NSString *)date
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [path objectAtIndex:0];
    NSString *Dbname = [[NSMutableString alloc] initWithString:@"date"];
    
//    NSDate *  senddate=[NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYYMMdd"];
//    dateString=[dateformatter stringFromDate:senddate];
    
    Dbname = [Dbname stringByAppendingString:date];
    Dbname = [Dbname stringByAppendingString:@".sqlite"];
    NSString *db_path = [documents stringByAppendingPathComponent:Dbname];
    
    if (sqlite3_open([db_path UTF8String],&db) != SQLITE_OK) {
        sqlite3_close(db);
    }
    
    NSString *setsql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'Data' ('StartTime' INTEGER PRIMARY KEY NOT NULL UNIQUE, 'Event' TEXT, 'State' TEXT, 'Location' TEXT, 'EndTime' INTEGER)"];
    char *err;
    
    if (sqlite3_exec(db,[setsql UTF8String],NULL,NULL,&err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"mission filed");
    }
    
    myView=[[MyView alloc]init];
    MsgModel * model;
    myView.msgModelArray = [[NSMutableArray alloc] init];
    char *sql = "SELECT * FROM Data";
    sqlite3_stmt *statement;
    
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            model=[[MsgModel alloc]init];
            int starttime = sqlite3_column_int(statement, 0);
            model.starttime = [NSString stringWithFormat:@"%d",starttime];
            
            char *event = (char *)sqlite3_column_text(statement, 1);
            model.motive = [[NSString alloc] initWithUTF8String:event];
            
            char *state = (char *)sqlite3_column_text(statement, 2);
            model.state = [[NSString alloc] initWithUTF8String:state];
            
            char *location = (char *)sqlite3_column_text(statement, 3);
            model.address = [[NSString alloc] initWithUTF8String:location];
            
            int endtime = sqlite3_column_int(statement, 4);
            model.endtime = [NSString stringWithFormat:@"%d",endtime];
            
            [myView.msgModelArray addObject:model];
            
        }
    }
}

-(void)delete:(id)sender
{
    
    int date = [sender tag];
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"delete?"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"yes"
                                              otherButtonTitles:@"no", nil];
    alertview.tag = date;
    [alertview show];
    [scrollView addSubview:alertview];
}

-(void)execSql:(int)date
{
    char *err;
    //NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO Data (Date,Event,State,Location) VALUES ('20160720','陈杰好笨呀','1','常州好热啊')"];
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documents = [path objectAtIndex:0];
//    NSString *db_path = [documents stringByAppendingPathComponent:Dbname];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [path objectAtIndex:0];
    NSString *Dbname = [[NSMutableString alloc] initWithString:@"date"];
    
    Dbname = [Dbname stringByAppendingString:dateString];
    Dbname = [Dbname stringByAppendingString:@".sqlite"];
    NSString *db_path = [documents stringByAppendingPathComponent:Dbname];
    
    //sqlite3 *db;
    if (sqlite3_open([db_path UTF8String],&db) != SQLITE_OK) {
        sqlite3_close(db);
    }
    NSString *sql1 = [NSString stringWithFormat:@"delete from Data where StartTime = '%d'",date];
    if (sqlite3_exec(db,[sql1 UTF8String],NULL,NULL,&err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"mission filed");
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self execSql:alertView.tag];
            [self readDb:dateString];
            [self scroViewRelode];
            break;
        case 1:
            [self readDb:dateString];
            [self scroViewRelode];
            break;
            
        default:
            break;
    }
}

-(void)datePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init]; datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [alert.view addSubview:datePicker];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        //实例化一个NSDateFormatter对象
        [dateFormat setDateFormat:@"yyyyMMdd"];//设定时间格式
        dateString = [dateFormat stringFromDate:datePicker.date];
        //求出当天的时间字符串
        [self readDb:dateString];
        [self scroViewRelode];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *actio){}];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{ }];
}

-(void)changeState:(id) sender
{
    //UPDATE Data SET State = 1 WHERE StartTime = 101
    int date = [sender tag]/10;
    int state = [sender tag]%10;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"活动已完成?"
                                                                   message:@"是否确认改变该事件的完成状态？"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    NSString *sql = [NSString stringWithFormat:@"UPDATE Data SET State = %d WHERE StartTime = %d",1-state,date];
    char *err;
    if (sqlite3_exec(db,[sql UTF8String],NULL,NULL,&err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"mission filed");
    }
    [self readDb:dateString];
    [self scroViewRelode];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *actio){}];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{ }];
}

-(void)changeEvent:(id) sender
{
    int date = [sender tag];
    
    NSString *exec_sql = [NSString stringWithFormat:@"SELECT * FROM Data WHERE StartTime = %d",date];
    const char * sql =[exec_sql UTF8String];
    sqlite3_stmt *statement;
    NSString *Starttime,*motive,*State,*Address,*Endtime;
    
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int starttime = sqlite3_column_int(statement, 0);
            Starttime = [NSString stringWithFormat:@"%d",starttime];
            
            char *event = (char *)sqlite3_column_text(statement, 1);
            motive = [[NSString alloc] initWithUTF8String:event];
            
            char *state = (char *)sqlite3_column_text(statement, 2);
            State = [[NSString alloc] initWithUTF8String:state];
            
            char *location = (char *)sqlite3_column_text(statement, 3);
            Address = [[NSString alloc] initWithUTF8String:location];
            
            int endtime = sqlite3_column_int(statement, 4);
            Endtime = [NSString stringWithFormat:@"%d",endtime];
        }
    }
    UIAlertController *addDate = [UIAlertController alertControllerWithTitle:@"input the message"
                                                                     message:@"please enter the events"
                                                              preferredStyle:UIAlertControllerStyleAlert];
    [addDate addTextFieldWithConfigurationHandler:^(UITextField *date){
        date.placeholder = Starttime;
        date.clearButtonMode=UITextFieldViewModeWhileEditing;
    }];
    [addDate addTextFieldWithConfigurationHandler:^(UITextField *date2){
        date2.placeholder = Endtime;
        date2.clearButtonMode=UITextFieldViewModeWhileEditing;
    }];
    [addDate addTextFieldWithConfigurationHandler:^(UITextField *event){
        event.placeholder = motive;
        event.clearButtonMode=UITextFieldViewModeWhileEditing;
    }];
    [addDate addTextFieldWithConfigurationHandler:^(UITextField *location){
        location.placeholder = Address;
        location.clearButtonMode=UITextFieldViewModeWhileEditing;
    }];
    UIAlertAction *okBuuton = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         NSString *n_starttime, *n_event, *n_location,*n_endtime;
                                                         NSMutableArray *textArray = [[NSMutableArray alloc] init];
                                                         NSEnumerator<UITextField *> *textfield = addDate.textFields.objectEnumerator;
                                                         UITextField *next;
                                                         while ((next = [textfield nextObject]) != nil) {
                                                             [textArray addObject:next.text];
                                                         }
                                                         n_starttime = [textArray objectAtIndex:0];
                                                         n_endtime = [textArray objectAtIndex:1];
                                                         n_event = [textArray objectAtIndex:2];
                                                         n_location = [textArray objectAtIndex:3];
                                                         NSString *sql = [NSString stringWithFormat:@"UPDATE Data SET StartTime = '%@',EndTime = '%@',Event = '%@',Location = '%@' WHERE StartTime = '%d'",n_starttime,n_endtime,n_event,n_location,date];
                                                         NSLog(sql);
                                                         char *err;
                                                         if (sqlite3_exec(db,[sql UTF8String],NULL,NULL,&err) != SQLITE_OK) {
                                                             sqlite3_close(db);
                                                             NSLog(@"mission filed");
                                                         }
                                                         [self readDb:dateString];
                                                         [self scroViewRelode];
                                                     }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *actio){}];
    [addDate addAction:okBuuton];
    [addDate addAction:cancelButton];
    [self presentViewController:addDate animated:YES completion:^{ }];
}

@end
