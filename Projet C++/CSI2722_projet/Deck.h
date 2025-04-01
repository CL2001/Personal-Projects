#ifndef DECK_H
#define DECK_H

#include <vector>
#include <ctime>
#include <fstream>
#include <iostream>
#include <random>
#include <algorithm>
#include "CardFactory.h"
#include <sstream>
using namespace std;


extern CardFactory* CARDFACTORY;

//Classe deck construit le deck du jeu
class Deck {
private:
    //Variable privé est un vecteur des cartes de la chaine
	vector<Card*> cards;

    //Fonction privé utilisé seulement dans le constructeur de deck mélange les cartes du jeu
	void shuffleDeck() {
        random_device aleatoire;
        mt19937 g(aleatoire());
        shuffle(cards.begin(), cards.end(), g);
	}
public:
    //Constructeur de deck, extrait les cartes de card factory et les mélange
    Deck() {
        cards = CARDFACTORY->getDeck();
        shuffleDeck();
    }

    //Retourne la carte du haut de deck et la supprime de deck. Renvoie nullptr si le deck est vide.
    Card* draw() {
        if (cards.empty()) return nullptr;

        Card* temp_card = cards.back();
        cards.pop_back();
        return temp_card;
    }

    //Surdéfinition de << utilisé dans la sauvegarde du fichier, imprime tout les cartes du deck
    friend ostream& operator<<(ostream& out, const Deck& deck) {
        out << "Contenue du Deck: " << endl;
        for (Card* card : deck.cards) {
            card->print(out);
        }
        return out;
    }

    /*
    Constructeur Deck à partir du fichier infile de sauvegarde. Lorsqu'une ancienne sauvegarde du jeu est chargé, ce constructeurs
    extrait la chaine désiré et la retourne dans la mémoire du system, en autre mots dans l'instance actif de table.
    */
    Deck(istream& infile, const CardFactory* card_factory) {
        string line;
        int line_number = 0;

        infile.clear();
        infile.seekg(0, std::ios::beg);
        while (getline(infile, line)) {
            line_number++;
            if (line_number == 18) {
                break;
            }
        }
        for (size_t i = 0; i < line.size(); ++i) {
            if (line[i] == 'B')       cards.push_back(new BlueCard());
            else if (line[i] == 'C')  cards.push_back(new ChiliCard());
            else if (line[i] == 'S')  cards.push_back(new StinkCard());
            else if (line[i] == 'G')  cards.push_back(new GreenCard());
            else if (line[i] == 's')  cards.push_back(new SoyCard());
            else if (line[i] == 'b')  cards.push_back(new BlackCard());
            else if (line[i] == 'R')  cards.push_back(new RedCard());
            else if (line[i] == 'g')  cards.push_back(new GardenCard());
            else {
                cout << "Erreur, mauvaise cartes a esssayer detre mis en jeu" << std::endl;
                exit(1);
            }
        }

    }

};

#endif
