from pydantic import BaseModel


class Table(BaseModel):
    catalog: str
    schema: str
    table: str


class UserAttribute(BaseModel):
    content_world: int
