package main

import (
	"fmt"
	"time"
)

func main() {
    var st = []int{3,6,9,15,18,34,22,5,77,99,44}
    ch := sendPair(st)
	//Appel recevePair comme une fonction exécuté en parallèle avec le mot clé go
	go recevePair(ch)
	time.Sleep(1*time.Second)

}

/**
* Reçois le channel et imprime les données tant que le channel à des données. Une fois le channel vide, 
ok est mis à faux et le programme sort de la boucle
*/
func recevePair(ch chan int){
	var value int
	var ok bool
		for{
		value, ok = <- ch
		if (!ok){
			return
		}
		fmt.Printf("%d ", value)
	}
}

func sendPair(intArr []int) chan int {
    ch := make(chan int)

    go func() {  
     for _, k := range intArr {
      if k%2 == 0 {
        ch <- k
      }
     }
     close(ch)
    }()
    return ch
}