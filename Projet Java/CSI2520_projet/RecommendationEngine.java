/*
    Christophe Lanouette 300171137
*/

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Classe représentant le moteur de recommandation.
 * Cette classe charge les données des fichiers CSV et calcule les scores de recommandation des films
 * pour un utilisateur donné.
 */
public class RecommendationEngine {

    public ArrayList<Movie> movies; // Liste des films disponibles
    public ArrayList<User> users; // Liste des utilisateurs et leurs préférences

    /**
     * Constructeur du moteur de recommandation.
     * Il charge les films et les évaluations des utilisateurs depuis les fichiers CSV,
     * puis calcule les scores de recommandation des films pour l'utilisateur sélectionné et
     * les imprimes dans un document .txt
     *
     * @param user_selected_id Identifiant de l'utilisateur pour lequel générer des recommandations.
     * @param movieFile        Fichier contenant la liste des films.
     * @param ratingsFile      Fichier contenant les évaluations des utilisateurs.
     * @throws IOException            En cas d'erreur de lecture des fichiers.
     * @throws NumberFormatException  En cas de problème de format des données.
     */
    public RecommendationEngine(int user_selected_id, String movieFile, String ratingsFile) throws IOException, NumberFormatException {

        // Initialisation des listes des films et des utilisateurs
        movies = new ArrayList<>();
        readMovies(movieFile);
        users = new ArrayList<>();
        readRatings(ratingsFile);

        // Dictionnaire pour stocker le nombre de fois qu'un film a été aimé
        HashMap<Integer, Integer> likedMoviesCount = new HashMap<>();
        for (User user : users) {
            for (int movieId : user.getLiked_movies_id()) {
                likedMoviesCount.put(movieId, likedMoviesCount.getOrDefault(movieId, 0) + 1);
            }
        }

        // Mise à jour du nombre de "likes" pour chaque film
        for (Movie movie : movies) {
            int movieId = movie.getID();
            movie.setNumberLiked(likedMoviesCount.getOrDefault(movieId, 0));
        }

        // Recherche de l'utilisateur sélectionné à partir de son ID
        User user_selected = null;
        for (User user : users) {
            if (user.getUserID() == user_selected_id) {
                user_selected = user;
                break;
            }
        }

        // Calcul du score de recommandation pour chaque film en fonction des préférences des autres utilisateurs
        for (Movie movie : movies) {
            Recommendation recommendation = new Recommendation(user_selected, movie, users);
            movie.setMovie_user_score(recommendation.getScore());
        }

        // Tri des films par ordre décroissant de score
        movies.sort((m1, m2) -> Double.compare(m2.getMovie_user_score(), m1.getMovie_user_score()));

        // Affichage des recommandations pour l'utilisateur sélectionné
        System.out.println("Recommandations pour l'utilisateur #" + user_selected_id + ":");
        for (int i = 0; i < CONSTANTS.N; i++) {
            System.out.println(movies.get(i).toString());
        }
    }

    /**
     * Lecture des évaluations des utilisateurs depuis un fichier CSV.
     * Chaque utilisateur devient un objet `User`, et les films qu'il a notés sont ajoutés à sa liste.
     *
     * @param csvFile Fichier contenant les évaluations des utilisateurs.
     * @throws IOException            En cas d'erreur de lecture du fichier.
     * @throws NumberFormatException  En cas de problème de format des données.
     */
    public void readRatings(String csvFile) throws IOException, NumberFormatException {
        String line;
        String delimiter = ",";
        BufferedReader br = new BufferedReader(new FileReader(csvFile));
        line = br.readLine(); // Ignorer l'en-tête du fichier

        // Dictionnaire pour stocker les utilisateurs et éviter les doublons
        HashMap<Integer, User> userMap = new HashMap<>();

        while ((line = br.readLine()) != null && line.length() > 0) {
            String[] parts = line.split(delimiter);
            if (parts.length < 4) {
                throw new NumberFormatException("Erreur : ligne invalide : " + line);
            }

            int userId = Integer.parseInt(parts[0]); // ID de l'utilisateur
            int movieId = Integer.parseInt(parts[1]); // ID du film
            float rating = Float.parseFloat(parts[2]); // Note attribuée au film

            // Vérifier si l'utilisateur existe déjà ou le créer
            User user = userMap.getOrDefault(userId, new User(userId));
            userMap.putIfAbsent(userId, user);
            if (!users.contains(user)) users.add(user);

            // Ajouter le film et la note à l'utilisateur
            user.addMovie(movieId, rating);
        }

        br.close();
    }

    /**
     * Lecture de la liste des films depuis un fichier CSV.
     * Chaque film est transformé en un objet `Movie` et ajouté à la liste.
     *
     * @param csvFile Fichier contenant la liste des films.
     * @throws IOException            En cas d'erreur de lecture du fichier.
     * @throws NumberFormatException  En cas de problème de format des données.
     */
    public void readMovies(String csvFile) throws IOException, NumberFormatException {
        String line;
        String delimiter = ",";
        BufferedReader br = new BufferedReader(new FileReader(csvFile));
        line = br.readLine(); // Ignorer l'en-tête du fichier

        while ((line = br.readLine()) != null && line.length() > 0) {
            String[] parts = line.split(delimiter);
            if (parts.length < 3)
                throw new NumberFormatException("Erreur : ligne invalide : " + line);

            int movieID = Integer.parseInt(parts[0]); // ID du film
            String title = parts[1]; // Titre du film

            movies.add(new Movie(movieID, title));
        }
    }

    /**
     * Méthode principale pour exécuter le moteur de recommandation.
     * Charge les fichiers et génère les recommandations pour un utilisateur donné.
     *
     * @param args Arguments en ligne de commande (non utilisés ici).
     */
    public static void main(String[] args) {
        int user_selected = 387; // Identifiant de l'utilisateur à tester
        String movie_file = "movies.csv"; // Nom du fichier contenant les films
        String rating_file = "ratings.csv"; // Nom du fichier contenant les notes des utilisateurs

        try {
            RecommendationEngine rec = new RecommendationEngine(user_selected, movie_file, rating_file);
        } catch (Exception e) {
            System.err.println("Erreur lors de la lecture du fichier : " + e.getMessage());
        }
    }
}
