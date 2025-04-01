package main

import (
	"encoding/csv"
	"fmt"
	"log"
	"os"
	"runtime"
	"slices"
	"sort"
	"strconv"
	"sync"
	"time"
)

// Score mininal pour qu'un film soit considéré comme aimé
const iLiked float64 = 3.5

// Score minimal pour qu'un fil soit recommandé
const minLiked int = 10

// Nombre de recommendations à retourner
const nRecommendations int = 20

// Structure de données pour les recommandations
// userID: identifiant de l'utilisateur
// movieID: identifiant du film
// movieTitle: titre du film
// score: score de recommandation
// nUsers: nombre d'utilisateurs ayant vu ce film
type Recommendation struct {
	userID     int
	movieID    int
	movieTitle string
	score      float32
	nUsers     int
}

// Fonction pour obtenir le score de recommendation P(U,M)
func (r Recommendation) getProbLike() float32 {
	return r.score / (float32)(r.nUsers)
}

// Structure de données pour les utilisateurs
// userID: identifiant de l'utilisateur
// liked: liste des films aimés
// notLiked: liste des films non aimés
type User struct {
	userID   int
	liked    []int
	notLiked []int
}

// Fonction pour obtenir l'identifiant de l'utilisateur
func (u User) getUser() int {
	return u.userID
}

// Fonction pour définit l'identifiant de l'utilisateur
func (u *User) setUser(id int) {
	u.userID = id
}

// Fonction pour ajouté un film aimé à la liste des films aimés de l'utilisateur
func (u *User) addLiked(id int) {
	u.liked = append(u.liked, id)
}

// Fonction pour ajouté un film non aimé à la liste des films non aimés de l'utilisateur
func (u *User) addNotLiked(id int) {
	u.notLiked = append(u.notLiked, id)
}

// Fonction qui lit le fichier CSV des évaluations et traite chaque ligne.
// La sortie est une map dans laquelle l'identifiant de l'utilisateur est utilisé comme clé
func readRatingsCSV(fileName string) (map[int]*User, error) {
	file, err := os.Open(fileName)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	reader := csv.NewReader(file)

	_, err = reader.Read()
	if err != nil {
		return nil, err
	}

	users := make(map[int]*User, 1000)

	records, err := reader.ReadAll()
	if err != nil {
		return nil, err
	}

	for _, record := range records {
		if len(record) != 4 {
			return nil, fmt.Errorf("each line must contain exactly 4 integers, but found %d", len(record))
		}

		uID, err := strconv.Atoi(record[0])
		if err != nil {
			return nil, fmt.Errorf("error converting '%s' to userID integer: %v", record[0], err)
		}

		mID, err := strconv.Atoi(record[1])
		if err != nil {
			return nil, fmt.Errorf("error converting '%s' to movieID integer: %v", record[1], err)
		}

		r, err := strconv.ParseFloat(record[2], 64)
		if err != nil {

			return nil, fmt.Errorf("error converting '%s' to rating: %v", record[2], err)
		}

		u, ok := users[uID]
		if !ok {
			u = &User{uID, nil, nil}
			users[uID] = u
		}

		if r >= iLiked {
			u.addLiked(mID)
		} else {
			u.addNotLiked(mID)
		}
	}
	return users, nil
}

// Fonction qui lit le fichier CSV des films et traite chaque ligne.
func readMoviesCSV(fileName string) (map[int]string, error) {
	file, err := os.Open(fileName)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	reader := csv.NewReader(file)

	_, err = reader.Read()
	if err != nil {
		return nil, err
	}

	movies := make(map[int]string, 1000)

	records, err := reader.ReadAll()
	if err != nil {
		return nil, err
	}

	for _, record := range records {
		if len(record) != 3 {
			return nil, fmt.Errorf("each line must contain exactly 3 entries, but found %d", len(record))
		}

		mID, err := strconv.Atoi(record[0])
		if err != nil {
			return nil, fmt.Errorf("error converting '%s' to movieID integer: %v", record[1], err)
		}

		movies[mID] = record[1]
	}
	return movies, nil
}

