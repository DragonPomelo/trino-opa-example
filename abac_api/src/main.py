from typing import Optional

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
    """
    Returns a simple greeting message.

    Returns:
        str: A greeting message.
    """
    return "Hello world"


@app.get("/content_worlds")
def get_content_worlds(name: Optional[str] = None):
    """
    Retrieves content worlds from the database.

    Args:
        name (str, optional): The name of the content world to retrieve. Defaults to None.

    Returns:
        list: A list of content worlds matching the given name.
    """
    if not name:
        return [
            {key: document[key] for key in document if key != "_id"}
            for document in get_collection("content_world_attributes")
        ]
    return [
        {key: document[key] for key in document if key != "_id"}
        for document in get_collection_by_key_value(
            "content_world_attributes", "name", name
        )
    ][0]


@app.get("/users")
def get_users(id: Optional[str] = None):
    """
    Retrieves users from the database.

    Args:
        id (str, optional): The ID of the user to retrieve. Defaults to None.

    Returns:
        list: A list of users matching the given ID.
    """
    if not id:
        return [document["user_id"] for document in get_collection("user_attributes")]
    return [
        {key: document[key] for key in document if key != "_id"}
        for document in get_collection_by_key_value("user_attributes", "user_id", id)
    ][0]


@app.get("/tables")
def get_tables(
    catalog: Optional[str] = None,
    schema: Optional[str] = None,
    table: Optional[str] = None,
):
    """
    Retrieves tables from the database.

    Args:
        catalog (str, optional): The catalog name of the table to retrieve. Defaults to None.
        schema (str, optional): The schema name of the table to retrieve. Defaults to None.
        table (str, optional): The table name to retrieve. Defaults to None.

    Returns:
        list: A list of tables matching the given criteria.
    """
    if not catalog and not schema and not table:
        return [
            {key: document[key] for key in document if key != "_id"}
            for document in get_collection("table_attributes")
        ]
    if catalog and schema and not table:
        return [
            {key: document[key] for key in document if key != "_id"}
            for document in get_collection_by_keys_values(
                "table_attributes", ["catalog_name", "schema_name"], [catalog, schema]
            )
        ]
    return [
        {key: document[key] for key in document if key != "_id"}
        for document in get_collection_by_keys_values(
            "table_attributes",
            ["catalog_name", "schema_name", "table_name"],
            [catalog, schema, table],
        )
    ][0]


if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8081, reload=True)
