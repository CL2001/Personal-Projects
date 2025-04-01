#ifndef PLAYER_H
#define PLAYER_H

#include <string>
#include <stdexcept>
#include <sstream>
using namespace std;

//Classe Player créé un joueur qui pourra joué au jeu
class Player {
private:
	//Variables privé sont le nom du joeur, ces cartes en main, son nombre de coins, de chaine, et ces chaines
	string name;
	Hand hand;
	int coins;
	int num_chains;
	vector<Chain<Card*>*> chains;
public:

	/*
	Constructeur de la classe player, ce construceur accorde le nom du joueur et initialise coins et num_chains selon leur valeur
	de défault. Le constructeur créé aussi deux chaine vide pour le joueur.
	*/
	Player(const string& player_name) {
		name = player_name;
		coins = 0;
		num_chains = 2;
		chains.push_back(new Chain<Card*>());
		chains.push_back(new Chain<Card*>());
	}



	//Retourne la main du joeur
	Hand& getHand() {
		return hand;
	}

	//Retourne le nom du joueur
	string getName() const {
		return name;
	}

	//Retourne le montant de coins du joueur 
	int getNumCoins() const{
		return coins;
	}

	//Sur définition de l'opérateur += afin d'ajouté des coins à la banque du joeur
	Player& operator+=(int coins_added) {
		coins += coins_added;
		return *this;
	}
	
	//Retourne le nombre maximale de chaine débloquer par le joeur
	int getMaxNumChains() {
		return num_chains;
	}

	//Retourne le nombre de chaine active du joueur, les chaines vide n'incérmente pas activeChains qui est retourné à la fin
	int getNumChains() const {
		int activeChains = 0;
		for (const auto& chain : chains) {
			if (chain) {
				activeChains++;
			}
		}
		return activeChains;

	}

	//L'opérateur [] est surdéfinie afin d'accédé à une des deux ou trois chaines du joeurs. player[0] est donc la première chaine du joueur
	Chain<Card*>* operator[](int i) {
		if (i < 0 || i >= chains.size()) {
			throw out_of_range("Chain index out of bounds.");
		}
		return chains[i];
	}

	/*
	Si le joueur à au moins deux coins et à deux chaine, une troisième chaine peut être acheté avec cette fonction
	Si l'appel est fait, deux coins sont enlevé du joeur et un nouvelle chaine vide est ajouté au joueur
	*/
	void buyThirdChain() {
		if (coins >= 2 && num_chains == 2) {
			coins -= 2;
			num_chains++;
			chains.push_back(new Chain<Card*>());
		} 
		else {
			throw runtime_error("Pas assez d'argent pour achete une troisieme chaine ou une troisieme chaine a deja ete achete");
		}
	}

	/*
	Surdéfinition de l'opérateur <<. La sortie d'un instance de la classe Player affiche sont nom et sont nombre de coins.
	Ensuite, chaque chaine est imprimé avec un appel de l'opréateur << de chaine
	Si la troisième chaine est bloqué, le message Chaine vide bloque est affiché à la place
	*/
	friend ostream& operator<<(ostream& out, const Player& player) {
		out << "Joueur " << player.getName() << " a " << player.getNumCoins() << " coins." << endl;
		for (int i = 0; i < player.num_chains; i++) {
			out << *player.chains[i] << endl;
		}
		if (player.num_chains == 2) {
			out << "Chaine vide bloque" << endl;
		}

		return out;
	}

	/*
	Constructeur Player à partir du fichier infile de sauvegarde. Lorsqu'une ancienne sauvegarde du jeu est chargé, ce constructeurs
	extrait la chaine désiré et la retourne dans la mémoire du system, en autre mots dans l'instance actif de table.
	*/
	Player(istream& infile, const CardFactory* card_factory, int player_num) {
		Hand new_hand(infile, card_factory, player_num);
		hand = new_hand;

		string name1, name2;
		int coins1 = 0, coins2 = 0;
		int chain1 = 3, chain2 = 3;

		string line;
		int line_number = 0;

		infile.clear();
		infile.seekg(0, std::ios::beg);
		while (getline(infile, line)) {
			line_number++;
			if (line_number == 2) {
				string prefix, name, suffix, coinsStr;
				istringstream iss(line);
				iss >> prefix >> name1 >> suffix >> coins1 >> coinsStr;
			}
			else if (line_number == 5 && line == "Chaine vide bloque") {
				chain1 = 2;
			}
			else if (line_number == 8) {
				string prefix, name, suffix, coinsStr;
				istringstream iss(line);
				iss >> prefix >> name2 >> suffix >> coins2 >> coinsStr;
			}
			else if (line_number == 11 && line == "Chaine vide bloque") {
				chain2 = 2;
			}

		}

		if (player_num == 0) {
			name = name1;
			coins = coins1;
			num_chains = chain1;
		}
		else {
			name = name2;
			coins = coins2;
			num_chains = chain2;
		}

		for (int i = 0; i < num_chains; i++) {
			chains.push_back(new Chain<Card*>(infile, card_factory, player_num, i));
		}
	}

};



#endif
