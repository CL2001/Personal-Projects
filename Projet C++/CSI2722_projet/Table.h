#ifndef TABLE_H
#define TABLE_H

#include <sstream>

class Table {
private:
	//Variables sont les joeurs assis à la table et le deck / discard pile / trade area du jeu
	vector<Player> players;
	Deck deck;
	DiscardPile discard_pile;
	TradeArea trade_area;

public:
	//Constructeur de table, construit les deux joeurs avec le nom spécifié
	Table(const string& player1_name, const string& player2_name) {
		Player player1(player1_name);
		Player player2(player2_name);
		players.push_back(player1); 
		players.push_back(player2);
	}

	//Retourne le deck sur la table
	Deck& getDeck() {
		return deck;
	}

	//Retourne le discard pile sur la table
	DiscardPile& getDiscardPile() {
		return discard_pile;
	}
	
	//Retourne le tarde area sur la table
	TradeArea& getTradeArea() {
		return trade_area;
	}

	//Retourne les joueurs sur la table
	vector<Player>& getPlayers() {
		return players;
	}

	//Surdéfintion de l'opérateur <<, imrpimer les joeurs, le discard pile et le trade area
	friend ostream& operator<<(ostream& out, const Table& table) {
		out << "Joueur 1: " << endl << table.players[0] << endl;
		out << "Joueur 2: " << endl << table.players[1] << endl;

		out << table.discard_pile;
		out << table.trade_area;
		
		return out;
	}

	/*
	Constructeur Table à partir d'un fichier de sauvegarde externe prends le fichier et appel le constructeur de chaque objet dans la table
	Nous pourrons donc construire notre table à partir d'un objet table lancé auparavant dans le code et qui à été sauvegarder dans 
	un fichier
	*/
	Table(istream& infile, const CardFactory* card_factory) {
		Player player1(infile, card_factory, 0);
		Player player2(infile, card_factory, 1);
		players.push_back(player1);
		players.push_back(player2);

		Deck new_deck(infile, card_factory);
		DiscardPile new_discard_pile(infile, card_factory);
		TradeArea new_trade_area(infile, card_factory);

		deck = new_deck;
		discard_pile = new_discard_pile;
		trade_area = new_trade_area;
	}

};


#endif