//
//  NSDictionary+preventor.m
//  JJCrashGuard
//
//  Created by Jerod on 2021/5/17.
//

#import "NSDictionary+JJShield.h"
//#import "JJCrashGuard.h"
#import "JJShieldCFuncs.h"


@implementation NSDictionary (JJCrashShield)

+ (void)openShield {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        //__NSPlaceholderDictionary
        Class __NSPlaceholderDictionary = NSClassFromString(@"__NSPlaceholderDictionary");
        swizzling_instance_method(__NSPlaceholderDictionary,
            @selector(initWithObjects:forKeys:count:),
            @selector(__NSPlaceholderDictionary_safe_initWithObjects:forKeys:count:));
        swizzling_instance_method(__NSPlaceholderDictionary,
            @selector(initWithObjects:forKeys:),
            @selector(__NSPlaceholderDictionary_safe_initWithObjects:forKeys:));
        swizzling_instance_method(__NSPlaceholderDictionary,
            @selector(allKeys),
            @selector(__NSPlaceholderDictionary_safe_allKeys));
        swizzling_instance_method(__NSPlaceholderDictionary,
              @selector(setValue:forKey:),
              @selector(__NSPlaceholderDictionary_safe_setValue:forKey:));
        swizzling_instance_method(__NSPlaceholderDictionary,
              @selector(objectForKey:),
              @selector(__NSPlaceholderDictionary_safe_objectForKey:));
        
        
        //__NSSingleEntryDictionaryI
//        Class __NSSingleEntryDictionaryI = NSClassFromString(@"__NSSingleEntryDictionaryI");
//        swizzling_instance_method(__NSSingleEntryDictionaryI, @selector(objectForKey:), @selector(__NSSingleEntryDictionaryI_safe_objectForKey:));
//        swizzling_instance_method(__NSSingleEntryDictionaryI, @selector(objectForKeyedSubscript:), @selector(__NSSingleEntryDictionaryI_safe_objectForKeyedSubscript:));

        // __NSDictionary0


        // __NSDictionaryI
//        Class __NSDictionaryI = NSClassFromString(@"__NSDictionaryI");
//        swizzling_instance_method(__NSDictionaryI, @selector(initWithObjects:forKeys:), @selector(__NSDictionaryI_safe_initWithObjects:forKeys:));


    });
}


// MARK: __NSPlaceholderDictionary
- (instancetype)__NSPlaceholderDictionary_safe_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt
{
    if (objects && keys)
    {
        if (objects[0] == nil || keys[0] == nil) {
            CPWarning(@"-[__NSPlaceholderDictionary initWithObjects:forKeys:count:], objects or keys is nil");
            return [self __NSPlaceholderDictionary_safe_initWithObjects:NULL forKeys:NULL count:0];
        }

        id newObjs[cnt];
        NSUInteger newCnt = 0;
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjs[newCnt] = objects[i];
                newCnt++;
            } else {
                CPWarning(@"-[__NSPlaceholderArray initWithObjects:forKeys:count:], object cannot be nil at %d", i);
            }
        }
        return [self __NSPlaceholderDictionary_safe_initWithObjects:objects forKeys:keys count:cnt];
    }
    else
    {
        return [self __NSPlaceholderDictionary_safe_initWithObjects:NULL forKeys:NULL count:0];
    }
}

- (instancetype)__NSPlaceholderDictionary_safe_initWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys
{
    if (objects && keys && objects.count == keys.count)
    {
        return [self __NSPlaceholderDictionary_safe_initWithObjects:objects forKeys:keys];
    }
    else
    {
        CPWarning(@"-[__NSPlaceholderArray initWithObjects:forKeys:], object, keys cannot be nil; or objects and keys count not equal.");
        return [self __NSPlaceholderDictionary_safe_initWithObjects:nil forKeys:nil];
    }
}

- (NSArray *)__NSPlaceholderDictionary_safe_allKeys {
    CPError(@"-[__NSPlaceholderDictionary allKeys], *** -[NSDictionary count]: method sent to an uninitialized immutable dictionary object");
    return @[];
}

- (void)__NSPlaceholderDictionary_safe_setValue:(id)value forKey:(NSString *)key {
    CPError(@"-[__NSPlaceholderDictionary setValue:forKey:], *** -[NSDictionary setObject:forKey:]: method sent to an uninitialized immutable dictionary object");
}

- (id)__NSPlaceholderDictionary_safe_objectForKey:(id)aKey {
    if (!aKey) {
        CPWarning(@"-[__NSPlaceholderDictionary objectForKey:], key can not be nil.");
        return nil;
    }
    if ([self.allKeys containsObject:aKey]) {
        return [self __NSPlaceholderDictionary_safe_objectForKey:aKey];
    } else {
        CPError(@"-[__NSPlaceholderDictionary objectForKey:], *** -[NSDictionary objectForKey:]: method sent to an uninitialized immutable dictionary object");
        return nil;
    }
}





// MARK: __NSDictionaryI
//- (instancetype)__NSDictionaryI_safe_initWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys
//{
//    if (objects && keys)
//    {
//        return [self __NSDictionaryI_safe_initWithObjects:objects forKeys:keys];
//    }
//    else
//    {
//        return [self __NSDictionaryI_safe_initWithObjects:nil forKeys:nil];
//    }
//}

//- (id)__NSSingleEntryDictionaryI_safe_objectForKey:(id)aKey {
//    if (aKey) {
//        return [self __NSSingleEntryDictionaryI_safe_objectForKey:aKey];
//    } else {
//        CPAssert(NO, @"*** [JJCrashGuard], -[__NSSingleEntryDictionaryI objectForKey:], key can not be nil.");
//        return nil;
//    }
//}
//
//- (id)__NSSingleEntryDictionaryI_safe_objectForKeyedSubscript:(id)key {
//    if (key) {
//        return [self __NSSingleEntryDictionaryI_safe_objectForKeyedSubscript:key];
//    } else {
//        CPAssert(NO, @"*** [JJCrashGuard], -[__NSSingleEntryDictionaryI objectForKeyedSubscript:], key can not be nil.");
//        return nil;
//    }
//}


@end
