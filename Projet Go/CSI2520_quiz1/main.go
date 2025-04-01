package main

import "fmt"

// Boite
type Boite struct {
  poids float64
  couleur string
}

// methodes
func (p *Boite) SetCouleur(newCouleur string) {
  p.couleur = newCouleur
}

func (p Boite) GetCouleur() string {
  return p.couleur
}

func (p Boite) GetPoids() float64 {
  return p.poids
}

//Fonction doit prendre un pointeur de l'objet sinon elle modifie une copie, donc la modification 
//n'est pas reflété dans le programme principale
func (p *Boite) doublePoids() {
  p.poids*=2
}

func main() {

    var b = Boite{32.4, "jaune"}

    // on veut doubler le poids de la boite
	//Modifier le &b pour uniquement b car le compilateur sais prendre un pointeur de l'objet dans cette situation
    b.doublePoids()

    // on veut imprimer la couleur de la boite
    fmt.Printf("La couleur est: %s\n", b.GetCouleur())
    fmt.Printf("Le poids est: %f", b.GetPoids())
}