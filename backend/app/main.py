import os
from fastapi import FastAPI, HTTPException, Request
from pydantic import BaseModel

app = FastAPI()

@app.get("/health")
async def health_check():
    return {"status": "ok"}

# Placeholder routes – will be fleshed out in later phases
@app.post("/api/ingest")
async def ingest(payload: dict):
    raise HTTPException(status_code=501, detail="Ingestion not implemented yet")

