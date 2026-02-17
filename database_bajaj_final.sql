--
-- PostgreSQL database dump
--

\restrict uOe7kbWSMkOMP5G2Xegn3IzsRxcysfKjkuTcmQPtCfCtG5aVujt13YGxTHEdj0q

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-17 07:31:16

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16503)
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    admin_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(20) DEFAULT 'Staff'::character varying,
    CONSTRAINT admins_role_check CHECK (((role)::text = ANY ((ARRAY['Owner'::character varying, 'Staff'::character varying])::text[])))
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16502)
-- Name: admins_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_admin_id_seq OWNER TO postgres;

--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 219
-- Name: admins_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_admin_id_seq OWNED BY public.admins.admin_id;


--
-- TOC entry 222 (class 1259 OID 16517)
-- Name: drivers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drivers (
    driver_id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    phone_number character varying(20),
    address text,
    status character varying(20) DEFAULT 'Active'::character varying,
    join_date date DEFAULT CURRENT_DATE,
    CONSTRAINT drivers_status_check CHECK (((status)::text = ANY ((ARRAY['Active'::character varying, 'Suspended'::character varying, 'Blacklisted'::character varying])::text[])))
);


ALTER TABLE public.drivers OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16516)
-- Name: drivers_driver_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.drivers_driver_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.drivers_driver_id_seq OWNER TO postgres;

--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 221
-- Name: drivers_driver_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.drivers_driver_id_seq OWNED BY public.drivers.driver_id;


--
-- TOC entry 228 (class 1259 OID 16570)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    rental_id integer NOT NULL,
    payment_date date NOT NULL,
    amount_paid numeric(10,2) NOT NULL,
    payment_type character varying(20) NOT NULL,
    notes text,
    CONSTRAINT payments_payment_type_check CHECK (((payment_type)::text = ANY ((ARRAY['Cash'::character varying, 'Transfer'::character varying])::text[])))
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16569)
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_payment_id_seq OWNER TO postgres;

--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 227
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- TOC entry 226 (class 1259 OID 16545)
-- Name: rentals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rentals (
    rental_id integer NOT NULL,
    driver_id integer NOT NULL,
    vehicle_id integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    agreed_daily_rate numeric(10,2) NOT NULL,
    status character varying(20) DEFAULT 'Ongoing'::character varying,
    CONSTRAINT rentals_status_check CHECK (((status)::text = ANY ((ARRAY['Ongoing'::character varying, 'Returned'::character varying, 'Overdue'::character varying])::text[])))
);


ALTER TABLE public.rentals OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16544)
-- Name: rentals_rental_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rentals_rental_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rentals_rental_id_seq OWNER TO postgres;

--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 225
-- Name: rentals_rental_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rentals_rental_id_seq OWNED BY public.rentals.rental_id;


--
-- TOC entry 230 (class 1259 OID 16590)
-- Name: vehicle_expenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_expenses (
    expense_id integer NOT NULL,
    vehicle_id integer NOT NULL,
    admin_id integer,
    expense_date date NOT NULL,
    total_cost numeric(10,2) NOT NULL,
    description text,
    category character varying(20) NOT NULL,
    receipt_photo_path character varying(255),
    CONSTRAINT vehicle_expenses_category_check CHECK (((category)::text = ANY ((ARRAY['Service'::character varying, 'Tax'::character varying, 'Washing'::character varying, 'Other'::character varying])::text[])))
);


ALTER TABLE public.vehicle_expenses OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16589)
-- Name: vehicle_expenses_expense_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vehicle_expenses_expense_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehicle_expenses_expense_id_seq OWNER TO postgres;

--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 229
-- Name: vehicle_expenses_expense_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vehicle_expenses_expense_id_seq OWNED BY public.vehicle_expenses.expense_id;


