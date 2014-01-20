//
//  main.m
//  kata
//
//  Created by Brandon Roth on 1/19/14.
//  Copyright (c) 2014 Brandon Roth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fibonacci : NSObject

+(int)fib:(int)n;
+(int)recursiveFibonacci:(int)n;

@end

@implementation fibonacci

+(int)fib:(int)n
{
    //In Objective c we can only put objects into arrays and dictionarys so everything
    //is stored as an NSNumber.

    //the @(variable) is a compiler shorthand to creating an NSNumber, @{key: value} is shorthand
    //for creating an NSDictionary, and dictionary[] is a shorthand for of [dict objectForKey:key];

    //We store the answer for 0 and 1 in dictionary and immediatly look in the dictionary to see
    //if it's there, if it is we return it right away otherwise compute it.  This solution suffers
    //from not dealing with negative numbers and will always return zero in that case.  This happens
    //Because when we look for a negative key in the dictionary it won't exist so nil will be returned
    //and when you send messages to nil you get a return value of nil (or zero in the case of intValue).
    NSMutableDictionary *memo = [@{@(0): @(0), @(1): @(1)} mutableCopy];
    NSNumber *number = memo[@(n)];
    if (number)
    {
        return [number intValue];
    }

    for (int i = 2; i <= n; i++)
    {
        int value = [memo[@(i-1)] intValue] + [memo[@(i-2)] intValue];
        memo[@(i)] = @(value);
    }

    return [memo[@(n)] intValue];
}

//The naive recurisive implementation doesn't handle negative numbers well so we
//just return zero.
+ (int)recursiveFibonacci:(int)n
{
    if (n <= 0)
        return 0;
    if (n == 1)
        return 1;

    return [self recursiveFibonacci:n-1] + [self recursiveFibonacci:n-2];
}

@end

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        int n = 10;
        NSLog(@"Fib 10 = %d", [fibonacci fib:n]);
        NSLog(@"Fib 10 = %i", [fibonacci recursiveFibonacci:n]);
    }
    return 0;
}

