package code

import (
	"fmt"
	"sync"
)

// Fonction afin de trouver le plus grand dénominateur commun
func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

// Synchronise utilisant un channel done
func Main_q1_1() {
	fmt.Println("Question 1 a)")
	defer fmt.Println("")
	x := []int{100, 15, 18, 10, 25, 90, 22, 60}
	y := []int{60, 5, 72, 5, 250, 108, 44, 3600}
	var z [8]int
	// Créer un channel de capacité équivalent à la longueur de z 
	done := make(chan bool, len(z))

	for i := range z {
		go func(i int) {
			z[i] = gcd(x[i], y[i])
			// Envoie true au channel done lorsque la sous routine est complété
			done <- true
		}(i)
	}

	// Ressort tous les valeur du channel une fois qu'elle sont lu
	// Ceci pause le programme jusqu'à ce que tous les valeurs qui seront inséré dans le channel en seront sorti
	for range z {
		<- done
	}

	// print result
	for _, v := range z {
		fmt.Println(v)
	}
}


// Synchronise utilisant un waitGroup
func Main_q1_2() {
	fmt.Println("Question 1 b)")
	defer fmt.Println("")
	x := []int{100, 15, 18, 10, 25, 90, 22, 60}
	y := []int{60, 5, 72, 5, 250, 108, 44, 3600}
	var z [8]int
	// Initialise le waitGroup
	var wg sync.WaitGroup

	// parallel loop
	for i := range z {
		// Ajoute un élément au waitGroup pour chaque itération de la boucle
		wg.Add(1)
		go func(i int) {
			z[i] = gcd(x[i], y[i])
			// Affiche cette itération comme étant terminé
			wg.Done()
		}(i)
	}

	// Pause jusqu'à ce que tous les waitGroups soient terminé
	wg.Wait()

	// print result
	for _, v := range z {
		fmt.Println(v)
	}
}