// Fonction pour vérifier si une valeur est dans un ensemble
func member(value int, set []int) bool {
	for _, v := range set {
		if value == v {
			return true
		}
	}
	return false
}

// Fonction pour générer les recommandations sans score pour un utilisateur
// Cette fonction est la 1ère étape du pipeline
// Elle génère et retorune tous les recommandations pour un utilisateur donné
func generateMovieRec(wg *sync.WaitGroup, stop <-chan bool, userID int, titles map[int]string) <-chan Recommendation {
	outputStream := make(chan Recommendation)
	wg.Add(1)
	go func() {
		defer func() { wg.Done() }()
		defer close(outputStream)
		defer fmt.Println("Fin de generateMovieRec...")
		for k, v := range titles {
			select {
			case <-stop:
				return
			case outputStream <- Recommendation{userID, k, v, 0.0, 0}:
			}
		}
	}()

	return outputStream
}

// Fonction qui enlève tous les films déjà vus par l'utilisateur
// Cette fonction est la 2ième étape du pipeline
func removeSeenMovies(wg *sync.WaitGroup, stop <-chan bool, user User, inputRecommendation <-chan Recommendation) <-chan Recommendation {
	outputRecommendation := make(chan Recommendation)
	wg.Add(1)
	go func() {
		defer func() { wg.Done() }()
		defer close(outputRecommendation)
		defer fmt.Println("Fin de removeSeenMovies...")
		for recommendation := range inputRecommendation {
			select {
			case <-stop:
				return
			default:
				alreadySeen := false
				for _, likedMovieID := range user.liked {
					if recommendation.movieID == likedMovieID {
						alreadySeen = true
						break
					}
				}
				for _, notLikedMovieID := range user.notLiked {
					if recommendation.movieID == notLikedMovieID {
						alreadySeen = true
						break
					}
				}
				if !alreadySeen {
					outputRecommendation <- recommendation
				}
			}
		}
	}()

	return outputRecommendation
}

// Fonction qui enlève tous les films aimé par moins que
// Cette fonction est la 3ième étape du pipeline
func likeByKFilter(wg *sync.WaitGroup, stop <-chan bool, users map[int]*User, inputRecommendation <-chan Recommendation) <-chan Recommendation {
	outputRecommendation := make(chan Recommendation)
	wg.Add(1)
	go func() {
		defer func() { wg.Done() }()
		defer close(outputRecommendation)
		defer fmt.Println("Fin de likeByKFilter...")
		for recommendation := range inputRecommendation {
			select {
			case <-stop:
				return
			default:
				for _, user := range users {
					liked := slices.Contains(user.liked, recommendation.movieID)
					if liked {
						recommendation.nUsers++
					}
				}
				if recommendation.nUsers >= minLiked {
					outputRecommendation <- recommendation
				}
			}
		}
	}()

	return outputRecommendation
}

