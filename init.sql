-- init.sql – creates the three core tables for DriftGuard

-- 1. Destination table (events_target) with a strict initial schema
CREATE TABLE IF NOT EXISTS events_target (
    event_id    VARCHAR(64) PRIMARY KEY,
    user_id    INTEGER NOT NULL,
    amount    NUMERIC(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Audit log for schema evolution
CREATE TABLE IF NOT EXISTS schema_evolution_log (
    id SERIAL PRIMARY KEY,
    table_name VARCHAR(64) NOT NULL,
    column_name VARCHAR(64) NOT NULL,
    inferred_sql_type VARCHAR(32) NOT NULL,
    sample_value TEXT,
    ddl_statement TEXT NOT NULL,
    detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Dead‑Letter Queue for irreconcilable events
CREATE TABLE IF NOT EXISTS dead_letter_queue (
    dlq_id SERIAL PRIMARY KEY,
    event_id VARCHAR(64),
    raw_payload JSONB NOT NULL,
    error_type VARCHAR(64) NOT NULL,
    error_detail TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING', -- PENDING | REPLAYED | DISCARDED
    retry_count INTEGER DEFAULT 0,
    failed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    replayed_at TIMESTAMP
);

