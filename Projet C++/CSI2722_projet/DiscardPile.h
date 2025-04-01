#ifndef DISCARDPILE_H
#define DISCARDPILE_H

#include <vector>
#include <iostream>
#include <sstream>
using namespace std;


class DiscardPile {
private:
	//Variable privé est un vecteur des cartes de la chaine
	vector<Card*> cards;
public:

	//Constructeur par défault
	DiscardPile() = default;

	
	//Surdéfintion de l'opérateur += afin d'ajouté des cartes au discard pile
	DiscardPile& operator+=(Card* card) {
		cards.push_back(card);
		return *this;
	}

	//Retourne la carte du haut du discard pile et l'efface de lu vecteur cards
	Card* pickUp() {
		if (cards.empty()) return nullptr;

		Card* temp_card = cards.back();
		cards.pop_back();
		return temp_card;
	}

	//Retourne la carte du haut sans l'effacer du discard pile
	Card* top() {
		if (cards.empty()) return nullptr;

		return cards.back();
	}

	//Surdéfinition de l'opérateur <<, Seul la carte en haut du discard pile est imrpimé
	friend ostream& operator<<(ostream& out, const DiscardPile& discard_pile) {
		if(!discard_pile.cards.empty()) {
			out << "Carte du haut du discard pile est: ";
			discard_pile.cards.back()->print(out);
			out << endl;
		}
		else {
		 out << "Le discard pile est vide." << endl;
		}
		return out;
	}

	/*
	Constructeur DiscardPile à partir du fichier infile de sauvegarde. Lorsqu'une ancienne sauvegarde du jeu est chargé, ce constructeurs
	extrait la chaine désiré et la retourne dans la mémoire du system, en autre mots dans l'instance actif de table.
	*/
	DiscardPile(istream& infile, const CardFactory* card_factory) {
		string line;
		int line_number = 0;
		string cards_str;

		infile.clear();
		infile.seekg(0, std::ios::beg);
		while (getline(infile, line)) {
			line_number++;
			if (line_number == 13) {
				string word1, word2, word3, word4, word5, word6, word7;
				istringstream iss(line);
				iss >> word1 >> word2 >> word3 >> word4 >> word5 >> word6 >> word7 >> cards_str;
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