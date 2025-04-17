--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-04-09 23:07:40

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16392)
-- Name: pr5; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pr5;


ALTER SCHEMA pr5 OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16428)
-- Name: dealer; Type: TABLE; Schema: pr5; Owner: postgres
--

CREATE TABLE pr5.dealer (
    id_dealer integer NOT NULL,
    company character varying(20),
    adress character varying,
    phone_number character varying(12),
    seo character varying
);


ALTER TABLE pr5.dealer OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16427)
-- Name: dealer_id_dealer_seq; Type: SEQUENCE; Schema: pr5; Owner: postgres
--

CREATE SEQUENCE pr5.dealer_id_dealer_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr5.dealer_id_dealer_seq OWNER TO postgres;

--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 220
-- Name: dealer_id_dealer_seq; Type: SEQUENCE OWNED BY; Schema: pr5; Owner: postgres
--

ALTER SEQUENCE pr5.dealer_id_dealer_seq OWNED BY pr5.dealer.id_dealer;


--
-- TOC entry 219 (class 1259 OID 16420)
-- Name: goods; Type: TABLE; Schema: pr5; Owner: postgres
--

CREATE TABLE pr5.goods (
    idgoods integer NOT NULL,
    name character varying(30) NOT NULL,
    deliverydate date NOT NULL,
    amount smallint NOT NULL,
    cost text NOT NULL,
    id_dealer integer
);


ALTER TABLE pr5.goods OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16419)
-- Name: goods_idgoods_seq; Type: SEQUENCE; Schema: pr5; Owner: postgres
--

CREATE SEQUENCE pr5.goods_idgoods_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr5.goods_idgoods_seq OWNER TO postgres;

--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 218
-- Name: goods_idgoods_seq; Type: SEQUENCE OWNED BY; Schema: pr5; Owner: postgres
--

ALTER SEQUENCE pr5.goods_idgoods_seq OWNED BY pr5.goods.idgoods;


--
-- TOC entry 223 (class 1259 OID 40966)
-- Name: sales; Type: TABLE; Schema: pr5; Owner: postgres
--

CREATE TABLE pr5.sales (
    idsales integer NOT NULL,
    idgoods integer,
    datesale date,
    count integer,
    price text
);


ALTER TABLE pr5.sales OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 40979)
-- Name: sales_id_sales_seq; Type: SEQUENCE; Schema: pr5; Owner: postgres
--

CREATE SEQUENCE pr5.sales_id_sales_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr5.sales_id_sales_seq OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 40980)
-- Name: sales_idsale_seq; Type: SEQUENCE; Schema: pr5; Owner: postgres
--

CREATE SEQUENCE pr5.sales_idsale_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr5.sales_idsale_seq OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 40965)
-- Name: sales_idsales_seq; Type: SEQUENCE; Schema: pr5; Owner: postgres
--

CREATE SEQUENCE pr5.sales_idsales_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr5.sales_idsales_seq OWNER TO postgres;

--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 222
-- Name: sales_idsales_seq; Type: SEQUENCE OWNED BY; Schema: pr5; Owner: postgres
--

ALTER SEQUENCE pr5.sales_idsales_seq OWNED BY pr5.sales.idsales;


--
-- TOC entry 227 (class 1259 OID 40986)
-- Name: staff; Type: TABLE; Schema: pr5; Owner: postgres
--

CREATE TABLE pr5.staff (
    idworker integer NOT NULL,
    name text,
    post text
);


ALTER TABLE pr5.staff OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 40985)
-- Name: staff_idworker_seq; Type: SEQUENCE; Schema: pr5; Owner: postgres
--

CREATE SEQUENCE pr5.staff_idworker_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pr5.staff_idworker_seq OWNER TO postgres;

--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 226
-- Name: staff_idworker_seq; Type: SEQUENCE OWNED BY; Schema: pr5; Owner: postgres
--

ALTER SEQUENCE pr5.staff_idworker_seq OWNED BY pr5.staff.idworker;


--
-- TOC entry 4764 (class 2604 OID 40982)
-- Name: dealer id_dealer; Type: DEFAULT; Schema: pr5; Owner: postgres
--

ALTER TABLE ONLY pr5.dealer ALTER COLUMN id_dealer SET DEFAULT nextval('pr5.dealer_id_dealer_seq'::regclass);


