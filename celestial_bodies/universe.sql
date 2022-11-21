--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: celestial_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.celestial_type (
    celestial_type_id integer NOT NULL,
    celestial_type_name character varying(30) NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.celestial_type OWNER TO freecodecamp;

--
-- Name: celestial_type_celestial_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.celestial_type_celestial_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.celestial_type_celestial_type_id_seq OWNER TO freecodecamp;

--
-- Name: celestial_type_celestial_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.celestial_type_celestial_type_id_seq OWNED BY public.celestial_type.celestial_type_id;


--
-- Name: celestials; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.celestials (
    celestials_id integer NOT NULL,
    name character varying(30),
    galaxy_name character varying(30) NOT NULL,
    star_name character varying(30),
    planet_name character varying(30),
    moon_name character varying(30)
);


ALTER TABLE public.celestials OWNER TO freecodecamp;

--
-- Name: celestials_celestials_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.celestials_celestials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.celestials_celestials_id_seq OWNER TO freecodecamp;

--
-- Name: celestials_celestials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.celestials_celestials_id_seq OWNED BY public.celestials.celestials_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    celestial_type_id integer NOT NULL,
    earth_viewable boolean NOT NULL,
    distance_from_earth numeric(5,3)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    planet_id integer,
    dist_from_planet integer NOT NULL,
    facts text
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    celestial_type_id integer NOT NULL,
    star_id integer,
    has_life boolean NOT NULL,
    facts text
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    celestial_type_id integer NOT NULL,
    galaxy_id integer,
    known_planets integer NOT NULL,
    facts text
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: celestial_type celestial_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.celestial_type ALTER COLUMN celestial_type_id SET DEFAULT nextval('public.celestial_type_celestial_type_id_seq'::regclass);


--
-- Name: celestials celestials_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.celestials ALTER COLUMN celestials_id SET DEFAULT nextval('public.celestials_celestials_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: celestial_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.celestial_type VALUES (27, 'CELESTIAL', 'TYPE_NAME');
INSERT INTO public.celestial_type VALUES (28, 'GALAXY', 'Barred spiral');
INSERT INTO public.celestial_type VALUES (29, 'GALAXY', 'Spiral');
INSERT INTO public.celestial_type VALUES (30, 'GALAXY', 'Elliptical');
INSERT INTO public.celestial_type VALUES (31, 'GALAXY', 'Peculiar');
INSERT INTO public.celestial_type VALUES (32, 'GALAXY', 'Irregular');
INSERT INTO public.celestial_type VALUES (33, 'STAR', 'Solar-type');
INSERT INTO public.celestial_type VALUES (34, 'STAR', 'Binary');
INSERT INTO public.celestial_type VALUES (35, 'STAR', 'Dwarf');
INSERT INTO public.celestial_type VALUES (36, 'STAR', 'Red giant');
INSERT INTO public.celestial_type VALUES (37, 'STAR', 'Hot blue');
INSERT INTO public.celestial_type VALUES (38, 'PLANET', 'Terrestrial');
INSERT INTO public.celestial_type VALUES (39, 'PLANET', 'Gas giant');
INSERT INTO public.celestial_type VALUES (40, 'MOON', '');


--
-- Data for Name: celestials; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.celestials VALUES (68, NULL, 'Milky Way', NULL, NULL, NULL);
INSERT INTO public.celestials VALUES (69, NULL, 'Andromeda', NULL, NULL, NULL);
INSERT INTO public.celestials VALUES (70, NULL, 'Whirlpool', NULL, NULL, NULL);
INSERT INTO public.celestials VALUES (71, NULL, 'Saffronius', NULL, NULL, NULL);
INSERT INTO public.celestials VALUES (72, NULL, 'Soupy Way', NULL, NULL, NULL);
INSERT INTO public.celestials VALUES (73, NULL, 'Paddington', NULL, NULL, NULL);
INSERT INTO public.celestials VALUES (74, NULL, 'Milky Way', 'Sol', NULL, NULL);
INSERT INTO public.celestials VALUES (75, NULL, 'Andromeda', 'Alpheratz', NULL, NULL);
INSERT INTO public.celestials VALUES (76, NULL, 'Milky Way', 'Sirius', NULL, NULL);
INSERT INTO public.celestials VALUES (77, NULL, 'Saffronius', 'Vanillius', NULL, NULL);
INSERT INTO public.celestials VALUES (78, NULL, 'Soupy Way', 'Fodori', NULL, NULL);
INSERT INTO public.celestials VALUES (79, NULL, 'Paddington', 'Ursa', NULL, NULL);
INSERT INTO public.celestials VALUES (80, NULL, 'Milky Way', 'Sol', 'Mercury', NULL);
INSERT INTO public.celestials VALUES (81, NULL, 'Milky Way', 'Sol', 'Venus', NULL);
INSERT INTO public.celestials VALUES (82, NULL, 'Milky Way', 'Sol', 'Earth', NULL);
INSERT INTO public.celestials VALUES (83, NULL, 'Milky Way', 'Sol', 'Mars', NULL);
INSERT INTO public.celestials VALUES (84, NULL, 'Milky Way', 'Sol', 'Jupiter', NULL);
INSERT INTO public.celestials VALUES (85, NULL, 'Milky Way', 'Sol', 'Saturn', NULL);
INSERT INTO public.celestials VALUES (86, NULL, 'Milky Way', 'Sol', 'Uranus', NULL);
INSERT INTO public.celestials VALUES (87, NULL, 'Milky Way', 'Sol', 'Neptune', NULL);
INSERT INTO public.celestials VALUES (88, NULL, 'Milky Way', 'Sol', 'Pluto', NULL);
INSERT INTO public.celestials VALUES (89, NULL, 'Soupy Way', 'Fodori', 'Cottonus', NULL);
INSERT INTO public.celestials VALUES (90, NULL, 'Soupy Way', 'Fodori', 'Brickerus', NULL);
INSERT INTO public.celestials VALUES (91, NULL, 'Saffronius', 'Vanillius', 'Pepperin', NULL);
INSERT INTO public.celestials VALUES (92, NULL, 'Milky Way', 'Sol', 'Earth', 'Luna');
INSERT INTO public.celestials VALUES (93, NULL, 'Milky Way', 'Sol', 'Mars', 'Phobos');
INSERT INTO public.celestials VALUES (94, NULL, 'Milky Way', 'Sol', 'Mars', 'Deimos');
INSERT INTO public.celestials VALUES (95, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Metis');
INSERT INTO public.celestials VALUES (96, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Adrastea');
INSERT INTO public.celestials VALUES (97, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Amalthea');
INSERT INTO public.celestials VALUES (98, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Thebe');
INSERT INTO public.celestials VALUES (99, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Io');
INSERT INTO public.celestials VALUES (100, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Europa');
INSERT INTO public.celestials VALUES (101, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Ganymede');
INSERT INTO public.celestials VALUES (102, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Callisto');
INSERT INTO public.celestials VALUES (103, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Themisto');
INSERT INTO public.celestials VALUES (104, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Leda');
INSERT INTO public.celestials VALUES (105, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Ersa');
INSERT INTO public.celestials VALUES (106, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Himalia');
INSERT INTO public.celestials VALUES (107, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Pandia');
INSERT INTO public.celestials VALUES (108, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Euporie');
INSERT INTO public.celestials VALUES (109, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Helike');
INSERT INTO public.celestials VALUES (110, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Ananke');
INSERT INTO public.celestials VALUES (111, NULL, 'Milky Way', 'Sol', 'Jupiter', 'Kale');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (12, 'Milky Way', 28, true, 0.000);
INSERT INTO public.galaxy VALUES (13, 'Andromeda', 28, true, 2.537);
INSERT INTO public.galaxy VALUES (14, 'Whirlpool', 29, true, 23.160);
INSERT INTO public.galaxy VALUES (15, 'Saffronius', 30, false, 99.342);
INSERT INTO public.galaxy VALUES (16, 'Soupy Way', 31, false, 3.145);
INSERT INTO public.galaxy VALUES (17, 'Paddington', 32, false, 57.775);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (22, 'Luna', NULL, 384400, 'Is named after a Harry Potter character');
INSERT INTO public.moon VALUES (23, 'Phobos', NULL, 6000, 'Is named after fear and panic');
INSERT INTO public.moon VALUES (24, 'Deimos', NULL, 23460, 'Is named after terror');
INSERT INTO public.moon VALUES (25, 'Metis', NULL, 128000, 'Looks like a disk');
INSERT INTO public.moon VALUES (26, 'Adrastea', NULL, 129000, 'Is tiny');
INSERT INTO public.moon VALUES (27, 'Amalthea', NULL, 181400, 'Looks like a red disk');
INSERT INTO public.moon VALUES (28, 'Thebe', NULL, 221900, 'Looks like a lost rock');
INSERT INTO public.moon VALUES (29, 'Io', NULL, 421800, 'Has a weird vowel only name');
INSERT INTO public.moon VALUES (30, 'Europa', NULL, 671100, 'Is named after Europe');
INSERT INTO public.moon VALUES (31, 'Ganymede', NULL, 1070400, 'Was supposed to be named Runnymede but Toronto took it');
INSERT INTO public.moon VALUES (32, 'Callisto', NULL, 1882700, 'Was supposed to be named Calypso or something');
INSERT INTO public.moon VALUES (33, 'Themisto', NULL, 7398500, 'Is the only ungrouped moon lol');
INSERT INTO public.moon VALUES (34, 'Leda', NULL, 11146400, 'Was discovered by Kowal and Kowal alone');
INSERT INTO public.moon VALUES (35, 'Ersa', NULL, 11401000, 'Was supposed to be named Ursula but that was taken');
INSERT INTO public.moon VALUES (36, 'Himalia', NULL, 11440600, 'Is part of the group with the same name');
INSERT INTO public.moon VALUES (37, 'Pandia', NULL, 11481000, 'Is named between Panda and Pandora');
INSERT INTO public.moon VALUES (38, 'Euporie', NULL, 19265800, 'Is Euphoria before Euphoria became a thing');
INSERT INTO public.moon VALUES (39, 'Helike', NULL, 20915700, 'Is how you start any gossipy sentence');
INSERT INTO public.moon VALUES (40, 'Ananke', NULL, 21034500, 'Is Anakin but not as cool');
INSERT INTO public.moon VALUES (41, 'Kale', NULL, 23052600, 'Is the favourite moon of all diet bros');


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (25, 'Mercury', 38, NULL, false, 'Also known as my');
INSERT INTO public.planet VALUES (26, 'Venus', 38, NULL, false, 'Is twins with earth');
INSERT INTO public.planet VALUES (27, 'Earth', 38, NULL, true, 'Where we live');
INSERT INTO public.planet VALUES (28, 'Mars', 38, NULL, false, 'Where we want to live');
INSERT INTO public.planet VALUES (29, 'Jupiter', 39, NULL, false, 'Has an eternal storm');
INSERT INTO public.planet VALUES (30, 'Saturn', 39, NULL, false, 'Has cool rings');
INSERT INTO public.planet VALUES (31, 'Uranus', 39, NULL, false, 'Is a joke amongst middle schoolers');
INSERT INTO public.planet VALUES (32, 'Neptune', 39, NULL, false, 'Is blue and is everyones favourite Roman god');
INSERT INTO public.planet VALUES (33, 'Pluto', 39, NULL, false, 'Is having an identity crisis');
INSERT INTO public.planet VALUES (34, 'Cottonus', 39, NULL, false, 'Is filled with cotton candy');
INSERT INTO public.planet VALUES (35, 'Brickerus', 38, NULL, false, 'Is made entirely by bricks');
INSERT INTO public.planet VALUES (36, 'Pepperin', 38, NULL, false, 'Is made entirely by pepper');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (12, 'Sol', 33, NULL, 9, 'Has solar storms causing Northern Lights');
INSERT INTO public.star VALUES (13, 'Alpheratz', 34, NULL, 0, 'Is the brightest star in Andromeda');
INSERT INTO public.star VALUES (14, 'Sirius', 35, NULL, 0, 'Is also named after a Harry Potter character');
INSERT INTO public.star VALUES (15, 'Vanillius', 36, NULL, 4, 'Is made entirely by vanilla beans');
INSERT INTO public.star VALUES (16, 'Fodori', 37, NULL, 7, 'Has lots of philosophers in it');
INSERT INTO public.star VALUES (17, 'Ursa', 35, NULL, 2, 'Paddington the Bear easter egg lol');


--
-- Name: celestial_type_celestial_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.celestial_type_celestial_type_id_seq', 40, true);


--
-- Name: celestials_celestials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.celestials_celestials_id_seq', 111, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 17, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 41, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 36, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 17, true);


--
-- Name: celestial_type celestial_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.celestial_type
    ADD CONSTRAINT celestial_type_name_key UNIQUE (name);


--
-- Name: celestial_type celestial_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.celestial_type
    ADD CONSTRAINT celestial_type_pkey PRIMARY KEY (celestial_type_id);


--
-- Name: celestials celestials_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.celestials
    ADD CONSTRAINT celestials_name_key UNIQUE (name);


--
-- Name: celestials celestials_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.celestials
    ADD CONSTRAINT celestials_pkey PRIMARY KEY (celestials_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy galaxy_celestial_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_celestial_type_id_fkey FOREIGN KEY (celestial_type_id) REFERENCES public.celestial_type(celestial_type_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_celestial_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_celestial_type_id_fkey FOREIGN KEY (celestial_type_id) REFERENCES public.celestial_type(celestial_type_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_celestial_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_celestial_type_id_fkey FOREIGN KEY (celestial_type_id) REFERENCES public.celestial_type(celestial_type_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

