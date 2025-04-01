#ifndef CHAIN_H
#define CHAIN_H

#include <vector>
#include <stdexcept>
#include <sstream>

/*
L'erreur illegal type est lancé lorsqu'une cartes ne peut pas être ajouté à une chaine.
Ceci est le cas lorsque la chaine contient déjà une carte d'un autre type
*/
class IllegalType : public exception {
public:
    const char* what() const noexcept override {
        return "Cartes illegal a essayer d'etre ajoute a la chaine";
    }
};

/*
La classe Chain_Base est un classe représentante une chaine vide. Vue que la chaine ne contient encore aucune carte,
sont type est encore inconnue et donc cette clase virtuelle est utilisé.
Lorsqu'on ajoute une carte à Chain_Base, celle ci devient automatiquement une chaine avec le type de sa classe
*/
class Chain_Base {
public:
	virtual ~Chain_Base() = default;
	virtual string getCardType() = 0;
	virtual Chain_Base& operator+=(Card* card) = 0;
	virtual int sell() = 0;
	virtual bool isEmpty() const = 0;
	friend ostream& operator<<(ostream& out, const Chain_Base& chain) {
		out << "Chaine vide" << endl;
	}
};


/*
Classe chaine est utilisé afin de représenter une des deux à trois chaine que chaque joeurs ont.
La classe chaine est de type inconnue T et lorsqu'elle est instancié, elle prendera le type de la cartes inséré dans elle.
*/
template <typename T>
class Chain {
private:
	//Variable privé est un vecteur des cartes de la chaine
	vector<T> cards;
public:

	//Constructeur par défaut est déclarer.
	Chain() = default;

	//Fonction retourne le type des cartes en chaine
	string getCardType() const {
		return cards.empty() ? "" : cards[0]->getName();
	}

	/*
	Opérateur += est utilisé afin d'ajouté une carte à une chaine.  Si la chaine est vide, la cartes est ajouté.
	Si la chaine contient déjà des cartes, on vérifie si le type d'une des cartes déjà ajouté est pareil que le type à ajouté.
	Si oui, nous ajoutons la cartes à la chaine, si non, nous lancons l'exception IllegalType() définie en haut
	*/
	Chain<T>& operator+=(Card* card) {
		if (cards.empty()) {
			cards.push_back(card);
			return *this;
		}
		else if (cards.back()->getName() == card->getName()) {
			cards.push_back(card);
		}
		else {
			throw IllegalType();
		}
		return *this;
	}
	
	/*
	La fonction sell prend un chaine, la vide et retourne le montant de coins à retourner correspondant à la valeur de la chaine.
	Nous utilisons la fonction getCardsPerCoins afin de vérifié si nous avons assez de cartes pour un montant d'argent
	Ce montant est retourner et la chaine est vider.
	*/
	int sell() {
		if (cards.empty()) {
			return 0;
		}
		int card_count = cards.size();
		for (int i = 1; i < 5; i++) {
			if (cards[0]->getCardsPerCoins(i) >= card_count) {
				cards.clear();
				return i;
			}
		}
		cards.clear();
		return 0;
	}

	//Renvoie une valeur booleenne décrivant si la chaine est vide ou non
	bool isEmpty() const {
		return cards.empty();
	}

	/*
	Surdéfinition de l'opérateur <<.
	Si la chaine est vide, la sortie sera chaine vide, sinon, le nom du type de la chaine est imprimé suvie de la première
	lettre de chaque carte pour le nombre de cartes dans la chaine
	*/
	friend ostream& operator<<(ostream& out, const Chain& chain) {
		if (chain.cards.empty()) {
			out << "Chaine vide";
			return out;
		}
		out << chain.cards[0]->getName() << ": ";
		for (const auto& card : chain.cards) {
			card->print(out);
		}
		return out;
	}

	/*
	Constructeur Chain à partir du fichier infile de sauvegarde. Lorsqu'une ancienne sauvegarde du jeu est chargé, ce constructeurs
	extrait la chaine désiré et la retourne dans la mémoire du system, en autre mots dans l'instance actif de table.
	*/
	Chain(istream& infile, const CardFactory* card_factory, int player_number, int chain_num) {
		string line;
		int line_number = 0;
		string cards_str;

		infile.clear();
		infile.seekg(0, std::ios::beg);
		while (getline(infile, line)) {
			line_number++;
			if (line_number == 3 && player_number == 0 && chain_num == 0) {
				string word1;
				istringstream iss(line);
				iss >> word1 >> cards_str;
				break;
			}
			else if (line_number == 4 && player_number == 0 && chain_num == 1) {
				string word1;
				istringstream iss(line);
				iss >> word1 >> cards_str;
				break;
			}
			else if (line_number == 5 && player_number == 0 && chain_num == 2) {
				string word1;
				istringstream iss(line);
				iss >> word1 >> cards_str;
				break;
			}
			else if (line_number == 9 && player_number == 1 && chain_num == 0) {
				string word1;
				istringstream iss(line);
				iss >> word1 >> cards_str;
				break;
			}
			else if (line_number == 10 && player_number == 1 && chain_num == 1) {
				string word1;
				istringstream iss(line);
				iss >> word1 >> cards_str;
				break;
			}
			else if (line_number == 11 && player_number == 1 && chain_num == 2) {
				string word1;
				istringstream iss(line);
				iss >> word1 >> cards_str;
				break;
			}
		}
		if (cards_str != "vide") {
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
	}
};


#endif
