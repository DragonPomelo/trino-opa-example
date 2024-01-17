import uvicorn
from fastapi import FastAPI
from mongo_handler import (
    get_collection,
    get_collection_by_key_value,
    get_collection_by_keys_values,
)

app = FastAPI()


@app.get("/")
def root():
    return "Hello world"


@app.get("/content_worlds")
def get_content_worlds():
    return [
        {key: document[key] for key in document if key != "_id"}
        for document in get_collection("content_world_attributes")
    ]


@app.get("/content_worlds/{name}")
def get_content_worlds_by_key(name: str):
    return [
        {key: document[key] for key in document if key != "_id"}
        for document in get_collection_by_key_value(
            "content_world_attributes", "name", name
        )
    ]


@app.get("/users")
def get_users_by_key(id: str = None):
    if not id:
        return [
            {key: document[key] for key in document if key != "_id"}
            for document in get_collection("user_attributes")
        ]
    return [
        {key: document[key] for key in document if key != "_id"}
        for document in get_collection_by_key_value("user_attributes", "user_id", id)
    ]


@app.get("/tables")
def get_tables():
    return [
        {key: document[key] for key in document if key != "_id"}
        for document in get_collection("table_attributes")
    ]


@app.get("/tables/{catalog}/{schema}/{table}")
def get_tables_by_key(catalog: str, schema: str, table: str):
    return [
        {key: document[key] for key in document if key != "_id"}
        for document in get_collection_by_keys_values(
            "table_attributes",
            ["catalog_name", "schema_name", "table_name"],
            [catalog, schema, table],
        )
    ]


if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8081, reload=True)
