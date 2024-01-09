from typing import List
from fastapi import FastAPI
import uvicorn
from models import Column, Table, UserAttribute, User, TableAttribute
from db import get_tables_db, get_users_db

app = FastAPI()


@app.get("/")
def root():
    return "Hello world"


@app.get("/users")
def get_user_attributes(user_id: int) -> List[UserAttribute]:
    users_db = get_users_db()
    this_user = [
        UserAttribute(
            user=User(id=u["user_id"], name=u["username"]),
            content_world=u["content_world"],
            classification=u["classification"],
        )
        for u in users_db
        if u["user_id"] == user_id
    ]
    return this_user


@app.post("/table")
def get_table_attributes(table: Table) -> TableAttribute | None:
    tables_db = get_tables_db()
    this_table = None
    table_attr = None
    for t in tables_db:
        this_table = Table(
            catalog_name=t["catalog_name"],
            schema_name=t["schema_name"],
            table_name=t["table_name"],
        )

        if this_table == table:
            table_attr = TableAttribute(
                table=this_table,
                content_world=t["content_world"],
                column_list=[
                    Column(
                        table=this_table,
                        name=c["name"],
                        classification=c["classification"],
                    )
                    for c in t["columns"]
                ],
            )
            break

    return table_attr


if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8081, reload=True)
