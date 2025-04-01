/*
    Christophe Lanouette 300171137
*/

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * Représente un film avec son identifiant, son titre et son score de recommandation.
 */
public class Movie {

    private int movieID; // Identifiant unique du film
    private String title; // Titre du film
    private int numberLiked; // Nombre d'utilisateurs ayant aimé ce film
    private double movie_user_score; // Score de recommandation du film pour un utilisateur donné

    /**
     * Constructeur de la classe Movie.
     * Initialise un film avec un identifiant et un titre.
     *
     * @param id    Identifiant du film.
     * @param title Titre du film.
     */
    public Movie(int id, String title) {
        this.movieID = id;
        this.title = title;
        this.numberLiked = 0; // Par défaut, aucun utilisateur n'a encore aimé ce film.
    }

    /**
     * Retourne le nombre d'utilisateurs ayant aimé ce film.
     *
     * @return Nombre d'utilisateurs qui ont aimé le film.
     */
    public int getNumberLiked() {
        return numberLiked;
    }

    /**
     * Met à jour le nombre d'utilisateurs ayant aimé ce film.
     *
     * @param numberLiked Nouveau nombre d'utilisateurs ayant aimé le film.
     */
    public void setNumberLiked(int numberLiked) {
        this.numberLiked = numberLiked;
    }

    /**
     * Retourne l'identifiant unique du film.
     *
     * @return Identifiant du film.
     */
    public int getID() {
        return movieID;
    }

    /**
     * Retourne le score de recommandation du film.
     *
     * @return Score de recommandation du film.
     */
    public double getMovie_user_score() {
        return movie_user_score;
    }

    /**
     * Met à jour le score de recommandation du film.
     * Le score est arrondi à 4 décimales pour plus de précision.
     *
     * @param movie_user_score Nouveau score de recommandation du film.
     */
    public void setMovie_user_score(double movie_user_score) {
        BigDecimal bd = new BigDecimal(movie_user_score).setScale(4, RoundingMode.HALF_UP);
        this.movie_user_score = bd.doubleValue();
    }

    /**
     * Retourne une représentation textuelle du film sous forme de chaîne de caractères.
     *
     * @return Chaîne représentant le film avec son identifiant, son titre, son score et son nombre de likes.
     */
    public String toString() {
        return "(" + movieID + "): " + title + " - Score: " + movie_user_score + " [" + numberLiked + "]";
    }
}
