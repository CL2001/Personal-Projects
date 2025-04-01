/*
    Christophe Lanouette 300171137
*/

import java.util.ArrayList;

/**
 * Représente un utilisateur du système de recommandation.
 * Chaque utilisateur possède un identifiant unique et des listes de films qu'il a aimés ou non.
 */
public class User {
    private int userID; // Identifiant unique de l'utilisateur
    private ArrayList<Integer> liked_movies_id; // Liste des identifiants des films aimés
    private ArrayList<Integer> disliked_movies_id; // Liste des identifiants des films non aimés

    /**
     * Constructeur de la classe User.
     * Initialise un utilisateur avec son identifiant et crée des listes vides pour ses films aimés et non aimés.
     *
     * @param id Identifiant unique de l'utilisateur.
     */
    public User(int id) {
        this.userID = id;
        this.liked_movies_id = new ArrayList<>();
        this.disliked_movies_id = new ArrayList<>();
    }

    /**
     * Ajoute un film à la liste des films aimés ou non aimés en fonction de sa note.
     * Un film est considéré comme "aimé" si sa note est supérieure ou égale au seuil défini dans CONSTANTS.R.
     * Sinon, il est ajouté à la liste des films non aimés.
     *
     * @param movie_id      Identifiant du film.
     * @param movie_ranking Note attribuée au film par l'utilisateur.
     */
    public void addMovie(int movie_id, double movie_ranking) {
        if (movie_ranking >= CONSTANTS.R) {
            liked_movies_id.add(movie_id);
        } else {
            disliked_movies_id.add(movie_id);
        }
    }

    /**
     * Retourne la liste des films aimés par l'utilisateur.
     *
     * @return Liste des identifiants des films aimés.
     */
    public ArrayList<Integer> getLiked_movies_id() {
        return liked_movies_id;
    }

    /**
     * Retourne la liste des films non aimés par l'utilisateur.
     *
     * @return Liste des identifiants des films non aimés.
     */
    public ArrayList<Integer> getDisliked_movies_id() {
        return disliked_movies_id;
    }

    /**
     * Retourne l'identifiant unique de l'utilisateur.
     *
     * @return Identifiant de l'utilisateur.
     */
    public int getUserID() {
        return userID;
    }
}
