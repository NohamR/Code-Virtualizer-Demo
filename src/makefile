CC=gcc
INCLUDE_PATH=-I../../Include/C -I../../StealthMode/C/StealthCodeRegsArea

all: libswizzle_arm64 test_swizzle_arm64


libswizzle_arm64: swizzle.m
	$(CC) -dynamiclib -framework Foundation $(INCLUDE_PATH) -o libswizzle_arm64.dylib swizzle.m -arch arm64


test_swizzle_arm64: test_swizzle.m
	$(CC) -o test_swizzle_arm64 test_swizzle.m -framework Foundation -arch arm64


clean:
	rm -f *.o test_x86 test_x64 test_arm64 libswizzle_*.dylib test_swizzle_*