--
-- TOC entry 224 (class 1259 OID 16531)
-- Name: vehicles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicles (
    vehicle_id integer NOT NULL,
    plate_number character varying(15) NOT NULL,
    model_year character varying(4),
    color character varying(20),
    status character varying(20) DEFAULT 'Available'::character varying,
    current_mileage integer DEFAULT 0,
    CONSTRAINT vehicles_status_check CHECK (((status)::text = ANY ((ARRAY['Available'::character varying, 'Rented'::character varying, 'Maintenance'::character varying])::text[])))
);


ALTER TABLE public.vehicles OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16530)
-- Name: vehicles_vehicle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vehicles_vehicle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehicles_vehicle_id_seq OWNER TO postgres;

--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 223
-- Name: vehicles_vehicle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vehicles_vehicle_id_seq OWNED BY public.vehicles.vehicle_id;


--
-- TOC entry 4881 (class 2604 OID 16506)
-- Name: admins admin_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN admin_id SET DEFAULT nextval('public.admins_admin_id_seq'::regclass);


--
-- TOC entry 4883 (class 2604 OID 16520)
-- Name: drivers driver_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers ALTER COLUMN driver_id SET DEFAULT nextval('public.drivers_driver_id_seq'::regclass);


--
-- TOC entry 4891 (class 2604 OID 16573)
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- TOC entry 4889 (class 2604 OID 16548)
-- Name: rentals rental_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals ALTER COLUMN rental_id SET DEFAULT nextval('public.rentals_rental_id_seq'::regclass);


--
-- TOC entry 4892 (class 2604 OID 16593)
-- Name: vehicle_expenses expense_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_expenses ALTER COLUMN expense_id SET DEFAULT nextval('public.vehicle_expenses_expense_id_seq'::regclass);


--
-- TOC entry 4886 (class 2604 OID 16534)
-- Name: vehicles vehicle_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicles ALTER COLUMN vehicle_id SET DEFAULT nextval('public.vehicles_vehicle_id_seq'::regclass);


--
-- TOC entry 5068 (class 0 OID 16503)
-- Dependencies: 220
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.admins VALUES (901, 'owner_medan', '$2y$10$HashRahasiaOwner123', 'Owner');
INSERT INTO public.admins VALUES (902, 'admin_staf', '$2y$10$HashRahasiaStaf456', 'Staff');


--
-- TOC entry 5070 (class 0 OID 16517)
-- Dependencies: 222
-- Data for Name: drivers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.drivers VALUES (10001, 'Abdul Muis', '081260203040', 'Jl. Jamin Ginting No. 45, Padang Bulan, Medan', 'Active', '2026-01-17');
INSERT INTO public.drivers VALUES (10002, 'Abdullah Jabat', '081370809010', 'Jl. Halat Gg. Sepakat No. 12, Medan Area', 'Active', '2026-01-25');
INSERT INTO public.drivers VALUES (10003, 'Bambang Surbakti', '081211223344', 'Jl. Karya Wisata, Johor, Medan', 'Active', '2026-01-18');
INSERT INTO public.drivers VALUES (10004, 'Siti Aminah', '085277889900', 'Jl. Marelan Raya Psr 4, Medan Marelan', 'Suspended', '2026-01-19');
INSERT INTO public.drivers VALUES (10005, 'Ucok Tarigan', '081366554433', 'Jl. Setia Budi No. 88, Tj. Rejo, Medan', 'Active', '2026-02-01');
INSERT INTO public.drivers VALUES (10006, 'Rini Boru Hombing', '081399887700', 'Jl. Pancing No. 5, Medan Tembung', 'Blacklisted', '2026-01-20');


