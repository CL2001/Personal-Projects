-- ==============================
-- Insertion des 5 chaînes
-- ==============================
INSERT INTO Chaine_Hoteliere 
    (Nom_Chaine, Classification, Adresse_Bureaux_Centraux, Nombre_Hotels)
VALUES
    ('True North Toronto',       3.5, '123 Queen St, Toronto',           11),
    ('Mont Royal Hospitality',   4.0, '456 Sainte-Catherine, Montreal',  11),
    ('Pacific West Lodgings',    2.5, '789 Robson St, Vancouver',        11),
    ('Chinook Skyline Suites',   4.5, '101 8th Avenue, Calgary',         11),
    ('Northern Lights Retreat',  1.5, '202 Jasper Ave, Edmonton',       11);


-- ==============================
-- Courriels pour chaque chaîne
-- ==============================
INSERT INTO Chaine_Hoteliere_Courriels (ID_Chaine, Courriel) VALUES
    (1, 'info@tnthotels.ca'),
    (1, 'reservations@tnthotels.ca'),
    (1, 'contact@tnthotels.ca'),
    (1, 'jobs@tnthotels.ca'),
    (2, 'info@montroyalhospitality.ca'),
    (2, 'reservations@montroyalhospitality.ca'),
    (2, 'sales@montroyalhospitality.ca'),
    (2, 'hr@montroyalhospitality.ca'),
    (2, 'marketing@montroyalhospitality.ca'),
    (2, 'admin@montroyalhospitality.ca'),
    (2, 'events@montroyalhospitality.ca'),
    (3, 'info@pacificwestlodgings.ca'),
    (3, 'booking@pacificwestlodgings.ca'),
    (3, 'group@pacificwestlodgings.ca'),
    (3, 'corporate@pacificwestlodgings.ca'),
    (3, 'careers@pacificwestlodgings.ca'),
    (3, 'media@pacificwestlodgings.ca'),
    (4, 'info@chinookskylinesuites.ca'),
    (4, 'reservations@chinookskylinesuites.ca'),
    (4, 'vip@chinookskylinesuites.ca'),
    (4, 'hr@chinookskylinesuites.ca'),
    (4, 'contact@chinookskylinesuites.ca'),
    (5, 'info@northernlightsretreat.ca'),
    (5, 'reservations@northernlightsretreat.ca'),
    (5, 'tours@northernlightsretreat.ca'),
    (5, 'support@northernlightsretreat.ca');


-- ==============================
-- Téléphones pour chaque chaîne
-- ==============================
INSERT INTO Chaine_Hoteliere_Telephones (ID_Chaine, Telephone) VALUES
    (1, '(416) 555-0101'),
    (1, '(416) 555-0102'),
    (1, '(416) 555-0103'),
    (1, '(416) 555-0104'),
    (1, '(416) 555-0105'),
    (1, '(416) 555-0106'),
    (2, '(514) 555-0201'),
    (2, '(514) 555-0202'),
    (2, '(514) 555-0203'),
    (2, '(514) 555-0204'),
    (2, '(514) 555-0205'),
    (3, '(604) 555-0301'),
    (3, '(604) 555-0302'),
    (3, '(604) 555-0303'),
    (3, '(604) 555-0304'),
    (3, '(604) 555-0305'),
    (3, '(604) 555-0306'),
    (3, '(604) 555-0307'),
    (3, '(604) 555-0308'),
    (4, '(403) 555-0401'),
    (4, '(403) 555-0402'),
    (4, '(403) 555-0403'),
    (4, '(403) 555-0404'),
    (5, '(780) 555-0501'),
    (5, '(780) 555-0502'),
    (5, '(780) 555-0503'),
    (5, '(780) 555-0504'),
    (5, '(780) 555-0505'),
    (5, '(780) 555-0506'),
    (5, '(780) 555-0507');


-- ==============================
-- Insertion des 55 hôtels
-- ==============================
INSERT INTO Hotel (Nom_Hotel, Classification, Adresse_Hotel, Nombre_de_chambres, ID_Chaine, NAS_Directeur, Nom_Directeur, Adresse_Directeur)
VALUES
-- 1) Toronto
('Distillery District Inn', 3.2, '100 King St, Toronto, ON', 15, 1, '111111111', 'John Campbell', '200 Queen St, Toronto, ON'),
('CN Tower View Hotel',     4.0, '101 King St, Toronto, ON', 18, 2, '111111112', 'Emily Thompson', '201 Queen St, Toronto, ON'),
('Casa Loma Suites',        2.8, '102 King St, Toronto, ON', 10, 3, '111111113', 'Marc Tremblay', '202 Queen St, Toronto, ON'),

-- 2) Montréal
('Basilique Notre-Dame Hotel', 4.2, '300 Rue Sainte-Catherine, Montréal, QC', 12, 2, '222222221', 'Sophie Gagnon', '400 Rue Sherbrooke, Montréal, QC'),
('Mont Royal Skyline Inn',     2.6, '301 Rue Sainte-Catherine, Montréal, QC',  9, 3, '222222222', 'Luc Tremblay', '401 Rue Sherbrooke, Montréal, QC'),
('Vieux-Port Heritage Suites', 4.7, '302 Rue Sainte-Catherine, Montréal, QC', 16, 4, '222222223', 'Antoine Lavoie', '402 Rue Sherbrooke, Montréal, QC'),
('La Ronde Riverside Lodge',   1.8, '303 Rue Sainte-Catherine, Montréal, QC',  5, 5, '222222224', 'Maxime Beaupré', '403 Rue Sherbrooke, Montréal, QC'),

-- 3) Vancouver
('Stanley Park Resort',       3.5, '500 Robson St, Vancouver, BC', 20, 1, '333333331', 'James Wilson', '600 Robson St, Vancouver, BC'),
('Granville Island Hotel',    4.4, '501 Robson St, Vancouver, BC',  8, 4, '333333332', 'Robert McKenzie', '601 Robson St, Vancouver, BC'),
('Capilano Bridge Retreat',   1.7, '502 Robson St, Vancouver, BC', 10, 5, '333333333', 'Henry Wong', '602 Robson St, Vancouver, BC'),

-- 4) Calgary
('Calgary Tower Hotel',     3.6, '700 8th Ave, Calgary, AB',  7, 1, '444444441', 'Sarah Mitchell', '800 8th Ave, Calgary, AB'),
('Stephen Avenue Suites',   4.5, '701 8th Ave, Calgary, AB', 12, 4, '444444442', 'Ian MacDonald',  '801 8th Ave, Calgary, AB'),
('Princes Island Inn',    1.9, '702 8th Ave, Calgary, AB',  5, 5, '444444443', 'Kara Smith',     '802 8th Ave, Calgary, AB'),

-- 5) Edmonton
('West Edmonton Mall Stay',      3.0, '900 Jasper Ave, Edmonton, AB',  6, 1, '555555551', 'Daniel Brown',   '1000 Jasper Ave, Edmonton, AB'),
('Muttart Conservatory Lodge',   4.1, '901 Jasper Ave, Edmonton, AB', 19, 2, '555555552', 'Jennifer White', '1001 Jasper Ave, Edmonton, AB'),
('Fort Edmonton Hotel',          1.6, '902 Jasper Ave, Edmonton, AB',  8, 5, '555555553', 'Lauren Jones',   '1002 Jasper Ave, Edmonton, AB'),

-- 6) Ottawa
('Parliament Hill Inn',  3.4, '1100 Elgin St, Ottawa, ON', 10, 1, '666666661', 'Matthew Green',   '1200 Elgin St, Ottawa, ON'),
('ByWard Market Hotel',  4.0, '1101 Elgin St, Ottawa, ON',  10, 2, '666666662', 'Ava Clarkson',    '1201 Elgin St, Ottawa, ON'),
('Rideau Canal Lodge',   2.9, '1102 Elgin St, Ottawa, ON',  9, 3, '666666663', 'Étienne Caron',   '1202 Elgin St, Ottawa, ON'),

-- 7) Winnipeg
('The Forks Heritage Hotel',   3.8, '1300 Portage Ave, Winnipeg, MB',  8, 2, '777777771', 'Linda Peterson',   '1400 Portage Ave, Winnipeg, MB'),
('Canadian Museum Suites',     2.4, '1301 Portage Ave, Winnipeg, MB', 11, 3, '777777772', 'Jean-Marc Poirier','1401 Portage Ave, Winnipeg, MB'),
('Esplanade Riel Resort',      4.6, '1302 Portage Ave, Winnipeg, MB', 16, 4, '777777773', 'Dylan Johnson',    '1402 Portage Ave, Winnipeg, MB'),

-- 8) Québec
('Chateau Frontenac Inn',    2.5, '1500 Grande Allée, Québec, QC', 14, 3, '888888881', 'François Mercier', '1600 Grande Allée, Québec, QC'),
('Plains of Abraham Hotel',  4.8, '1501 Grande Allée, Québec, QC', 20, 4, '888888882', 'Nicolas Bouchard','1601 Grande Allée, Québec, QC'),
('Petit Champlain Lodge',    1.4, '1502 Grande Allée, Québec, QC',  7, 5, '888888883', 'Léa Tremblay',     '1602 Grande Allée, Québec, QC'),

-- 9) Hamilton
('Dundurn Castle Inn',                3.3, '1700 Main St, Hamilton, ON',  6, 1, '999999991', 'Jason Clark',     '1800 Main St, Hamilton, ON'),
('Royal Botanical Gardens Suites',    4.3, '1701 Main St, Hamilton, ON',  9, 4, '999999992', 'Oliver Stewart',  '1801 Main St, Hamilton, ON'),
('Bayfront Park Hotel',              1.5, '1702 Main St, Hamilton, ON', 15, 5, '999999993', 'Kevin Liu',       '1802 Main St, Hamilton, ON'),

-- 10) Kitchener
('Victoria Park Kitchener Inn', 3.7, '200 King St, Kitchener, ON',  8, 1, '101010101', 'George Harrison', '210 King St, Kitchener, ON'),
('St. Jacobs Market Hotel',     4.2, '201 King St, Kitchener, ON',  5, 2, '101010102', 'Alicia Gordon',   '211 King St, Kitchener, ON'),
('Chicopee Ski Lodge',          1.4, '202 King St, Kitchener, ON', 17, 5, '101010103', 'Timothy Baker',   '212 King St, Kitchener, ON'),

-- 11) London
('Covent Garden Hotel',                 3.0, '300 Wellington Rd, London, ON',  8, 1, '121212121', 'Chris Adams',     '310 Wellington Rd, London, ON'),
('Budweiser Gardens Inn',               4.3, '301 Wellington Rd, London, ON',  9, 2, '121212122', 'Grace Patterson', '311 Wellington Rd, London, ON'),
('Fanshawe Pioneer Village Lodge',      2.7, '302 Wellington Rd, London, ON', 10, 3, '121212123', 'Gabriel Dubois',  '312 Wellington Rd, London, ON'),

-- 12) Victoria
('Butchart Gardens Resort',      3.9, '400 Douglas St, Victoria, BC',  6, 2, '131313131', 'Hailey Robertson', '410 Douglas St, Victoria, BC'),
('Craigdarroch Castle Inn',      2.8, '401 Douglas St, Victoria, BC',  7, 3, '131313132', 'Xavier Leblanc',   '411 Douglas St, Victoria, BC'),
('Fisherman''s Wharf Hotel',     4.9, '402 Douglas St, Victoria, BC', 12, 4, '131313133', 'Morgan Price',     '412 Douglas St, Victoria, BC'),

-- 13) Halifax
('Citadel Hill Inn',        2.3, '500 Barrington St, Halifax, NS',  5, 3, '141414141', 'Jean Roy',        '510 Barrington St, Halifax, NS'),
('Peggy''s Cove Lodge',     4.4, '501 Barrington St, Halifax, NS',  8, 4, '141414142', 'Charlotte Hughes','511 Barrington St, Halifax, NS'),
('Halifax Waterfront Suites',1.7, '502 Barrington St, Halifax, NS', 9, 5, '141414143', 'Ian Fraser',      '512 Barrington St, Halifax, NS'),

-- 14) Oshawa
('Parkwood Estate Hotel',                  3.6, '600 King St, Oshawa, ON', 15, 1, '151515151', 'Peter McDonald',         '610 King St, Oshawa, ON'),
('Canadian Automotive Museum Inn',         4.5, '601 King St, Oshawa, ON',16, 4, '151515152', 'Derek Thomson',          '611 King St, Oshawa, ON'),
('Oshawa Valleylands Suites',              1.3, '602 King St, Oshawa, ON', 6, 5, '151515153', 'Andrew Davis',           '612 King St, Oshawa, ON'),

-- 15) Windsor
('Dieppe Gardens Inn',         3.2, '700 Riverside Dr, Windsor, ON', 14, 1, '161616161', 'Brandon Kelly',   '710 Riverside Dr, Windsor, ON'),
('Windsor Riverfront Hotel',   4.1, '701 Riverside Dr, Windsor, ON',  8, 2, '161616162', 'Melissa Carter',  '711 Riverside Dr, Windsor, ON'),
('Adventure Bay Lodge',        1.9, '702 Riverside Dr, Windsor, ON',  5, 5, '161616163', 'Samantha O''Neill','712 Riverside Dr, Windsor, ON'),

-- 16) Saskatoon
('Wanuskewin Heritage Inn', 3.8, '800 22nd St, Saskatoon, SK',  9, 1, '171717171', 'Brad Miller',   '810 22nd St, Saskatoon, SK'),
('Remai Modern Hotel',      4.0, '801 22nd St, Saskatoon, SK', 12, 2, '171717172', 'Janet Martin',  '811 22nd St, Saskatoon, SK'),
('Broadway District Suites',2.4, '802 22nd St, Saskatoon, SK',  7, 3, '171717173', 'Rémy Gauthier', '812 22nd St, Saskatoon, SK'),

-- 17) Regina
('Wascana Centre Lodge',          4.2, '900 Victoria Ave, Regina, SK',  6, 2, '181818181', 'Catherine Reid', '910 Victoria Ave, Regina, SK'),
('RCMP Heritage Inn',             2.6, '901 Victoria Ave, Regina, SK',  5, 3, '181818182', 'Vincent Fortin', '911 Victoria Ave, Regina, SK'),
('Legislative Building Hotel',    4.3, '902 Victoria Ave, Regina, SK', 13, 4, '181818183', 'Trevor Gray',    '912 Victoria Ave, Regina, SK'),

-- 18) St. John’s
('Signal Hill Suites',    2.5, '100 Water St, St. John''s, NL',  5, 3, '191919191', 'Jean-Paul Martin', '110 Water St, St. John''s, NL'),
('George Street Hotel',   4.6, '101 Water St, St. John''s, NL', 10, 4, '191919192', 'Ashley Doyle',     '111 Water St, St. John''s, NL'),
('Cape Spear Retreat',    1.4, '102 Water St, St. John''s, NL',  10, 5, '191919193', 'Cody Williams',    '112 Water St, St. John''s, NL');

