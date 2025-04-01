/*
    Christophe Lanouette 300171137
*/

/**
 * Classe contenant des constantes globales utilisées dans le système de recommandation.
 * Ces constantes définissent les critères de recommandation des films.
 */
public class CONSTANTS {

    /**
     * Nombre minimum d'utilisateurs ayant aimé un film pour qu'il puisse être recommandé.
     * Si un film a été aimé par moins de `K` utilisateurs, il ne sera pas pris en compte.
     */
    public static final int K = 10;

    /**
     * Note minimale pour qu'un film soit considéré comme "bon".
     * Si un utilisateur attribue une note supérieure ou égale à `R`, le film est ajouté à sa liste de films aimés.
     */
    public static final double R = 3.5;

    /**
     * Nombre maximum de recommandations à générer pour un utilisateur.
     * Lorsqu'un utilisateur demande des recommandations, il recevra au maximum `N` films.
     */
    public static final int N = 20;
}
