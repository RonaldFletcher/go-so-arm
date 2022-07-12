package main

import "fmt"
import "errors"

/*
#cgo LDFLAGS: -ldl
#include <dlfcn.h>

// function pointer type
typedef signed char GoInt8;
typedef int (*TwoSum)(int,int);
// wrapper function
int TwoSumCall(void* f, int a,int b) {
  return ((TwoSum) f)(a,b);
}
*/
import "C"

func TwoSum(a, b int) (int, error) {

	handler := C.dlopen(C.CString("/Users/wangrui/go/src/go-so-arm/dlopen/lib/libnumber.so"), C.RTLD_LAZY)
	funcPtr := C.dlsym(handler, C.CString("TwoSum"))
	result, err := C.TwoSumCall(funcPtr, C.int(a), C.int(b))
	if err != nil {
		return 0, errors.New(fmt.Sprintf("TwoSumCall return %v, err: %v", result, err))
	}
	return int(result), nil

}
func main() {
	v, _ := TwoSum(2, 13)
	fmt.Printf("TwoSum func value:%d \n", v)

}
