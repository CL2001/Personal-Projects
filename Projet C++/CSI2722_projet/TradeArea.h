#ifndef TRADEAREA_H
#define TRADEAREA_H

#include <list>
#include <iostream>
#include <sstream>
using namespace std;


class TradeArea {
private:
	//Variable privé est un list des cartes de la chaine
	list<Card*> cards;
public:

	//Constructeur par défault
	TradeArea() = default;

	//Utilisé pour retirer la carte du haut du trade area
	Card* removeTopCard() {
		if (cards.size() == 0) { return nullptr; }
		Card* card = cards.back();
		cards.pop_back();
		return card;
	}

	//Surdéfinition de l'opérateur [] afin de choisir une carte spéficique dans la list
	//Cette fonction traverse la list double chainé
	Card* operator[](int num) {
		if (num < 0 || num >= cards.size()) {
			throw std::out_of_range("Index out of bounds.");
		}
		auto it = cards.begin();
		std::advance(it, num);
		Card* temp_card = *it;
		cards.erase(it);
		return temp_card;
	}

	//Surdéfition de l'opérateur += pour ajouté une carte au trade area
	TradeArea& operator+=(Card* card) {
		cards.push_back(card);
		return *this;
	}

	//Retoune vrai si une carte du type d'entrée se retrouve dans le trade area
	bool legal(Card* card) {
		for (auto i = cards.begin(); i != cards.end(); i++) {
			if (card->getName() == (*i)->getName()) {
				return true;
			}
		}
		return false;
	}

	//Échange un carte du trade area selon le nom de la carte
	Card* trade(const string card_name) {
		for (auto i = cards.begin(); i != cards.end(); i++) {
			if (card_name == (*i)->getName()) {
				Card* removed_card = *i;
				cards.erase(i);
				return removed_card;
			}
			else {
				i++;
			}
		}
		return nullptr;
	}

	//Retourne le nombre de cartes dans le trade area
	int numCards() {
		return cards.size();
	}

	//Surdéfintion de l'oprateur <<, imprime les cartes dans le trade area
	friend ostream& operator<<(ostream& out, const TradeArea& trade_area) {
		if (!trade_area.cards.empty()) {
			out << "Les cartes dans le Trade Area sont: " << endl;
			for (const auto& card : trade_area.cards) {
				card->print(out);
				out << " ";
			}
			out << endl;
		}
		else {
			out << "Le Trade Area est vide." << endl;
		}
		return out;
	}

	/*
	Constructeur TardeArea à partir du fichier infile de sauvegarde. Lorsqu'une ancienne sauvegarde du jeu est chargé, ce constructeurs
	extrait la chaine désiré et la retourne dans la mémoire du system, en autre mots dans l'instance actif de table.
	*/
	TradeArea(istream& infile, const CardFactory* card_factory) {
		string line;
		int line_number = 0;

		infile.clear();
		infile.seekg(0, std::ios::beg);
		while (getline(infile, line)) {
			line_number++;
			if (line_number == 15) {
				break;
			}
		}
		for (size_t i = 0; i < line.size(); ++i) {
			if (line[i] == ' ') continue;
			else if (line[i] == 'B')  cards.push_back(new BlueCard());
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


