#include "Include.h"
#include <iostream>
using namespace std;

/*
    Variable constante
*/
const string PLAYER_NAME1 = "Christophe";
const string PLAYER_NAME2 = "Maro";
const string FILENAME = "GAMESAVE.txt";
CardFactory* CARDFACTORY = CardFactory::getFactory();


int main() {
    //Demande si une reprise d'un jeu est voulu
    bool play_save = false;
    do {
        cout << "Voulez-vous jouer un jeu sauvegarde? (oui/non): ";
        string response;
        cin >> response;

        for (auto& c : response) {
            c = tolower(c);
        }

        if (response == "oui") {
            play_save = true;
            break;
        }
        else if (response == "non") {
            play_save = false;
            break;
        }
        else {
            cout << "Entree invalide. Veuillez repondre par 'oui' ou 'non'." << endl;
        }
        cin.clear();
        cin.ignore(numeric_limits<streamsize>::max(), '\n');

    } while (true);

    Table table(PLAYER_NAME1, PLAYER_NAME2);

    if (play_save) {
        try {
            ifstream INFILE(FILENAME);
            Table new_table(INFILE, CARDFACTORY);
            table = new_table;
        }
        catch(exception& e){
            cerr << "Error loading saved game: " << e.what() << endl;
        }
    }
    


    //Donner 5 cartes dans la main de chaque joeur du deck
    for (int i = 0; i < 5; i++) {
        table.getPlayers()[0].getHand() += table.getDeck().draw();
        table.getPlayers()[1].getHand() += table.getDeck().draw();
    }

    //While there are still cards on the Deck (break later if there are none)
    while (true) {
        for (auto& player : table.getPlayers()) { //For each Player

            //Display Table
            cout << "Tour de " << player.getName() << " a jouer" << endl;
            cout << table << endl;
            cout << player.getHand() << endl;

            //Player draws top card from Deck
            Card* card = table.getDeck().draw();
            if (!card) {
                cout << "Il n'y a plus de cartes dans le deck, le jeu est terminé" << endl;
                if (table.getPlayers()[0].getNumCoins() > table.getPlayers()[0].getNumCoins()) {
                    cout << "Victoire de " << table.getPlayers()[0].getName() << endl;
                }
                else {
                    cout << "Victoire de " << table.getPlayers()[1].getName() << endl;
                }
                return 0;
            }
            player.getHand() += card;
 

            //If TradeArea is not empty
                //Add bean cards from the TradeArea to chains or discard them.
            for (int i = 0; i < table.getTradeArea().numCards(); i++) {
                bool added_to_chain = false;
                Card* trade_card = table.getTradeArea().removeTopCard();
                for (int i = 0; i < player.getMaxNumChains(); i++) {
                    if (player[i]->isEmpty()) {
                        continue;
                    }
                    try {
                        *player[i] += trade_card;
                        added_to_chain = true;
                    }
                    catch (const IllegalType& e) {
                        continue;
                    }
                }
                if (!added_to_chain) {
                    table.getDiscardPile() += trade_card;
                }
                    
            }

            

            for (int i = 0; i < 2; i++) {
                //Play topmost card from Hand 
                Card* play_card = player.getHand().play();

                bool card_added = false;
                for (int j = 0; j < player.getMaxNumChains(); j++) {
                    try {
                        *player[j] += play_card;
                        card_added = true;
                        break;
                    }
                    catch (const IllegalType& e) {
                        continue;
                    }
                }
                if (!card_added) {
                    int chain_number = 0;
                    do {
                        cout << table << endl;
                        cout << player.getHand() << endl;
                        cout << "Choisir un chaine a vendre entre 1 et " << player.getMaxNumChains() << " ";
                        cin >> chain_number;

                        if (cin.fail() || chain_number < 1 || chain_number > player.getMaxNumChains()) {
                            cin.clear();
                            cin.ignore(numeric_limits<streamsize>::max(), '\n');
                            cout << "Entree invalide" << endl;
                        }
                        else {
                            break;
                        }
                    } while (true);

                    player += player[chain_number - 1]->sell();
                    *player[chain_number - 1] += play_card;
                }

                //If chain is ended, cards for chain are removed and player receives coin(s).
                int chain_number = 0;
                do {
                    cout << table << endl;
                    cout << player.getHand() << endl;
                    cout << "Choisir un chaine a vendre entre 1 et " << player.getMaxNumChains() << " ou 0 pour aucune ";
                    cin >> chain_number;

                    if (cin.fail() || chain_number < 0 || chain_number > player.getMaxNumChains()) {
                        cin.clear();
                        cin.ignore(numeric_limits<streamsize>::max(), '\n');
                        cout << "Entree invalide" << endl;
                    }
                    else {
                        break;
                    }
                } while (true);

                if (chain_number > 0) {
                    player += player[chain_number - 1]->sell();
                }



                //If player decides to
                if (i == 1) {
                    break;
                }
                bool repeat = false;
                do {
                    cout << table << endl;
                    cout << player.getHand() << endl;
                    cout << "Voulez-vous rejouer une carte de votre main? (oui/non): ";
                    string response;
                    cin >> response;

                    for (auto& c : response) {
                        c = tolower(c);
                    }

                    if (response == "oui") {
                        repeat = true;
                        break;
                    }
                    else if (response == "non") {
                        repeat = false;
                        break;
                    }
                    else {
                        cout << "Entree invalide. Veuillez repondre par 'oui' ou 'non'." << endl;
                    }
                    cin.clear();
                    cin.ignore(numeric_limits<streamsize>::max(), '\n');

                } while (true);

                if (!repeat) {
                    break;
                }
            }




            //If player decides to Show the player's full hand and player selects an arbitrary card and Discard the arbitrary card from the player's hand and place it on the discard pile.
            bool show_game = false;
            do {
                cout << table << endl;
                cout << player.getHand() << endl;
                cout << "Voulez-vous montrer votre jeu et discarter une carte? (oui/non): ";
                string response;
                cin >> response;

                for (auto& c : response) {
                    c = tolower(c);
                }

                if (response == "oui") {
                    show_game = true;
                    break;
                }
                else if (response == "non") {
                    show_game = false;
                    break;
                }
                else {
                    cout << "Entree invalide. Veuillez repondre par 'oui' ou 'non'." << endl;
                }
                cin.clear();
                cin.ignore(numeric_limits<streamsize>::max(), '\n');

            } while (true);

            if (show_game) {
                cout << player.getHand() << endl;
                int cards_in_hand = 0;
                do {
                    cout << table << endl;
                    cout << player.getHand() << endl;
                    cout << "Choisir une carte a discarter entre 1 et " << player.getHand().getNumCards() << " ";
                    cin >> cards_in_hand;

                    if (cin.fail() || cards_in_hand < 1 || cards_in_hand > player.getHand().getNumCards()) {
                        cin.clear();
                        cin.ignore(numeric_limits<streamsize>::max(), '\n');
                        cout << "Entree invalide" << endl;
                    }
                    else {
                        break;
                    }
                } while (true);

                table.getDiscardPile() += player.getHand()[cards_in_hand - 1];
            }


            //Draw three cards from the deck and place cards in the trade area
            for (int i = 0; i < 3; i++) {
                Card* card = table.getDeck().draw();
                if (!card) {
                    cout << "Il n'y a plus de cartes dans le deck, le jeu est terminé" << endl;
                    if (table.getPlayers()[0].getNumCoins() > table.getPlayers()[0].getNumCoins()) {
                        cout << "Victoire de " << table.getPlayers()[0].getName() << endl;
                    }
                    else {
                        cout << "Victoire de " << table.getPlayers()[1].getName() << endl;
                    }
                    return 0;
                }
                table.getTradeArea() += card;
            }


            //while top card of discard pile matches an existing card in the trade area 
            //  draw the top - most card from the discard pile and place it in the trade area
            while (true) {
                Card* discard_card = table.getDiscardPile().top();
                if (discard_card == nullptr) {
                    break;
                }
                else if (table.getTradeArea().legal(discard_card)) {
                    table.getTradeArea() += table.getDiscardPile().pickUp();
                }
                else {
                    break;
                }
            }


            //for all cards in the trade area
            //  if player wants to chain the card
            //      chain the card.
            //  else
            //      card remains in trade area for the next player.
            while (true) {
                bool chaine_carte = false;
                if (table.getTradeArea().numCards() == 0) {
                    break;
                }
                do {
                    cout << table << endl;
                    cout << player.getHand() << endl;
                    cout << "Voulez-vous prendre une carte du trading area et la mettre dans votre chaine? (oui/non): ";
                    string response;
                    cin >> response;

                    for (auto& c : response) {
                        c = tolower(c);
                    }

                    if (response == "oui") {
                        chaine_carte = true;
                        break;
                    }
                    else if (response == "non") {
                        chaine_carte = false;
                        break;
                    }
                    else {
                        cout << "Entree invalide. Veuillez repondre par 'oui' ou 'non'." << endl;
                    }
                    cin.clear();
                    cin.ignore(numeric_limits<streamsize>::max(), '\n');

                } while (true);

                if (!chaine_carte) {
                    break;
                }

                int card_number = 0;
                do {
                    cout << "Choisir un carte a prendre entre 1 et " << table.getTradeArea().numCards() << " ";
                    cin >> card_number;

                    if (cin.fail() || card_number < 1 || card_number > table.getTradeArea().numCards()) {
                        cin.clear();
                        cin.ignore(numeric_limits<streamsize>::max(), '\n');
                        cout << "Entree invalide" << endl;
                    }
                    else {
                        break;
                    }
                } while (true);


                int chain_number = 0;
                do {
                    cout << "Choisir un chaine a ajoute la carte entre 1 et " << player.getMaxNumChains() << " ";
                    cin >> chain_number;

                    if (cin.fail() || chain_number < 1 || chain_number > player.getMaxNumChains()) {
                        cin.clear();
                        cin.ignore(numeric_limits<streamsize>::max(), '\n');
                        cout << "Entree invalide" << endl;
                    }
                    else {
                        break;
                    }
                } while (true);

                Card* carte_trade_area = table.getTradeArea()[card_number - 1];
                try {
                    *player[chain_number - 1] += carte_trade_area;
                }
                catch (const IllegalType& e) {
                    cout << "Ajout a la chaine manque: " << e.what() << endl;
                    table.getTradeArea() += carte_trade_area;

                    continue;
                }
            }


            //Draw two cards from Deck and add the cards to the player's hand (at the back).
            for (int i = 0; i < 2; i++) {
                Card* card = table.getDeck().draw();
                if (!card) {
                    cout << "Il n'y a plus de cartes dans le deck, le jeu est terminé" << endl;
                    if (table.getPlayers()[0].getNumCoins() > table.getPlayers()[0].getNumCoins()) {
                        cout << "Victoire de " << table.getPlayers()[0].getName() << endl;
                    }
                    else {
                        cout << "Victoire de " << table.getPlayers()[1].getName() << endl;
                    }
                    return 0;
                }
                player.getHand() += card;
            }


            //Buy third chain (note que dans les instructions une fois dit la troisieme chaine coute 3$ et l'autre 2$ donc on a choisi 2$)
            bool achete_chaine = false;
            if (player.getNumCoins() > 2 && player.getMaxNumChains() < 3) {
                do {
                    cout << table << endl;
                    cout << player.getHand() << endl;
                    cout << "Voulez-vous acheter une troisieme chaine? (oui/non): ";
                    string response;
                    cin >> response;

                    for (auto& c : response) {
                        c = tolower(c);
                    }

                    if (response == "oui") {
                        achete_chaine = true;
                        break;
                    }
                    else if (response == "non") {
                        achete_chaine = false;
                        break;
                    }
                    else {
                        cout << "Entree invalide. Veuillez repondre par 'oui' ou 'non'." << endl;
                    }
                    cin.clear();
                    cin.ignore(numeric_limits<streamsize>::max(), '\n');

                } while (true);

                if (achete_chaine) {
                    player.buyThirdChain();
                }
            }


            //Option de sauvegarder apres le jeu apres le tour du joueur 2
            if (player.getName() == table.getPlayers()[1].getName()) {
                bool save = false;
                do {
                    cout << "Voulez-vous sauvegarde le jeu? (oui/non): ";
                    string response;
                    cin >> response;

                    for (auto& c : response) {
                        c = tolower(c);
                    }

                    if (response == "oui") {
                        save = true;
                        break;
                    }
                    else if (response == "non") {
                        save = false;
                        break;
                    }
                    else {
                        cout << "Entree invalide. Veuillez repondre par 'oui' ou 'non'." << endl;
                    }
                    cin.clear();
                    cin.ignore(numeric_limits<streamsize>::max(), '\n');

                } while (true);

                if (save) {
                    ofstream OUTFILE(FILENAME, ios::trunc);
                    OUTFILE << table << endl;
                    OUTFILE << table.getDeck() << endl;
                    OUTFILE << table.getPlayers()[0].getHand() << endl;
                    OUTFILE << table.getPlayers()[1].getHand() << endl;
                    OUTFILE << table.getDiscardPile() << endl;
                    OUTFILE.close();
                    return 0;
                }
            }
            

            cout << "Fin du tour de " << player.getName() << endl;


        }
    }
    return 0;
    
}


