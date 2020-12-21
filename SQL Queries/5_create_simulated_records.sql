DROP TABLE IF EXISTS simulated_records;
CREATE TABLE simulated_records
(
  record_id bigint NOT NULL PRIMARY KEY,
  school text NOT NULL,
  grade text NOT NULL
);