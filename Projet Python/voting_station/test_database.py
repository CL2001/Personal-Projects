import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import hashlib

def string_to_hash256(input_string: str) -> str:
    input_bytes = input_string.encode('utf-8')
    hash_object = hashlib.sha256(input_bytes)
    return hash_object.hexdigest()


# Initialize Firebase Admin SDK
cred = credentials.Certificate("/home/zero/python_project/chessgamesdatabase-ca7c9-firebase-adminsdk-bim4g-dce0d30c95.json")
firebase_admin.initialize_app(cred, {
    "databaseURL": "https://chessgamesdatabase-ca7c9-default-rtdb.firebaseio.com/"
})

def get_candidates():
    print("test")
    current_election = db.reference("current_election").get()
    candidates_ref = db.reference(f"election/{current_election}/candidats")
    candidates = candidates_ref.get()
    print("test2",candidates)
    expected_keys = {'a', 'b', 'c', 'd'}
    if not isinstance(candidates, dict) or set(candidates.keys()) != expected_keys:
        raise ValueError("Candidates must have keys a, b, c, d")
    ordered_candidates = [candidates['a'], candidates['b'], candidates['c'], candidates['d']]
    return ordered_candidates


def get_card_id(finger_id):
    finger_hash = string_to_hash256(str(finger_id) + "Password=ksjksdsggd34342aksjskajnah")
    users_ref = db.reference("users")
    users = users_ref.get() or {}
    return users.get(finger_hash)



def add_vote(finger_id, candidate):
    voter_id = string_to_hash256(str(finger_id) + str(get_card_id(finger_id)) + "Password=ksjkaksjska122233411257jnah")
    if candidate not in ["a", "b", "c", "d"]:
        raise ValueError("Candidate must be one of 'a', 'b', 'c', or 'd'.")
    current_election = db.reference("current_election").get()
    votes_ref = db.reference(f"election/{current_election}/votes")
    votes_ref.update({voter_id: candidate})
    print(f"Vote added: {voter_id} -> {candidate}")


def add_user(finger_id, card_id):
    finger_hash = string_to_hash256(str(finger_id) + "Password=ksjksdsggd34342aksjskajnah")
    users_ref = db.reference("users")
    users_ref.update({finger_hash: card_id})
    print(f"User added: {finger_hash} -> {card_id}")


def vote_already_exists(finger_id):
    voter_id = string_to_hash256(str(finger_id) + str(get_card_id(finger_id)) + "Password=ksjkaksjska122233411257jnah")
    current_election = db.reference("current_election").get()
    votes_ref = db.reference(f"election/{current_election}/votes")
    votes = votes_ref.get() or {}
    return voter_id in votes


def user_already_exists(card_id):
    users_ref = db.reference("users")
    users = users_ref.get() or {}
    return card_id in users.values()


"""
def main():

    sample_text = "TestHash"
    print("SHA-256 Hash:", string_to_hash256(sample_text))

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
"""