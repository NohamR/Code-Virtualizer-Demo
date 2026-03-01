/*****************************************************************************
 * swizzle.m
 * Build: gcc -dynamiclib -framework Foundation -o libswizzle.dylib swizzle.m -arch arm64
 *****************************************************************************/

#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#include "include/VirtualizerSDK.h"
#include "include/StealthCodeArea.h"

int SwizzleStealthVar = 0;
STEALTH_AUX_FUNCTION

void SwizzleStealthCodeArea(void) {
    STEALTH_AREA_START
    STEALTH_AREA_CHUNK STEALTH_AREA_CHUNK STEALTH_AREA_CHUNK STEALTH_AREA_CHUNK STEALTH_AREA_CHUNK
    STEALTH_AREA_CHUNK STEALTH_AREA_CHUNK STEALTH_AREA_CHUNK STEALTH_AREA_CHUNK STEALTH_AREA_CHUNK
    STEALTH_AREA_END
}

__attribute__((used))
void ensure_stealth_area_compiled(void) {
    if (SwizzleStealthVar == 0x11223344) SwizzleStealthCodeArea();
}

static inline void *swizzle_instance_method(const char *cls, const char *sel, void *imp) {
    Method m = class_getInstanceMethod(objc_getClass(cls), sel_registerName(sel));
    return method_setImplementation(m, imp);
}

static IMP original_description = NULL;

id my_description(id self, SEL _cmd) {
    VIRTUALIZER_START
    
    VIRTUALIZER_STR_ENCRYPT_START
    const char *msg = "Swizzled :)";
    VIRTUALIZER_STR_ENCRYPT_END
    id result = [NSString stringWithUTF8String:msg];

    VIRTUALIZER_END
    return result;
}

id my_description_chained(id self, SEL _cmd) {
    VIRTUALIZER_START

    VIRTUALIZER_STR_ENCRYPT_START
    const char *log_msg = "[Swizzle] Original: %@";
    const char *msg = "Swizzled :)";
    VIRTUALIZER_STR_ENCRYPT_END

    if (original_description)
        NSLog([NSString stringWithUTF8String:log_msg], ((id(*)(id,SEL))original_description)(self, _cmd));
    id result = [NSString stringWithUTF8String:msg];

    VIRTUALIZER_END
    return result;
}

__attribute__((constructor))
static void load(void) {
    VIRTUALIZER_START

    VIRTUALIZER_STR_ENCRYPT_START
    const char *cls1 = "OriginalClass";
    const char *sel1 = "original_selector";
    const char *cls2 = "NSString";
    const char *sel2 = "description";
    VIRTUALIZER_STR_ENCRYPT_END

    swizzle_instance_method(cls1, sel1, my_description);
    original_description = swizzle_instance_method(cls2, sel2, my_description_chained);

    VIRTUALIZER_END
}