
CREATE USER analytics WITH PASSWORD 'analytics';
CREATE DATABASE analytics OWNER analytics;
GRANT ALL PRIVILEGES ON DATABASE analytics TO analytics;

CREATE USER observatory WITH PASSWORD 'observatory';
CREATE DATABASE observatory OWNER observatory;
GRANT ALL PRIVILEGES ON DATABASE observatory TO observatory;

CREATE USER observatoryconfig WITH PASSWORD 'observatoryconfig';
CREATE DATABASE observatoryconfig OWNER observatoryconfig;
GRANT ALL PRIVILEGES ON DATABASE observatoryconfig TO observatoryconfig;

CREATE USER saebackend WITH PASSWORD 'saebackend';
CREATE DATABASE saebackend OWNER saebackend;
GRANT ALL PRIVILEGES ON DATABASE saebackend TO saebackend;

CREATE TABLE IF NOT EXISTS public.detection
(
    "detection_id" integer,
    "capture_ts" timestamp with time zone NOT NULL,
    "camera_id" character varying COLLATE pg_catalog."default",
    "object_id" character varying COLLATE pg_catalog."default",
    "class_id" integer,
    "confidence" double precision,
    "min_x" real,
    "min_y" real,
    "max_x" real,
    "max_y" real,
    "latitude" double precision,
    "longitude" double precision
);
SELECT create_hypertable('detection', 'capture_ts', if_not_exists => TRUE);

CREATE INDEX IF NOT EXISTS detection_camera_id
    ON public.detection USING btree
    ("camera_id" COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
    
CREATE INDEX IF NOT EXISTS detection_object_id
    ON public.detection USING btree
    ("object_id" COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

SELECT add_retention_policy('detection', INTERVAL '30 days', if_not_exists => TRUE);

SELECT set_chunk_time_interval('detection', INTERVAL '24 hours');