#import "NSDate+Twitter.h"

@implementation NSDate (Twitter)

+ (NSDate *)dateWithTwitterCreatedAtString:(NSString *)string
{
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    }
    return [formatter dateFromString:string];
}

+ (NSDate *)dateWithTwitterSearchCreatedAtString:(NSString *)string
{
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        formatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss Z";
    }
    return [formatter dateFromString:string];
}

- (NSString *)description
{
    static NSCalendar *cal = nil;
    if (cal == nil) {
        cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    NSUInteger flag = (NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit| 
                       NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit);
    
    NSTimeInterval interval = -1*[self timeIntervalSinceNow];
    
    if (interval < 60*60*24) {
        if (interval < 60) {
            return [NSString stringWithFormat:@"%d秒前", (NSInteger)interval];
        } else if (interval < 60*60) {
            return [NSString stringWithFormat:@"%d分前", (NSInteger)interval/60];
        } 
        return [NSString stringWithFormat:@"%d時間前", (NSInteger)interval/(60*60)];
    }
    NSDateComponents *components = [cal components:flag fromDate:self];
    return [NSString stringWithFormat:@"%04d/%02d/%02d %02d:%02d:%02d",
            [components year], [components month], [components day],
            [components hour], [components minute], [components second]];
}

@end
