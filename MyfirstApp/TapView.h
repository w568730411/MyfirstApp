//
//  TapView.h
//  MyfirstApp
//
//  Created by 吴立翔 on 16/7/14.
//  Copyright © 2016年 吴立翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface TapView : UIViewController<UITextFieldDelegate>
{
    sqlite3 *db;
}

@end
