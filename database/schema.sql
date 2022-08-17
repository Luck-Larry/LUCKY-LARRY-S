-- postgres schema

DROP DATABASE IF EXISTS luckylarrys;
CREATE DATABASE luckylarrys;

\c luckylarrys;

CREATE TABLE country (
  id SERIAL PRIMARY KEY NOT NULL,
  country TEXT NOT NULL
);

INSERT INTO country (country) VALUES
('Afghanistan'),
('Aland Islands'),
('Albania'),
('Algeria'),
('American Samoa'),
('Andorra'),
('Angola'),
('Anguilla'),
('Antarctica'),
('Antigua And Barbuda'),
('Argentina'),
('Armenia'),
('Aruba'),
('Australia'),
('Austria'),
('Azerbaijan'),
('Bahamas'),
('Bahrain'),
('Bangladesh'),
('Barbados'),
('Belarus'),
('Belgium'),
('Belize'),
('Benin'),
('Bermuda'),
('Bhutan'),
('Bolivia'),
('Bosnia And Herzegovina'),
('Botswana'),
('Brazil'),
('British Indian Ocean Territory'),
('British Virgin Islands'),
('Brunei Darussalam'),
('Bulgaria'),
('Burkina Faso'),
('Burundi'),
('Cambodia'),
('Cameroon'),
('Canada'),
('Cape Verde'),
('Cayman Islands'),
('Central African Republic'),
('Chad'),
('Chile'),
('China'),
('Christmas Island'),
('Cocos Keeling Islands'),
('Colombia'),
('Comoros'),
('Congo'),
('Cook Islands'),
('Costa Rica'),
('Croatia'),
('Cuba'),
('Curaao'),
('Cyprus'),
('Czech Republic'),
('Democratic Republic Congo'),
('Denmark'),
('Djibouti'),
('Dominica'),
('Dominican Republic'),
('Ecuador'),
('Egypt'),
('El Salvador'),
('Equatorial Guinea'),
('Eritrea'),
('Estonia'),
('Ethiopia'),
('Falkland Islands'),
('Faroe Islands'),
('Fiji'),
('Finland'),
('France'),
('French Polynesia'),
('French Southern Territories'),
('Gabon'),
('Gambia'),
('Georgia'),
('Germany'),
('Ghana'),
('Gibraltar'),
('Great Britain'),
('Greece'),
('Greenland'),
('Grenada'),
('Guam'),
('Guatemala'),
('Guernsey'),
('Guinea Bissau'),
('Guinea'),
('Guyana'),
('Honduras'),
('Hong Kong'),
('Hungary'),
('Iceland'),
('India'),
('Indonesia'),
('Iran'),
('Iraq'),
('Ireland'),
('Isle Of Man'),
('Israel'),
('Italy'),
('Ivory Coast'),
('Jamaica'),
('Japan'),
('Jersey'),
('Jordan'),
('Kazakhstan'),
('Kenya'),
('Kiribati'),
('Kuwait'),
('Kyrgyzstan'),
('Laos'),
('Latvia'),
('Lebanon'),
('Lesotho'),
('Liberia'),
('Libya'),
('Liechtenstein'),
('Lithuania'),
('Luxembourg'),
('Macao'),
('Macedonia'),
('Madagascar'),
('Malawi'),
('Malaysia'),
('Maldives'),
('Mali'),
('Malta'),
('Marshall Islands'),
('Mauritania'),
('Mauritius'),
('Mexico'),
('Micronesia'),
('Moldova'),
('Monaco'),
('Mongolia'),
('Montenegro'),
('Montserrat'),
('Morocco'),
('Mozambique'),
('Myanmar'),
('Namibia'),
('Nauru'),
('Nepal'),
('Netherlands'),
('New Zealand'),
('Nicaragua'),
('Niger'),
('Nigeria'),
('Niue'),
('Norfolk Island'),
('North Korea'),
('Northern Mariana Islands'),
('Norway'),
('Oman'),
('Pakistan'),
('Palestine'),
('Panama'),
('Papua New Guinea'),
('Paraguay'),
('Peru'),
('Philippines'),
('Pitcairn Islands'),
('Poland'),
('Portugal'),
('Puerto Rico'),
('Qatar'),
('Romania'),
('Russian Federation'),
('Rwanda'),
('Saint Kitts And Nevis'),
('Saint Lucia'),
('Saint Vincent And The Grenadines'),
('Samoa'),
('San Marino'),
('Sao Tome And Principe'),
('Saudi Arabia'),
('Senegal'),
('Serbia'),
('Seychelles'),
('Sierra Leone'),
('Singapore'),
('Slovakia'),
('Slovenia'),
('Solomon Islands'),
('Somalia'),
('South Africa'),
('South Georgia And The South Sandwich Islands'),
('South Korea'),
('South Sudan'),
('Spain'),
('Sri Lanka'),
('Sudan'),
('Suriname'),
('Swaziland'),
('Sweden'),
('Switzerland'),
('Syria'),
('Tajikistan'),
('Tanzania'),
('Thailand'),
('The Republic Of Haiti'),
('Timor Leste'),
('Togo'),
('Tokelau'),
('Tonga'),
('Trinidad And Tobago'),
('Tunisia'),
('Turkey'),
('Turkmenistan'),
('Turks And Caicos Islands'),
('Tuvalu'),
('Uganda'),
('Ukraine'),
('United Arab Emirates'),
('United States Virgin Islands'),
('Uruguay'),
('USA'),
('Ussr'),
('Uzbekistan'),
('Vanuatu'),
('Vatican City'),
('Venezuela'),
('Vietnam'),
('Western Sahara'),
('Yemen'),
('Zambia'),
('Zimbabwe');

CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL,
  username VARCHAR(256) UNIQUE NOT NULL,
  password VARCHAR(256) NOT NULL,
  countryID INT,
  balance INT NOT NULL,
  winnings INT NOT NULL,
  FOREIGN KEY (countryID) REFERENCES country(id)
);

CREATE TABLE friends (
  id SERIAL PRIMARY KEY NOT NULL,
  userID INT,
  friendID INT,
  FOREIGN KEY (userID) REFERENCES users(id),
  FOREIGN KEY (friendID) REFERENCES users(id)
);

CREATE TABLE chat (
  id SERIAL PRIMARY KEY NOT NULL,
  date BIGINT NOT NULL,
  message VARCHAR(500) NOT NULL,
  country VARCHAR(50) NOT NULL,
  username VARCHAR(256) NOT NULL,
  userID INT,
  FOREIGN KEY (userID) REFERENCES users(id)
);

CREATE TABLE dms (
  id SERIAL PRIMARY KEY NOT NULL,
  date TIMESTAMP WITH TIME ZONE DEFAULT now(),
  message VARCHAR(500) NOT NULL,
  userID INT NOT NULL,
  recipientID INT NOT NULL,
  FOREIGN KEY (userID) REFERENCES users(id),
  FOREIGN KEY (recipientID) REFERENCES users(id)
);

CREATE INDEX IF NOT EXISTS idx_users ON users(id);
CREATE INDEX IF NOT EXISTS idx_country ON country(id);
CREATE INDEX IF NOT EXISTS idx_friends ON friends(userID);
CREATE INDEX IF NOT EXISTS idx_chat ON chat(userID);


INSERT INTO users (username, password, countryID, balance, winnings) VALUES
('Bruce', 'Waifus', 1, 2000, 10000000),
('Matthew', 'Moofus', 2, 2000, 10),
('Cornelius', 'Mario', 3, 2000, 0),
('River', 'Animation', 4, 2000, 100),
('Jesse', 'Roulette', 5, 2000, 1000),
('Andy', 'Anime', 6, 2000, 100000),
('Mark', 'Tensorflow', 7, 2000, 1000),
('Gary', 'Pokemon', 8, 2000, 10000);

-------Roulette---------
-- USE roulette

--id = num
--E0 = even/odd - even = 'even', odd = 'odd', 0 = 'zero'
--color = r='red', b='black', g='green'
--Rangeof12 = 0,1st,2nd,3rd range
--firstHalf = 1 to 18 = 1, 19-36 = 2, 0 = 0
--numRow =1,2,3 rows, 0
-- further functionality - add relation in DB for when users pick middle quadrants between numbers

CREATE TABLE RouletteNums(
  id INTEGER NOT NULL PRIMARY KEY,
  evenOdd VARCHAR(5) NOT NULL,
  color VARCHAR(6) NOT NULL,
  rangeOf12 INTEGER NOT NULL,
  firstHalf INTEGER NOT NULL,
  numRow INTEGER NOT NULL
);

-- Load data in
INSERT INTO RouletteNums(id, evenOdd, color, rangeOf12, firstHalf, numRow) VALUES (0, 'zero', 'green', 0, 0, 0),
(1, 'odd', 'black', 1, 1, 1),
(2, 'even', 'red', 1, 1, 2),
(3, 'odd', 'black', 1, 1, 3),
(4, 'even', 'red', 1, 1, 1),
(5, 'odd', 'black', 1, 1, 2),
(6, 'even', 'red', 1, 1, 3),
(7, 'odd', 'black', 1, 1, 1),
(8, 'even', 'red', 1, 1, 2),
(9, 'odd', 'black', 1, 1, 3),
(10, 'even', 'red', 1, 1, 1),
(11, 'odd', 'black', 1, 1, 2),
(12, 'even', 'red', 1, 1, 3),
(13, 'odd', 'black', 1, 1, 1),
(14, 'even', 'red', 1, 1, 2),
(15, 'odd', 'black', 1, 1, 3),
(16, 'even', 'red', 1, 1, 1),
(17, 'odd', 'black', 1, 1, 2),
(18, 'even', 'red', 1, 1, 3),
(19, 'odd', 'black', 2, 2, 1),
(20, 'even', 'red', 2, 2, 2),
(21, 'odd', 'black', 2, 2, 3),
(22, 'even', 'red', 2, 2, 1),
(23, 'odd', 'black', 2, 2, 2),
(24, 'even', 'red', 2, 2, 3),
(25, 'odd', 'black', 3, 2, 1),
(26, 'even', 'red', 3, 2, 2),
(27, 'odd', 'black', 3, 2, 3),
(28, 'even', 'red', 3, 2, 1),
(29, 'odd', 'black', 3, 2, 2),
(30, 'even', 'red', 3, 2, 3),
(31, 'odd', 'black', 3, 2, 1),
(32, 'even', 'red', 3, 2, 2),
(33, 'odd', 'black', 3, 2, 3),
(34, 'even', 'red', 3, 2, 1),
(35, 'odd', 'black', 3, 2, 2),
(36, 'even', 'red', 3, 2, 3);
