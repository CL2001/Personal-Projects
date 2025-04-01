#ifndef HAND_H
#define HAND_H

#include <vector>
#include <iostream>
#include <sstream>
using namespace std;


class Hand {
private:
	//Variable privé est un vecteur des cartes de la chaine
	vector<Card*> cards;
public:

	//Constructeur par défault de Hand
	Hand() = default;

	//Retourne le nombre du cartes dans la mains
	int getNumCards() {
		return cards.size();
	}

	//Surdéfinition de l'opérateur += afin d'ajouté des cartes dans la main
	Hand& operator+=(Card* card) {
		cards.push_back(card);
		return *this;
	}

	//Joue la première cartes de la main en la retournant et l'effaçant de la main
	Card* play() {
		Card* temp_card = cards[0];
		vector<Card*> new_cards;
		for (int i = 1; i < cards.size(); i++) {
			new_cards.push_back(cards[i]);
		}
		cards.clear();
		cards = new_cards;
		return temp_card;
	}

	//Retourne la carte du haut sans l'effacer
	Card* top() {
		return cards[0];
	}

	//Surdéfinition de l'opérateur [] utilisé pour chosir une carte spécifique dans la main du joeur
	Card* operator[] (int num) {
		Card* temp_card = cards[num];
		vector<Card*> new_cards;
		for (int i = 0; i < cards.size(); i++) {
			if(i != num)
				new_cards.push_back(cards[i]);
		}
		cards.clear();
		cards = new_cards;
		return temp_card;
	}

	//Surdéfintion de l'opérateur << utilisé pour imprimer le contenu de la main
	friend ostream& operator<<(ostream& out, const Hand& hand) {
		out << "Cartes dans la main sont: ";
		for (int i = 0; i < hand.cards.size(); i++) {
			hand.cards[i]->print(out);
			cout << " ";
		}
		out << endl;
		return out;
	}

	/*
	Constructeur Hand à partir du fichier infile de sauvegarde. Lorsqu'une ancienne sauvegarde du jeu est chargé, ce constructeurs
	extrait la chaine désiré et la retourne dans la mémoire du system, en autre mots dans l'instance actif de table.
	*/
	Hand(istream& infile, const CardFactory* card_factory, int player_number) {
		string line;
		int line_number = 0;
		string cards_str;

		infile.clear();
		infile.seekg(0, std::ios::beg);
		while (getline(infile, line)) {
			line_number++;
			if (line_number == 19 && player_number == 0) {
				string word1, word2, word3, word4, word5;
				istringstream iss(line);
				iss >> word1 >> word2 >> word3 >> word4 >> word5 >> cards_str;
				break;
			}
			else if (line_number == 21 && player_number == 1) {
				string word1, word2, word3, word4, word5;
				istringstream iss(line);
				iss >> word1 >> word2 >> word3 >> word4 >> word5 >> cards_str;
				break;
			}
		}
		for (size_t i = 0; i < cards_str.size(); ++i) {
			if (cards_str[i] == 'B')       cards.push_back(new BlueCard());
			else if (cards_str[i] == 'C')  cards.push_back(new ChiliCard());
			else if (cards_str[i] == 'S')  cards.push_back(new StinkCard());
			else if (cards_str[i] == 'G')  cards.push_back(new GreenCard());
			else if (cards_str[i] == 's')  cards.push_back(new SoyCard());
			else if (cards_str[i] == 'b')  cards.push_back(new BlackCard());
			else if (cards_str[i] == 'R')  cards.push_back(new RedCard());
			else if (cards_str[i] == 'g')  cards.push_back(new GardenCard());
			else {
				cout << "Erreur, mauvaise cartes a esssayer detre mis en jeu" << std::endl;
				exit(1);
			}
		}
	}
};


#endif