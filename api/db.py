from typing import Dict, List


users_db = [
    {
        "user_id": 8398239,
        "username": "nadav",
        "content_world": 1,
        "classification": 1,
    },
    {
        "user_id": 8398239,
        "username": "nadav",
        "content_world": 2,
        "classification": 2,
    },
    {
        "user_id": 87654321,
        "username": "alon",
        "content_world": 1,
        "classification": 2,
    },
    {
        "user_id": 12345678,
        "username": "shoham",
        "content_world": 1,
        "classification": 3,
    },
]

tables_db = [
    {
        "catalog_name": "datalake",
        "schema_name": "halo",
        "table_name": "test1",
        "content_world": 1,
        "columns": [
            {"name": "a", "classification": 1},
            {"name": "b", "classification": 1},
            {"name": "c", "classification": 2},
        ],
    },
    {
        "catalog_name": "datalake",
        "schema_name": "halo",
        "table_name": "test2",
        "content_world": 2,
        "columns": [
            {"name": "a", "classification": 1},
            {"name": "b", "classification": 1},
            {"name": "c", "classification": 3},
        ],
    },
]


def get_users_db() -> List[Dict]:
    return users_db


def get_tables_db() -> List[Dict]:
    return tables_db