--
-- TOC entry 4763 (class 2604 OID 40981)
-- Name: goods idgoods; Type: DEFAULT; Schema: pr5; Owner: postgres
--

ALTER TABLE ONLY pr5.goods ALTER COLUMN idgoods SET DEFAULT nextval('pr5.goods_idgoods_seq'::regclass);


--
-- TOC entry 4765 (class 2604 OID 40984)
-- Name: sales idsales; Type: DEFAULT; Schema: pr5; Owner: postgres
--

ALTER TABLE ONLY pr5.sales ALTER COLUMN idsales SET DEFAULT nextval('pr5.sales_idsales_seq'::regclass);


--
-- TOC entry 4766 (class 2604 OID 40989)
-- Name: staff idworker; Type: DEFAULT; Schema: pr5; Owner: postgres
--

ALTER TABLE ONLY pr5.staff ALTER COLUMN idworker SET DEFAULT nextval('pr5.staff_idworker_seq'::regclass);


--
-- TOC entry 4925 (class 0 OID 16428)
-- Dependencies: 221
-- Data for Name: dealer; Type: TABLE DATA; Schema: pr5; Owner: postgres
--

COPY pr5.dealer (id_dealer, company, adress, phone_number, seo) FROM stdin;
1	Company 1	Russia, Moscow, Lenina street, 1	+79011234567	Панин А.С.
2	Company 2	Russia, Moscow, Lenina street, 2	+79021234567	Акимов С.Ф.
3	Company 3	Russia, Moscow, Lenina street, 3	+79031234567	Петров З.Е.
4	Company 4	Russia, Moscow, Lenina street, 4	+79041234567	Малашкин И.И.
5	Company 5	Russia, Moscow, Lenina street, 5	+79051234567	Антонов Ю.М.
6	Company 6	Russia, Moscow, Lenina street, 6	+79061234567	Сафронов Д.В.
7	Company 7	Russia, Moscow, Lenina street, 7	+79071234567	Пирогов С.С.
8	Company 8	Russia, Moscow, Lenina street, 8	+79081234567	Калашников А.А.
9	Company 9	Russia, Moscow, Lenina street, 9	+79091234567	Мухаметова А.Г.
10	Company 10	Russia, Moscow, Lenina street, 10	+79101234567	Романов Т.Е.
11	Company 11	Russia, Moscow, Lenina street, 11	+79111234567	Сыралидзе Н.Д.
12	Company 12	Russia, Moscow, Lenina street, 12	+79121234567	Крутовских Я.К.
13	Company 13	Russia, Moscow, Lenina street, 13	+79131234567	Гогиашвили К.Д.
14	Company 14	Russia, Moscow, Lenina street, 14	+79141234567	Стерлядкин В.В.
15	Company 15	Russia, Moscow, Lenina street, 15	+79151234567	Грабова Е.Б.
16	Company 16	Russia, Moscow, Lenina street, 16	+79161234567	Босоногов К. А.
17	Company 17	Russia, Moscow, Lenina street, 17	+79171234567	Дорохов Ф.Д.
18	Company 18	Russia, Moscow, Lenina street, 18	+79181234567	Кристалинов В.Р.
19	Company 19	Russia, Moscow, Lenina street, 19	+79191234567	Жириновский В.В.
20	Company 20	Russia, Moscow, Lenina street, 20	+79201234567	Колпакова М.Ф.
\.


--
-- TOC entry 4923 (class 0 OID 16420)
-- Dependencies: 219
-- Data for Name: goods; Type: TABLE DATA; Schema: pr5; Owner: postgres
--

