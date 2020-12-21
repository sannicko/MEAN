DROP TABLE IF EXISTS school_probs;
CREATE TABLE school_probs
(
  school_code bigint NOT NULL PRIMARY KEY,
  school text NOT NULL,
  probs numeric[] NOT NULL
);