

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ViewController : UIViewController
{
    sqlite3 *db;
}

-(void)readDb:(NSString *) date;
@end

