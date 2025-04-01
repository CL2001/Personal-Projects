package otherMain
import "fmt"

type Rect struct {
	Width, Height int
   }
   func modifW (r Rect) {
	r.Width *= 2
   }
   func modifH (r *Rect) {
	r.Height *= 2
   }


   //Ce petit programme illustre le concept de passage par valeur et par adresse en Go
func Main_ex1(){
	fmt.Printf("Main_ex1\n")
	var r1 Rect
	r1.Width= 10
	r1.Height= 30
	r2 := Rect{7,3}
	r3 := new(Rect)
	r3.Width= 17
	r3.Height= 23
	fmt.Println("R1:", r1)
	fmt.Println("R2:", r2)
	fmt.Println("R3:", *r3)
	modifW(r1)
	modifH(&r2)
	modifH(r3)
	fmt.Println("\nR1:", r1)
	fmt.Println("R2:", r2)
	fmt.Println("R3:", *r3)
}
