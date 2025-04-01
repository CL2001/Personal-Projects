#ifndef CARDFACTORY_H
#define CARDFACTORY_H

#include <vector>
#include <iostream>
using namespace std;

class CardFactory {
private:
	//Les variables privées sont le pointeur à card factory et un vecteurs de tous les cartes
    static CardFactory* ptr;
	vector<Card*> cards;

	//Le vecteur est initialisé par le constructeurs suivant
	CardFactory() {
		for (int i = 0; i < 20; i++) cards.push_back(new BlueCard());
		for (int i = 0; i < 18; i++) cards.push_back(new ChiliCard());
		for (int i = 0; i < 16; i++) cards.push_back(new StinkCard());
		for (int i = 0; i < 14; i++) cards.push_back(new GreenCard());
		for (int i = 0; i < 12; i++) cards.push_back(new SoyCard());
		for (int i = 0; i < 10; i++) cards.push_back(new BlackCard());
		for (int i = 0; i < 8; i++) cards.push_back(new RedCard());
		for (int i = 0; i < 6; i++) cards.push_back(new GardenCard());
	}
    

public:
	// Renvoie un pointeur à l’unique instance, si le pointeur est null, card factory est créé
	static CardFactory* getFactory() {
		if (ptr == nullptr) {
			ptr = new CardFactory();
		}
		return ptr;
	}

	// Renvoie un jeu avec toutes les 104 cartes
	vector<Card*> getDeck() const {
		vector<Card*> deck_cards;
		for (Card* card : cards) {
			deck_cards.push_back(card);
		}

		return deck_cards;
	}

	//Empêche un constructeur de recopie et l'opérteur =.
    CardFactory(const CardFactory&) = delete;
    CardFactory& operator=(const CardFactory&) = delete;
};

//Initialise la variable static
CardFactory* CardFactory::ptr = nullptr;

#endif
