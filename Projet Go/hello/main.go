// cd .\hello\ <- Entrée dans le directory hello
// go mod init hello <- Créer le fichier go.mod
/*
package main

import "fmt"

//Function to calculate factorial numbers
func factorial(num int) int {
    if num == 0 {
        return 1
    }
    return num * factorial(num-1)
}

func main(){
	fmt.Println("Hello World")
	fmt.Println(factorial(5)) // Output: 120
}

package main
import "fmt"
func main(){
    var i int
    i = 7
    fmt.Println("resultat=", i)
}

package main
import "fmt"
func main(){
    i := 9
    fct(&i)
    fmt.Println("resultat=", i)
}

func fct(x *int){
    *x = *x + 10
}
*/

package main

import (
	"fmt"
	"time"
)
func main(){
    var tableau = [8]int{10, 20, 30, 40, 50, 60, 70, 80}
    var val_g int
    for _, valeur := range tableau{
        val_g = valeur
        go func(){
            fmt.Printf("%d, ", val_g)
        }()
    }
    time.Sleep(1*time.Second)
    fmt.Printf("\n")
    for _, valeur := range tableau{
        go func(valeur int){
            fmt.Printf("%d,", valeur)
        }(valeur)
    }
    time.Sleep(1*time.Second)
}