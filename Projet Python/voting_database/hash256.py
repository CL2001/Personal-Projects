import hashlib

def string_to_hash256(input_string: str) -> str:
    input_bytes = input_string.encode('utf-8')
    hash_object = hashlib.sha256(input_bytes)
    return hash_object.hexdigest()

sample_text = "TestHash"
print("SHA-256 Hash:", string_to_hash256(sample_text))
