package otherMain
import (
	"fmt"
	"os"
		)

func Main_ex2() {
	file, err := os.Open("otherMain/pays.txt")
	if err != nil {
		panic(err)
	}
	defer file.Close()
	var (
		nom string
		population int
	)
   
   
	for {
		n,err := fmt.Fscan(file, &nom, &population)
   
		if (err==nil) {
			fmt.Println(n, nom, population)
		} else {
			break;
		}
	}
}