COPY pr5.goods (idgoods, name, deliverydate, amount, cost, id_dealer) FROM stdin;
6	Product 6	2024-04-17	79	349.60	3
8	Product 8	2024-05-09	85	449.40	20
10	Product 10	2024-05-09	105	549.20	1
1	Product 1	2024-04-15	104	99.00	7
2	Product 2	2024-04-15	125	149.90	2
9	Product 3	2024-05-09	95	499.30	20
14	Product 9	2024-06-28	145	748.80	14
3	Product 3	2024-04-17	35	199.95	15
4	Product 4	2024-04-17	206	249.80	19
5	Product 5	2024-04-17	110	299.70	2
7	Product 7	2024-04-17	75	399.50	11
11	Product 11	2024-06-28	115	599.10	12
12	Product 12	2024-06-28	125	649.00	9
13	Product 13	2024-06-28	135	698.90	14
15	Product 15	2024-07-19	155	798.70	4
16	Product 16	2024-07-19	165	848.60	17
17	Product 17	2024-08-02	175	898.50	13
18	Product 18	2024-08-11	185	948.40	13
19	Product 19	2024-08-22	40	998.30	13
21	Product 7	2024-09-20	70	399.50	11
22	Product 11	2024-09-20	120	600.0	12
23	Product 13	2024-09-20	20	699.10	14
24	Product 3	2024-09-27	91	210.25	15
25	Product 18	2024-09-27	111	948.40	13
26	Product 5	2024-09-27	49	299.99	2
27	Product 4	2024-09-27	210	249.80	2
28	Product 8	2024-09-29	55	455.10	20
29	Product 21	2024-09-29	100	720.50	10
30	Product 16	2024-09-29	45	848.60	19
31	Product 14	2024-10-08	100	749.80	5
32	Product 6	2024-10-08	90	351.20	16
20	Product 20	2024-09-11	59	1048.20	1
\.


--
-- TOC entry 4927 (class 0 OID 40966)
-- Dependencies: 223
-- Data for Name: sales; Type: TABLE DATA; Schema: pr5; Owner: postgres
--

COPY pr5.sales (idsales, idgoods, datesale, count, price) FROM stdin;
1	3	2024-04-20	3	210.99
2	2	2024-04-20	12	160.99
3	1	2024-04-20	7	115.99
4	6	2024-04-20	17	370.99
5	4	2024-04-21	2	269.99
6	7	2024-04-21	15	419.99
7	5	2024-04-21	13	319.99
8	1	2024-04-21	9	115.99
9	6	2024-04-21	21	370.99
10	2	2024-04-21	1	160.99
11	3	2024-04-22	4	210.99
12	4	2024-04-22	11	269.99
13	7	2024-04-22	2	419.99
14	5	2024-04-23	1	319.99
15	1	2024-04-24	10	115.99
16	6	2024-04-25	3	370.99
17	1	2024-04-25	2	115.99
19	5	2024-04-27	1	319.99
18	3	2024-04-25	2	210.99
21	7	2024-04-28	4	419.99
22	4	2024-04-29	13	269.99
23	5	2024-04-30	1	319.99
24	1	2024-04-30	1	115.99
25	2	2024-04-30	1	160.99
26	7	2024-04-30	2	419.99
27	1	2024-05-01	2	115.99
28	4	2024-05-01	12	269.99
29	4	2024-05-02	3	269.99
30	2	2024-05-02	1	160.99
31	4	2024-05-04	17	269.99
32	5	2024-05-04	1	319.99
33	6	2024-05-04	13	370.99
20	2	2024-04-27	3	160.99
34	3	2024-05-05	4	210.99
35	7	2024-05-05	3	419.99
36	2	2024-05-05	9	160.99
37	4	2024-05-05	32	269.99
38	4	2024-05-06	32	269.99
39	4	2024-05-07	2	269.99
40	1	2024-05-07	1	115.99
41	2	2024-05-08	13	160.99
42	3	2024-05-08	11	210.99
43	5	2024-05-09	11	319.99
44	8	2024-05-09	11	469.99
47	14	2024-07-01	17	779.99
46	14	2024-06-30	21	779.99
48	11	2024-07-02	98	629.99
49	12	2024-07-02	107	669.99
50	13	2024-07-02	115	739.99
51	16	2024-07-20	141	889.99
45	14	2024-06-29	24	779.99
52	15	2024-07-20	132	849.99
53	17	2024-08-03	149	929.99
54	18	2024-08-12	158	989.99
55	19	2024-08-23	34	1029.99
56	20	2024-09-12	41	1200.99
57	21	2024-09-21	60	419.99
58	22	2024-09-21	102	620.99
59	23	2024-09-21	17	727.99
60	27	2024-09-28	179	260.99
61	24	2024-09-28	95	999.99
62	26	2024-09-28	42	319.99
63	25	2024-09-28	78	219.99
64	30	2024-09-30	39	889.99
65	29	2024-09-30	85	759.99
66	28	2024-09-30	47	469.99
67	32	2024-10-09	77	379.99
68	31	2024-10-09	85	779.99
\.


