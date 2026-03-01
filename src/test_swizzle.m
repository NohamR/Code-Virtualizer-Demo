/*****************************************************************************
 * test_swizzle.m
 * Description: Test program to demonstrate the method swizzling dylib
 * Build: gcc -o test_swizzle test_swizzle.m -framework Foundation -arch arm64
 * Run: ./test_swizzle
 * Run with dylib: DYLD_INSERT_LIBRARIES=./libswizzle_arm64.dylib ./test_swizzle
 *****************************************************************************/

#import <Foundation/Foundation.h>

@interface OriginalClass : NSObject
- (NSString *)original_selector;
@end

@implementation OriginalClass
- (NSString *)original_selector {
    return @"Original Implementation";
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        OriginalClass *obj = [[OriginalClass alloc] init];
        NSString *result = [obj original_selector];
        NSLog(@"Result: %@", result);
        
        NSString *testString = @"Hello World";

        NSString *description = [testString description];
        NSLog(@"testString.description: %@", description);
        
        NSLog(@"Logging string directly: %@", testString);
        
        NSString *str1 = @"Test1";
        NSString *str2 = @"Test2";
        NSLog(@"str1: %@, str2: %@", str1, str2);
        
        if ([description isEqualToString:@"Swizzled :)"]) {
            NSLog(@"Swizzling is active!");
        } else {
            NSLog(@"Swizzling is NOT active");
        }
    }
    return 0;
}
