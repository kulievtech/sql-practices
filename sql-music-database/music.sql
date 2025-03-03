-- Exercises in Joining (mostly)
-- Referring to the table system outlined below. One of many advantages of the table system chosen is the ability to determine a person's relations (eg. Mother, Father, Uncle, Cousin etc.)




--                PEOPLE
-- Person	    Sex	    Born	    Nationality
-- Gerry	    M	    1941	    Australian
-- Rhonda	    F	    1943	    British
-- Sybil	    F	    1963	    Australian
-- Gina	    F	    1985	    Australian
-- Frank	    M	    1937	    American
-- Mary	    F	    ?	        American
-- Paul	    M	    1962	    American
-- Peter	    M	    1963	    Australian
-- Joe	        M	    1984	    ?
-- Steven	    M	    1942	    British
-- Sue	        F	    1941	    American
-- Paula	    F	    1964	    American
-- Harry	    M	    1963	    ?
-- Alan	    M	    1986	    ?



        FAMILY
-- Person	    Parent
-- Sybil	    Gerry
-- Sybil	    Rhonda
-- Paul	    Frank
-- Paul	    Mary
-- Peter	    Frank
-- Peter	    Mary
-- Paula	    Steven
-- Paula	    Sue
-- Gina	    Sybil
-- Gina	    Paul
-- Joe     	Peter
-- Joe	        Paula
-- Harry	    Frank
-- Harry	    Rhonda
-- Alan	    Paul



