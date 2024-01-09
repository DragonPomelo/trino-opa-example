from typing import List, Tuple
from fastapi import FastAPI
import uvicorn
from models import Table, UserAttribute

app = FastAPI()


@app.get("/")
def root():
    return "Hello world"


@app.get("/users")
def get_user_attributes(user_id: int) -> Tuple[int, List[UserAttribute]]:
    a = "sa"
    return (1, [])


@app.get("/table")
def get_table_attributes(table: Table):
    return "hi"


if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8081, reload=True)