--
-- TOC entry 4931 (class 0 OID 40986)
-- Dependencies: 227
-- Data for Name: staff; Type: TABLE DATA; Schema: pr5; Owner: postgres
--

COPY pr5.staff (idworker, name, post) FROM stdin;
3	Варенуха И. А.	Продавец-консультант
2	Обломов И .И.	Начальник смены
4	Горячев А. В.	Продавец-консультант
5	Сорокин В. А.	Работник склада
1	Трошкин Л. М.	Директор магазина
6	Сорокин К. А.	Работник склада
7	Ложкин С. Д.	Работник склада
\.


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 220
-- Name: dealer_id_dealer_seq; Type: SEQUENCE SET; Schema: pr5; Owner: postgres
--

SELECT pg_catalog.setval('pr5.dealer_id_dealer_seq', 20, true);


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 218
-- Name: goods_idgoods_seq; Type: SEQUENCE SET; Schema: pr5; Owner: postgres
--

SELECT pg_catalog.setval('pr5.goods_idgoods_seq', 21, true);


--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 224
-- Name: sales_id_sales_seq; Type: SEQUENCE SET; Schema: pr5; Owner: postgres
--

SELECT pg_catalog.setval('pr5.sales_id_sales_seq', 1, false);


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 225
-- Name: sales_idsale_seq; Type: SEQUENCE SET; Schema: pr5; Owner: postgres
--

SELECT pg_catalog.setval('pr5.sales_idsale_seq', 1, false);


--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 222
-- Name: sales_idsales_seq; Type: SEQUENCE SET; Schema: pr5; Owner: postgres
--

SELECT pg_catalog.setval('pr5.sales_idsales_seq', 76, true);


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 226
-- Name: staff_idworker_seq; Type: SEQUENCE SET; Schema: pr5; Owner: postgres
--

SELECT pg_catalog.setval('pr5.staff_idworker_seq', 7, true);


--
-- TOC entry 4770 (class 2606 OID 16435)
-- Name: dealer dealer_pkey; Type: CONSTRAINT; Schema: pr5; Owner: postgres
--

ALTER TABLE ONLY pr5.dealer
    ADD CONSTRAINT dealer_pkey PRIMARY KEY (id_dealer);


--
-- TOC entry 4768 (class 2606 OID 16425)
-- Name: goods goods_pkey; Type: CONSTRAINT; Schema: pr5; Owner: postgres
--

ALTER TABLE ONLY pr5.goods
    ADD CONSTRAINT goods_pkey PRIMARY KEY (idgoods);


--
-- TOC entry 4772 (class 2606 OID 40973)
-- Name: sales idsales; Type: CONSTRAINT; Schema: pr5; Owner: postgres
--

ALTER TABLE ONLY pr5.sales
    ADD CONSTRAINT idsales PRIMARY KEY (idsales);


--
-- TOC entry 4774 (class 2606 OID 40993)
-- Name: staff staff_pk; Type: CONSTRAINT; Schema: pr5; Owner: postgres
--

ALTER TABLE ONLY pr5.staff
    ADD CONSTRAINT staff_pk PRIMARY KEY (idworker);


--
-- TOC entry 4775 (class 2606 OID 40960)
-- Name: goods goods_dealer_fk; Type: FK CONSTRAINT; Schema: pr5; Owner: postgres
--

ALTER TABLE ONLY pr5.goods
    ADD CONSTRAINT goods_dealer_fk FOREIGN KEY (id_dealer) REFERENCES pr5.dealer(id_dealer) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4776 (class 2606 OID 40974)
-- Name: sales sales_goods_fk; Type: FK CONSTRAINT; Schema: pr5; Owner: postgres
--

ALTER TABLE ONLY pr5.sales
    ADD CONSTRAINT sales_goods_fk FOREIGN KEY (idgoods) REFERENCES pr5.goods(idgoods) ON UPDATE CASCADE;


-- Completed on 2025-04-09 23:07:40

--
-- PostgreSQL database dump complete
--

