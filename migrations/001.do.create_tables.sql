DROP TYPE IF EXISTS race CASCADE;
CREATE TYPE race AS ENUM (
  'Human',
  'Shield Dwarf',
  'Half-Orc',
  'Half-Elf',
  'Sun-Elf'
);

DROP TYPE IF EXISTS char_class CASCADE;
CREATE TYPE char_class AS ENUM (
  'Arcane',
  'Deception',
  'Martial',
  'Devotion'
);

DROP TYPE IF EXISTS sub_class CASCADE;
CREATE TYPE sub_class AS ENUM (
  'Wizard',
  'Rogue',
  'Fighter',
  'Cleric'
);

DROP TABLE IF EXISTS stickers CASCADE;
CREATE TABLE IF NOT EXISTS stickers (
  sticker_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  sticker_title VARCHAR(128) NOT NULL,
  sticker_description VARCHAR(256) NOT NULL,
  sticker_cost VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS feature_pack CASCADE;
CREATE TABLE IF NOT EXISTS feature_pack (
  feature_pack_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  sticker_1_id INTEGER,
  sticker_2_id INTEGER,
  sticker_3_id INTEGER,
  sticker_4_id INTEGER,
  sticker_5_id INTEGER,
  sticker_6_id INTEGER,
  FOREIGN KEY (sticker_1_id) REFERENCES stickers(sticker_id),
  FOREIGN KEY (sticker_2_id) REFERENCES stickers(sticker_id),
  FOREIGN KEY (sticker_3_id) REFERENCES stickers(sticker_id),
  FOREIGN KEY (sticker_4_id) REFERENCES stickers(sticker_id),
  FOREIGN KEY (sticker_5_id) REFERENCES stickers(sticker_id),
  FOREIGN KEY (sticker_6_id) REFERENCES stickers(sticker_id)
);

DROP TABLE IF EXISTS equipment_pack CASCADE;
CREATE TABLE IF NOT EXISTS equipment_pack (
  equipment_pack_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  arcane SMALLINT,
  deception SMALLINT,
  martial SMALLINT,
  devotion SMALLINT
);


DROP TABLE IF EXISTS party CASCADE;
CREATE TABLE IF NOT EXISTS party (
  party_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(56)
);

DROP TABLE IF EXISTS characters CASCADE;
CREATE TABLE IF NOT EXISTS characters (
  char_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(56) NOT NULL,
  race race NOT NULL,
  char_class char_class NOT NULL,
  sub_class sub_class NOT NULL,
  xp SMALLINT NOT NULL,
  hand_size SMALLINT NOT NULL,
  health SMALLINT NOT NULL,
  equipment_pack_id INTEGER,
  feature_pack_id INTEGER,
  party_id INTEGER,
  FOREIGN KEY (party_id) REFERENCES party(party_id),
  FOREIGN KEY (equipment_pack_id) REFERENCES equipment_pack(equipment_pack_id),
  FOREIGN KEY (feature_pack_id) REFERENCES feature_pack(feature_pack_id)
);

DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE IF NOT EXISTS users (
  user_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  user_email VARCHAR(50),
  user_password VARCHAR(50)
);
