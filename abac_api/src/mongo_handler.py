import pymongo


def initialize_mongo_client():
    client = pymongo.MongoClient("mongodb://attribute_db:27017/")
    db = client["attributes_db"]
    return db


# this function receives a collection name and fetches all the documents from it
def get_collection(collection_name: str):
    db = initialize_mongo_client()
    collection = db[collection_name]
    return collection.find({})


# this function receives a collection name, a key, and returns all the documents that have this key
def get_collection_by_key(collection_name: str, key: str):
    db = initialize_mongo_client()
    collection = db[collection_name]
    return collection.find({key: {"$exists": True}})


# this function receives a collection name, a key, and a value, and returns all the documents that have this key and value
def get_collection_by_key_value(collection_name: str, key: str, value):
    db = initialize_mongo_client()
    collection = db[collection_name]
    return collection.find({key: value})


# this function receives a collection name, list of keys and list of values, and returns all the documents that have these keys and values
def get_collection_by_keys_values(collection_name: str, keys: list, values: list):
    db = initialize_mongo_client()
    collection = db[collection_name]
    query = {}
    for i in range(len(keys)):
        query[keys[i]] = values[i]
    return collection.find(query)
