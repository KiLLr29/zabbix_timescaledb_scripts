CREATE TABLE history_new (LIKE history INCLUDING DEFAULTS INCLUDING CONSTRAINTS EXCLUDING INDEXES);
SELECT create_hypertable('history_new', 'clock', chunk_time_interval => 86400);
ALTER TABLE IF EXISTS history RENAME TO history_old;
ALTER TABLE IF EXISTS history_new RENAME TO history;
CREATE INDEX history_1 on history_uint (itemid,clock);
GRANT ALL PRIVILEGES ON TABLE history TO zabbix;
INSERT INTO history SELECT * FROM history_old;
DROP TABLE IF EXISTS history_old;