-- ==============================
-- Courriels pour chaque hôtel
-- ==============================
INSERT INTO Hotel_Courriels (ID_Hotel, Courriel)
VALUES
    -- 1) Toronto
    (1, 'info@distillerydistrictinn.ca'),
    (1, 'reservations@distillerydistrictinn.ca'),
    (2, 'info@cntowerviewhotel.ca'),
    (2, 'reservations@cntowerviewhotel.ca'),
    (3, 'info@casalomasuites.ca'),
    (3, 'reservations@casalomasuites.ca'),

    -- 2) Montréal
    (4, 'info@basiliquenotredamehotel.ca'),
    (4, 'reservations@basiliquenotredamehotel.ca'),
    (5, 'info@montroyalskylineinn.ca'),
    (5, 'reservations@montroyalskylineinn.ca'),
    (6, 'info@vieuxportheritagesuites.ca'),
    (6, 'reservations@vieuxportheritagesuites.ca'),
    (7, 'info@laronderiversidelodge.ca'),
    (7, 'reservations@laronderiversidelodge.ca'),

    -- 3) Vancouver
    (8, 'info@stanleyparkresort.ca'),
    (8, 'reservations@stanleyparkresort.ca'),
    (9, 'info@granvilleislandhotel.ca'),
    (9, 'reservations@granvilleislandhotel.ca'),
    (10, 'info@capilanobridgeretreat.ca'),
    (10, 'reservations@capilanobridgeretreat.ca'),

    -- 4) Calgary
    (11, 'info@calgarytowerhotel.ca'),
    (11, 'reservations@calgarytowerhotel.ca'),
    (12, 'info@stephenavenuesuites.ca'),
    (12, 'reservations@stephenavenuesuites.ca'),
    (13, 'info@princesislandinn.ca'),
    (13, 'reservations@princesislandinn.ca'),

    -- 5) Edmonton
    (14, 'info@westedmontonmallstay.ca'),
    (14, 'reservations@westedmontonmallstay.ca'),
    (15, 'info@muttartconservatorylodge.ca'),
    (15, 'reservations@muttartconservatorylodge.ca'),
    (16, 'info@fortedmontonhotel.ca'),
    (16, 'reservations@fortedmontonhotel.ca'),

    -- 6) Ottawa
    (17, 'info@parliamenthillinn.ca'),
    (17, 'reservations@parliamenthillinn.ca'),
    (18, 'info@bywardmarkethotel.ca'),
    (18, 'reservations@bywardmarkethotel.ca'),
    (19, 'info@rideaucanallodge.ca'),
    (19, 'reservations@rideaucanallodge.ca'),

    -- 7) Winnipeg
    (20, 'info@theforksheritagehotel.ca'),
    (20, 'reservations@theforksheritagehotel.ca'),
    (21, 'info@canadianmuseumsuites.ca'),
    (21, 'reservations@canadianmuseumsuites.ca'),
    (22, 'info@esplanaderielresort.ca'),
    (22, 'reservations@esplanaderielresort.ca'),

    -- 8) Québec
    (23, 'info@chateaufrontenacinn.ca'),
    (23, 'reservations@chateaufrontenacinn.ca'),
    (24, 'info@plainsofabrahamhotel.ca'),
    (24, 'reservations@plainsofabrahamhotel.ca'),
    (25, 'info@petitchamplainlodge.ca'),
    (25, 'reservations@petitchamplainlodge.ca'),

    -- 9) Hamilton
    (26, 'info@dundurncastleinn.ca'),
    (26, 'reservations@dundurncastleinn.ca'),
    (27, 'info@royalbotanicalgardenssuites.ca'),
    (27, 'reservations@royalbotanicalgardenssuites.ca'),
    (28, 'info@bayfrontparkhotel.ca'),
    (28, 'reservations@bayfrontparkhotel.ca'),

    -- 10) Kitchener
    (29, 'info@victoriaparkkitchenerinn.ca'),
    (29, 'reservations@victoriaparkkitchenerinn.ca'),
    (30, 'info@stjacobsmarkethotel.ca'),
    (30, 'reservations@stjacobsmarkethotel.ca'),
    (31, 'info@chicopeeskilodge.ca'),
    (31, 'reservations@chicopeeskilodge.ca'),

    -- 11) London
    (32, 'info@coventgardenhotel.ca'),
    (32, 'reservations@coventgardenhotel.ca'),
    (33, 'info@budweisergardensinn.ca'),
    (33, 'reservations@budweisergardensinn.ca'),
    (34, 'info@fanshawepioneervillagelodge.ca'),
    (34, 'reservations@fanshawepioneervillagelodge.ca'),

    -- 12) Victoria
    (35, 'info@butchartgardensresort.ca'),
    (35, 'reservations@butchartgardensresort.ca'),
    (36, 'info@craigdarrochcastleinn.ca'),
    (36, 'reservations@craigdarrochcastleinn.ca'),
    (37, 'info@fishermanswharfhotel.ca'),
    (37, 'reservations@fishermanswharfhotel.ca'),

    -- 13) Halifax
    (38, 'info@citadelhillinn.ca'),
    (38, 'reservations@citadelhillinn.ca'),
    (39, 'info@peggyscovelodge.ca'),
    (39, 'reservations@peggyscovelodge.ca'),
    (40, 'info@halifaxwaterfrontsuites.ca'),
    (40, 'reservations@halifaxwaterfrontsuites.ca'),

    -- 14) Oshawa
    (41, 'info@parkwoodestatehotel.ca'),
    (41, 'reservations@parkwoodestatehotel.ca'),
    (42, 'info@canadianautomotivemuseuminn.ca'),
    (42, 'reservations@canadianautomotivemuseuminn.ca'),
    (43, 'info@oshawavalleylandssuites.ca'),
    (43, 'reservations@oshawavalleylandssuites.ca'),

    -- 15) Windsor
    (44, 'info@dieppegardensinn.ca'),
    (44, 'reservations@dieppegardensinn.ca'),
    (45, 'info@windsorriverfronthotel.ca'),
    (45, 'reservations@windsorriverfronthotel.ca'),
    (46, 'info@adventurebaylodge.ca'),
    (46, 'reservations@adventurebaylodge.ca'),

    -- 16) Saskatoon
    (47, 'info@wanuskewinheritageinn.ca'),
    (47, 'reservations@wanuskewinheritageinn.ca'),
    (48, 'info@remaimodernhotel.ca'),
    (48, 'reservations@remaimodernhotel.ca'),
    (49, 'info@broadwaydistrictsuites.ca'),
    (49, 'reservations@broadwaydistrictsuites.ca'),

    -- 17) Regina
    (50, 'info@wascanacentrelodge.ca'),
    (50, 'reservations@wascanacentrelodge.ca'),
    (51, 'info@rcmpheritageinn.ca'),
    (51, 'reservations@rcmpheritageinn.ca'),
    (52, 'info@legislativebuildinghotel.ca'),
    (52, 'reservations@legislativebuildinghotel.ca'),

    -- 18) St. John’s
    (53, 'info@signalhillsuites.ca'),
    (53, 'reservations@signalhillsuites.ca'),
    (54, 'info@georgestreethotel.ca'),
    (54, 'reservations@georgestreethotel.ca'),
    (55, 'info@capespearretreat.ca'),
    (55, 'reservations@capespearretreat.ca');


-- ==============================
-- Téléphones pour chaque hôtel
-- ==============================
INSERT INTO Hotel_Telephones (ID_Hotel, Telephone)
VALUES
    -- 1) Toronto (416)
    (1, '(416) 555-1101'),
    (1, '(416) 555-1102'),
    (2, '(416) 555-1201'),
    (2, '(416) 555-1202'),
    (3, '(416) 555-1301'),
    (3, '(416) 555-1302'),

    -- 2) Montréal (514)
    (4, '(514) 555-2101'),
    (4, '(514) 555-2102'),
    (5, '(514) 555-2201'),
    (5, '(514) 555-2202'),
    (6, '(514) 555-2301'),
    (6, '(514) 555-2302'),
    (7, '(514) 555-2401'),
    (7, '(514) 555-2402'),

    -- 3) Vancouver (604)
    (8, '(604) 555-3101'),
    (8, '(604) 555-3102'),
    (9, '(604) 555-3201'),
    (9, '(604) 555-3202'),
    (10, '(604) 555-3301'),
    (10, '(604) 555-3302'),

    -- 4) Calgary (403)
    (11, '(403) 555-4101'),
    (11, '(403) 555-4102'),
    (12, '(403) 555-4201'),
    (12, '(403) 555-4202'),
    (13, '(403) 555-4301'),
    (13, '(403) 555-4302'),

    -- 5) Edmonton (780)
    (14, '(780) 555-5101'),
    (14, '(780) 555-5102'),
    (15, '(780) 555-5201'),
    (15, '(780) 555-5202'),
    (16, '(780) 555-5301'),
    (16, '(780) 555-5302'),

    -- 6) Ottawa (613)
    (17, '(613) 555-6101'),
    (17, '(613) 555-6102'),
    (18, '(613) 555-6201'),
    (18, '(613) 555-6202'),
    (19, '(613) 555-6301'),
    (19, '(613) 555-6302'),

    -- 7) Winnipeg (204)
    (20, '(204) 555-7201'),
    (20, '(204) 555-7202'),
    (21, '(204) 555-7301'),
    (21, '(204) 555-7302'),
    (22, '(204) 555-7401'),
    (22, '(204) 555-7402'),

    -- 8) Québec (418)
    (23, '(418) 555-8101'),
    (23, '(418) 555-8102'),
    (24, '(418) 555-8201'),
    (24, '(418) 555-8202'),
    (25, '(418) 555-8301'),
    (25, '(418) 555-8302'),

    -- 9) Hamilton (905)
    (26, '(905) 555-9101'),
    (26, '(905) 555-9102'),
    (27, '(905) 555-9201'),
    (27, '(905) 555-9202'),
    (28, '(905) 555-9301'),
    (28, '(905) 555-9302'),

    -- 10) Kitchener (519)
    (29, '(519) 555-0101'),
    (29, '(519) 555-0102'),
    (30, '(519) 555-0201'),
    (30, '(519) 555-0202'),
    (31, '(519) 555-0301'),
    (31, '(519) 555-0302'),

    -- 11) London (519)
    (32, '(519) 555-1101'),
    (32, '(519) 555-1102'),
    (33, '(519) 555-1201'),
    (33, '(519) 555-1202'),
    (34, '(519) 555-1301'),
    (34, '(519) 555-1302'),

    -- 12) Victoria (250)
    (35, '(250) 555-2101'),
    (35, '(250) 555-2102'),
    (36, '(250) 555-2201'),
    (36, '(250) 555-2202'),
    (37, '(250) 555-2301'),
    (37, '(250) 555-2302'),

    -- 13) Halifax (902)
    (38, '(902) 555-3101'),
    (38, '(902) 555-3102'),
    (39, '(902) 555-3201'),
    (39, '(902) 555-3202'),
    (40, '(902) 555-3301'),
    (40, '(902) 555-3302'),

    -- 14) Oshawa (905)
    (41, '(905) 555-4101'),
    (41, '(905) 555-4102'),
    (42, '(905) 555-4201'),
    (42, '(905) 555-4202'),
    (43, '(905) 555-4301'),
    (43, '(905) 555-4302'),

    -- 15) Windsor (519)
    (44, '(519) 555-5101'),
    (44, '(519) 555-5102'),
    (45, '(519) 555-5201'),
    (45, '(519) 555-5202'),
    (46, '(519) 555-5301'),
    (46, '(519) 555-5302'),

    -- 16) Saskatoon (306)
    (47, '(306) 555-6101'),
    (47, '(306) 555-6102'),
    (48, '(306) 555-6201'),
    (48, '(306) 555-6202'),
    (49, '(306) 555-6301'),
    (49, '(306) 555-6302'),

    -- 17) Regina (306)
    (50, '(306) 555-7101'),
    (50, '(306) 555-7102'),
    (51, '(306) 555-7201'),
    (51, '(306) 555-7202'),
    (52, '(306) 555-7301'),
    (52, '(306) 555-7302'),

    -- 18) St. John’s (709)
    (53, '(709) 555-8101'),
    (53, '(709) 555-8102'),
    (54, '(709) 555-8201'),
    (54, '(709) 555-8202'),
    (55, '(709) 555-8301'),
    (55, '(709) 555-8302');