--
-- TOC entry 5076 (class 0 OID 16570)
-- Dependencies: 228
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.payments VALUES (1, 20001, '2026-01-17', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (2, 20001, '2026-01-18', 200000.00, 'Cash', 'Setoran Rapel');
INSERT INTO public.payments VALUES (3, 20001, '2026-01-19', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (4, 20001, '2026-01-20', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (5, 20001, '2026-01-21', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (6, 20001, '2026-01-22', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (7, 20001, '2026-01-23', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (8, 20001, '2026-01-24', 200000.00, 'Transfer', 'Setoran Rapel via Dana');
INSERT INTO public.payments VALUES (9, 20001, '2026-01-25', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (10, 20001, '2026-01-26', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (11, 20002, '2026-01-29', 85000.00, 'Cash', 'Setoran Awal');
INSERT INTO public.payments VALUES (12, 20002, '2026-01-30', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (13, 20002, '2026-01-31', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (14, 20002, '2026-02-01', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (15, 20002, '2026-02-02', 200000.00, 'Transfer', 'Setoran Rapel BCA');
INSERT INTO public.payments VALUES (16, 20003, '2026-01-20', 90000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (17, 20003, '2026-01-23', 270000.00, 'Transfer', 'Setoran 3 Hari');
INSERT INTO public.payments VALUES (18, 20003, '2026-01-30', 450000.00, 'Transfer', 'Setoran Mingguan');
INSERT INTO public.payments VALUES (19, 20004, '2026-01-20', 85000.00, 'Cash', 'Setoran Awal');
INSERT INTO public.payments VALUES (20, 20004, '2026-01-21', 85000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (21, 20005, '2026-02-02', 85000.00, 'Cash', 'Setoran Awal');
INSERT INTO public.payments VALUES (22, 20006, '2026-01-28', 80000.00, 'Cash', 'Setoran Harian');
INSERT INTO public.payments VALUES (23, 20006, '2026-01-30', 80000.00, 'Transfer', 'Pelunasan');


--
-- TOC entry 5074 (class 0 OID 16545)
-- Dependencies: 226
-- Data for Name: rentals; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.rentals VALUES (20001, 10001, 50001, '2026-01-17 08:00:00', '2026-02-17 20:00:00', 85000.00, 'Ongoing');
INSERT INTO public.rentals VALUES (20002, 10002, 50002, '2026-01-29 08:00:00', '2026-02-15 20:00:00', 85000.00, 'Ongoing');
INSERT INTO public.rentals VALUES (20003, 10003, 50003, '2026-01-20 08:00:00', '2026-02-05 20:00:00', 90000.00, 'Returned');
INSERT INTO public.rentals VALUES (20004, 10004, 50004, '2026-01-20 08:00:00', '2026-01-27 20:00:00', 85000.00, 'Overdue');
INSERT INTO public.rentals VALUES (20005, 10005, 50005, '2026-02-02 08:00:00', '2026-02-09 20:00:00', 85000.00, 'Ongoing');
INSERT INTO public.rentals VALUES (20006, 10006, 50004, '2026-01-28 08:00:00', '2026-01-30 20:00:00', 80000.00, 'Returned');


--
-- TOC entry 5078 (class 0 OID 16590)
-- Dependencies: 230
-- Data for Name: vehicle_expenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vehicle_expenses VALUES (1, 50004, 902, '2026-01-18', 150000.00, 'Servis Pengecekan Awal. Lokasi: Bengkel Resmi Bajaj, Jl. Cemara No.63', 'Service', '/uploads/nota_service_awal.jpg');
INSERT INTO public.vehicle_expenses VALUES (2, 50001, 902, '2026-01-25', 45000.00, 'Ganti Oli Mesin Shell. Lokasi: Showroom Bajaj Cemara', 'Service', '/uploads/nota_oli_muis.jpg');
INSERT INTO public.vehicle_expenses VALUES (3, 50002, 901, '2026-02-01', 650000.00, 'Biaya Administrasi STNK Baru (Samsat Putri Hijau)', 'Tax', '/uploads/pajak_stnk.jpg');
INSERT INTO public.vehicle_expenses VALUES (4, 50005, 902, '2026-02-01', 25000.00, 'Cuci Steam (Doorsmeer Ringroad)', 'Washing', '/uploads/cuci_ucok.jpg');
INSERT INTO public.vehicle_expenses VALUES (5, 50003, 902, '2026-01-28', 15000.00, 'Tambal Ban Tubeless (Dr. Mansyur)', 'Other', '/uploads/nota_tambal.jpg');


--
-- TOC entry 5072 (class 0 OID 16531)
-- Dependencies: 224
-- Data for Name: vehicles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vehicles VALUES (50001, 'BK 4521 AXZ', '2026', 'Putih', 'Rented', 800);
INSERT INTO public.vehicles VALUES (50002, 'BK 3390 CD', '2026', 'Putih', 'Rented', 400);
INSERT INTO public.vehicles VALUES (50003, 'BK 6789 KLS', '2026', 'Merah', 'Available', 1500);
INSERT INTO public.vehicles VALUES (50004, 'BK 1234 XY', '2026', 'Biru', 'Available', 1200);
INSERT INTO public.vehicles VALUES (50005, 'BK 9988 OO', '2026', 'Biru', 'Rented', 100);


--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 219
-- Name: admins_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_admin_id_seq', 1, false);


--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 221
-- Name: drivers_driver_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.drivers_driver_id_seq', 10006, true);


--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 227
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 23, true);


--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 225
-- Name: rentals_rental_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rentals_rental_id_seq', 20006, true);


--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 229
-- Name: vehicle_expenses_expense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vehicle_expenses_expense_id_seq', 5, true);


--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 223
-- Name: vehicles_vehicle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vehicles_vehicle_id_seq', 50005, true);


--
-- TOC entry 4900 (class 2606 OID 16513)
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (admin_id);


--
-- TOC entry 4902 (class 2606 OID 16515)
-- Name: admins admins_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_username_key UNIQUE (username);


--
-- TOC entry 4904 (class 2606 OID 16529)
-- Name: drivers drivers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_pkey PRIMARY KEY (driver_id);


--
-- TOC entry 4912 (class 2606 OID 16583)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 4910 (class 2606 OID 16558)
-- Name: rentals rentals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT rentals_pkey PRIMARY KEY (rental_id);


--
-- TOC entry 4914 (class 2606 OID 16603)
-- Name: vehicle_expenses vehicle_expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_expenses
    ADD CONSTRAINT vehicle_expenses_pkey PRIMARY KEY (expense_id);


--
-- TOC entry 4906 (class 2606 OID 16541)
-- Name: vehicles vehicles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_pkey PRIMARY KEY (vehicle_id);


--
-- TOC entry 4908 (class 2606 OID 16543)
-- Name: vehicles vehicles_plate_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicles
    ADD CONSTRAINT vehicles_plate_number_key UNIQUE (plate_number);


--
-- TOC entry 4918 (class 2606 OID 16609)
-- Name: vehicle_expenses fk_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_expenses
    ADD CONSTRAINT fk_admin FOREIGN KEY (admin_id) REFERENCES public.admins(admin_id) ON DELETE SET NULL;


--
-- TOC entry 4915 (class 2606 OID 16559)
-- Name: rentals fk_driver; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT fk_driver FOREIGN KEY (driver_id) REFERENCES public.drivers(driver_id) ON DELETE CASCADE;


--
-- TOC entry 4917 (class 2606 OID 16584)
-- Name: payments fk_rental; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rental FOREIGN KEY (rental_id) REFERENCES public.rentals(rental_id) ON DELETE CASCADE;


--
-- TOC entry 4916 (class 2606 OID 16564)
-- Name: rentals fk_vehicle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT fk_vehicle FOREIGN KEY (vehicle_id) REFERENCES public.vehicles(vehicle_id) ON DELETE CASCADE;


--
-- TOC entry 4919 (class 2606 OID 16604)
-- Name: vehicle_expenses fk_vehicle_expense; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_expenses
    ADD CONSTRAINT fk_vehicle_expense FOREIGN KEY (vehicle_id) REFERENCES public.vehicles(vehicle_id) ON DELETE CASCADE;


-- Completed on 2026-02-17 07:31:17

--
-- PostgreSQL database dump complete
--

\unrestrict uOe7kbWSMkOMP5G2Xegn3IzsRxcysfKjkuTcmQPtCfCtG5aVujt13YGxTHEdj0q

