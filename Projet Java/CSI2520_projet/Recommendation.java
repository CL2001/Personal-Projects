/*
    Christophe Lanouette 300171137
*/

import java.util.ArrayList;
import java.util.HashSet;

/**
 * Classe permettant de calculer un score de recommandation pour un film donné
 * en fonction des préférences d'un utilisateur et des autres utilisateurs.
 */
public class Recommendation {
    private User user; // Utilisateur pour lequel la recommandation est faite
    private Movie movie; // Film à évaluer
    private ArrayList<User> users; // Liste de tous les utilisateurs
    private double score; // Score de recommandation calculé
    private int nUsers; // Nombre d'utilisateurs ayant aimé ce film

    /**
     * Constructeur de la classe Recommendation.
     * Initialise l'utilisateur, le film et la liste des utilisateurs,
     * puis calcule le score de recommandation du film.
     *
     * @param user  Utilisateur pour lequel la recommandation est effectuée.
     * @param movie Film à évaluer.
     * @param users Liste des utilisateurs pour l'analyse des préférences.
     */
    public Recommendation(User user, Movie movie, ArrayList<User> users) {
        this.user = user;
        this.movie = movie;
        this.users = users;
        this.nUsers = movie.getNumberLiked(); // Récupère le nombre d'utilisateurs ayant aimé le film
        this.score = calculateScore(); // Calcule le score de recommandation
    }

    /**
     * Calcule le score de recommandation du film pour l'utilisateur en fonction
     * des préférences des autres utilisateurs.
     *
     * @return Score de recommandation du film (plus il est élevé, plus le film est pertinent).
     */
    private double calculateScore() {
        // Vérifie si l'utilisateur a déjà vu ou noté ce film
        if (user.getLiked_movies_id().contains(movie.getID()) || user.getDisliked_movies_id().contains(movie.getID())) {
            return 0.0;
        }

        // Vérifie si le film a été aimé par suffisamment d'utilisateurs pour être recommandé
        if (nUsers < CONSTANTS.K) {
            return 0.0;
        }

        double score = 0.0;
        int num_liked = 0;

        // Compare l'utilisateur sélectionné avec les autres utilisateurs ayant aimé ce film
        for (User user_comp : users) {
            if (user_comp.getLiked_movies_id().contains(movie.getID()) && user_comp.getUserID() != user.getUserID()) {
                score += calculateSimilarity(user, user_comp);
                num_liked++;
            }
        }

        // Retourne le score moyen de similarité entre les utilisateurs
        return num_liked == 0 ? 0.0 : score / (double) num_liked;
    }

    /**
     * Calcule la similarité entre deux utilisateurs en fonction de leurs goûts communs.
     * Utilise l'indice de Jaccard pour mesurer la similarité.
     *
     * @param u1 Premier utilisateur.
     * @param u2 Deuxième utilisateur à comparer avec le premier.
     * @return Score de similarité entre les deux utilisateurs (entre 0 et 1).
     */
    private double calculateSimilarity(User u1, User u2) {
        // Ensemble des films aimés en commun
        HashSet<Integer> likedIntersection = new HashSet<>(u1.getLiked_movies_id());
        likedIntersection.retainAll(u2.getLiked_movies_id());

        // Ensemble des films non aimés en commun
        HashSet<Integer> dislikedIntersection = new HashSet<>(u1.getDisliked_movies_id());
        dislikedIntersection.retainAll(u2.getDisliked_movies_id());

        int intersectionLiked = likedIntersection.size();
        int intersectionDisliked = dislikedIntersection.size();

        // Ensemble total des films notés par les deux utilisateurs
        HashSet<Integer> unionSet = new HashSet<>(u1.getLiked_movies_id());
        unionSet.addAll(u1.getDisliked_movies_id());
        unionSet.addAll(u2.getLiked_movies_id());
        unionSet.addAll(u2.getDisliked_movies_id());

        int union = unionSet.size();

        // Si aucun film en commun, la similarité est nulle
        return union == 0 ? 0.0 : (intersectionLiked + intersectionDisliked) / (double) union;
    }

    /**
     * Retourne le score de recommandation du film.
     *
     * @return Score de recommandation calculé.
     */
    public double getScore() {
        return score;
    }
}
