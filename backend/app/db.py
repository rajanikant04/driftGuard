import os
import asyncpg
from typing import AsyncGenerator

DATABASE_URL = os.getenv("DATABASE_URL")

async def get_pool() -> asyncpg.Pool:
    return await asyncpg.create_pool(DATABASE_URL, min_size=1, max_size=10)

# FastAPI lifespan events
async def connect_db(app):
    app.state.db_pool = await asyncpg.create_pool(DATABASE_URL)

async def close_db(app):
    await app.state.db_pool.close()

