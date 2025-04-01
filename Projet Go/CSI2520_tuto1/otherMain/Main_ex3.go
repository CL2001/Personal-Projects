package otherMain
import "fmt"
func Main_ex3() {
	scores := make([]int, 0, 5)
	c := cap(scores)
	fmt.Println(c)
	for i := 0; i < 25; i++ {
		scores = append(scores, i)
		if cap(scores) != c {
			c = cap(scores)
			fmt.Println(c)
		}
	}
}