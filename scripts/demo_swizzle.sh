#!/bin/bash

echo "=============================================="
echo "  Method Swizzling Demo with Code Virtualizer"
echo "=============================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Test 1: Run without swizzling
echo -e "${YELLOW}Test 1: Running test_swizzle_arm64 WITHOUT dylib injection${NC}"
echo "Command: ./test_swizzle_arm64"
echo ""
"$DIR/test_swizzle_arm64"
echo ""
echo "---"
echo ""

# Test 2: Run with swizzling
echo -e "${YELLOW}Test 2: Running test_swizzle_arm64 WITH dylib injection${NC}"
echo "Command: DYLD_INSERT_LIBRARIES=./libswizzle_arm64.dylib ./test_swizzle_arm64"
echo ""
DYLD_INSERT_LIBRARIES="$DIR/libswizzle_arm64.dylib" "$DIR/test_swizzle_arm64"
echo ""
echo "---"
echo ""