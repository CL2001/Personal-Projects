//Exercise 1
/*
package main
import ("fmt"
		"math")

func round_high_low(num float32) (ceiling int, floor int){
	ceiling = int(math.Ceil(float64(num)))
	floor = int(math.Floor(float64(num)))
	return
}


func main(){
    var fnum float32
	fnum = 9.6372
	var ceil int
	var floor int
	ceil, floor = round_high_low(fnum)
	fmt.Printf("Ceil = %d Floor = %d\n", ceil, floor)
}
*/

//Exercise 2
/*
package main
import "fmt"


func main(){
	original_slice := []int{1, -4, 6, -3, 2, -5, -8, -9, 1, 23, 145, 12, -3, 9, -5}
	var output_slice []int
	for _, val := range original_slice{
		if val >= 0{
			output_slice = append(output_slice, val)
		}
	}

	fmt.Printf("Slice: [")
	for _, val := range output_slice{
		fmt.Printf(" %d ", val)
	}
	fmt.Printf("]\n")

}
*/

// Excercise 3

package main
import (
	"fmt"
	"strings"
	"strconv"
	"bufio"
	"os"
)

type Person struct {
	lastName string
	firstName string
	birthDay int // a number between 1 and 31
	birthMonth int // a number between 1 and 12
	birthYear int
	ID string
   }
   
func genID(personne_adr *Person) string{
	return personne_adr.lastName[0:3] + string(personne_adr.firstName[0]) + strconv.Itoa(personne_adr.birthYear) + strconv.Itoa(personne_adr.birthMonth)+ strconv.Itoa(personne_adr.birthDay)
}

func main(){
	reader := bufio.NewReader(os.Stdin)

	fmt.Printf("Votre nom? \n")
	nom, _ := reader.ReadString('\n')
	nom = strings.TrimSpace(nom)

	fmt.Printf("Votre date de naissance? \n")
	date, _ := reader.ReadString('\n')
	date = strings.TrimSpace(date)

	var personne Person

	nom_arr := strings.Split(nom, " ")
	personne.firstName = nom_arr[0]
	personne.lastName = nom_arr[1]

	birth_day, err := strconv.Atoi(date[0:2])
	if err != nil {
		fmt.Println("Error:", err)
		return
	}
	personne.birthDay = birth_day

	birth_month, err := strconv.Atoi(date[3:5])
	if err != nil {
		fmt.Println("Error:", err)
		return
	}
	personne.birthMonth = birth_month

	birth_year, err := strconv.Atoi(date[6:10])
	if err != nil {
		fmt.Println("Error:", err)
		return
	}
	personne.birthYear = birth_year

	personne.ID = genID(&personne)

	fmt.Printf("Nom: %s\n", personne.firstName)
	fmt.Printf("Nom de famille: %s\n", personne.lastName)
	fmt.Printf("Jour: %d\n", personne.birthDay)
	fmt.Printf("Mois: %d\n", personne.birthMonth)
	fmt.Printf("Année: %d\n", personne.birthYear)
	fmt.Printf("ID: %s\n", personne.ID)
}
