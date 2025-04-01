package main
import "fmt"

type Point struct {
	x int
	y int
	}

type PtTree struct {
	pt Point
	left, right *PtTree
	}

func printPoint(p Point){
	fmt.Printf("Point: x = %d, y = %d\n", p.x, p.y)
}	

// 1 Fonction qui imprime le binary en post order
func (node *PtTree) postOrder(){
	if (node.left != nil){
		node.left.postOrder()
	}
	if (node.right != nil){
		node.right.postOrder()
	}
	printPoint(node.pt)
}


type PointSearcher interface {
	find(x int, y int) bool
}

func (node *PtTree) find(x int, y int) bool {
	if (node.left != nil){
		if (node.left.find(x, y)){
			return true
		}
	}
	if (node.right != nil){
		if (node.right.find(x, y)){
			return true
		}
	}
	if (node.pt.x == x && node.pt.y == y){
		return true
	}
	return false
}

func main() {
	tree := PtTree{Point{2, 3},
			&PtTree{Point{5,1},
			&PtTree{Point{2,2},nil,nil},
			&PtTree{Point{8,3},&PtTree{Point{1,6},nil,nil},nil}},
			&PtTree{Point{4,7},
			&PtTree{Point{7,2},
			&PtTree{Point{6,4},nil,nil},
			&PtTree{Point{0,9},nil,nil}},
			&PtTree{Point{3,6},nil,nil}}}

	tree.postOrder()
	fmt.Println("")
	var ps PointSearcher
	ps= &tree
	u, v := 7, 2

	if ps.find(u, v) {
		fmt.Printf("Found: %d %d \n", u, v)
	} else {
		fmt.Printf("Not Found\n")
	}

	x, y := 8, 6
	if ps.find(x, y) {
		fmt.Printf("Found: %d %d \n", u, v)
	} else {
		fmt.Printf("Not Found\n")
	}
		
}