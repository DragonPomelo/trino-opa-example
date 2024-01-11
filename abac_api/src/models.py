from typing import List

from pydantic import BaseModel


class Table(BaseModel):
    catalog_name: str | None
    schema_name: str | None
    table_name: str | None


class Column(BaseModel):
    table: Table
    name: str
    classification: int


class TableAttribute(BaseModel):
    table: Table | None
    content_world: int | None
    column_list: List[Column] | None


class User(BaseModel):
    id: str
    name: str


class UserAttribute(BaseModel):
    user: User
    content_world: int
    classification: int