-- ==============================
-- Insertion de 560 chambres
-- ==============================
INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 1, 128.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 1, 135.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 1, 150.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 1, 142.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 1, 135.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 1, 128.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(202, 1, 135.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(203, 1, 150.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(204, 1, 142.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(205, 1, 135.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(301, 1, 128.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(302, 1, 135.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(303, 1, 150.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(304, 1, 142.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(305, 1, 135.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré');


INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 2, 144.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 2, 151.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 2, 166.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 2, 158.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 2, 151.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 2, 144.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(202, 2, 151.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(203, 2, 166.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(204, 2, 158.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(205, 2, 151.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(301, 2, 144.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(302, 2, 151.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(303, 2, 166.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(304, 2, 158.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(305, 2, 151.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(401, 2, 144.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(402, 2, 151.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(403, 2, 166.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante');

INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 3, 120.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 3, 127.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 3, 142.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 3, 134.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 3, 127.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 3, 120.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(202, 3, 127.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(203, 3, 142.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(204, 3, 134.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(205, 3, 127.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré');

INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 4, 148.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 4, 155.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 4, 170.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 4, 162.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 4, 155.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 4, 148.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(202, 4, 155.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(203, 4, 170.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(204, 4, 162.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(205, 4, 155.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(301, 4, 148.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(302, 4, 155.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain');

INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 5, 116.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 5, 123.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 5, 138.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 5, 130.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 5, 123.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 5, 116.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(202, 5, 123.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(203, 5, 138.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(204, 5, 130.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL);

INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 6, 158.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 6, 165.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 6, 180.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 6, 172.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 6, 165.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 6, 158.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(202, 6, 165.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(203, 6, 180.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(204, 6, 172.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(205, 6, 165.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(301, 6, 158.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(302, 6, 165.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(303, 6, 180.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(304, 6, 172.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(305, 6, 165.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(401, 6, 158.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL);

INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 7, 100.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 7, 107.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 7, 122.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 7, 114.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 7, 107.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré');

INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 8, 134.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 8, 141.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 8, 156.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 8, 148.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 8, 141.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 8, 134.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(202, 8, 141.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(203, 8, 156.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(204, 8, 148.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(205, 8, 141.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(301, 8, 134.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(302, 8, 141.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(303, 8, 156.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(304, 8, 148.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(305, 8, 141.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(401, 8, 134.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(402, 8, 141.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(403, 8, 156.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(404, 8, 148.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(405, 8, 141.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré');

INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 9, 152.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 9, 159.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 9, 174.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 9, 166.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 9, 159.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 9, 152.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(202, 9, 159.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(203, 9, 174.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante');

INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 10, 98.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 10, 105.00, 'TV, AC, Fridge',                2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 10, 120.00, 'TV, AC, Kitchenette',           4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 10, 112.00, 'TV, AC, Microwave, Fridge',     2, 'océan',    FALSE, NULL),
(105, 10, 105.00, 'TV, AC, Coffee machine',        1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 10, 98.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(202, 10, 105.00, 'TV, AC, Fridge',                2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(203, 10, 120.00, 'TV, AC, Kitchenette',           4, 'mer',      TRUE,  'Climatisation bruyante'),
(204, 10, 112.00, 'TV, AC, Microwave, Fridge',     2, 'océan',    FALSE, NULL),
(205, 10, 105.00, 'TV, AC, Coffee machine',        1, 'forêt',    TRUE,  'Mur fissuré');

INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 11, 136.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 11, 143.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 11, 158.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 11, 150.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 11, 143.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 11, 136.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(202, 11, 143.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain');

INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 12, 154.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 12, 161.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 12, 176.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 12, 168.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 12, 161.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 12, 154.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(202, 12, 161.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(203, 12, 176.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(204, 12, 168.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(205, 12, 161.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(301, 12, 154.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(302, 12, 161.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain');

INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 13, 102.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 13, 109.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 13, 124.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 13, 116.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 13, 109.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré');


INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
(101, 14, 124.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
(102, 14, 131.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
(103, 14, 146.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
(104, 14, 138.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
(105, 14, 131.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
(201, 14, 124.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL);


INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 15, 146.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 15, 153.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 15, 168.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 15, 160.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 15, 153.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 15, 146.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (202, 15, 153.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 15, 168.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (204, 15, 160.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (205, 15, 153.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (301, 15, 146.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (302, 15, 153.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (303, 15, 168.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (304, 15, 160.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (305, 15, 153.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (401, 15, 146.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (402, 15, 153.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (403, 15, 168.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (404, 15, 160.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL);


INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 16, 88.00, 'TV, AC', 1, 'aucune', FALSE, NULL),
  (102, 16, 95.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 16, 100.00, 'TV, AC, Kitchenette', 2, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 16, 92.00, 'TV, AC, Microwave, Fridge', 1, 'océan', FALSE, NULL),
  (105, 16, 90.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 16, 88.00, 'TV, AC', 1, 'aucune', FALSE, NULL),
  (202, 16, 95.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 16, 100.00, 'TV, AC, Kitchenette', 2, 'mer', TRUE, 'Climatisation bruyante');


INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 17, 136.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 17, 143.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 17, 158.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 17, 150.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 17, 143.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 17, 136.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (202, 17, 143.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 17, 158.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (204, 17, 150.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (205, 17, 143.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 18, 144.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 18, 151.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 18, 166.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 18, 158.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 18, 151.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 18, 144.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (202, 18, 151.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 18, 166.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (204, 18, 158.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (205, 18, 151.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré');


INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 19, 120.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (102, 19, 127.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 19, 142.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 19, 134.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 19, 127.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 19, 120.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (202, 19, 127.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 19, 142.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 19, 134.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL);


INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 20, 152.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (102, 20, 159.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 20, 174.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 20, 166.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 20, 159.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 20, 152.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (202, 20, 159.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 20, 174.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante');




INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 21, 120.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (102, 21, 127.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 21, 142.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 21, 134.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 21, 127.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 21, 120.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (202, 21, 127.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 21, 142.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 21, 134.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (205, 21, 127.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (301, 21, 120.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL);



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 22, 180.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (102, 22, 188.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 22, 205.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 22, 198.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 22, 188.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 22, 180.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (202, 22, 188.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 22, 205.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 22, 198.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (205, 22, 188.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (301, 22, 180.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (302, 22, 188.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (303, 22, 205.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (304, 22, 198.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (305, 22, 188.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (401, 22, 180.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL);




INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 23, 130.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (102, 23, 137.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 23, 152.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 23, 144.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 23, 137.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 23, 130.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (202, 23, 137.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 23, 152.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 23, 144.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (205, 23, 137.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (301, 23, 130.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (302, 23, 137.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (303, 23, 152.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (304, 23, 144.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL);




INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 24, 190.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (102, 24, 198.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 24, 215.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 24, 208.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 24, 198.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 24, 190.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (202, 24, 198.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 24, 215.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 24, 208.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (205, 24, 198.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (301, 24, 190.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (302, 24, 198.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (303, 24, 215.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (304, 24, 208.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (305, 24, 198.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (401, 24, 190.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (402, 24, 198.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (403, 24, 215.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (404, 24, 208.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (405, 24, 198.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 25, 100.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (102, 25, 107.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 25, 122.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 25, 114.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 25, 107.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 25, 100.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (202, 25, 107.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain');


INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 26, 140.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (102, 26, 147.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 26, 162.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 26, 154.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 26, 147.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 26, 140.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL);




INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 27, 160.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (102, 27, 167.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 27, 182.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 27, 174.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 27, 167.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 27, 160.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (202, 27, 167.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 27, 182.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 27, 174.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL);



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 28, 110.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 28, 117.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 28, 132.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 28, 124.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 28, 117.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 28, 110.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (202, 28, 117.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 28, 132.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (204, 28, 124.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (205, 28, 117.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (301, 28, 110.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (302, 28, 117.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (303, 28, 132.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (304, 28, 124.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (305, 28, 117.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré');




INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 29, 150.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 29, 157.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 29, 172.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 29, 164.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 29, 157.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 29, 150.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (202, 29, 157.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 29, 172.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante');




INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 30, 160.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 30, 167.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 30, 182.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 30, 174.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 30, 167.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 31, 100.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 31, 107.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 31, 122.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 31, 114.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 31, 107.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 31, 100.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (202, 31, 107.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 31, 122.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (204, 31, 114.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (205, 31, 107.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (301, 31, 100.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (302, 31, 107.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (303, 31, 122.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (304, 31, 114.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (305, 31, 107.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (401, 31, 100.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (402, 31, 107.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 32, 130.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 32, 137.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 32, 152.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 32, 144.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 32, 137.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 32, 130.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (202, 32, 137.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 32, 152.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 33, 150.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (102, 33, 157.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 33, 172.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 33, 164.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 33, 157.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 33, 150.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (202, 33, 157.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 33, 172.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 33, 164.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL);



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 34, 120.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (102, 34, 127.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 34, 142.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 34, 134.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 34, 127.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 34, 120.00, 'TV, AC',                         2, 'aucune',   FALSE, NULL),
  (202, 34, 127.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 34, 142.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 34, 134.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (205, 34, 127.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 35, 140.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 35, 147.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 35, 162.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 35, 154.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 35, 147.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 35, 140.00, 'TV, AC',                         2, 'aucune', FALSE, NULL);



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 36, 130.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 36, 137.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 36, 152.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 36, 144.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 36, 137.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 36, 130.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (202, 36, 137.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 37, 200.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 37, 208.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 37, 225.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 37, 218.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 37, 208.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 37, 200.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (202, 37, 208.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 37, 225.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 37, 218.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (205, 37, 208.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (301, 37, 200.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (302, 37, 208.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 38, 102.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 38, 109.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 38, 124.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 38, 116.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 38, 109.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 39, 150.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 39, 157.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 39, 172.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 39, 164.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 39, 157.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 39, 150.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (202, 39, 157.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 39, 172.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 40, 100.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 40, 107.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 40, 122.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 40, 114.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 40, 107.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 40, 100.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (202, 40, 107.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 40, 122.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 40, 114.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL);



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 41, 136.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 41, 143.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 41, 158.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 41, 150.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 41, 143.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 41, 136.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (202, 41, 143.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 41, 158.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 41, 150.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (205, 41, 143.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (301, 41, 136.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (302, 41, 143.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (303, 41, 158.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (304, 41, 150.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (305, 41, 143.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 42, 160.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 42, 168.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 42, 185.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 42, 178.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 42, 168.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 42, 160.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (202, 42, 168.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 42, 185.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 42, 178.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (205, 42, 168.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (301, 42, 160.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (302, 42, 168.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (303, 42, 185.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (304, 42, 178.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (305, 42, 168.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (401, 42, 160.00, 'TV, AC',                         2, 'aucune', FALSE, NULL);



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 43, 80.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 43, 87.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 43, 102.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 43, 94.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 43, 87.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 43, 80.00, 'TV, AC', 2, 'aucune', FALSE, NULL);



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 44, 130.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 44, 137.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 44, 152.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 44, 144.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 44, 137.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 44, 130.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (202, 44, 137.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 44, 152.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 44, 144.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (205, 44, 137.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (301, 44, 130.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (302, 44, 137.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (303, 44, 152.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (304, 44, 144.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL);


INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 45, 150.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 45, 157.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 45, 172.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 45, 164.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 45, 157.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 45, 150.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (202, 45, 157.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 45, 172.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 46, 150.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 46, 157.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 46, 172.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 46, 164.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 46, 157.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 47, 140.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 47, 147.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 47, 162.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 47, 154.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 47, 147.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 47, 140.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (202, 47, 147.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 47, 162.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (204, 47, 154.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL);



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 48, 150.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 48, 157.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 48, 172.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 48, 164.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 48, 157.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 48, 150.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (202, 48, 157.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 48, 172.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (204, 48, 164.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (205, 48, 157.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (301, 48, 150.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (302, 48, 157.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 49, 120.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 49, 127.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 49, 142.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 49, 134.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 49, 127.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 49, 120.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (202, 49, 127.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 50, 150.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 50, 157.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 50, 172.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 50, 164.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 50, 157.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 50, 150.00, 'TV, AC', 2, 'aucune', FALSE, NULL);



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 51, 130.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 51, 137.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 51, 152.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 51, 144.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 51, 137.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 52, 160.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 52, 167.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 52, 182.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 52, 174.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 52, 167.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (201, 52, 160.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (202, 52, 167.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 52, 182.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (204, 52, 174.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (205, 52, 167.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (301, 52, 160.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (302, 52, 167.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (303, 52, 182.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 53, 120.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 53, 127.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 53, 142.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 53, 134.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 53, 127.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré');



INSERT INTO Chambre 
  (Numero_Chambre, ID_Hotel, Prix_par_nuit, Commodites, Capacite, Vue, Etendues, Problemes)
VALUES
  (101, 54, 150.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (102, 54, 157.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 54, 172.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (104, 54, 164.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (105, 54, 157.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré'),
  (106, 54, 150.00, 'TV, AC',                         2, 'aucune', FALSE, NULL),
  (107, 54, 157.00, 'TV, AC, Fridge',                 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (108, 54, 172.00, 'TV, AC, Kitchenette',            4, 'mer',      TRUE,  'Climatisation bruyante'),
  (109, 54, 164.00, 'TV, AC, Microwave, Fridge',      2, 'océan',    FALSE, NULL),
  (110, 54, 157.00, 'TV, AC, Coffee machine',         1, 'forêt',    TRUE,  'Mur fissuré');




INSERT INTO Chambre (
  Numero_Chambre, ID_Hotel, Prix_par_nuit,
  Commodites, Capacite, Vue, Etendues, Problemes
)
VALUES
  (101, 55, 100.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (102, 55, 107.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (103, 55, 122.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (104, 55, 114.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (105, 55, 107.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré'),
  (201, 55, 100.00, 'TV, AC', 2, 'aucune', FALSE, NULL),
  (202, 55, 107.00, 'TV, AC, Fridge', 2, 'montagne', FALSE, 'Fuite dans la salle de bain'),
  (203, 55, 122.00, 'TV, AC, Kitchenette', 4, 'mer', TRUE, 'Climatisation bruyante'),
  (301, 55, 114.00, 'TV, AC, Microwave, Fridge', 2, 'océan', FALSE, NULL),
  (302, 55, 107.00, 'TV, AC, Coffee machine', 1, 'forêt', TRUE, 'Mur fissuré');



-- ======================
-- Insertion d'employés
-- ======================
-- Hôtel 1 : Distillery District Inn (Toronto, ON) – 5 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900000101', 'John Smith', '101 King St, Toronto, ON', 'Réception', 1),
('900000102', 'Michael Johnson', '102 King St, Toronto, ON', 'Service de Chambre', 1),
('900000103', 'David Brown', '103 King St, Toronto, ON', 'Service de Chambre', 1),
('900000104', 'Robert Davis', '104 King St, Toronto, ON', 'Réception', 1),
('900000105', 'William Miller', '105 King St, Toronto, ON', 'Service de Chambre', 1);

-- Hôtel 2 : CN Tower View Hotel (Toronto, ON) – 8 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900000201', 'Thomas Wilson', '106 King St, Toronto, ON', 'Réception', 2),
('900000202', 'Christopher Moore', '107 King St, Toronto, ON', 'Service de Chambre', 2),
('900000203', 'Daniel Taylor', '108 King St, Toronto, ON', 'Service de Chambre', 2),
('900000204', 'Matthew Anderson', '109 King St, Toronto, ON', 'Réception', 2),
('900000205', 'Anthony Thomas', '110 King St, Toronto, ON', 'Service de Chambre', 2),
('900000206', 'Mark Jackson', '111 King St, Toronto, ON', 'Réception', 2),
('900000207', 'Donald White', '112 King St, Toronto, ON', 'Service de Chambre', 2),
('900000208', 'Paul Harris', '113 King St, Toronto, ON', 'Réception', 2);

-- Hôtel 3 : Casa Loma Suites (Toronto, ON) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900000301', 'Steven Martin', '114 King St, Toronto, ON', 'Réception', 3),
('900000302', 'Kevin Thompson', '115 King St, Toronto, ON', 'Service de Chambre', 3),
('900000303', 'Brian Garcia', '116 King St, Toronto, ON', 'Service de Chambre', 3);

-- Hôtel 4 : Basilique Notre-Dame Hotel (Montréal, QC) – 6 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900000401', 'Georges Saint-Pierre', '101 Rue Sainte-Catherine, Montréal, QC', 'Réception', 4),
('900000402', 'Luc Gagnon', '102 Rue Sainte-Catherine, Montréal, QC', 'Service de Chambre', 4),
('900000403', 'Pierre Lavoie', '103 Rue Sainte-Catherine, Montréal, QC', 'Service de Chambre', 4),
('900000404', 'Marc Fortin', '104 Rue Sainte-Catherine, Montréal, QC', 'Réception', 4),
('900000405', 'André Morel', '105 Rue Sainte-Catherine, Montréal, QC', 'Service de Chambre', 4),
('900000406', 'Serge Pelletier', '106 Rue Sainte-Catherine, Montréal, QC', 'Réception', 4);

-- Hôtel 5 : Mont Royal Skyline Inn (Montréal, QC) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900000501', 'François Roy', '107 Rue Sainte-Catherine, Montréal, QC', 'Réception', 5),
('900000502', 'Éric Dubé', '108 Rue Sainte-Catherine, Montréal, QC', 'Service de Chambre', 5),
('900000503', 'Martin Leclerc', '109 Rue Sainte-Catherine, Montréal, QC', 'Service de Chambre', 5);

-- Hôtel 6 : Vieux-Port Heritage Suites (Montréal, QC) – 8 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900000601', 'Alain Gagné', '110 Rue Sainte-Catherine, Montréal, QC', 'Réception', 6),
('900000602', 'Pierre Mercier', '111 Rue Sainte-Catherine, Montréal, QC', 'Service de Chambre', 6),
('900000603', 'Jean-Paul Richard', '112 Rue Sainte-Catherine, Montréal, QC', 'Service de Chambre', 6),
('900000604', 'Claude Bouchard', '113 Rue Sainte-Catherine, Montréal, QC', 'Réception', 6),
('900000605', 'René Perreault', '114 Rue Sainte-Catherine, Montréal, QC', 'Service de Chambre', 6),
('900000606', 'Marcel Dion', '115 Rue Sainte-Catherine, Montréal, QC', 'Réception', 6),
('900000607', 'Gérard Morin', '116 Rue Sainte-Catherine, Montréal, QC', 'Service de Chambre', 6),
('900000608', 'Louis Charest', '117 Rue Sainte-Catherine, Montréal, QC', 'Réception', 6);

-- Hôtel 7 : La Ronde Riverside Lodge (Montréal, QC) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900000701', 'Sébastien Côté', '118 Rue Sainte-Catherine, Montréal, QC', 'Réception', 7),
('900000702', 'Olivier Beaulieu', '119 Rue Sainte-Catherine, Montréal, QC', 'Service de Chambre', 7),
('900000703', 'Nicolas Caron', '120 Rue Sainte-Catherine, Montréal, QC', 'Service de Chambre', 7);

-- Hôtel 8 : Stanley Park Resort (Vancouver, BC) – 7 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900000801', 'James Lee', '101 Robson St, Vancouver, BC', 'Réception', 8),
('900000802', 'Robert Kim', '102 Robson St, Vancouver, BC', 'Service de Chambre', 8),
('900000803', 'William Chen', '103 Robson St, Vancouver, BC', 'Service de Chambre', 8),
('900000804', 'John Patel', '104 Robson St, Vancouver, BC', 'Réception', 8),
('900000805', 'David Wong', '105 Robson St, Vancouver, BC', 'Service de Chambre', 8),
('900000806', 'Michael Singh', '106 Robson St, Vancouver, BC', 'Réception', 8),
('900000807', 'Richard Liu', '107 Robson St, Vancouver, BC', 'Service de Chambre', 8);

-- Hôtel 9 : Granville Island Hotel (Vancouver, BC) – 4 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900000901', 'Samuel Park', '108 Robson St, Vancouver, BC', 'Réception', 9),
('900000902', 'Andrew Scott', '109 Robson St, Vancouver, BC', 'Service de Chambre', 9),
('900000903', 'Benjamin Turner', '110 Robson St, Vancouver, BC', 'Service de Chambre', 9),
('900000904', 'Patrick Rogers', '111 Robson St, Vancouver, BC', 'Réception', 9);

-- Hôtel 10 : Capilano Bridge Retreat (Vancouver, BC) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900001001', 'Charles Evans', '112 Robson St, Vancouver, BC', 'Réception', 10),
('900001002', 'Edward Murphy', '113 Robson St, Vancouver, BC', 'Service de Chambre', 10),
('900001003', 'Anthony Bell', '114 Robson St, Vancouver, BC', 'Service de Chambre', 10);

-- Hôtel 11 : Calgary Tower Hotel (Calgary, AB) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900001101', 'Bruce Miller', '101 8th Ave, Calgary, AB', 'Réception', 11),
('900001102', 'Scott Wilson', '102 8th Ave, Calgary, AB', 'Service de Chambre', 11),
('900001103', 'Gordon Clark', '103 8th Ave, Calgary, AB', 'Service de Chambre', 11);

-- Hôtel 12 : Stephen Avenue Suites (Calgary, AB) – 6 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900001201', 'Derek Adams', '104 8th Ave, Calgary, AB', 'Réception', 12),
('900001202', 'Frank Baker', '105 8th Ave, Calgary, AB', 'Service de Chambre', 12),
('900001203', 'Ronald Carter', '106 8th Ave, Calgary, AB', 'Service de Chambre', 12),
('900001204', 'Patrick Davis', '107 8th Ave, Calgary, AB', 'Réception', 12),
('900001205', 'Samuel Edwards', '108 8th Ave, Calgary, AB', 'Service de Chambre', 12),
('900001206', 'George Foster', '109 8th Ave, Calgary, AB', 'Réception', 12);

-- Hôtel 13 : Princes Island Inn (Calgary, AB) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900001301', 'Larry Grant', '110 8th Ave, Calgary, AB', 'Réception', 13),
('900001302', 'Arthur Hughes', '111 8th Ave, Calgary, AB', 'Service de Chambre', 13),
('900001303', 'Victor Price', '112 8th Ave, Calgary, AB', 'Service de Chambre', 13);

-- Hôtel 14 : West Edmonton Mall Stay (Edmonton, AB) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900001401', 'Allen Parker', '101 Jasper Ave, Edmonton, AB', 'Réception', 14),
('900001402', 'Bruce Roberts', '102 Jasper Ave, Edmonton, AB', 'Service de Chambre', 14),
('900001403', 'Carl Stewart', '103 Jasper Ave, Edmonton, AB', 'Service de Chambre', 14);

-- Hôtel 15 : Muttart Conservatory Lodge (Edmonton, AB) – 8 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900001501', 'Eugene Turner', '104 Jasper Ave, Edmonton, AB', 'Réception', 15),
('900001502', 'Franklin Ward', '105 Jasper Ave, Edmonton, AB', 'Service de Chambre', 15),
('900001503', 'Gerald Young', '106 Jasper Ave, Edmonton, AB', 'Service de Chambre', 15),
('900001504', 'Harold Zimmerman', '107 Jasper Ave, Edmonton, AB', 'Réception', 15),
('900001505', 'Isaac Knight', '108 Jasper Ave, Edmonton, AB', 'Service de Chambre', 15),
('900001506', 'Jackie Reed', '109 Jasper Ave, Edmonton, AB', 'Réception', 15),
('900001507', 'Kenneth Brooks', '110 Jasper Ave, Edmonton, AB', 'Service de Chambre', 15),
('900001508', 'Louis Simmons', '111 Jasper Ave, Edmonton, AB', 'Réception', 15);

-- Hôtel 16 : Fort Edmonton Hotel (Edmonton, AB) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900001601', 'Martin Fisher', '112 Jasper Ave, Edmonton, AB', 'Réception', 16),
('900001602', 'Oliver Grant', '113 Jasper Ave, Edmonton, AB', 'Service de Chambre', 16),
('900001603', 'Patrick Howard', '114 Jasper Ave, Edmonton, AB', 'Service de Chambre', 16);

-- Hôtel 17 : Parliament Hill Inn (Ottawa, ON) – 4 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900001701', 'Richard Scott', '101 Elgin St, Ottawa, ON', 'Réception', 17),
('900001702', 'Samuel King', '102 Elgin St, Ottawa, ON', 'Service de Chambre', 17),
('900001703', 'Victor Lee', '103 Elgin St, Ottawa, ON', 'Service de Chambre', 17),
('900001704', 'Walter Young', '104 Elgin St, Ottawa, ON', 'Réception', 17);

-- Hôtel 18 : ByWard Market Hotel (Ottawa, ON) – 4 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900001801', 'Allen Harris', '105 Elgin St, Ottawa, ON', 'Réception', 18),
('900001802', 'Barry Nelson', '106 Elgin St, Ottawa, ON', 'Service de Chambre', 18),
('900001803', 'Clyde Mitchell', '107 Elgin St, Ottawa, ON', 'Service de Chambre', 18),
('900001804', 'Derek Price', '108 Elgin St, Ottawa, ON', 'Réception', 18);

-- Hôtel 19 : Rideau Canal Lodge (Ottawa, ON) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900001901', 'Ethan Roberts', '109 Elgin St, Ottawa, ON', 'Réception', 19),
('900001902', 'Frank Simmons', '110 Elgin St, Ottawa, ON', 'Service de Chambre', 19),
('900001903', 'George Turner', '111 Elgin St, Ottawa, ON', 'Service de Chambre', 19);

-- Hôtel 20 : The Forks Heritage Hotel (Winnipeg, MB) – 4 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900002001', 'Henry Walker', '101 Portage Ave, Winnipeg, MB', 'Réception', 20),
('900002002', 'Ivan Scott', '102 Portage Ave, Winnipeg, MB', 'Service de Chambre', 20),
('900002003', 'Jack Robinson', '103 Portage Ave, Winnipeg, MB', 'Service de Chambre', 20),
('900002004', 'Kevin Lewis', '104 Portage Ave, Winnipeg, MB', 'Réception', 20);

-- Hôtel 21 : Canadian Museum Suites (Winnipeg, MB) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900002101', 'Larry Young', '105 Portage Ave, Winnipeg, MB', 'Réception', 21),
('900002102', 'Martin Allen', '106 Portage Ave, Winnipeg, MB', 'Service de Chambre', 21),
('900002103', 'Nathan Carter', '107 Portage Ave, Winnipeg, MB', 'Service de Chambre', 21);

-- Hôtel 22 : Esplanade Riel Resort (Winnipeg, MB) – 8 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900002201', 'Oliver Davis', '108 Portage Ave, Winnipeg, MB', 'Réception', 22),
('900002202', 'Patrick Evans', '109 Portage Ave, Winnipeg, MB', 'Service de Chambre', 22),
('900002203', 'Quentin Foster', '110 Portage Ave, Winnipeg, MB', 'Service de Chambre', 22),
('900002204', 'Roger Garcia', '111 Portage Ave, Winnipeg, MB', 'Réception', 22),
('900002205', 'Steven Harris', '112 Portage Ave, Winnipeg, MB', 'Service de Chambre', 22),
('900002206', 'Trevor Ingram', '113 Portage Ave, Winnipeg, MB', 'Réception', 22),
('900002207', 'Ulysses Johnson', '114 Portage Ave, Winnipeg, MB', 'Service de Chambre', 22),
('900002208', 'Victor King', '115 Portage Ave, Winnipeg, MB', 'Réception', 22);

-- Hôtel 23 : Chateau Frontenac Inn (Québec, QC) – 4 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900002301', 'Alexandre Dupont', '101 Grande Allée, Québec, QC', 'Réception', 23),
('900002302', 'Benoit Roy', '102 Grande Allée, Québec, QC', 'Service de Chambre', 23),
('900002303', 'Céline Gauthier', '103 Grande Allée, Québec, QC', 'Service de Chambre', 23),
('900002304', 'Denis Fortier', '104 Grande Allée, Québec, QC', 'Réception', 23);

-- Hôtel 24 : Plains of Abraham Hotel (Québec, QC) – 10 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900002401', 'Émile Bergeron', '105 Grande Allée, Québec, QC', 'Réception', 24),
('900002402', 'François Lemieux', '106 Grande Allée, Québec, QC', 'Service de Chambre', 24),
('900002403', 'Gabriel Tremblay', '107 Grande Allée, Québec, QC', 'Service de Chambre', 24),
('900002404', 'Hervé Moreau', '108 Grande Allée, Québec, QC', 'Réception', 24),
('900002405', 'Isabelle Ouellet', '109 Grande Allée, Québec, QC', 'Service de Chambre', 24),
('900002406', 'Jocelyn Morin', '110 Grande Allée, Québec, QC', 'Réception', 24),
('900002407', 'Karine Leduc', '111 Grande Allée, Québec, QC', 'Service de Chambre', 24),
('900002408', 'Laurent Gervais', '112 Grande Allée, Québec, QC', 'Réception', 24),
('900002409', 'Marianne Beaulieu', '113 Grande Allée, Québec, QC', 'Service de Chambre', 24),
('900002410', 'Nicolas Côté', '114 Grande Allée, Québec, QC', 'Réception', 24);

-- Hôtel 25 : Petit Champlain Lodge (Québec, QC) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900002501', 'Olivier Paquette', '115 Grande Allée, Québec, QC', 'Réception', 25),
('900002502', 'Patrice Roberge', '116 Grande Allée, Québec, QC', 'Service de Chambre', 25),
('900002503', 'Quentin Desjardins', '117 Grande Allée, Québec, QC', 'Service de Chambre', 25);

-- Hôtel 26 : Dundurn Castle Inn (Hamilton, ON) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900002601', 'Ryan Mitchell', '101 Main St, Hamilton, ON', 'Réception', 26),
('900002602', 'Sean Parker', '102 Main St, Hamilton, ON', 'Service de Chambre', 26),
('900002603', 'Trevor Evans', '103 Main St, Hamilton, ON', 'Service de Chambre', 26);

-- Hôtel 27 : Royal Botanical Gardens Suites (Hamilton, ON) – 4 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900002701', 'Umar Jackson', '104 Main St, Hamilton, ON', 'Réception', 27),
('900002702', 'Victor Morales', '105 Main St, Hamilton, ON', 'Service de Chambre', 27),
('900002703', 'Wesley Ortiz', '106 Main St, Hamilton, ON', 'Service de Chambre', 27),
('900002704', 'Xavier Rivera', '107 Main St, Hamilton, ON', 'Réception', 27);

-- Hôtel 28 : Bayfront Park Hotel (Hamilton, ON) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900002801', 'Yves Martin', '108 Main St, Hamilton, ON', 'Réception', 28),
('900002802', 'Zachary Lee', '109 Main St, Hamilton, ON', 'Service de Chambre', 28),
('900002803', 'Adam Clark', '110 Main St, Hamilton, ON', 'Service de Chambre', 28);

-- Hôtel 29 : Victoria Park Kitchener Inn (Kitchener, ON) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900002901', 'Brandon Lewis', '101 King St, Kitchener, ON', 'Réception', 29),
('900002902', 'Calvin Mitchell', '102 King St, Kitchener, ON', 'Service de Chambre', 29),
('900002903', 'Dylan Scott', '103 King St, Kitchener, ON', 'Service de Chambre', 29);

-- Hôtel 30 : St. Jacobs Market Hotel (Kitchener, ON) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900003001', 'Evan Turner', '104 King St, Kitchener, ON', 'Réception', 30),
('900003002', 'Felix Adams', '105 King St, Kitchener, ON', 'Service de Chambre', 30),
('900003003', 'George Baker', '106 King St, Kitchener, ON', 'Service de Chambre', 30);

-- Hôtel 31 : Chicopee Ski Lodge (Kitchener, ON) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900003101', 'Harold Campbell', '107 King St, Kitchener, ON', 'Réception', 31),
('900003102', 'Ian Douglas', '108 King St, Kitchener, ON', 'Service de Chambre', 31),
('900003103', 'Jason Edwards', '109 King St, Kitchener, ON', 'Service de Chambre', 31);

-- Hôtel 32 : Covent Garden Hotel (London, ON) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900003201', 'Kevin Foster', '101 Wellington Rd, London, ON', 'Réception', 32),
('900003202', 'Leonard Graham', '102 Wellington Rd, London, ON', 'Service de Chambre', 32),
('900003203', 'Martin Hughes', '103 Wellington Rd, London, ON', 'Service de Chambre', 32);

-- Hôtel 33 : Budweiser Gardens Inn (London, ON) – 4 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900003301', 'Nathan Ingram', '104 Wellington Rd, London, ON', 'Réception', 33),
('900003302', 'Oliver Jenkins', '105 Wellington Rd, London, ON', 'Service de Chambre', 33),
('900003303', 'Philip Knight', '106 Wellington Rd, London, ON', 'Service de Chambre', 33),
('900003304', 'Quincy Lambert', '107 Wellington Rd, London, ON', 'Réception', 33);

-- Hôtel 34 : Fanshawe Pioneer Village Lodge (London, ON) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900003401', 'Robert Mitchell', '108 Wellington Rd, London, ON', 'Réception', 34),
('900003402', 'Samuel Norris', '109 Wellington Rd, London, ON', 'Service de Chambre', 34),
('900003403', 'Timothy Olson', '110 Wellington Rd, London, ON', 'Service de Chambre', 34);

-- Hôtel 35 : Butchart Gardens Resort (Victoria, BC) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900003501', 'Ursula Parker', '101 Douglas St, Victoria, BC', 'Réception', 35),
('900003502', 'Vanessa Quinn', '102 Douglas St, Victoria, BC', 'Service de Chambre', 35),
('900003503', 'Wendy Ross', '103 Douglas St, Victoria, BC', 'Service de Chambre', 35);

-- Hôtel 36 : Craigdarroch Castle Inn (Victoria, BC) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900003601', 'Xavier Scott', '104 Douglas St, Victoria, BC', 'Réception', 36),
('900003602', 'Yolanda Turner', '105 Douglas St, Victoria, BC', 'Service de Chambre', 36),
('900003603', 'Zoe Underwood', '106 Douglas St, Victoria, BC', 'Service de Chambre', 36);

-- Hôtel 37 : Fisherman's Wharf Hotel (Victoria, BC) – 6 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900003701', 'Alan Vargas', '107 Douglas St, Victoria, BC', 'Réception', 37),
('900003702', 'Brian Watson', '108 Douglas St, Victoria, BC', 'Service de Chambre', 37),
('900003703', 'Carl Xavier', '109 Douglas St, Victoria, BC', 'Service de Chambre', 37),
('900003704', 'Dennis Young', '110 Douglas St, Victoria, BC', 'Réception', 37),
('900003705', 'Ethan Ziegler', '111 Douglas St, Victoria, BC', 'Service de Chambre', 37),
('900003706', 'Felix Abbott', '112 Douglas St, Victoria, BC', 'Réception', 37);

-- Hôtel 38 : Citadel Hill Inn (Halifax, NS) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900003801', 'Gordon Price', '101 Barrington St, Halifax, NS', 'Réception', 38),
('900003802', 'Harvey Collins', '102 Barrington St, Halifax, NS', 'Service de Chambre', 38),
('900003803', 'Ivan Brooks', '103 Barrington St, Halifax, NS', 'Service de Chambre', 38);

-- Hôtel 39 : Peggy's Cove Lodge (Halifax, NS) – 4 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900003901', 'Jacob Foster', '104 Barrington St, Halifax, NS', 'Réception', 39),
('900003902', 'Kyle Gordon', '105 Barrington St, Halifax, NS', 'Service de Chambre', 39),
('900003903', 'Logan Harris', '106 Barrington St, Halifax, NS', 'Service de Chambre', 39),
('900003904', 'Mitchell Irving', '107 Barrington St, Halifax, NS', 'Réception', 39);

-- Hôtel 40 : Halifax Waterfront Suites (Halifax, NS) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900004001', 'Nathaniel James', '108 Barrington St, Halifax, NS', 'Réception', 40),
('900004002', 'Oliver King', '109 Barrington St, Halifax, NS', 'Service de Chambre', 40),
('900004003', 'Patrick Lee', '110 Barrington St, Halifax, NS', 'Service de Chambre', 40);

-- Hôtel 41 : Parkwood Estate Hotel (Oshawa, ON) – 6 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900004101', 'Quentin Miles', '101 King St, Oshawa, ON', 'Réception', 41),
('900004102', 'Ryan Norton', '102 King St, Oshawa, ON', 'Service de Chambre', 41),
('900004103', 'Samuel Ortiz', '103 King St, Oshawa, ON', 'Service de Chambre', 41),
('900004104', 'Timothy Parker', '104 King St, Oshawa, ON', 'Réception', 41),
('900004105', 'Ulysses Quinn', '105 King St, Oshawa, ON', 'Service de Chambre', 41),
('900004106', 'Victor Ramirez', '106 King St, Oshawa, ON', 'Réception', 41);

-- Hôtel 42 : Canadian Automotive Museum Inn (Oshawa, ON) – 8 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900004201', 'William Scott', '107 King St, Oshawa, ON', 'Réception', 42),
('900004202', 'Xavier Turner', '108 King St, Oshawa, ON', 'Service de Chambre', 42),
('900004203', 'Yusuf Underwood', '109 King St, Oshawa, ON', 'Service de Chambre', 42),
('900004204', 'Zachary Vance', '110 King St, Oshawa, ON', 'Réception', 42),
('900004205', 'Aaron Walker', '111 King St, Oshawa, ON', 'Service de Chambre', 42),
('900004206', 'Brandon Young', '112 King St, Oshawa, ON', 'Réception', 42),
('900004207', 'Caleb Zimmerman', '113 King St, Oshawa, ON', 'Service de Chambre', 42),
('900004208', 'Dylan Adams', '114 King St, Oshawa, ON', 'Réception', 42);

-- Hôtel 43 : Oshawa Valleylands Suites (Oshawa, ON) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900004301', 'Edward Brooks', '115 King St, Oshawa, ON', 'Réception', 43),
('900004302', 'Franklin Carter', '116 King St, Oshawa, ON', 'Service de Chambre', 43),
('900004303', 'George Dixon', '117 King St, Oshawa, ON', 'Service de Chambre', 43);

-- Hôtel 44 : Dieppe Gardens Inn (Windsor, ON) – 5 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900004401', 'Henry Edwards', '101 Riverside Dr, Windsor, ON', 'Réception', 44),
('900004402', 'Isaac Foster', '102 Riverside Dr, Windsor, ON', 'Service de Chambre', 44),
('900004403', 'Jacob Gray', '103 Riverside Dr, Windsor, ON', 'Service de Chambre', 44),
('900004404', 'Kevin Harris', '104 Riverside Dr, Windsor, ON', 'Réception', 44),
('900004405', 'Leonard Irving', '105 Riverside Dr, Windsor, ON', 'Service de Chambre', 44);

-- Hôtel 45 : Windsor Riverfront Hotel (Windsor, ON) – 4 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900004501', 'Michael Jones', '106 Riverside Dr, Windsor, ON', 'Réception', 45),
('900004502', 'Nathan Kelly', '107 Riverside Dr, Windsor, ON', 'Service de Chambre', 45),
('900004503', 'Oscar Lee', '108 Riverside Dr, Windsor, ON', 'Service de Chambre', 45),
('900004504', 'Peter Martin', '109 Riverside Dr, Windsor, ON', 'Réception', 45);

-- Hôtel 46 : Adventure Bay Lodge (Windsor, ON) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900004601', 'Quentin Nelson', '110 Riverside Dr, Windsor, ON', 'Réception', 46),
('900004602', 'Richard Owens', '111 Riverside Dr, Windsor, ON', 'Service de Chambre', 46),
('900004603', 'Samuel Peterson', '112 Riverside Dr, Windsor, ON', 'Service de Chambre', 46);

-- Hôtel 47 : Wanuskewin Heritage Inn (Saskatoon, SK) – 4 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900004701', 'Thomas Quinn', '101 22nd St, Saskatoon, SK', 'Réception', 47),
('900004702', 'Umar Richards', '102 22nd St, Saskatoon, SK', 'Service de Chambre', 47),
('900004703', 'Victor Stone', '103 22nd St, Saskatoon, SK', 'Service de Chambre', 47),
('900004704', 'William Turner', '104 22nd St, Saskatoon, SK', 'Réception', 47);

-- Hôtel 48 : Remai Modern Hotel (Saskatoon, SK) – 5 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900004801', 'Xander Underwood', '105 22nd St, Saskatoon, SK', 'Réception', 48),
('900004802', 'Yosef Vargas', '106 22nd St, Saskatoon, SK', 'Service de Chambre', 48),
('900004803', 'Zane White', '107 22nd St, Saskatoon, SK', 'Service de Chambre', 48),
('900004804', 'Aaron Xiong', '108 22nd St, Saskatoon, SK', 'Réception', 48),
('900004805', 'Brian Young', '109 22nd St, Saskatoon, SK', 'Service de Chambre', 48);

-- Hôtel 49 : Broadway District Suites (Saskatoon, SK) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900004901', 'Calvin Zane', '110 22nd St, Saskatoon, SK', 'Réception', 49),
('900004902', 'Derrick Allen', '111 22nd St, Saskatoon, SK', 'Service de Chambre', 49),
('900004903', 'Ethan Brooks', '112 22nd St, Saskatoon, SK', 'Service de Chambre', 49);

-- Hôtel 50 : Wascana Centre Lodge (Regina, SK) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900005001', 'Franklin Carter', '101 Victoria Ave, Regina, SK', 'Réception', 50),
('900005002', 'George Daniels', '102 Victoria Ave, Regina, SK', 'Service de Chambre', 50),
('900005003', 'Harold Evans', '103 Victoria Ave, Regina, SK', 'Service de Chambre', 50);

-- Hôtel 51 : RCMP Heritage Inn (Regina, SK) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900005101', 'Isaac Foster', '104 Victoria Ave, Regina, SK', 'Réception', 51),
('900005102', 'Jacob Grant', '105 Victoria Ave, Regina, SK', 'Service de Chambre', 51),
('900005103', 'Kevin Holmes', '106 Victoria Ave, Regina, SK', 'Service de Chambre', 51);

-- Hôtel 52 : Legislative Building Hotel (Regina, SK) – 6 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900005201', 'Louis Irving', '107 Victoria Ave, Regina, SK', 'Réception', 52),
('900005202', 'Michael Jenkins', '108 Victoria Ave, Regina, SK', 'Service de Chambre', 52),
('900005203', 'Nicholas Kennedy', '109 Victoria Ave, Regina, SK', 'Service de Chambre', 52),
('900005204', 'Oliver Lawrence', '110 Victoria Ave, Regina, SK', 'Réception', 52),
('900005205', 'Paul Martin', '111 Victoria Ave, Regina, SK', 'Service de Chambre', 52),
('900005206', 'Quentin Nelson', '112 Victoria Ave, Regina, SK', 'Réception', 52);

-- Hôtel 53 : Signal Hill Suites (St. John's, NL) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900005301', 'Richard Owens', '101 Water St, St. John''s, NL', 'Réception', 53),
('900005302', 'Samuel Parker', '102 Water St, St. John''s, NL', 'Service de Chambre', 53),
('900005303', 'Timothy Quinn', '103 Water St, St. John''s, NL', 'Service de Chambre', 53);

-- Hôtel 54 : George Street Hotel (St. John's, NL) – 5 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900005401', 'Ulysses Reed', '104 Water St, St. John''s, NL', 'Réception', 54),
('900005402', 'Victor Scott', '105 Water St, St. John''s, NL', 'Service de Chambre', 54),
('900005403', 'Warren Thomas', '106 Water St, St. John''s, NL', 'Service de Chambre', 54),
('900005404', 'Xavier Underwood', '107 Water St, St. John''s, NL', 'Réception', 54),
('900005405', 'Yannick Vial', '108 Water St, St. John''s, NL', 'Service de Chambre', 54);

-- Hôtel 55 : Cape Spear Retreat (St. John's, NL) – 3 employés
INSERT INTO Employes (NAS, Nom, Adresse, Role, ID_Hotel) VALUES
('900005501', 'Zachary White', '109 Water St, St. John''s, NL', 'Réception', 55),
('900005502', 'Adam Brown', '110 Water St, St. John''s, NL', 'Service de Chambre', 55),
('900005503', 'Benjamin Clark', '111 Water St, St. John''s, NL', 'Service de Chambre', 55);


-- =============================================
-- Insertion de clients dans la base de données
-- =============================================
-- Insertion de 100 clients avec des noms humains réalistes dans une seule requête
INSERT INTO Clients (NAS, Nom, Adresse, Date_Enregistrement) VALUES
-- Montréal
('200000001', 'Jean Tremblay', '1234 Rue Sainte-Catherine, Montreal, QC, Canada', '2010-01-01'),
('200000011', 'André Simard', '5678 Avenue du Parc, Montreal, QC, Canada', '2011-06-23'),
('200000021', 'Sébastien Marchand', '3456 Boulevard Saint-Laurent, Montreal, QC, Canada', '2012-12-03'),
('200000031', 'Bernard Morissette', '7890 Rue Sherbrooke, Montreal, QC, Canada', '2014-05-18'),
('200000041', 'Denis Gagnon', '2468 Rue Saint-Denis, Montreal, QC, Canada', '2015-10-29'),
('200000051', 'Pascal Leclerc', '1357 Rue Saint-Paul, Montreal, QC, Canada', '2017-05-11'),
('200000061', 'Simon Richard', '9876 Avenue du Mont-Royal, Montreal, QC, Canada', '2018-10-25'),
('200000071', 'Vincent Roussel', '4321 Rue de la Montagne, Montreal, QC, Canada', '2020-05-08'),
('200000081', 'Patrick Gervais', '6789 Rue Peel, Montreal, QC, Canada', '2021-10-21'),
('200000091', 'Éric Gagné', '1023 Rue Ontario, Montreal, QC, Canada', '2023-04-05'),

-- Toronto
('200000002', 'Marie Gagnon', '100 King Street West, Toronto, ON, Canada', '2010-02-24'),
('200000012', 'Sylvie Gauthier', '250 Queen Street East, Toronto, ON, Canada', '2011-08-15'),
('200000022', 'Karine Paquette', '375 Yonge Street, Toronto, ON, Canada', '2013-01-25'),
('200000032', 'Amélie Poirier', '420 Bloor Street West, Toronto, ON, Canada', '2014-07-10'),
('200000042', 'Mélanie Roberge', '512 Spadina Avenue, Toronto, ON, Canada', '2015-12-21'),
('200000052', 'Isabelle Fournier', '678 College Street, Toronto, ON, Canada', '2017-07-03'),
('200000062', 'Élise Morin', '789 Dundas Street West, Toronto, ON, Canada', '2018-12-17'),
('200000072', 'Audrey Lemieux', '845 Bay Street, Toronto, ON, Canada', '2020-06-30'),
('200000082', 'Sophie Leduc', '910 Front Street West, Toronto, ON, Canada', '2021-12-13'),
('200000092', 'Julie Lapointe', '1122 University Avenue, Toronto, ON, Canada', '2023-05-28'),

-- Vancouver
('200000003', 'Luc Bouchard', '101 West Georgia Street, Vancouver, BC, Canada', '2010-04-19'),
('200000013', 'Patrick Ouellet', '202 Burrard Street, Vancouver, BC, Canada', '2011-10-07'),
('200000023', 'Philippe Bédard', '303 Robson Street, Vancouver, BC, Canada', '2013-03-19'),
('200000033', 'Guillaume Perreault', '404 Granville Street, Vancouver, BC, Canada', '2014-09-01'),
('200000043', 'Kevin St-Pierre', '505 Davie Street, Vancouver, BC, Canada', '2016-02-12'),
('200000053', 'Laurent Deslauriers', '606 Commercial Drive, Vancouver, BC, Canada', '2017-08-26'),
('200000063', 'Maxime Bellemare', '707 Kingsway, Vancouver, BC, Canada', '2019-02-08'),
('200000073', 'Stéphane Caron', '808 Main Street, Vancouver, BC, Canada', '2020-08-22'),
('200000083', 'Alexandre Pelletier', '909 Seymour Street, Vancouver, BC, Canada', '2021-10-21'),
('200000093', 'Daniel Blais', '1111 Clark Drive, Vancouver, BC, Canada', '2023-07-20'),

-- Calgary
('200000004', 'Sophie Roy', '100 17th Avenue SW, Calgary, AB, Canada', '2010-06-12'),
('200000014', 'Christine Boucher', '200 8th Street SE, Calgary, AB, Canada', '2011-11-29'),
('200000024', 'Élise Dubois', '300 10th Street NW, Calgary, AB, Canada', '2013-05-11'),
('200000034', 'Chantal Gervais', '400 Centre Street SE, Calgary, AB, Canada', '2014-10-24'),
('200000044', 'Sandrine Lemaire', '500 4th Street SW, Calgary, AB, Canada', '2016-04-05'),
('200000054', 'Carole Thibault', '600 9th Avenue SE, Calgary, AB, Canada', '2017-10-18'),
('200000064', 'Virginie Lachance', '700 6th Avenue SW, Calgary, AB, Canada', '2019-04-02'),
('200000074', 'Mélissa Desjardins', '800 Elbow Drive SW, Calgary, AB, Canada', '2020-10-14'),
('200000084', 'Catherine Bouchard', '900 1st Street SE, Calgary, AB, Canada', '2022-03-29'),
('200000094', 'Sophie Royer', '1010 12th Avenue NW, Calgary, AB, Canada', '2023-09-11'),

-- Ottawa
('200000005', 'Marc Leblanc', '123 Rideau Street, Ottawa, ON, Canada', '2010-08-05'),
('200000015', 'Martin Côté', '456 Bank Street, Ottawa, ON, Canada', '2012-01-20'),
('200000025', 'Mathieu Lambert', '789 Wellington Street, Ottawa, ON, Canada', '2013-07-03'),
('200000035', 'Jérôme Leduc', '101 Sparks Street, Ottawa, ON, Canada', '2014-12-16'),
('200000045', 'Alexandre Beauregard', '202 Sussex Drive, Ottawa, ON, Canada', '2016-05-28'),
('200000055', 'Sébastien Roy', '303 Elgin Street, Ottawa, ON, Canada', '2017-12-10'),
('200000065', 'Benoît Cormier', '404 Bronson Avenue, Ottawa, ON, Canada', '2019-05-25'),
('200000075', 'David Bergeron', '505 St. Patrick Street, Ottawa, ON, Canada', '2020-12-06'),
('200000085', 'Nicolas Simard', '606 Laurier Avenue, Ottawa, ON, Canada', '2022-05-21'),
('200000095', 'Marc-André Fortin', '707 Mackenzie Avenue, Ottawa, ON, Canada', '2023-11-03'),

-- Edmonton
('200000006', 'Isabelle Fortin', '111 104 Avenue NW, Edmonton, AB, Canada', '2010-09-28'),
('200000016', 'Véronique Cloutier', '222 82 Street NW, Edmonton, AB, Canada', '2012-03-13'),
('200000026', 'Audrey Beaulieu', '333 109 Street NW, Edmonton, AB, Canada', '2013-08-25'),
('200000036', 'Marianne Desrochers', '444 112 Avenue NW, Edmonton, AB, Canada', '2015-03-31'),
('200000046', 'Florence Rivard', '555 97 Street NW, Edmonton, AB, Canada', '2016-07-20'),
('200000056', 'Pascale Martel', '666 101 Avenue NW, Edmonton, AB, Canada', '2018-02-01'),
('200000066', 'Julie Boivin', '777 75 Street NW, Edmonton, AB, Canada', '2019-07-17'),
('200000076', 'Caroline Gagnon', '888 124 Avenue NW, Edmonton, AB, Canada', '2021-01-28'),
('200000086', 'Marie-Claude Dubois', '999 89 Street NW, Edmonton, AB, Canada', '2022-07-13'),
('200000096', 'Claire Gagnon', '1010 95 Avenue NW, Edmonton, AB, Canada', '2024-01-25'),

-- Québec
('200000007', 'Pierre Lavoie', '100 Rue Saint-Jean, Quebec City, QC, Canada', '2010-11-21'),
('200000017', 'David Mercier', '200 Rue du Petit-Champlain, Quebec City, QC, Canada', '2012-05-05'),
('200000027', 'François Lafleur', '300 Boulevard Champlain, Quebec City, QC, Canada', '2013-10-17'),
('200000037', 'Xavier Caron', '400 Rue Saint-Louis, Quebec City, QC, Canada', '2015-03-31'),
('200000047', 'Jonathan Pelletier', '500 Avenue Cartier, Quebec City, QC, Canada', '2016-09-11'),
('200000057', 'Guillaume Dubé', '600 Rue Saint-Joseph, Quebec City, QC, Canada', '2018-03-27'),
('200000067', 'Alexandre Poirier', '700 Rue de la Couronne, Quebec City, QC, Canada', '2019-09-08'),
('200000077', 'Julien Deslauriers', '800 Rue des Remparts, Quebec City, QC, Canada', '2021-03-22'),
('200000087', 'Sébastien Couture', '900 Rue Montcalm, Quebec City, QC, Canada', '2022-09-04'),
('200000097', 'Antoine Leblanc', '1000 Boulevard Laurier, Quebec City, QC, Canada', '2024-03-18'),

-- Winnipeg
('200000008', 'Catherine Girard', '100 Main Street, Winnipeg, MB, Canada', '2011-01-13'),
('200000018', 'Anne Desjardins', '200 Portage Avenue, Winnipeg, MB, Canada', '2012-06-27'),
('200000028', 'Stéphanie Bergeron', '300 Notre Dame Avenue, Winnipeg, MB, Canada', '2013-12-09'),
('200000038', 'Geneviève Tremblay', '400 Osborne Street, Winnipeg, MB, Canada', '2015-05-23'),
('200000048', 'Roxane Dufresne', '500 Armstrongs Point, Winnipeg, MB, Canada', '2016-11-03'),
('200000058', 'Monique Bouchard', '600 Garry Street, Winnipeg, MB, Canada', '2018-05-19'),
('200000068', 'Amélie Cloutier', '700 Pembina Highway, Winnipeg, MB, Canada', '2019-11-01'),
('200000078', 'Anaïs Tremblay', '800 Portage Street, Winnipeg, MB, Canada', '2021-05-14'),
('200000088', 'Amélie Martineau', '900 Ellice Avenue, Winnipeg, MB, Canada', '2022-10-27'),
('200000098', 'Chantal Desrochers', '1000 St. Marys Road, Winnipeg, MB, Canada', '2024-05-10'),

-- Hamilton
('200000009', 'Daniel Morin', '100 King Street, Hamilton, ON, Canada', '2011-03-08'),
('200000019', 'Claude Lemoine', '200 Main Street West, Hamilton, ON, Canada', '2012-08-19'),
('200000029', 'Olivier Gagné', '300 King William Street, Hamilton, ON, Canada', '2014-02-01'),
('200000039', 'Éric Boucher', '400 James Street, Hamilton, ON, Canada', '2015-07-15'),
('200000049', 'Christian Moreau', '500 Sherman Avenue, Hamilton, ON, Canada', '2017-01-25'),
('200000059', 'Marc-André Lapointe', '600 Sanford Street, Hamilton, ON, Canada', '2018-07-11'),
('200000069', 'Mathieu Gervais', '700 Barton Street, Hamilton, ON, Canada', '2020-01-23'),
('200000079', 'Eric Cloutier', '800 Wentworth Street, Hamilton, ON, Canada', '2021-07-06'),
('200000089', 'Olivier Moreau', '900 Locke Street, Hamilton, ON, Canada', '2022-12-19'),
('200000099', 'Jérôme St-Pierre', '1000 Hess Street, Hamilton, ON, Canada', '2024-07-02'),

-- Kitchener
('200000010', 'Nicole Pelletier', '100 King Street East, Kitchener, ON, Canada', '2011-05-01'),
('200000020', 'Julie Renaud', '200 Victoria Street, Kitchener, ON, Canada', '2012-10-11'),
('200000030', 'Valérie Lebrun', '300 Weber Street North, Kitchener, ON, Canada', '2014-03-26'),
('200000040', 'Aline Fortier', '400 Scott Street, Kitchener, ON, Canada', '2015-09-06'),
('200000050', 'Colette Rivard', '500 King Street West, Kitchener, ON, Canada', '2017-03-19'),
('200000060', 'Nadia Gagné', '600 Bridgeport Road, Kitchener, ON, Canada', '2018-09-02'),
('200000070', 'Catherine Morel', '700 Highland Road, Kitchener, ON, Canada', '2020-03-16'),
('200000080', 'Jessica Fortin', '800 West Street, Kitchener, ON, Canada', '2021-08-29'),
('200000090', 'Catherine Bouchard', '900 Ottawa Street, Kitchener, ON, Canada', '2023-02-10'),
('200000100', 'Caroline Poirier', '1000 Queen Street, Kitchener, ON, Canada', '2024-08-25');


INSERT INTO Clients (NAS, Nom, Adresse, Date_Enregistrement) VALUES
-- Halifax, NS
('300000001', 'John Smith', '1234 Barrington Street, Halifax, NS, Canada', '2010-01-01'),
('300000002', 'Michael Johnson', '5678 Robie Street, Halifax, NS, Canada', '2010-02-01'),
('300000003', 'David Williams', '2345 Summer Street, Halifax, NS, Canada', '2010-03-01'),
('300000004', 'James Brown', '7890 Quinpool Road, Halifax, NS, Canada', '2010-04-01'),
('300000005', 'Robert Jones', '3456 Agricola Street, Halifax, NS, Canada', '2010-05-01'),
('300000006', 'William Miller', '9012 South Park Street, Halifax, NS, Canada', '2010-06-01'),
('300000007', 'Richard Davis', '6789 Barrington Place, Halifax, NS, Canada', '2010-07-01'),
('300000008', 'Thomas Wilson', '4321 South Park Street, Halifax, NS, Canada', '2010-08-01'),
('300000009', 'Charles Moore', '8765 Spring Garden Road, Halifax, NS, Canada', '2010-09-01'),
('300000010', 'Christopher Taylor', '1357 Quinpool Street, Halifax, NS, Canada', '2010-10-01'),

-- Victoria, BC
('300000011', 'Daniel Anderson', '101 Belleville Street, Victoria, BC, Canada', '2011-01-15'),
('300000012', 'Matthew Thomas', '202 Douglas Street, Victoria, BC, Canada', '2011-02-15'),
('300000013', 'Anthony Jackson', '303 Government Street, Victoria, BC, Canada', '2011-03-15'),
('300000014', 'Mark White', '404 Fort Street, Victoria, BC, Canada', '2011-04-15'),
('300000015', 'Donald Harris', '505 Yates Street, Victoria, BC, Canada', '2011-05-15'),
('300000016', 'Paul Martin', '606 Pandora Avenue, Victoria, BC, Canada', '2011-06-15'),
('300000017', 'Steven Thompson', '707 Humboldt Street, Victoria, BC, Canada', '2011-07-15'),
('300000018', 'Andrew Garcia', '808 Fisgard Street, Victoria, BC, Canada', '2011-08-15'),
('300000019', 'Kenneth Martinez', '909 Courtney Street, Victoria, BC, Canada', '2011-09-15'),
('300000020', 'Joshua Robinson', '1111 Bastion Square, Victoria, BC, Canada', '2011-10-15'),

-- St. John's, NL
('300000021', 'Brian Clark', '1 Water Street, St. John''s, NL, Canada', '2012-01-10'),
('300000022', 'Kevin Rodriguez', '2 Water Street, St. John''s, NL, Canada', '2012-02-10'),
('300000023', 'Jason Lewis', '3 Duckworth Street, St. John''s, NL, Canada', '2012-03-10'),
('300000024', 'Jeffrey Lee', '4 Water Street, St. John''s, NL, Canada', '2012-04-10'),
('300000025', 'Ryan Walker', '5 Water Street, St. John''s, NL, Canada', '2012-05-10'),
('300000026', 'Gary Hall', '6 Signal Hill Road, St. John''s, NL, Canada', '2012-06-10'),
('300000027', 'Jacob Allen', '7 Rennies Mill Road, St. John''s, NL, Canada', '2012-07-10'),
('300000028', 'Nicholas Young', '8 Ferry Terminal Road, St. John''s, NL, Canada', '2012-08-10'),
('300000029', 'Eric King', '9 Military Road, St. John''s, NL, Canada', '2012-09-10'),
('300000030', 'Stephen Wright', '10 Kenmount Road, St. John''s, NL, Canada', '2012-10-10'),

-- Saskatoon, SK
('300000031', 'Frank Scott', '100 Broadway Avenue, Saskatoon, SK, Canada', '2013-01-05'),
('300000032', 'Scott Adams', '200 22nd Street, Saskatoon, SK, Canada', '2013-02-05'),
('300000033', 'Patrick Baker', '300 Avenue A, Saskatoon, SK, Canada', '2013-03-05'),
('300000034', 'Raymond Gonzalez', '400 21st Street, Saskatoon, SK, Canada', '2013-04-05'),
('300000035', 'Gregory Nelson', '500 20th Street, Saskatoon, SK, Canada', '2013-05-05'),
('300000036', 'Benjamin Carter', '600 19th Street, Saskatoon, SK, Canada', '2013-06-05'),
('300000037', 'Samuel Mitchell', '700 18th Street, Saskatoon, SK, Canada', '2013-07-05'),
('300000038', 'Adam Perez', '800 17th Street, Saskatoon, SK, Canada', '2013-08-05'),
('300000039', 'Larry Roberts', '900 16th Street, Saskatoon, SK, Canada', '2013-09-05'),
('300000040', 'Ernest Turner', '1000 15th Street, Saskatoon, SK, Canada', '2013-10-05'),

-- Regina, SK
('300000041', 'Jack Evans', '101 Saskatchewan Drive, Regina, SK, Canada', '2014-01-20'),
('300000042', 'Harry Collins', '202 Victoria Avenue, Regina, SK, Canada', '2014-02-20'),
('300000043', 'Owen Stewart', '303 Albert Street, Regina, SK, Canada', '2014-03-20'),
('300000044', 'Ethan Sanchez', '404 Lewvan Drive, Regina, SK, Canada', '2014-04-20'),
('300000045', 'Aiden Morris', '505 Broad Street, Regina, SK, Canada', '2014-05-20'),
('300000046', 'Logan Rogers', '606 Victoria Street, Regina, SK, Canada', '2014-06-20'),
('300000047', 'Caleb Reed', '707 King Street, Regina, SK, Canada', '2014-07-20'),
('300000048', 'Ryan Cook', '808 College Avenue, Regina, SK, Canada', '2014-08-20'),
('300000049', 'Brandon Morgan', '909 Saskatchewan Crescent, Regina, SK, Canada', '2014-09-20'),
('300000050', 'Tyler Bell', '1010 Victoria Road, Regina, SK, Canada', '2014-10-20'),

-- London, ON
('300000051', 'Aaron Murphy', '101 Talbot Street, London, ON, Canada', '2015-01-25'),
('300000052', 'Nathan Bailey', '202 Dundas Street, London, ON, Canada', '2015-02-25'),
('300000053', 'Zachary Rivera', '303 Wellington Road, London, ON, Canada', '2015-03-25'),
('300000054', 'Christian Cooper', '404 Hyde Park Road, London, ON, Canada', '2015-04-25'),
('300000055', 'Jonathan Richardson', '505 Oxford Street, London, ON, Canada', '2015-05-25'),
('300000056', 'Dylan Cox', '606 Richmond Street, London, ON, Canada', '2015-06-25'),
('300000057', 'Lucas Howard', '707 Carling Avenue, London, ON, Canada', '2015-07-25'),
('300000058', 'Evan Ward', '808 Highbury Avenue, London, ON, Canada', '2015-08-25'),
('300000059', 'Caleb Peterson', '909 Adelaide Street, London, ON, Canada', '2015-09-25'),
('300000060', 'Owen Flores', '1010 Quebec Street, London, ON, Canada', '2015-10-25'),

-- Mississauga, ON
('300000061', 'Justin Simmons', '101 Hurontario Street, Mississauga, ON, Canada', '2016-03-01'),
('300000062', 'Ethan Foster', '202 Burnhamthorpe Road, Mississauga, ON, Canada', '2016-04-01'),
('300000063', 'Connor Graham', '303 Lakeshore Road, Mississauga, ON, Canada', '2016-05-01'),
('300000064', 'Blake Ross', '404 Dundas Street, Mississauga, ON, Canada', '2016-06-01'),
('300000065', 'Liam Stone', '505 Erin Mills Parkway, Mississauga, ON, Canada', '2016-07-01'),
('300000066', 'Noah Chapman', '606 Britannia Road, Mississauga, ON, Canada', '2016-08-01'),
('300000067', 'Cameron Porter', '707 Mississauga Road, Mississauga, ON, Canada', '2016-09-01'),
('300000068', 'Austin Butler', '808 Eglinton Avenue, Mississauga, ON, Canada', '2016-10-01'),
('300000069', 'Dylan Harper', '909 Matheson Boulevard, Mississauga, ON, Canada', '2016-11-01'),
('300000070', 'Jordan Webb', '1010 Mavis Road, Mississauga, ON, Canada', '2016-12-01'),

-- Burlington, ON
('300000071', 'Sean Butler', '101 Maple Avenue, Burlington, ON, Canada', '2017-01-10'),
('300000072', 'Derek Coleman', '202 Lakeshore Road, Burlington, ON, Canada', '2017-02-10'),
('300000073', 'Russell Perry', '303 Main Street, Burlington, ON, Canada', '2017-03-10'),
('300000074', 'Martin Powell', '404 Brant Street, Burlington, ON, Canada', '2017-04-10'),
('300000075', 'Joel Russell', '505 Byron Street, Burlington, ON, Canada', '2017-05-10'),
('300000076', 'Trevor Long', '606 Fairview Road, Burlington, ON, Canada', '2017-06-10'),
('300000077', 'Mitchell Patterson', '707 Prospect Street, Burlington, ON, Canada', '2017-07-10'),
('300000078', 'Corey Hughes', '808 Guelph Line, Burlington, ON, Canada', '2017-08-10'),
('300000079', 'Bryan Simmons', '909 Upper Middle Road, Burlington, ON, Canada', '2017-09-10'),
('300000080', 'Shawn Foster', '1010 Clarkson Street, Burlington, ON, Canada', '2017-10-10'),

-- Oshawa, ON
('300000081', 'Gary Bennett', '101 Simcoe Street, Oshawa, ON, Canada', '2018-01-15'),
('300000082', 'Timothy Matthews', '202 King Street, Oshawa, ON, Canada', '2018-02-15'),
('300000083', 'Phillip Alexander', '303 Dundas Street, Oshawa, ON, Canada', '2018-03-15'),
('300000084', 'Patrick Jenkins', '404 Stevenson Road, Oshawa, ON, Canada', '2018-04-15'),
('300000085', 'Benjamin Stephens', '505 Courtland Avenue, Oshawa, ON, Canada', '2018-05-15'),
('300000086', 'Jeffrey Holmes', '606 Westney Road, Oshawa, ON, Canada', '2018-06-15'),
('300000087', 'Samuel Dunn', '707 Stevenson Street, Oshawa, ON, Canada', '2018-07-15'),
('300000088', 'Dennis Ellis', '808 Carruthers Street, Oshawa, ON, Canada', '2018-08-15'),
('300000089', 'Wayne Webb', '909 Ritson Road, Oshawa, ON, Canada', '2018-09-15'),
('300000090', 'Shawn Armstrong', '1010 Taunton Road, Oshawa, ON, Canada', '2018-10-15'),

-- Windsor, ON
('300000091', 'Bruce Kennedy', '101 Huron Street, Windsor, ON, Canada', '2019-01-20'),
('300000092', 'Patrick Mason', '202 Ouellette Avenue, Windsor, ON, Canada', '2019-02-20'),
('300000093', 'Joel Holmes', '303 Sandwich Street, Windsor, ON, Canada', '2019-03-20'),
('300000094', 'Dennis Barrett', '404 University Avenue, Windsor, ON, Canada', '2019-04-20'),
('300000095', 'Franklin Barker', '505 Riverside Drive, Windsor, ON, Canada', '2019-05-20'),
('300000096', 'Jeffrey Nichols', '606 Dominion Boulevard, Windsor, ON, Canada', '2019-06-20'),
('300000097', 'Russell McDonald', '707 Howard Avenue, Windsor, ON, Canada', '2019-07-20'),
('300000098', 'Vincent Austin', '808 Walker Road, Windsor, ON, Canada', '2019-08-20'),
('300000099', 'Trevor Marsh', '909 Grand Boulevard, Windsor, ON, Canada', '2019-09-20'),
('300000100', 'Howard Lloyd', '1010 E.C. Row Expressway, Windsor, ON, Canada', '2019-10-20');

INSERT INTO Clients (NAS, Nom, Adresse, Date_Enregistrement) VALUES
-- Groupe 1 : Halifax, NS
('400000001', 'Oliver Grant', '1010 Barrington Street, Halifax, NS, Canada', '2010-01-01'),
('400000002', 'Henry Foster', '1020 Robie Street, Halifax, NS, Canada', '2010-02-01'),
('400000003', 'Arthur Bennett', '1030 South Park Street, Halifax, NS, Canada', '2010-03-01'),
('400000004', 'Sebastian Clarke', '1040 Quinpool Road, Halifax, NS, Canada', '2010-04-01'),
('400000005', 'Maxwell Reed', '1050 Agricola Street, Halifax, NS, Canada', '2010-05-01'),
('400000006', 'Everett Marshall', '1060 Jubilee Road, Halifax, NS, Canada', '2010-06-01'),
('400000007', 'Julian King', '1070 Windsor Street, Halifax, NS, Canada', '2010-07-01'),
('400000008', 'Lawrence Dunn', '1080 South Park Place, Halifax, NS, Canada', '2010-08-01'),
('400000009', 'Frederick Nash', '1090 Barrington Avenue, Halifax, NS, Canada', '2010-09-01'),
('400000010', 'Wesley Stone', '1100 Robie Crescent, Halifax, NS, Canada', '2010-10-01'),

-- Groupe 2 : Victoria, BC
('400000011', 'Gavin Mitchell', '2010 Belleville Street, Victoria, BC, Canada', '2011-01-15'),
('400000012', 'Spencer Hart', '2020 Douglas Street, Victoria, BC, Canada', '2011-02-15'),
('400000013', 'Adrian Cole', '2030 Government Street, Victoria, BC, Canada', '2011-03-15'),
('400000014', 'Miles Gardner', '2040 Fort Street, Victoria, BC, Canada', '2011-04-15'),
('400000015', 'Damian Cross', '2050 Yates Street, Victoria, BC, Canada', '2011-05-15'),
('400000016', 'Tristan Brooks', '2060 Pandora Avenue, Victoria, BC, Canada', '2011-06-15'),
('400000017', 'Curtis Burns', '2070 Humboldt Street, Victoria, BC, Canada', '2011-07-15'),
('400000018', 'Dominic Shaw', '2080 Fisgard Street, Victoria, BC, Canada', '2011-08-15'),
('400000019', 'Chase Powell', '2090 Courtney Street, Victoria, BC, Canada', '2011-09-15'),
('400000020', 'Preston Ford', '2100 Bastion Square, Victoria, BC, Canada', '2011-10-15'),

-- Groupe 3 : St. John's, NL
('400000021', 'Elliot Mason', '101 Water Street, St. John''s, NL, Canada', '2012-01-10'),
('400000022', 'Garrett Hayes', '102 Duckworth Street, St. John''s, NL, Canada', '2012-02-10'),
('400000023', 'Clayton Brooks', '103 Water Street, St. John''s, NL, Canada', '2012-03-10'),
('400000024', 'Darren Dean', '104 Signal Hill Road, St. John''s, NL, Canada', '2012-04-10'),
('400000025', 'Marcus Flynn', '105 Rennies Mill Road, St. John''s, NL, Canada', '2012-05-10'),
('400000026', 'Oscar Day', '106 Ferry Terminal Road, St. John''s, NL, Canada', '2012-06-10'),
('400000027', 'Quentin Marsh', '107 Military Road, St. John''s, NL, Canada', '2012-07-10'),
('400000028', 'Omar Reeves', '108 Kenmount Road, St. John''s, NL, Canada', '2012-08-10'),
('400000029', 'Silas Carter', '109 Waterford Avenue, St. John''s, NL, Canada', '2012-09-10'),
('400000030', 'Felix Monroe', '110 Signal Hill Avenue, St. John''s, NL, Canada', '2012-10-10'),

-- Groupe 4 : Saskatoon, SK
('400000031', 'Ian Brooks', '1010 22nd Avenue, Saskatoon, SK, Canada', '2013-01-05'),
('400000032', 'Victor Bishop', '1020 21st Avenue, Saskatoon, SK, Canada', '2013-02-05'),
('400000033', 'Xavier Carter', '1030 20th Avenue, Saskatoon, SK, Canada', '2013-03-05'),
('400000034', 'Nolan Pierce', '1040 19th Avenue, Saskatoon, SK, Canada', '2013-04-05'),
('400000035', 'Bennett Wright', '1050 18th Avenue, Saskatoon, SK, Canada', '2013-05-05'),
('400000036', 'Dorian Stone', '1060 17th Avenue, Saskatoon, SK, Canada', '2013-06-05'),
('400000037', 'Reid Simmons', '1070 16th Avenue, Saskatoon, SK, Canada', '2013-07-05'),
('400000038', 'Jasper Daniels', '1080 15th Avenue, Saskatoon, SK, Canada', '2013-08-05'),
('400000039', 'Declan Hudson', '1090 14th Avenue, Saskatoon, SK, Canada', '2013-09-05'),
('400000040', 'Blake Ward', '1100 13th Avenue, Saskatoon, SK, Canada', '2013-10-05'),

-- Groupe 5 : Regina, SK
('400000041', 'Damien Archer', '1010 Saskatchewan Drive, Regina, SK, Canada', '2014-01-20'),
('400000042', 'Isaac Fox', '1020 Victoria Avenue, Regina, SK, Canada', '2014-02-20'),
('400000043', 'Morgan Grant', '1030 Albert Street, Regina, SK, Canada', '2014-03-20'),
('400000044', 'Elias Reed', '1040 Lewvan Drive, Regina, SK, Canada', '2014-04-20'),
('400000045', 'Mason Scott', '1050 Broad Street, Regina, SK, Canada', '2014-05-20'),
('400000046', 'Cole Armstrong', '1060 Victoria Street, Regina, SK, Canada', '2014-06-20'),
('400000047', 'Grant Edwards', '1070 King Street, Regina, SK, Canada', '2014-07-20'),
('400000048', 'Wyatt Moore', '1080 College Avenue, Regina, SK, Canada', '2014-08-20'),
('400000049', 'Ryder Murphy', '1090 Saskatchewan Crescent, Regina, SK, Canada', '2014-09-20'),
('400000050', 'Asher Price', '1100 Victoria Road, Regina, SK, Canada', '2014-10-20'),

-- Groupe 6 : London, ON
('400000051', 'Miles Abbott', '1010 Talbot Street, London, ON, Canada', '2015-01-25'),
('400000052', 'Cody Bell', '1020 Dundas Street, London, ON, Canada', '2015-02-25'),
('400000053', 'Leo Carter', '1030 Wellington Road, London, ON, Canada', '2015-03-25'),
('400000054', 'Connor Dixon', '1040 Hyde Park Road, London, ON, Canada', '2015-04-25'),
('400000055', 'Calvin Ellis', '1050 Oxford Street, London, ON, Canada', '2015-05-25'),
('400000056', 'Harrison Fisher', '1060 Richmond Street, London, ON, Canada', '2015-06-25'),
('400000057', 'Colin Gibson', '1070 Carling Avenue, London, ON, Canada', '2015-07-25'),
('400000058', 'Brandon Howard', '1080 Highbury Avenue, London, ON, Canada', '2015-08-25'),
('400000059', 'Landon Irving', '1090 Adelaide Street, London, ON, Canada', '2015-09-25'),
('400000060', 'Cameron Jacobs', '1100 Quebec Street, London, ON, Canada', '2015-10-25'),

-- Groupe 7 : Mississauga, ON
('400000061', 'Colton Kelly', '1010 Hurontario Street, Mississauga, ON, Canada', '2016-03-01'),
('400000062', 'Brayden Knight', '1020 Burnhamthorpe Road, Mississauga, ON, Canada', '2016-04-01'),
('400000063', 'Hudson Miles', '1030 Lakeshore Road, Mississauga, ON, Canada', '2016-05-01'),
('400000064', 'Orion Norris', '1040 Dundas Street, Mississauga, ON, Canada', '2016-06-01'),
('400000065', 'Easton Rivers', '1050 Erin Mills Parkway, Mississauga, ON, Canada', '2016-07-01'),
('400000066', 'Finn Palmer', '1060 Britannia Road, Mississauga, ON, Canada', '2016-08-01'),
('400000067', 'Griffin Quinn', '1070 Mississauga Road, Mississauga, ON, Canada', '2016-09-01'),
('400000068', 'Holden Saunders', '1080 Eglinton Avenue, Mississauga, ON, Canada', '2016-10-01'),
('400000069', 'Emmett Turner', '1090 Matheson Boulevard, Mississauga, ON, Canada', '2016-11-01'),
('400000070', 'Rowan Vance', '1100 Mavis Road, Mississauga, ON, Canada', '2016-12-01'),

-- Groupe 8 : Burlington, ON
('400000071', 'Theodore Baxter', '1010 Maple Avenue, Burlington, ON, Canada', '2017-01-10'),
('400000072', 'Lincoln Ford', '1020 Lakeshore Road, Burlington, ON, Canada', '2017-02-10'),
('400000073', 'Roman Graham', '1030 Main Street, Burlington, ON, Canada', '2017-03-10'),
('400000074', 'Bennett Diaz', '1040 Brant Street, Burlington, ON, Canada', '2017-04-10'),
('400000075', 'Dylan Edwards', '1050 Byron Street, Burlington, ON, Canada', '2017-05-10'),
('400000076', 'Maverick Fisher', '1060 Fairview Road, Burlington, ON, Canada', '2017-06-10'),
('400000077', 'Ashton Grant', '1070 Prospect Street, Burlington, ON, Canada', '2017-07-10'),
('400000078', 'Cameron Hughes', '1080 Guelph Line, Burlington, ON, Canada', '2017-08-10'),
('400000079', 'Duncan Irving', '1090 Upper Middle Road, Burlington, ON, Canada', '2017-09-10'),
('400000080', 'Ethan James', '1100 Clarkson Street, Burlington, ON, Canada', '2017-10-10'),

-- Groupe 9 : Oshawa, ON
('400000081', 'Ryder Knight', '1010 Simcoe Street, Oshawa, ON, Canada', '2018-01-15'),
('400000082', 'Cooper Lee', '1020 King Street, Oshawa, ON, Canada', '2018-02-15'),
('400000083', 'Tanner Moore', '1030 Dundas Street, Oshawa, ON, Canada', '2018-03-15'),
('400000084', 'Ashton Neal', '1040 Stevenson Road, Oshawa, ON, Canada', '2018-04-15'),
('400000085', 'Carson Owens', '1050 Courtland Avenue, Oshawa, ON, Canada', '2018-05-15'),
('400000086', 'Dalton Pierce', '1060 Westney Road, Oshawa, ON, Canada', '2018-06-15'),
('400000087', 'Gage Quinn', '1070 Stevenson Street, Oshawa, ON, Canada', '2018-07-15'),
('400000088', 'Hunter Reed', '1080 Carruthers Street, Oshawa, ON, Canada', '2018-08-15'),
('400000089', 'Preston Scott', '1090 Ritson Road, Oshawa, ON, Canada', '2018-09-15'),
('400000090', 'Jaxon Underwood', '1100 Taunton Road, Oshawa, ON, Canada', '2018-10-15'),

-- Groupe 10 : Windsor, ON
('400000091', 'Simon Vaughn', '1010 Huron Street, Windsor, ON, Canada', '2019-01-20'),
('400000092', 'Tobias Walker', '1020 Ouellette Avenue, Windsor, ON, Canada', '2019-02-20'),
('400000093', 'Xander Young', '1030 Sandwich Street, Windsor, ON, Canada', '2019-03-20'),
('400000094', 'Harper Zane', '1040 University Avenue, Windsor, ON, Canada', '2019-04-20'),
('400000095', 'Emmett Allen', '1050 Riverside Drive, Windsor, ON, Canada', '2019-05-20'),
('400000096', 'Orion Brown', '1060 Dominion Boulevard, Windsor, ON, Canada', '2019-06-20'),
('400000097', 'Troy Davis', '1070 Howard Avenue, Windsor, ON, Canada', '2019-07-20'),
('400000098', 'Leon Evans', '1080 Walker Road, Windsor, ON, Canada', '2019-08-20'),
('400000099', 'Corbin Foster', '1090 Grand Boulevard, Windsor, ON, Canada', '2019-09-20'),
('400000100', 'Milo Graham', '1100 E.C. Row Expressway, Windsor, ON, Canada', '2019-10-20');


INSERT INTO Clients (NAS, Nom, Adresse, Date_Enregistrement) VALUES
-- Groupe 1 : Halifax, NS
('500000001', 'Albert Reynolds', '1200 Barrington Street, Halifax, NS, Canada', '2010-01-01'),
('500000002', 'Clarence Lawson', '1210 Robie Street, Halifax, NS, Canada', '2010-02-01'),
('500000003', 'Edwin McAllister', '1220 South Park Street, Halifax, NS, Canada', '2010-03-01'),
('500000004', 'Irving Wallace', '1230 Quinpool Road, Halifax, NS, Canada', '2010-04-01'),
('500000005', 'Louis Henderson', '1240 Agricola Street, Halifax, NS, Canada', '2010-05-01'),
('500000006', 'Milton Barnes', '1250 South Park Avenue, Halifax, NS, Canada', '2010-06-01'),
('500000007', 'Percy Douglas', '1260 Windsor Street, Halifax, NS, Canada', '2010-07-01'),
('500000008', 'Quincy Farnham', '1270 South Park Place, Halifax, NS, Canada', '2010-08-01'),
('500000009', 'Roland Davies', '1280 Barrington Avenue, Halifax, NS, Canada', '2010-09-01'),
('500000010', 'Stanley McKenna', '1290 Robie Crescent, Halifax, NS, Canada', '2010-10-01'),

-- Groupe 2 : Victoria, BC
('500000011', 'Abraham Morton', '1300 Belleville Street, Victoria, BC, Canada', '2011-01-15'),
('500000012', 'Basil Cunningham', '1310 Douglas Street, Victoria, BC, Canada', '2011-02-15'),
('500000013', 'Cedric Monroe', '1320 Government Street, Victoria, BC, Canada', '2011-03-15'),
('500000014', 'Darius Vance', '1330 Fort Street, Victoria, BC, Canada', '2011-04-15'),
('500000015', 'Emerson Porter', '1340 Yates Street, Victoria, BC, Canada', '2011-05-15'),
('500000016', 'Fergus Donnelly', '1350 Pandora Avenue, Victoria, BC, Canada', '2011-06-15'),
('500000017', 'Giles Hartman', '1360 Humboldt Street, Victoria, BC, Canada', '2011-07-15'),
('500000018', 'Harold Pritchard', '1370 Fisgard Street, Victoria, BC, Canada', '2011-08-15'),
('500000019', 'Ivan McKenzie', '1380 Courtney Street, Victoria, BC, Canada', '2011-09-15'),
('500000020', 'Justus Ramsey', '1390 Bastion Square, Victoria, BC, Canada', '2011-10-15'),

-- Groupe 3 : St. John's, NL
('500000021', 'Keaton Doyle', '1400 Water Street, St. John''s, NL, Canada', '2012-01-10'),
('500000022', 'Leland Sutherland', '1410 Duckworth Street, St. John''s, NL, Canada', '2012-02-10'),
('500000023', 'Merrick O''Neil', '1420 Water Street, St. John''s, NL, Canada', '2012-03-10'),
('500000024', 'Neville Hargrove', '1430 Signal Hill Road, St. John''s, NL, Canada', '2012-04-10'),
('500000025', 'Orson Fitzgerald', '1440 Rennies Mill Road, St. John''s, NL, Canada', '2012-05-10'),
('500000026', 'Prescott Laird', '1450 Ferry Terminal Road, St. John''s, NL, Canada', '2012-06-10'),
('500000027', 'Reginald Dempsey', '1460 Military Road, St. John''s, NL, Canada', '2012-07-10'),
('500000028', 'Sidney Crawford', '1470 Kenmount Road, St. John''s, NL, Canada', '2012-08-10'),
('500000029', 'Truman Spencer', '1480 Waterford Avenue, St. John''s, NL, Canada', '2012-09-10'),
('500000030', 'Vernon Holloway', '1490 Signal Hill Avenue, St. John''s, NL, Canada', '2012-10-10'),

-- Groupe 4 : Saskatoon, SK
('500000031', 'Winston Everett', '1500 22nd Avenue, Saskatoon, SK, Canada', '2013-01-05'),
('500000032', 'Yale Fitzroy', '1510 21st Avenue, Saskatoon, SK, Canada', '2013-02-05'),
('500000033', 'Zachariah Whitman', '1520 20th Avenue, Saskatoon, SK, Canada', '2013-03-05'),
('500000034', 'Alfred Pemberton', '1530 19th Avenue, Saskatoon, SK, Canada', '2013-04-05'),
('500000035', 'Cecil Stanfield', '1540 18th Avenue, Saskatoon, SK, Canada', '2013-05-05'),
('500000036', 'Edmund Lowry', '1550 17th Avenue, Saskatoon, SK, Canada', '2013-06-05'),
('500000037', 'Gordon Ingram', '1560 16th Avenue, Saskatoon, SK, Canada', '2013-07-05'),
('500000038', 'Herbert Calhoun', '1570 15th Avenue, Saskatoon, SK, Canada', '2013-08-05'),
('500000039', 'Irwin Barlow', '1580 14th Avenue, Saskatoon, SK, Canada', '2013-09-05'),
('500000040', 'Kendrick Carver', '1590 13th Avenue, Saskatoon, SK, Canada', '2013-10-05'),

-- Groupe 5 : Regina, SK
('500000041', 'Luther McBride', '1600 Saskatchewan Drive, Regina, SK, Canada', '2014-01-20'),
('500000042', 'Maximilian O''Connor', '1610 Victoria Avenue, Regina, SK, Canada', '2014-02-20'),
('500000043', 'Norbert Fitzpatrick', '1620 Albert Street, Regina, SK, Canada', '2014-03-20'),
('500000044', 'Odin Carrington', '1630 Lewvan Drive, Regina, SK, Canada', '2014-04-20'),
('500000045', 'Phineas Drummond', '1640 Broad Street, Regina, SK, Canada', '2014-05-20'),
('500000046', 'Rex Laird', '1650 Victoria Street, Regina, SK, Canada', '2014-06-20'),
('500000047', 'Sylvester Grimshaw', '1660 King Street, Regina, SK, Canada', '2014-07-20'),
('500000048', 'Thaddeus Sinclair', '1670 College Avenue, Regina, SK, Canada', '2014-08-20'),
('500000049', 'Ulysses Faraday', '1680 Saskatchewan Crescent, Regina, SK, Canada', '2014-09-20'),
('500000050', 'Vance Carmichael', '1690 Victoria Road, Regina, SK, Canada', '2014-10-20'),

-- Groupe 6 : London, ON
('500000051', 'Waldo Prescott', '1700 Talbot Street, London, ON, Canada', '2015-01-25'),
('500000052', 'Ambrose Whitaker', '1710 Dundas Street, London, ON, Canada', '2015-02-25'),
('500000053', 'Blaine Kensington', '1720 Wellington Road, London, ON, Canada', '2015-03-25'),
('500000054', 'Harlan Lowell', '1730 Hyde Park Road, London, ON, Canada', '2015-04-25'),
('500000055', 'Ingram Rutherford', '1740 Oxford Street, London, ON, Canada', '2015-05-25'),
('500000056', 'Keir Ellington', '1750 Richmond Street, London, ON, Canada', '2015-06-25'),
('500000057', 'Laurence Montgomery', '1760 Carling Avenue, London, ON, Canada', '2015-07-25'),
('500000058', 'Mortimer Blackwell', '1770 Highbury Avenue, London, ON, Canada', '2015-08-25'),
('500000059', 'Newton Forsyth', '1780 Adelaide Street, London, ON, Canada', '2015-09-25'),
('500000060', 'Oswald Pritchard', '1790 Quebec Street, London, ON, Canada', '2015-10-25'),

-- Groupe 7 : Mississauga, ON
('500000061', 'Parker Aldridge', '1800 Hurontario Street, Mississauga, ON, Canada', '2016-03-01'),
('500000062', 'Reuben Bannister', '1810 Burnhamthorpe Road, Mississauga, ON, Canada', '2016-04-01'),
('500000063', 'Sterling Carr', '1820 Lakeshore Road, Mississauga, ON, Canada', '2016-05-01'),
('500000064', 'Ulric Duvall', '1830 Dundas Street, Mississauga, ON, Canada', '2016-06-01'),
('500000065', 'Vaughn Ellison', '1840 Erin Mills Parkway, Mississauga, ON, Canada', '2016-07-01'),
('500000066', 'Zeke Ellison', '1850 Britannia Road, Mississauga, ON, Canada', '2016-08-01'),
('500000067', 'Cyrus Granger', '1860 Mississauga Road, Mississauga, ON, Canada', '2016-09-01'),
('500000068', 'Dante Harding', '1870 Eglinton Avenue, Mississauga, ON, Canada', '2016-10-01'),
('500000069', 'Edison Irving', '1880 Matheson Boulevard, Mississauga, ON, Canada', '2016-11-01'),
('500000070', 'Gideon Jarvis', '1890 Mavis Road, Mississauga, ON, Canada', '2016-12-01'),

-- Groupe 8 : Burlington, ON
('500000071', 'Hector Kilpatrick', '1900 Maple Avenue, Burlington, ON, Canada', '2017-01-10'),
('500000072', 'Isidore Langley', '1910 Lakeshore Road, Burlington, ON, Canada', '2017-02-10'),
('500000073', 'Kelvin Morrow', '1920 Main Street, Burlington, ON, Canada', '2017-03-10'),
('500000074', 'Lester Norris', '1930 Brant Street, Burlington, ON, Canada', '2017-04-10'),
('500000075', 'Merrill Orton', '1940 Byron Street, Burlington, ON, Canada', '2017-05-10'),
('500000076', 'Percival Parrish', '1950 Fairview Road, Burlington, ON, Canada', '2017-06-10'),
('500000077', 'Roderick Ramsey', '1960 Prospect Street, Burlington, ON, Canada', '2017-07-10'),
('500000078', 'Thelonious Sinclair', '1970 Guelph Line, Burlington, ON, Canada', '2017-08-10'),
('500000079', 'Wilbur Underwood', '1980 Upper Middle Road, Burlington, ON, Canada', '2017-09-10'),
('500000080', 'Xenophon Drake', '1990 Clarkson Street, Burlington, ON, Canada', '2017-10-10'),

-- Groupe 9 : Oshawa, ON
('500000081', 'Zebediah Abbott', '2000 Simcoe Street, Oshawa, ON, Canada', '2018-01-15'),
('500000082', 'Alden Baxter', '2010 King Street, Oshawa, ON, Canada', '2018-02-15'),
('500000083', 'Bartholomew Carter', '2020 Dundas Street, Oshawa, ON, Canada', '2018-03-15'),
('500000084', 'Clemens Doyle', '2030 Stevenson Road, Oshawa, ON, Canada', '2018-04-15'),
('500000085', 'Demetrius Evans', '2040 Courtland Avenue, Oshawa, ON, Canada', '2018-05-15'),
('500000086', 'Ephraim Ford', '2050 Westney Road, Oshawa, ON, Canada', '2018-06-15'),
('500000087', 'Ferdinand Garner', '2060 Stevenson Street, Oshawa, ON, Canada', '2018-07-15'),
('500000088', 'Garnett Harris', '2070 Carruthers Street, Oshawa, ON, Canada', '2018-08-15'),
('500000089', 'Horace Ingram', '2080 Ritson Road, Oshawa, ON, Canada', '2018-09-15'),
('500000090', 'Isaias Jennings', '2090 Taunton Road, Oshawa, ON, Canada', '2018-10-15'),

-- Groupe 10 : Windsor, ON
('500000091', 'Jebediah Keene', '2100 Huron Street, Windsor, ON, Canada', '2019-01-20'),
('500000092', 'Kipling Landry', '2110 Ouellette Avenue, Windsor, ON, Canada', '2019-02-20'),
('500000093', 'Leopold Mercer', '2120 Sandwich Street, Windsor, ON, Canada', '2019-03-20'),
('500000094', 'Mordecai Norton', '2130 University Avenue, Windsor, ON, Canada', '2019-04-20'),
('500000095', 'Nestor O''Brien', '2140 Riverside Drive, Windsor, ON, Canada', '2019-05-20'),
('500000096', 'Octavius Pratt', '2150 Dominion Boulevard, Windsor, ON, Canada', '2019-06-20'),
('500000097', 'Philo Quigley', '2160 Howard Avenue, Windsor, ON, Canada', '2019-07-20'),
('500000098', 'Raphael Rourke', '2170 Walker Road, Windsor, ON, Canada', '2019-08-20'),
('500000099', 'Simeon Sykes', '2180 Grand Boulevard, Windsor, ON, Canada', '2019-09-20'),
('500000100', 'Thurston Tatum', '2190 E.C. Row Expressway, Windsor, ON, Canada', '2019-10-20');

-- ========================================
-- Insert into Archive
-- ========================================
INSERT INTO Archive 
    (Date_de_debut, Date_de_fin, Enregistrement, NAS_Employes, NAS_Client, ID_Hotel, Numero_Chambre)
VALUES
  -- Hotel 1
  ('2019-05-12', '2019-05-17', 'location', '900000101', '200000055', '1', '203'),
  
  -- Hotel 2 (rooms: 101, 105, 204)
  ('2027-05-10', '2027-05-15', 'reservation', NULL, '200000002', '2', '101'),
  ('2019-12-02', '2019-12-07', 'location', '900000201', '200000069', '2', '105'),
  ('2019-07-07', '2019-07-12', 'location', '900000201', '200000059', '2', '204'),
  
  -- Hotel 3 (rooms: 101, 104)
  ('2019-06-09', '2019-06-14', 'location', '900000301', '200000057', '3', '101'),
  ('2027-10-05', '2027-10-10', 'reservation', NULL, '200000052', '3', '104'),
  
  -- Hotel 4 (rooms: 102, 105, 203)
  ('2017-03-10', '2017-03-15', 'location', '900000401', '200000001', '4', '102'),
  ('2019-08-03', '2019-08-08', 'location', '900000401', '200000061', '4', '105'),
  ('2020-01-10', '2020-01-15', 'location', '900000401', '200000071', '4', '203'),
  
  -- Hotel 5 (room: 101)
  ('2030-01-11', '2030-01-16', 'reservation', NULL, '200000005', '5', '101'),
  
  -- Hotel 6 (rooms: 101, 203, 203)
  ('2020-02-06', '2020-02-11', 'location', '900000601', '200000073', '6', '101'),
  ('2017-04-20', '2017-04-25', 'location', '900000601', '200000003', '6', '203'),
  ('2019-09-01', '2019-09-06', 'location', '900000601', '200000063', '6', '203'),
  
  -- Hotel 7 (room: 103)
  ('2027-11-11', '2027-11-16', 'reservation', NULL, '200000062', '7', '103'),
  
  -- Hotel 8 (rooms: 101, 102, 104, 104, 105, 304)
  ('2019-10-08', '2019-10-13', 'location', '900000801', '200000065', '8', '101'),
  ('2030-02-20', '2030-02-25', 'reservation', NULL, '200000015', '8', '102'),
  ('2017-05-15', '2017-05-20', 'location', '900000801', '200000005', '8', '104'),
  ('2028-03-10', '2028-03-15', 'reservation', NULL, '200000003', '8', '104'),
  ('2027-07-01', '2027-07-04', 'reservation', NULL, '200000022', '8', '105'),
  ('2020-03-05', '2020-03-10', 'location', '900000801', '200000075', '8', '304'),
  
  -- Hotel 10 (rooms: 101, 101, 203, 205)
  ('2027-12-01', '2027-12-06', 'reservation', NULL, '200000072', '10', '101'),
  ('2029-01-05', '2029-01-10', 'reservation', NULL, '200000004', '10', '101'),
  ('2020-08-16', '2020-08-21', 'location', '900001001', '200000087', '10', '203'),
  ('2017-06-10', '2017-06-15', 'location', '900001001', '200000007', '10', '205'),
  
  -- Hotel 11 (room: 202)
  ('2027-08-20', '2027-08-25', 'reservation', NULL, '200000032', '11', '202'),
  
  -- Hotel 12 (rooms: 101, 202)
  ('2017-07-05', '2017-07-10', 'location', '900001201', '200000009', '12', '101'),
  ('2028-04-05', '2028-04-10', 'reservation', NULL, '200000013', '12', '202'),
  
  -- Hotel 14 (room 105 twice)
  ('2017-08-25', '2017-08-30', 'location', '900001401', '200000011', '14', '105'),
  ('2027-09-15', '2027-09-20', 'reservation', NULL, '200000042', '14', '105'),
  
  -- Hotel 15 (room: 102)
  ('2029-02-14', '2029-02-19', 'reservation', NULL, '200000014', '15', '102'),
  
  -- Hotel 16 (rooms: 105, 203)
  ('2017-09-20', '2017-09-25', 'location', '900001601', '200000013', '16', '105'),
  ('2020-06-22', '2020-06-27', 'location', '900001601', '200000083', '16', '203'),
  
  -- Hotel 17 (rooms: 105, 205, 205)
  ('2030-05-05', '2030-05-10', 'reservation', NULL, '200000045', '17', '105'),
  ('2028-05-18', '2028-05-23', 'reservation', NULL, '200000023', '17', '205'),
  ('2030-03-15', '2030-03-20', 'reservation', NULL, '200000025', '17', '205'),
  
  -- Hotel 18 (rooms: 105, 203)
  ('2020-07-19', '2020-07-24', 'location', '900001801', '200000085', '18', '105'),
  ('2017-10-15', '2017-10-20', 'location', '900001801', '200000015', '18', '203'),
  
  -- Hotel 20 (rooms: 101, 203, 203)
  ('2017-11-10', '2017-11-15', 'location', '900002001', '200000017', '20', '101'),
  ('2029-03-03', '2029-03-08', 'reservation', NULL, '200000024', '20', '203'),
  ('2030-06-14', '2030-06-19', 'reservation', NULL, '200000055', '20', '203'),
  
  -- Hotel 22 (rooms: 204, 205)
  ('2017-12-05', '2017-12-10', 'location', '900002201', '200000019', '22', '204'),
  ('2028-01-15', '2028-01-20', 'reservation', NULL, '200000082', '22', '205'),
  
  -- Hotel 23 (room: 101)
  ('2030-07-23', '2030-07-28', 'reservation', NULL, '200000065', '23', '101'),
  
  -- Hotel 24 (rooms: 101, 105)
  ('2020-05-25', '2020-05-30', 'location', '900002401', '200000081', '24', '101'),
  ('2018-01-14', '2018-01-19', 'location', '900002401', '200000021', '24', '105'),
  
  -- Hotel 26 (rooms: 105, 105, 105, 201)
  ('2018-02-20', '2018-02-25', 'location', '900002601', '200000023', '26', '105'),
  ('2028-06-12', '2028-06-17', 'reservation', NULL, '200000033', '26', '105'),
  ('2030-04-25', '2030-04-30', 'reservation', NULL, '200000035', '26', '105'),
  ('2030-08-12', '2030-08-17', 'reservation', NULL, '200000075', '26', '201'),
  
  -- Hotel 28 (room: 101)
  ('2018-03-17', '2018-03-22', 'location', '900002801', '200000025', '28', '101'),
  
  -- Hotel 29 (room: 203)
  ('2030-09-01', '2030-09-06', 'reservation', NULL, '200000085', '29', '203'),
  
  -- Hotel 30 (rooms: 101, 105, 105)
  ('2021-01-01', '2021-01-06', 'location', '900003001', '200000097', '30', '101'),
  ('2018-04-12', '2018-04-17', 'location', '900003001', '200000027', '30', '105'),
  ('2029-05-20', '2029-05-25', 'reservation', NULL, '200000044', '30', '105'),
  
  -- Hotel 32 (rooms: 105, 203, 203)
  ('2018-05-08', '2018-05-13', 'location', '900003201', '200000029', '32', '105'),
  ('2021-01-28', '2021-02-02', 'location', '900003201', '200000099', '32', '203'),
  ('2030-10-10', '2030-10-15', 'reservation', NULL, '200000095', '32', '203'),
  
  -- Hotel 33 (room: 203)
  ('2028-02-20', '2028-02-25', 'reservation', NULL, '200000092', '33', '203'),
  
  -- Hotel 34 (room: 203)
  ('2018-06-04', '2018-06-09', 'location', '900003401', '200000031', '34', '203'),
  
  -- Hotel 35 (rooms: 101, 101, 105)
  ('2028-07-07', '2028-07-12', 'reservation', NULL, '200000043', '35', '101'),
  ('2031-01-20', '2031-01-25', 'reservation', NULL, '200000006', '35', '101'),
  ('2029-06-15', '2029-06-20', 'reservation', NULL, '200000054', '35', '105'),
  
  -- Hotel 36 (room: 101)
  ('2018-07-01', '2018-07-06', 'location', '900003601', '200000033', '36', '101'),
  
  -- Hotel 38 (rooms: 102, 105, 105)
  ('2031-02-15', '2031-02-20', 'reservation', NULL, '200000016', '38', '102'),
  ('2018-07-28', '2018-08-02', 'location', '900003801', '200000035', '38', '105'),
  ('2020-12-04', '2020-12-09', 'location', '900003801', '200000095', '38', '105'),
  
  -- Hotel 40 (rooms: 101, 105)
  ('2029-07-10', '2029-07-15', 'reservation', NULL, '200000064', '40', '101'),
  ('2018-08-24', '2018-08-29', 'location', '900004001', '200000037', '40', '105'),
  
  -- Hotel 41 (room: 105)
  ('2031-03-25', '2031-03-30', 'reservation', NULL, '200000026', '41', '105'),
  
  -- Hotel 42 (rooms: 101, 102, 203, 203)
  ('2020-09-13', '2020-09-18', 'location', '900004201', '200000089', '42', '101'),
  ('2028-08-22', '2028-08-27', 'reservation', NULL, '200000053', '42', '102'),
  ('2018-09-20', '2018-09-25', 'location', '900004201', '200000039', '42', '203'),
  ('2031-10-05', '2031-10-10', 'reservation', NULL, '200000096', '42', '203'),
  
  -- Hotel 44 (rooms: 101, 104, 204)
  ('2018-10-16', '2018-10-21', 'location', '900004401', '200000041', '44', '101'),
  ('2031-04-30', '2031-05-05', 'reservation', NULL, '200000036', '44', '104'),
  ('2020-10-10', '2020-10-15', 'location', '900004401', '200000091', '44', '204'),
  
  -- Hotel 45 (rooms: 105, 202) – note: 105 comes before 202 numerically
  ('2028-11-10', '2028-11-15', 'reservation', NULL, '200000083', '45', '105'),
  ('2029-08-18', '2029-08-23', 'reservation', NULL, '200000074', '45', '202'),
  
  -- Hotel 46 (room: 105 – four rows ordered by date)
  ('2018-11-12', '2018-11-17', 'location', '900004601', '200000043', '46', '105'),
  ('2020-11-07', '2020-11-12', 'location', '900004601', '200000093', '46', '105'),
  ('2028-12-01', '2028-12-06', 'reservation', NULL, '200000093', '46', '105'),
  ('2031-08-15', '2031-08-20', 'reservation', NULL, '200000076', '46', '105'),
  
  -- Hotel 47 (room: 105)
  ('2031-05-20', '2031-05-25', 'reservation', NULL, '200000046', '47', '105'),
  
  -- Hotel 49 (room: 105)
  ('2031-09-10', '2031-09-15', 'reservation', NULL, '200000086', '49', '105'),
  
  -- Hotel 50 (rooms: 105, 105, 105, 201)
  ('2028-09-30', '2028-10-05', 'reservation', NULL, '200000063', '50', '105'),
  ('2029-09-22', '2029-09-27', 'reservation', NULL, '200000084', '50', '105'),
  ('2031-06-10', '2031-06-15', 'reservation', NULL, '200000056', '50', '105'),
  ('2019-01-03', '2019-01-08', 'location', '900005001', '200000047', '50', '201'),
  
  -- Hotel 52 (room: 101)
  ('2019-02-01', '2019-02-06', 'location', '900005201', '200000049', '52', '101'),
  
  -- Hotel 53 (room: 101)
  ('2031-07-05', '2031-07-10', 'reservation', NULL, '200000066', '53', '101'),
  
  -- Hotel 54 (room: 105)
  ('2019-03-08', '2019-03-13', 'location', '900005401', '200000051', '54', '105'),
  
  -- Hotel 55 (rooms: 105, then 203 with three rows)
  ('2019-04-05', '2019-04-10', 'location', '900005501', '200000053', '55', '105'),
  ('2019-11-05', '2019-11-10', 'location', '900005501', '200000067', '55', '203'),
  ('2028-10-15', '2028-10-20', 'reservation', NULL, '200000073', '55', '203'),
  ('2029-10-30', '2029-11-04', 'reservation', NULL, '200000094', '55', '203')
;
