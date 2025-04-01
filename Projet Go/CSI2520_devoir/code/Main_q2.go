package code

import (
	"fmt"
	"math"
	"sync"
)

// Retourne true is un nombre est premier
func isPrime(v int64) bool {

	sq := int64(math.Sqrt(float64(v))) + 1
	var i int64

	for i = 2; i < sq; i++ {

		if v%i == 0 {
			return false
		}
	}

	return true
}

// Génère des int dans le channel de sortie
func intGenerator(wg *sync.WaitGroup, stop <-chan bool) <-chan int64 {

	intStream := make(chan int64)

	go func() {
		defer func() { wg.Done() }()
		defer close(intStream)
		defer fmt.Println("End of intGenerator...")

		var i int64

		for {
			i++
			select {
			case <-stop:
				return
			case intStream <- i:
			}
		}
	}()

	return intStream
}

// Prend un channel comme entrée et génère le nombre de Mercenne de chaque int qui est un nombre premier
// Ce nombre est retourner dans le channel de sortie. Ceci agit donc comme un pipeline
func findPrimeMercenne(wg *sync.WaitGroup, stop <-chan bool, inputIntstream <-chan int64) <-chan int64 {
	outputIntStream := make(chan int64)

	go func() {
		defer wg.Done()
		defer close(outputIntStream)
		defer fmt.Println("End of findPrimeMercenne...")
		for num := range inputIntstream{
			select {
			case <-stop:
				return
			default:
				if isPrime(num) {
					mercenneNum := int64(math.Pow(2.0, float64(num)))
					select {
					case <-stop:
						return
					case outputIntStream <- mercenneNum:
					}
					

				}
			}
		}
	}()

	return outputIntStream

}

// Prend une pipeline comme entrée et insert que n int dans la pipeline de sorti
func takeN(wg *sync.WaitGroup, stop <-chan bool, inputIntstream <-chan int64, n int) <-chan int64 {

	outputIntStream := make(chan int64)

	go func() {
		defer func() { wg.Done() }()
		defer close(outputIntStream)
		defer fmt.Println("End of takeN...")
		for i := 0; i < n; i++ {
			select {
			case <-stop:
				return
			case outputIntStream <- <-inputIntstream:
			}
		}
	}()

	return outputIntStream
}

func Main_q2() {
	fmt.Println("Question 2")
	defer fmt.Println("")
	stop := make(chan bool)
	var wg sync.WaitGroup
	wg.Add(3)

	intChannel := intGenerator(&wg, stop)
	mercenneNumCh := findPrimeMercenne(&wg, stop, intChannel)
	mercenneNumCh15 := takeN(&wg, stop, mercenneNumCh, 15)

	
	for mercenne := range mercenneNumCh15 {
		fmt.Printf("%d\n", mercenne)
	}
	close(stop)
	wg.Wait()

	
}
