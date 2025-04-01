/*
package main

import (
	"fmt"
)

func numberGen(start int, count int, out chan<- int){
	for i := 0; i < count; i++ {
		out <- (i+start)
	}
	close(out)
}

func printNums(in <-chan int, done chan<- bool){
	for {
		value, ok := <- in
		if !ok {
			done<- true
			break;
		}
		fmt.Println(value)
	}
}


func main(){
	channel := make(chan int)
	done := make(chan bool)
	go numberGen(7, 14, channel)
	go printNums(channel, done)
	<-done
}
*/

package main
import "fmt"
import "time"
func tr(c chan int, w time.Duration) {
 i:=0
 for {
 time.Sleep(w)
 c <- i
 i++
 }
}
func main() {
 m1 := make(chan int)
 m2 := make(chan int)
 go tr(m1, 1*time.Second)
 go tr(m2, 1*time.Second)
 a:=time.After(5*time.Second)
 P1:
 for {
 select {
 case msg1 := <-m1:
 fmt.Println("received from m1 message", msg1)
 case msg2 := <-m2:
 fmt.Println("received from m2 message", msg2)
 case <-a:
 fmt.Println("Time out")
 break P1
 }
 time.Sleep(time.Second)
 }
 close(m1)
 close(m2)
 time.Sleep(3*time.Second)
}