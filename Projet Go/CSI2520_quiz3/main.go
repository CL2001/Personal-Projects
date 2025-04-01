package main

    import (
        "fmt"
        "sync"
    )

    func process(x, y int) int {
      r := x + y
      return r
    }

    func main() {
		//Créé la variable wg
		var wg sync.WaitGroup
        arr1 := []int{40, 15, 22, 32}
        arr2 := []int{14, 21, 30, 44}

        for i := 0; i < 4 ; i++ {
			//Ajoute un wait group a chaque boucle
			wg.Add(1)
			go func(idx int) {
				fmt.Println(arr1[idx],"+", arr2[idx])
				arr2[idx] =process(arr1[idx],arr2[idx])
				//Affiche le wait group comme étant terminé
				wg.Done()
			}(i)
        }
		//Attend que tout les wait groups soivent terminé
		wg.Wait()
        fmt.Println("arr1=",arr1)
        fmt.Println("arr2=",arr2)
    }