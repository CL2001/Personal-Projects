package code

import (
	"fmt"
	"math"
	"math/rand"
	"sync"
	"time"
)

// Retourne un nombre premier
func isPrimeq3(v int64) bool {
	sq := int64(math.Sqrt(float64(v))) + 1
	var i int64
	for i = 2; i < sq; i++ {

		if v%i == 0 {
			return false
		}
	}
	return true
}

// Retourne un nombre premier aléatoire entre 0 et maxValue
func getPrime(maxValue int64) int64 {
	for {
		n := rand.Int63n(maxValue)
		if isPrimeq3(n) {
			return n
		}
	}
}

// Essaie de trouver des Prime special et les place dans le channel de sortie. La go routine continue
// jusqu'à ce que le channel stop soit fermer
func getSpecialPrimeStream(wg *sync.WaitGroup, stop <-chan bool, pattern int64, maxValue int64, nTrials int) <-chan int64 {
	outputIntStream := make(chan int64)
	wg.Add(1)
	go func() {
		defer wg.Done()
		defer close(outputIntStream)
		var div int64
		for div = 10; pattern/div != 0; div *= 10 {
		}

		for {
			select {
			case <-stop:
				return
			default:
				n := getPrime(maxValue)
				if n%div == pattern {
					outputIntStream <- n
				}
			}
		}
	}()
	return outputIntStream
}

// Main avec threads
func Main_q3() {
	fmt.Println("Question 3")

	var sp []int64

	var pattern int64 = 1111       // the suffix pattern we are looking for
	var maxV int64 = 1000000000000 // maximum value for the prime number
	var trials int = 3             // number of trials for each attempts
	var nPrimes int = 4            // number of special primes we want

	start := time.Now()

	// Initialise la variable wait group et le channel stop
	var wg sync.WaitGroup
	stop := make(chan bool)
	//defer close(stop)

	ch1 := getSpecialPrimeStream(&wg, stop, pattern, maxV, trials)
	ch2 := getSpecialPrimeStream(&wg, stop, pattern, maxV, trials)
	ch3 := getSpecialPrimeStream(&wg, stop, pattern, maxV, trials)
	ch4 := getSpecialPrimeStream(&wg, stop, pattern, maxV, trials)
	ch5 := getSpecialPrimeStream(&wg, stop, pattern, maxV, trials)
	ch6 := getSpecialPrimeStream(&wg, stop, pattern, maxV, trials)
	ch7 := getSpecialPrimeStream(&wg, stop, pattern, maxV, trials)
	ch8 := getSpecialPrimeStream(&wg, stop, pattern, maxV, trials)
	// Lit des channels et place les numéros dans sp jusqu'à ce que sp en aille 4
	for len(sp) < nPrimes {
		select {
		case number, ok := <-ch1:
			if ok && number != 0 {
				sp = append(sp, number)
			}
		case number, ok := <-ch2:
			if ok && number != 0 {
				sp = append(sp, number)
			}
		case number, ok := <-ch3:
			if ok && number != 0 {
				sp = append(sp, number)
			}
		case number, ok := <-ch4:
			if ok && number != 0 {
				sp = append(sp, number)
			}
		case number, ok := <-ch5:
			if ok && number != 0 {
				sp = append(sp, number)
			}
		case number, ok := <-ch6:
			if ok && number != 0 {
				sp = append(sp, number)
			}
		case number, ok := <-ch7:
			if ok && number != 0 {
				sp = append(sp, number)
			}
		case number, ok := <-ch8:
			if ok && number != 0 {
				sp = append(sp, number)
			}
		}
	}
	// Ferme le channel stop et ensuite attends que tous nos go routine soit terminer avant d'imprimer
	// les résultats
	close(stop)
	wg.Wait()

	end := time.Now()

	fmt.Println("Special prime numbers are: ", sp)
	fmt.Println("End of program.", end.Sub(start))

}
