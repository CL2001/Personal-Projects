/*
ex1
package main
import "fmt"

func main() {
	src := sendInt(10)
	dst := filterInt(src)
	for {
		i, stop := <-dst
		if stop {
			break;
		}
		fmt.Printf("%d ", i)
	}
}

func sendInt(maxNum int) (ch chan int) {
	defer fmt.Println("Sender ready!")
	ch = make(chan int)
		go func() {
		for i := 0; i < maxNum; i++ {
			ch <- i
		}
		close(ch)
	}()
	return
}

func filterInt(src <-chan int) (dst chan int) {
	defer fmt.Println("Filter ready!")
	dst = make(chan int)
	go func() {
		defer close(dst)
		open := true
		for open {
			var i int
			i, open = <-src
			if open {
				i *= 2
				dst <- i
			}
		}
	}()
	return
}
*/
//ex2
package main

import (
	"fmt"
	"math"
	"math/rand"
	"sync"
	"time"
)

func numbers(sz int) (res chan float64) {
	res = make(chan float64)
	go func() {
		defer close(res)
		num := 0.0
		// sleeping to simulate work...
		time.Sleep(time.Duration(rand.Intn(1000)) *
			time.Microsecond)
		for i := 0; i < sz; i++ {
			num += math.Sqrt(math.Abs(rand.Float64()))
		}
		num /= float64(sz)
		res <- num // send the result and stop
		return
	}()
	return
}

func main() {
	var nGo int
	rand.Seed(42)
	// user selected number of goroutines to be created
	fmt.Print("Number of Go routines: ")
	fmt.Scanf("%d \n", &nGo)
	// this is a slice of channels
	res := make([]chan float64, nGo)
	var wg sync.WaitGroup
	// creates the goroutines and get the channels
	for i := 0; i < nGo; i++ {
		res[i] = numbers(1000)
		wg.Add(1)
	}

	go func() {
		wg.Wait()
		for _, ch := range res {
			close(ch)
		}
	}()
	// This is sequential and hence not right
	//for i := range res {
	//for num := range res[i] {
	//fmt.Printf("Result %d: %f\n", i, num)
	//}
	//}

	// Suivi des channels déjà lus

	completedCount := 0
	for completedCount < nGo {
		for i := 0; i < nGo; i++ {
			select {
			case num, open := <-res[i]:
				if open {
					fmt.Printf("Result %d: %f\n", i, num)
					completedCount++
				}
			default:
				// Non-blocking default case to avoid deadlock
			}
		}
		//time.Sleep(100 * time.Millisecond)
	}
}
