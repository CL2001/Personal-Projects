package otherMain
import (
"fmt"
)
func Filter(s []int, fn func(int) bool) []int {
	var p []int // == nil
	for _, v := range s {
		if fn(v) {
			p = append(p, v)
		}
	}
	return p
}
func mult3(n int) bool {
	return n%3==0
}
func Main_ex4() {
	tab := [10]int{3,7,2,9,1,6,12,23,66,37}
	f := Filter(tab[:], mult3)
	fmt.Println(f)
}