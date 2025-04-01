package main

import (
	"fmt"
)

type geometric_object interface{
	area() int
	perim() int
}

type rect struct {
	width, height int
}

type square struct{
	len int
}

func (r *rect) area() int {
	return r.height * r.width
}

func (r *rect) perim() int {
	return r.height * 2 + r.width * 2
}

func (s *square) area() int {
	return s.len * s.len
}

func (s *square) perim() int {
	return s.len * 4
}

type Personne struct {
	Nom string
	Prenom string
   }
func (p *Personne) Bonjour() {
	fmt.Printf("Bonjour, Je suis %s %s\n", p.Prenom, p.Nom)
   }
type Employé struct {
	Personne
	Salaire float32
   }

func main(){
	geo_arr := make([]geometric_object, 0)
	r1 := &rect{5, 6}
	r2 := &rect{7, 8}
	s1 := &square{4}
	s2 := &square{5}
	geo_arr = append(geo_arr, r1)
	geo_arr = append(geo_arr, r2)
	geo_arr = append(geo_arr, s1)
	geo_arr = append(geo_arr, s2)

	for i, geo := range geo_arr{
		fmt.Println("Object ", i)
		fmt.Println("Area:", geo.area())
		fmt.Println("Perim:", geo.perim())
	}


	p1 := Personne{"Cesar", "Jules"}
	p1.Bonjour()
	p2 := &Employé{Personne{"Gates","Bill"}, 15.25}
	p2.Bonjour()

}