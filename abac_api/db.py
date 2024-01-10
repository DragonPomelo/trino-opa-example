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
        "catalog_name": "tpch",
        "schema_name": "sf1",
        "table_name": "customer",
        "content_world": 1,
        "columns": [
            {"name": "custkey", "classification": 1},
            {"name": "name", "classification": 1},
            {"name": "address", "classification": 2},
            {"name": "nationkey", "classification": 2},
            {"name": "phone", "classification": 2},
            {"name": "acctbal", "classification": 2},
            {"name": "mktsegment", "classification": 2},
            {"name": "comment", "classification": 2},
        ],
    },
    {
        "catalog_name": "tpch",
        "schema_name": "sf1",
        "table_name": "region",
        "content_world": 2,
        "columns": [
            {"name": "regionkey", "classification": 1},
            {"name": "name", "classification": 1},
            {"name": "comment", "classification": 3},
        ],
    },
]


def get_users_db() -> List[Dict]:
    return users_db


def get_tables_db() -> List[Dict]:
    return tables_db
