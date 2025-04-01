#ifndef CARD_H
#define CARD_H

#include <ostream>
#include <string>
#include <cassert>
using namespace std;

/*
Classe virtuelle Card utilisé lorsqu'un vecteur contient des cartes de types différentes
Tout les composantes de cette classe sont virtuelle et seront surdéfinie par la classe de la carte en question
*/
class Card {
public:
	virtual int getCardsPerCoins(int coins) = 0;
	virtual string getName() const = 0;
	virtual void print(ostream& out) = 0;
	virtual ~Card() = default;
};

/*
Chaque type de carte contient sa propre classe implémenter à partir de Card
Les trois fonction virtuelle dans card sont surdéfinie afin d'être implémenter pour le type spécifique
*/
class BlueCard : public Card {
public:
	int getCardsPerCoins(int coins) {
		if (coins == 4) { return 10; }
		else if (coins == 3) { return 8; }
		else if (coins == 2) { return 6; }
		else { return 4; }
	}
	string getName() const{
		return "Blue";
	}
	void print(ostream& out) {
		out << "B";
	}
};

class ChiliCard : public Card {
public:
	int getCardsPerCoins(int coins) {
		if (coins == 4) { return 9; }
		else if (coins == 3) { return 8; }
		else if (coins == 2) { return 6; }
		else { return 3; }
	}
	string getName() const{
		return "Chili";
	}
	void print(ostream& out) {
		out << "C";
	}
};

class StinkCard : public Card {
public:
	int getCardsPerCoins(int coins) {
		if (coins == 4) { return 8; }
		else if (coins == 3) { return 7; }
		else if (coins == 2) { return 5; }
		else { return 3; }
	}
	string getName() const{
		return "Stink";
	}
	void print(ostream& out) {
		out << "S";
	}
};

class GreenCard : public Card {
public:
	int getCardsPerCoins(int coins) {
		if (coins == 4) { return 7; }
		else if (coins == 3) { return 6; }
		else if (coins == 2) { return 5; }
		else { return 3; }
	}
	string getName() const{
		return "Green";
	}
	void print(ostream& out) {
		out << "G";
	}
};


class SoyCard : public Card {
public:
	int getCardsPerCoins(int coins) {
		if (coins == 4) { return 7; }
		else if (coins == 3) { return 6; }
		else if (coins == 2) { return 4; }
		else { return 2; }
	}
	string getName() const{
		return "soy";
	}
	void print(ostream& out) {
		out << "s";
	}
};

class BlackCard : public Card {
public:
	int getCardsPerCoins(int coins) {
		if (coins == 4) { return 6; }
		else if (coins == 3) { return 5; }
		else if (coins == 2) { return 4; }
		else { return 2; }
	}
	string getName() const{
		return "black";
	}
	void print(ostream& out) {
		out << "b";
	}
};


class RedCard : public Card {
public:
	int getCardsPerCoins(int coins) {
		if (coins == 4) { return 5; }
		else if (coins == 3) { return 4; }
		else if (coins == 2) { return 3; }
		else { return 2; }
	}
	string getName() const{
		return "Red";
	}
	void print(ostream& out) {
		out << "R";
	}
};

class GardenCard : public Card {
public:
	int getCardsPerCoins(int coins) {
		if (coins == 3 || coins == 4) { return 3; }
		if (coins == 2) { return 2; }
		else { return 1000; }
	}
	string getName() const{
		return "garden";
	}
	void print(ostream& out) {
		out << "g";
	}
};

#endif