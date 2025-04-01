import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

# Initialize Firebase Admin SDK
# Replace 'serviceAccountKey.json' with the path to your service account JSON file
cred = credentials.Certificate("C:/Users/chris/VSCode/Projet Python/voting_database/chessgamesdatabase-ca7c9-firebase-adminsdk-bim4g-dce0d30c95.json")
firebase_admin.initialize_app(cred, {
    "databaseURL": "https://chessgamesdatabase-ca7c9-default-rtdb.firebaseio.com/"
})

def get_candidates():
    current_election = db.reference("current_election").get()
    candidates_ref = db.reference(f"election/{current_election}/candidats")
    candidates = candidates_ref.get()
    return candidates

def add_vote(voter_id, candidate):
    if candidate not in ["a", "b", "c", "d"]:
        raise ValueError("Candidate must be one of 'a', 'b', 'c', or 'd'.")

    current_election = db.reference("current_election").get()
    votes_ref = db.reference(f"election/{current_election}/votes")
    votes_ref.update({voter_id: candidate})
    print(f"Vote added: {voter_id} -> {candidate}")

def add_user(finger_hash, card_id):
    users_ref = db.reference("users")
    users_ref.update({finger_hash: card_id})
    print(f"User added: {finger_hash} -> {card_id}")

def is_vote_already_exists(voter_id):
    current_election = db.reference("current_election").get()
    votes_ref = db.reference(f"election/{current_election}/votes")
    votes = votes_ref.get() or {}
    return voter_id in votes


def is_user_already_exists(finger_hash):
    users_ref = db.reference("users")
    users = users_ref.get() or {}
    return finger_hash in users

def main():
    # 1. See the candidates of the current election
    print("Current election candidates:")
    candidates = get_candidates()
    print(candidates)

    # 2. Add a vote (example)
    #voter_id = "hash_finger_card34"
    #candidate_choice = "a"
    #add_vote(voter_id, candidate_choice)

    # 3. Add a user (example)
    #new_user_hash = "finger_hash34"
    #new_card_id = "card_id34"
    #add_user(new_user_hash, new_card_id)

    # 4. Check if the vote already exists
    voter_id = "hash_finger_card12"
    vote_exists = is_vote_already_exists(voter_id)
    print(f"Does voter_id '{voter_id}' already have a vote? {vote_exists}")

    # 5. Check if the user already exists
    finger_hash = "finger_hash23"
    user_exists = is_user_already_exists(finger_hash)
    print(f"Does card_id '{finger_hash}' already exist? {user_exists}")

if __name__ == "__main__":
    main() 
