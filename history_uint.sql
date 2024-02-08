CREATE TABLE history_uint_new (LIKE history_uint INCLUDING DEFAULTS INCLUDING CONSTRAINTS EXCLUDING INDEXES);
SELECT create_hypertable('history_uint_new', 'clock', chunk_time_interval => 86400);
ALTER TABLE IF EXISTS history_uint RENAME TO history_uint_old;
ALTER TABLE IF EXISTS history_uint_new RENAME TO history_uint;
INSERT INTO history_uint SELECT * FROM history_uint_old;
DROP TABLE IF EXISTS history_uint_old;
CREATE INDEX history_uint_1 on history_uint (itemid,clock);
