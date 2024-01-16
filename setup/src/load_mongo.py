def load_mongo_data():
    import pymongo
    import os
    import json

    # Connect to MongoDB (assuming it's running on localhost and the default port)
    client = pymongo.MongoClient("mongodb://attribute_db:27017/")

    # Create a new database named "your_database_name"
    db = client["attributes_db"]

    folder_path = "attributes_data"

    files = [
        (folder_name, file_name)
        for folder_name in os.listdir(folder_path)
        for file_name in os.listdir(os.path.join(folder_path, folder_name))
    ]

    print(f"fetched all files from the data folder | got {len(files)} files")

    for folder_name in set([folder_name for folder_name, _ in files]):
        db[folder_name].drop()
        print(f"dropped {folder_name} collection")

    for folder_name, file_name in files:
        collection = db[folder_name]
        with open(os.path.join(folder_path, folder_name, file_name)) as file:
            document = json.loads(file.read())
            collection.insert_one(document)
            print(f"inserted {file_name} into {folder_name} collection")

    # Close the MongoDB connection
    client.close()
    print("inserted data to mongodb")