// Fonction qui donne une score de recommandation selon l'utilisateur à chaque recommandation
// Cette fonction est la 4ième étape du pipeline
func calculateScore(wg *sync.WaitGroup, stop <-chan bool, instances int, recUser User, users map[int]*User, inputRecommendation <-chan Recommendation) <-chan Recommendation {
	outputRecommendation := make(chan Recommendation)
	wg.Add(1)
	var internalWG sync.WaitGroup
	internalWG.Add(instances)

	for i := 0; i < instances; i++ {
		go func() {
			defer func() { internalWG.Done() }()
			for recommendation := range inputRecommendation {
				select {
				case <-stop:
					return
				default:
					var score float32 = 0.0
					for _, user := range users {
						if user.userID != recUser.userID && slices.Contains(user.liked, recommendation.movieID) {
							intersectLiked := 0
							for _, recUserLiked := range recUser.liked {
								for _, userLiked := range user.liked {
									if recUserLiked == userLiked {
										intersectLiked++
									}
								}
							}
							intersectNotLiked := 0
							for _, recUserNotLiked := range recUser.notLiked {
								for _, userNotLiked := range user.notLiked {
									if recUserNotLiked == userNotLiked {
										intersectNotLiked++
									}
								}
							}
							unionSlice := append([]int{}, recUser.liked...)
							unionSlice = append(unionSlice, recUser.notLiked...)
							unionSlice = append(unionSlice, user.liked...)
							unionSlice = append(unionSlice, user.notLiked...)

							// Use a map to remove duplicates.
							uniqueUnionSlice := make(map[int]struct{})
							for _, movieID := range unionSlice {
								uniqueUnionSlice[movieID] = struct{}{}
							}
							score += (float32(intersectLiked) + float32(intersectNotLiked)) / float32(len(uniqueUnionSlice))
						}
					}
					recommendation.score = score / float32(recommendation.nUsers)
					outputRecommendation <- recommendation

				}
			}
		}()
	}
	go func() {
		internalWG.Wait()
		close(outputRecommendation)
		wg.Done()
		fmt.Println("Fin de calculateScore...")
	}()

	return outputRecommendation
}

// Fonction qui prend les N meilleures recommandations
// Cette fonction est la dernière étape du pipeline
func topNRecommendations(inputRecommendation <-chan Recommendation) []Recommendation {
	var topNRecommendation []Recommendation

	for recommendation := range inputRecommendation {
		topNRecommendation = append(topNRecommendation, recommendation)
	}

	sort.Slice(topNRecommendation, func(i, j int) bool {
		return topNRecommendation[i].score > topNRecommendation[j].score
	})

	if len(topNRecommendation) > nRecommendations {
		return topNRecommendation[:nRecommendations]
	}

	return topNRecommendation
}

func main() {
	// Imprime le nombre de CPU utilisé
	fmt.Println("Number of CPUs:", runtime.NumCPU())

	// Demande à l'utilisateur de choisir qu'elle user est choisi
	var currentUser int
	fmt.Println("Recommendations for which user? ")
	fmt.Scanf("%d", &currentUser)
	fmt.Println("Recommendations for user ", currentUser)

	// Appel de la fonction pour lire et parser le fichier CSV des films.
	titles, err := readMoviesCSV("movies.csv")
	if err != nil {
		log.Fatal(err)
	}

	// Appel de la fonction pour lire et parser le fichier CSV des évaluations.
	users, err := readRatingsCSV("ratings.csv")
	if err != nil {
		log.Fatal(err)
	}

	// Syncronisation des threads
	stop := make(chan bool)
	var wg sync.WaitGroup

	// Début du chronomètre
	start := time.Now()

	// Appel de la fonction pour générer les recommandations pour un utilisateur
	recChannel1 := generateMovieRec(&wg, stop, currentUser, titles)

	// Appel de la fonction pour enlever les films déjà vus par l'utilisateur
	recChannel2 := removeSeenMovies(&wg, stop, *users[currentUser], recChannel1)

	// Appel de la fonction pour enlever les films qui n'ont pas assez de likes
	recChannel3 := likeByKFilter(&wg, stop, users, recChannel2)

	// Appel de la fonction pour trouver les score de chaque film selon l'utilisateur
	const instances = 2
	recChannel4 := calculateScore(&wg, stop, instances, *users[currentUser], users, recChannel3)

	// Appel de la fonction pour trouver les 20 meilleurs recommandations
	topNRecommendation := topNRecommendations(recChannel4)

	wg.Wait()
	close(stop)

	end := time.Now()

	// Imprime les 20 meilleurs recommandations
	fmt.Println("Top 20 recommendations for user ", currentUser)
	for _, recommendation := range topNRecommendation {
		fmt.Println("(", recommendation.movieID, "):", recommendation.movieTitle, "- Score:", recommendation.score, "[", recommendation.nUsers, "]")
	}

	fmt.Printf("\n\nExecution time: %s", end.Sub(start))

}
