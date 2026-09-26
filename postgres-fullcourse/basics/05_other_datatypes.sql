DROP TABLE IF EXISTS basic_schema.app_events;

CREATE TABLE basic_schema.app_events (
    -- primary key is uuid that automatically gets created when record is inserted
    event_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name TEXT NOT NULL,

    -- JOSNB is used for storing json data in binary formaat
    metadata JSONB DEFAULT '{}'::jsonb,

    -- created_at TIMESTAMP
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- queries to insert data into app_events
INSERT INTO basic_schema.app_events (event_name, metadata) VALUES
('User Signed Up', '{"user_id": "123"}'),
('User Logged In', '{"user_id": "123"}'),
('User Logged Out', '{"user_id": "123", "name": "John Doe", "age": 30}');

-- query all app events
-- SELECT * FROM basic_schema.app_events;

-- query through json type
SELECT event_name, metadata->>'user_id' AS user_id FROM basic_schema.app_events WHERE metadata ? 'user_id';

-- query through json type for specific key
SELECT event_name, metadata->>'name' AS name FROM basic_schema.app_events;

-- query through json type for another specific key
SELECT event_name, metadata->>'age' AS age FROM basic_schema.app_events;

