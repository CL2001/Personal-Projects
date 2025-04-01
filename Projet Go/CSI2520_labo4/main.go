package main

import (
	"fmt"
	"math"
	"sync"
)

type Point struct {
	x int
	y int
}

type PtTree struct {
	pt          Point
	left, right *PtTree
}

func (t *PtTree) postOrder() {
	if t.left != nil {
		t.left.postOrder()
	}
	if t.right != nil {
		t.right.postOrder()
	}
	fmt.Printf("(%d,%d)", t.pt.x, t.pt.y)
}

func (t *PtTree) find(u, v int) bool {
	if t.pt.x == u && t.pt.y == v {
		return true
	}
	if t.left != nil && t.left.find(u, v) {
		return true
	}
	if t.right != nil && t.right.find(u, v) {
		return true
	}
	return false
}

func (t *PtTree) closest(u, v int) (closest Point, distPt float64) {
	p := Point{x: u, y: v}
	dist := distance(p, t.pt)

	closest = t.pt
	distPt = dist

	if t.left != nil {
		closestLeft, distPtLeft := t.left.closest(u, v)
		if distPtLeft < distPt {
			closest = closestLeft
			distPt = distPtLeft
		}
	}

	if t.right != nil {
		closestRight, distPtRight := t.right.closest(u, v)
		if distPtRight < distPt {
			closest = closestRight
			distPt = distPtRight
		}
	}

	return closest, distPt
}

func (t *PtTree) closestConcurrent(u int, v int, result chan struct{ Point; float64 }, wg *sync.WaitGroup) {
	defer wg.Done()

	if t == nil {
		return
	}

	p := Point{x: u, y: v}
	dist := distance(p, t.pt)

	// Send the current point and its distance to the channel
	result <- struct{ Point; float64 }{t.pt, dist}

	if t.left != nil {
		wg.Add(1)
		go t.left.closestConcurrent(u, v, result, wg)
	}
	if t.right != nil {
		wg.Add(1)
		go t.right.closestConcurrent(u, v, result, wg)
	}
}

func distance(pt1 Point, pt2 Point) float64 {
	d := float64(pt1.x-pt2.x)*float64(pt1.x-pt2.x) + float64(pt1.y-pt2.y)*float64(pt1.y-pt2.y)
	return math.Sqrt(d)
}

func main() {
	tree := PtTree{Point{2, 3},
		&PtTree{Point{5, 1},
			&PtTree{Point{2, 2}, nil, nil},
			&PtTree{Point{8, 3},
				&PtTree{Point{1, 6}, nil, nil}, nil}},
		&PtTree{Point{4, 7},
			&PtTree{Point{7, 2},
				&PtTree{Point{6, 4}, nil, nil},
				&PtTree{Point{0, 9}, nil, nil}},
			&PtTree{Point{3, 6}, nil, nil}}}

	// Postorder traversal
	tree.postOrder()
	fmt.Println("")

	// Finding a point in the tree
	u, v := 7, 2
	if tree.find(u, v) {
		fmt.Printf("Found: %d %d \n", u, v)
	} else {
		fmt.Printf("Not Found\n")
	}

	// Closest point (Sequential)
	x, y := 8, 6
	point_proche, distSeq := tree.closest(x, y)
	fmt.Printf("Point le plus proche à %d %d, à une distance de %f\n", point_proche.x, point_proche.y, distSeq)

	// Closest point (Concurrent)
	resultChan := make(chan struct{ Point; float64 })
	var wg sync.WaitGroup

	wg.Add(1)
	go tree.closestConcurrent(x, y, resultChan, &wg)

	// Close channel when all goroutines are done
	go func() {
		wg.Wait()
		close(resultChan)
	}()

	// Process results from the channel
	closest := Point{}
	minDist := math.Inf(1)

	for res := range resultChan {
		if res.float64 < minDist {
			minDist = res.float64
			closest = res.Point
		}
	}

	fmt.Printf("Concurrent - Point le plus proche à %d %d, à une distance de %f\n", closest.x, closest.y, minDist)
}
