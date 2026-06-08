--
-- PostgreSQL database dump
--

\restrict KlTysNTjQWjKgPqGF8h9Txt17EXPcipxs9jQnqYMrziAHGtgR1pLTgo32bXE6Yf

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

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
-- Name: ab_testing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ab_testing (
    id integer NOT NULL,
    user_id integer,
    group_type character varying(100),
    assigned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ab_testing OWNER TO postgres;

--
-- Name: ab_testing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ab_testing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ab_testing_id_seq OWNER TO postgres;

--
-- Name: ab_testing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_testing_id_seq OWNED BY public.ab_testing.id;


--
-- Name: admin_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_logs (
    id integer NOT NULL,
    admin_id integer,
    action character varying(100),
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.admin_logs OWNER TO postgres;

--
-- Name: admin_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_logs_id_seq OWNER TO postgres;

--
-- Name: admin_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_logs_id_seq OWNED BY public.admin_logs.id;


--
-- Name: feature_interactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feature_interactions (
    id integer NOT NULL,
    user_id integer,
    feature_id integer,
    interaction_type character varying(20),
    interaction_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.feature_interactions OWNER TO postgres;

--
-- Name: feature_interactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feature_interactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feature_interactions_id_seq OWNER TO postgres;

--
-- Name: feature_interactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feature_interactions_id_seq OWNED BY public.feature_interactions.id;


--
-- Name: features; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.features (
    id integer NOT NULL,
    feature_name character varying(100),
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.features OWNER TO postgres;

--
-- Name: features_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.features_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.features_id_seq OWNER TO postgres;

--
-- Name: features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.features_id_seq OWNED BY public.features.id;


--
-- Name: homepage_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.homepage_configs (
    id integer NOT NULL,
    persona_label character varying(20),
    config jsonb,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.homepage_configs OWNER TO postgres;

--
-- Name: homepage_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.homepage_configs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.homepage_configs_id_seq OWNER TO postgres;

--
-- Name: homepage_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.homepage_configs_id_seq OWNED BY public.homepage_configs.id;


--
-- Name: model_monitoring; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_monitoring (
    id integer NOT NULL,
    model_name character varying(50),
    version character varying(20),
    accuracy numeric(5,2),
    status character varying(20),
    last_run timestamp without time zone
);


ALTER TABLE public.model_monitoring OWNER TO postgres;

--
-- Name: model_monitoring_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.model_monitoring_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.model_monitoring_id_seq OWNER TO postgres;

--
-- Name: model_monitoring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.model_monitoring_id_seq OWNED BY public.model_monitoring.id;


--
-- Name: recommendation_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommendation_events (
    id integer NOT NULL,
    user_id integer,
    group_type character varying(50),
    event_type character varying(50),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.recommendation_events OWNER TO postgres;

--
-- Name: recommendation_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recommendation_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recommendation_events_id_seq OWNER TO postgres;

--
-- Name: recommendation_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recommendation_events_id_seq OWNED BY public.recommendation_events.id;


--
-- Name: recommendations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommendations (
    id integer NOT NULL,
    user_id integer,
    config jsonb,
    generated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expired_at timestamp without time zone,
    ml_version character varying(20)
);


ALTER TABLE public.recommendations OWNER TO postgres;

--
-- Name: recommendations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recommendations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recommendations_id_seq OWNER TO postgres;

--
-- Name: recommendations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recommendations_id_seq OWNED BY public.recommendations.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    user_id integer,
    transaction_type character varying(50),
    transaction_category character varying(50),
    amount numeric,
    status character varying(20),
    transaction_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    receiver_id integer
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: user_consents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consents (
    id integer NOT NULL,
    user_id integer,
    consent_given boolean DEFAULT false,
    consent_type character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_consents OWNER TO postgres;

--
-- Name: user_consents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_consents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_consents_id_seq OWNER TO postgres;

--
-- Name: user_consents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_consents_id_seq OWNED BY public.user_consents.id;


--
-- Name: user_segments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_segments (
    id integer NOT NULL,
    user_id integer,
    persona_label character varying(20),
    cluster_label character varying(100),
    confidence double precision,
    source character varying(20),
    assigned_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expired_at timestamp without time zone,
    CONSTRAINT user_segments_persona_label_check CHECK (((persona_label)::text = ANY ((ARRAY['REGULER'::character varying, 'PRIORITAS'::character varying, 'PENGUSAHA'::character varying])::text[])))
);


ALTER TABLE public.user_segments OWNER TO postgres;

--
-- Name: user_segments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_segments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_segments_id_seq OWNER TO postgres;

--
-- Name: user_segments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_segments_id_seq OWNED BY public.user_segments.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100),
    email character varying(100),
    password text,
    account_status character varying(20) DEFAULT 'active'::character varying,
    job_type character varying(50),
    account_type character varying(50),
    balance_band character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone,
    role character varying(20) DEFAULT 'user'::character varying,
    phone character varying(20),
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    balance numeric(15,2) DEFAULT 1000000,
    last_login timestamp without time zone,
    birth_date date
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: ab_testing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_testing ALTER COLUMN id SET DEFAULT nextval('public.ab_testing_id_seq'::regclass);


--
-- Name: admin_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_logs ALTER COLUMN id SET DEFAULT nextval('public.admin_logs_id_seq'::regclass);


--
-- Name: feature_interactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature_interactions ALTER COLUMN id SET DEFAULT nextval('public.feature_interactions_id_seq'::regclass);


--
-- Name: features id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features ALTER COLUMN id SET DEFAULT nextval('public.features_id_seq'::regclass);


--
-- Name: homepage_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_configs ALTER COLUMN id SET DEFAULT nextval('public.homepage_configs_id_seq'::regclass);


--
-- Name: model_monitoring id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_monitoring ALTER COLUMN id SET DEFAULT nextval('public.model_monitoring_id_seq'::regclass);


--
-- Name: recommendation_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendation_events ALTER COLUMN id SET DEFAULT nextval('public.recommendation_events_id_seq'::regclass);


--
-- Name: recommendations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations ALTER COLUMN id SET DEFAULT nextval('public.recommendations_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: user_consents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consents ALTER COLUMN id SET DEFAULT nextval('public.user_consents_id_seq'::regclass);


--
-- Name: user_segments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_segments ALTER COLUMN id SET DEFAULT nextval('public.user_segments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ab_testing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_testing (id, user_id, group_type, assigned_at) FROM stdin;
1	1	A/B_Test_Grup_B_Personalisasi	2026-05-30 18:25:38.190038
2	1	A/B_Test_Grup_B_Personalisasi	2026-05-30 18:28:51.581896
\.


--
-- Data for Name: admin_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_logs (id, admin_id, action, description, created_at) FROM stdin;
1	1	UPDATE_HOMEPAGE	Updated homepage for REGULER users	2026-05-20 12:27:06.38572
2	1	CHANGE_CONSENT	Modified consent settings	2026-05-20 12:27:06.38572
3	1	UPDATE_SEGMENT	Updated user segmentation	2026-05-20 12:27:06.38572
4	9	SYNC_DATABASE	melakukan sync ML model	2026-06-07 18:12:16.340394
\.


--
-- Data for Name: feature_interactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feature_interactions (id, user_id, feature_id, interaction_type, interaction_time) FROM stdin;
1	8	1	click	2026-06-05 14:07:36.231503
2	8	1	click	2026-06-05 14:07:36.231503
3	8	3	click	2026-06-05 14:07:36.231503
4	8	3	click	2026-06-05 14:14:53.155316
5	8	3	click	2026-06-05 14:14:55.217739
6	8	3	click	2026-06-05 14:14:56.550504
7	8	3	click	2026-06-05 14:14:57.918497
8	8	5	click	2026-06-05 14:15:03.544244
9	8	5	click	2026-06-05 14:15:04.812147
10	8	5	click	2026-06-05 14:15:06.149512
11	5	1	click	2026-06-07 20:45:11.780444
12	5	2	click	2026-06-07 20:45:12.774797
13	5	2	click	2026-06-07 20:45:16.363756
14	5	2	click	2026-06-07 20:45:19.332765
15	5	2	click	2026-06-07 20:45:22.598026
16	5	2	click	2026-06-07 20:45:22.614384
17	5	2	click	2026-06-07 20:45:23.803266
18	5	2	click	2026-06-07 20:45:23.917816
19	5	2	click	2026-06-07 20:45:23.919863
20	5	2	click	2026-06-07 20:45:24.918753
21	5	2	click	2026-06-07 20:45:28.067866
22	10	2	click	2026-06-07 21:38:05.664019
23	10	2	click	2026-06-07 21:38:09.201429
24	10	2	click	2026-06-07 21:38:15.170172
25	10	2	click	2026-06-07 21:38:15.247627
26	10	2	click	2026-06-07 21:38:15.666105
27	10	2	click	2026-06-07 21:38:15.709225
28	10	2	click	2026-06-07 21:38:15.929625
29	10	2	click	2026-06-07 21:38:16.147209
30	10	2	click	2026-06-07 21:38:16.384306
31	10	5	click	2026-06-07 21:47:02.938919
32	10	5	click	2026-06-07 21:47:04.778972
33	10	5	click	2026-06-07 21:47:05.712841
34	10	5	click	2026-06-07 21:47:07.528266
35	10	5	click	2026-06-07 21:47:07.767087
36	10	5	click	2026-06-07 21:47:07.839051
37	10	5	click	2026-06-07 21:47:10.363668
38	10	5	click	2026-06-07 21:47:10.714161
39	10	5	click	2026-06-07 21:47:33.006297
40	10	5	click	2026-06-07 21:47:34.113198
41	10	5	click	2026-06-07 21:47:34.473963
42	10	5	click	2026-06-07 21:47:34.835129
43	10	5	click	2026-06-07 21:47:34.904953
44	10	5	click	2026-06-07 21:47:35.144534
45	10	5	click	2026-06-07 21:47:35.146901
46	10	5	click	2026-06-07 21:47:35.274519
47	10	5	click	2026-06-07 21:47:35.412844
48	10	5	click	2026-06-07 21:47:35.528282
49	10	5	click	2026-06-07 21:47:35.674727
50	10	5	click	2026-06-07 21:47:35.821203
51	10	5	click	2026-06-07 21:47:35.991516
52	10	5	click	2026-06-07 21:47:36.150092
53	10	5	click	2026-06-07 21:47:36.328372
54	10	3	click	2026-06-07 21:48:13.190323
55	10	3	click	2026-06-07 21:48:14.198843
56	10	3	click	2026-06-07 21:48:22.685938
57	10	3	click	2026-06-07 21:48:26.401261
58	10	3	click	2026-06-07 21:48:30.900108
59	10	3	click	2026-06-07 21:48:53.183682
60	10	3	click	2026-06-07 21:59:50.131771
61	10	3	click	2026-06-07 21:59:57.993302
62	10	3	click	2026-06-07 21:59:59.780133
63	10	3	click	2026-06-07 22:00:01.745113
64	10	3	click	2026-06-07 22:00:02.827412
65	10	3	click	2026-06-07 22:00:04.991205
66	10	3	click	2026-06-07 22:00:15.234178
67	10	5	click	2026-06-07 22:00:40.658021
68	10	1	click	2026-06-07 22:00:41.510562
69	10	1	click	2026-06-07 22:01:38.931807
\.


--
-- Data for Name: features; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.features (id, feature_name, description, created_at) FROM stdin;
1	transfer	\N	2026-06-05 13:57:36.873146
2	top_up	\N	2026-06-05 13:57:36.873146
3	investasi	\N	2026-06-05 13:57:36.873146
4	pembayaran	\N	2026-06-05 13:57:36.873146
5	payroll	\N	2026-06-05 13:57:36.873146
6	transaksi_tanpa_kartu	\N	2026-06-05 13:57:36.873146
7	kartu_elektronik	\N	2026-06-05 13:57:36.873146
8	jadwal_saya	\N	2026-06-05 13:57:36.873146
9	kode_promo	\N	2026-06-05 13:57:36.873146
\.


--
-- Data for Name: homepage_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.homepage_configs (id, persona_label, config, is_active, created_at) FROM stdin;
1	PENGUSAHA	{"widgets": ["header", "cashflow_widget", "feature_grid"]}	t	2026-05-17 22:12:01.013116
\.


--
-- Data for Name: model_monitoring; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model_monitoring (id, model_name, version, accuracy, status, last_run) FROM stdin;
1	Recommendation Engine	v2.1	88.40	ACTIVE	2026-06-07 18:09:17.877486
2	Personalization AI	v1.8	91.20	ACTIVE	2026-06-07 18:09:17.877486
3	Fraud Detection	v3.0	84.70	INACTIVE	2026-06-07 18:09:17.877486
4	Recommendation Engine	V1.0.1	90.00	TRAINING	2026-06-07 18:16:47.06765
\.


--
-- Data for Name: recommendation_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recommendation_events (id, user_id, group_type, event_type, created_at) FROM stdin;
1	\N	GROUP_A	vie	2026-06-07 04:50:14.906188
2	\N	GROUP_A	click	2026-06-07 04:50:14.906188
3	\N	GROUP_B	view	2026-06-07 04:50:14.906188
4	\N	GROUP_B	click	2026-06-07 04:50:14.906188
5	\N	GROUP_A	VIEW	2026-06-07 04:55:23.572682
6	\N	GROUP_A	CLICK	2026-06-07 04:55:23.572682
7	\N	GROUP_B	VIEW	2026-06-07 04:55:23.572682
8	\N	GROUP_B	CLICK	2026-06-07 04:55:23.572682
17	1	GROUP_A	view	2026-06-01 00:00:00
18	1	GROUP_A	click	2026-06-01 00:00:00
19	3	GROUP_B	view	2026-06-01 00:00:00
20	3	GROUP_B	click	2026-06-01 00:00:00
21	1	GROUP_A	view	2026-06-02 00:00:00
22	1	GROUP_A	click	2026-06-02 00:00:00
23	6	GROUP_B	view	2026-06-02 00:00:00
24	6	GROUP_B	click	2026-06-02 00:00:00
\.


--
-- Data for Name: recommendations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recommendations (id, user_id, config, generated_at, expired_at, ml_version) FROM stdin;
22	8	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 8, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "transfer"}, {"info": "Baru saja diakses", "menu": "investasi"}, {"info": "Rekomendasi untukmu", "menu": "top_up"}, {"info": "Rekomendasi untukmu", "menu": "pembayaran"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "transfer", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "transfer"}, {"menu": "investasi", "rank": 2, "score": 0.7, "reason": "Baru saja diakses", "feature_id": "investasi"}, {"menu": "top_up", "rank": 3, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "top_up"}, {"menu": "pembayaran", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "pembayaran"}]}	2026-06-05 14:08:10.2558	2026-06-05 14:16:15.363393	v1
23	8	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 8, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "investasi"}, {"info": "Baru saja diakses", "menu": "payroll"}, {"info": "Baru saja diakses", "menu": "transfer"}, {"info": "Rekomendasi untukmu", "menu": "top_up"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "investasi", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "investasi"}, {"menu": "payroll", "rank": 2, "score": 0.76, "reason": "Baru saja diakses", "feature_id": "payroll"}, {"menu": "transfer", "rank": 3, "score": 0.64, "reason": "Baru saja diakses", "feature_id": "transfer"}, {"menu": "top_up", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "top_up"}]}	2026-06-05 14:16:15.39752	2026-06-06 14:16:15.39752	v1
24	8	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 8, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "investasi"}, {"info": "Baru saja diakses", "menu": "payroll"}, {"info": "Baru saja diakses", "menu": "transfer"}, {"info": "Rekomendasi untukmu", "menu": "top_up"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "investasi", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "investasi"}, {"menu": "payroll", "rank": 2, "score": 0.76, "reason": "Baru saja diakses", "feature_id": "payroll"}, {"menu": "transfer", "rank": 3, "score": 0.64, "reason": "Baru saja diakses", "feature_id": "transfer"}, {"menu": "top_up", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "top_up"}]}	2026-06-06 16:49:06.537646	2026-06-07 16:49:06.537646	v1
26	10	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 10, "dynamic_nav": [{"info": "Urutan standar persona", "menu": "transfer"}, {"info": "Urutan standar persona", "menu": "top_up"}, {"info": "Urutan standar persona", "menu": "kode_promo"}, {"info": "Urutan standar persona", "menu": "transaksi_tanpa_kartu"}], "explanation": {"beta": null, "alpha": null, "method": "Fallback by persona", "summary": "Homepage menggunakan urutan standar persona karena user belum memberi consent atau belum memiliki cukup interaksi."}, "ab_test_group": "A/B_Test_Grup_A_Statis", "recommendations": [{"menu": "transfer", "rank": 1, "score": null, "reason": "Urutan standar persona", "feature_id": "transfer"}, {"menu": "top_up", "rank": 2, "score": null, "reason": "Urutan standar persona", "feature_id": "top_up"}, {"menu": "kode_promo", "rank": 3, "score": null, "reason": "Urutan standar persona", "feature_id": "kode_promo"}, {"menu": "transaksi_tanpa_kartu", "rank": 4, "score": null, "reason": "Urutan standar persona", "feature_id": "transaksi_tanpa_kartu"}]}	2026-06-07 21:37:44.774644	2026-06-07 21:38:22.418673	v1
27	10	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 10, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "top_up"}, {"info": "Rekomendasi untukmu", "menu": "transfer"}, {"info": "Rekomendasi untukmu", "menu": "investasi"}, {"info": "Rekomendasi untukmu", "menu": "pembayaran"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "top_up", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "top_up"}, {"menu": "transfer", "rank": 2, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "transfer"}, {"menu": "investasi", "rank": 3, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "investasi"}, {"menu": "pembayaran", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "pembayaran"}]}	2026-06-07 21:38:22.424966	2026-06-07 21:47:29.193068	v1
25	5	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 5, "dynamic_nav": [{"info": "Urutan standar persona", "menu": "transfer"}, {"info": "Urutan standar persona", "menu": "top_up"}, {"info": "Urutan standar persona", "menu": "kode_promo"}, {"info": "Urutan standar persona", "menu": "transaksi_tanpa_kartu"}], "explanation": {"beta": null, "alpha": null, "method": "Fallback by persona", "summary": "Homepage menggunakan urutan standar persona karena user belum memberi consent atau belum memiliki cukup interaksi."}, "ab_test_group": "A/B_Test_Grup_A_Statis", "recommendations": [{"menu": "transfer", "rank": 1, "score": null, "reason": "Urutan standar persona", "feature_id": "transfer"}, {"menu": "top_up", "rank": 2, "score": null, "reason": "Urutan standar persona", "feature_id": "top_up"}, {"menu": "kode_promo", "rank": 3, "score": null, "reason": "Urutan standar persona", "feature_id": "kode_promo"}, {"menu": "transaksi_tanpa_kartu", "rank": 4, "score": null, "reason": "Urutan standar persona", "feature_id": "transaksi_tanpa_kartu"}]}	2026-06-07 20:45:01.423377	2026-06-07 21:54:44.088483	v1
28	10	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 10, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "top_up"}, {"info": "Sering digunakan dan baru saja diakses", "menu": "payroll"}, {"info": "Rekomendasi untukmu", "menu": "transfer"}, {"info": "Rekomendasi untukmu", "menu": "investasi"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "top_up", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "top_up"}, {"menu": "payroll", "rank": 2, "score": 0.9333, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "payroll"}, {"menu": "transfer", "rank": 3, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "transfer"}, {"menu": "investasi", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "investasi"}]}	2026-06-07 21:47:29.198955	2026-06-07 21:47:50.68931	v1
29	10	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 10, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "payroll"}, {"info": "Baru saja diakses", "menu": "top_up"}, {"info": "Rekomendasi untukmu", "menu": "transfer"}, {"info": "Rekomendasi untukmu", "menu": "investasi"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "payroll", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "payroll"}, {"menu": "top_up", "rank": 2, "score": 0.6348, "reason": "Baru saja diakses", "feature_id": "top_up"}, {"menu": "transfer", "rank": 3, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "transfer"}, {"menu": "investasi", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "investasi"}]}	2026-06-07 21:47:50.694285	2026-06-07 21:48:49.274366	v1
30	10	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 10, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "payroll"}, {"info": "Baru saja diakses", "menu": "top_up"}, {"info": "Baru saja diakses", "menu": "investasi"}, {"info": "Rekomendasi untukmu", "menu": "transfer"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "payroll", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "payroll"}, {"menu": "top_up", "rank": 2, "score": 0.6348, "reason": "Baru saja diakses", "feature_id": "top_up"}, {"menu": "investasi", "rank": 3, "score": 0.5304, "reason": "Baru saja diakses", "feature_id": "investasi"}, {"menu": "transfer", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "transfer"}]}	2026-06-07 21:48:49.282688	2026-06-07 21:51:20.87633	v1
32	5	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 5, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "top_up"}, {"info": "Baru saja diakses", "menu": "transfer"}, {"info": "Rekomendasi untukmu", "menu": "investasi"}, {"info": "Rekomendasi untukmu", "menu": "pembayaran"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "top_up", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "top_up"}, {"menu": "transfer", "rank": 2, "score": 0.46, "reason": "Baru saja diakses", "feature_id": "transfer"}, {"menu": "investasi", "rank": 3, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "investasi"}, {"menu": "pembayaran", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "pembayaran"}]}	2026-06-07 21:54:44.134407	2026-06-08 21:54:44.134407	v1
31	10	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 10, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "payroll"}, {"info": "Baru saja diakses", "menu": "top_up"}, {"info": "Baru saja diakses", "menu": "investasi"}, {"info": "Rekomendasi untukmu", "menu": "transfer"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "payroll", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "payroll"}, {"menu": "top_up", "rank": 2, "score": 0.6348, "reason": "Baru saja diakses", "feature_id": "top_up"}, {"menu": "investasi", "rank": 3, "score": 0.5565, "reason": "Baru saja diakses", "feature_id": "investasi"}, {"menu": "transfer", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "transfer"}]}	2026-06-07 21:51:20.900456	2026-06-07 22:00:33.893706	v1
33	10	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 10, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "payroll"}, {"info": "Baru saja diakses", "menu": "investasi"}, {"info": "Baru saja diakses", "menu": "top_up"}, {"info": "Rekomendasi untukmu", "menu": "transfer"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "payroll", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "payroll"}, {"menu": "investasi", "rank": 2, "score": 0.7391, "reason": "Baru saja diakses", "feature_id": "investasi"}, {"menu": "top_up", "rank": 3, "score": 0.6348, "reason": "Baru saja diakses", "feature_id": "top_up"}, {"menu": "transfer", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "transfer"}]}	2026-06-07 22:00:34.223812	2026-06-07 22:01:17.957194	v1
34	10	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 10, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "payroll"}, {"info": "Baru saja diakses", "menu": "investasi"}, {"info": "Baru saja diakses", "menu": "top_up"}, {"info": "Baru saja diakses", "menu": "transfer"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "payroll", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "payroll"}, {"menu": "investasi", "rank": 2, "score": 0.725, "reason": "Baru saja diakses", "feature_id": "investasi"}, {"menu": "top_up", "rank": 3, "score": 0.625, "reason": "Baru saja diakses", "feature_id": "top_up"}, {"menu": "transfer", "rank": 4, "score": 0.425, "reason": "Baru saja diakses", "feature_id": "transfer"}]}	2026-06-07 22:01:18.182623	2026-06-07 22:02:28.495161	v1
35	10	{"cluster": 2, "persona": "PRIORITAS", "success": true, "user_id": 10, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "payroll"}, {"info": "Baru saja diakses", "menu": "investasi"}, {"info": "Baru saja diakses", "menu": "top_up"}, {"info": "Baru saja diakses", "menu": "transfer"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "payroll", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "payroll"}, {"menu": "investasi", "rank": 2, "score": 0.725, "reason": "Baru saja diakses", "feature_id": "investasi"}, {"menu": "top_up", "rank": 3, "score": 0.625, "reason": "Baru saja diakses", "feature_id": "top_up"}, {"menu": "transfer", "rank": 4, "score": 0.45, "reason": "Baru saja diakses", "feature_id": "transfer"}]}	2026-06-07 22:02:28.499923	2026-06-08 22:02:28.499923	v1
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, user_id, transaction_type, transaction_category, amount, status, transaction_time, receiver_id) FROM stdin;
1	5	TRANSFER	BUSINESS	500000	SUCCESS	2026-05-17 18:54:37.333271	\N
2	5	transfer	transfer	100000	success	2026-05-31 21:53:48.660581	8
3	5	transfer	transfer	50000	success	2026-06-03 21:53:13.327193	8
4	10	transfer	transfer	67000000	success	2026-06-07 22:01:07.979966	5
5	10	transfer	transfer	300000000	success	2026-06-07 22:02:04.643038	3
\.


--
-- Data for Name: user_consents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consents (id, user_id, consent_given, consent_type, created_at, updated_at) FROM stdin;
1	5	t	PERSONALIZATION	2026-05-18 01:03:07.73996	2026-06-03 07:08:39.821847
2	8	t	PERSONALIZATION	2026-06-03 22:09:12.54879	2026-06-03 22:09:12.54879
3	10	t	data_sharing	2026-06-07 21:37:55.167111	2026-06-07 21:37:55.167111
\.


--
-- Data for Name: user_segments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_segments (id, user_id, persona_label, cluster_label, confidence, source, assigned_at, expired_at) FROM stdin;
2	\N	\N	\N	\N	\N	2026-05-17 20:04:24.8148	\N
1	1	PRIORITAS	TRANSFER_HEAVY	0.91	ml_engine	2026-05-17 21:57:50.673169	2026-07-01 00:00:00
3	1	PRIORITAS	TRANSFER_HEAVY	0.91	MANUAL	2026-05-17 21:57:50.673169	2026-07-01 00:00:00
4	1	REGULER	1	\N	ML_SERVICE	2026-05-30 18:13:38.68325	\N
6	1	REGULER	1	\N	ML_SERVICE	2026-05-30 18:28:51.393951	\N
5	1	PENGUSAHA	1	\N	ML_SERVICE	2026-05-30 18:25:37.964444	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, account_status, job_type, account_type, balance_band, created_at, update_at, role, phone, updated_at, balance, last_login, birth_date) FROM stdin;
1	Didi	didi@mail.com	123456	active	\N	\N	\N	2026-04-27 18:08:28.932259	\N	admin	\N	2026-05-17 18:02:23.070105	1000000.00	\N	\N
7	admin	admin@bank.com	$2b$10$WeN9MQ9WHNlAoET8/dWx9O5r0R8j3VzyUv83i4v8306hZ3fh5uOB6	active	\N	\N	\N	2026-05-19 18:02:48.304468	\N	admin	\N	2026-05-19 18:02:48.304468	1000000.00	\N	\N
9	admin	admin@octo.com	$2b$10$KNEz/Wk7c6FThR6Kshf7Oeh14bHTHBT2tjvgp6lGadydP/DEWu0da	active	\N	\N	\N	2026-06-06 21:18:15.026289	\N	admin	\N	2026-06-06 21:18:15.026289	1000000.00	\N	\N
6	Haerin	haerin@admin.com	$2b$10$cCOzJwxjSS7Jo.bQcEZvi.ycCtGJwoxJfUO0Y7FzriiiZlZjdphqu	active	\N	\N	\N	2026-05-19 18:00:16.112884	\N	user	\N	2026-05-19 18:00:16.112884	1000000.00	\N	2006-01-01
8	Minji Kim	minji@mail.com	$2b$10$/Icx07BH5.R8LmyLk.XieOcw0X8YHJaUF/OieX4k83CscCi/4gocK	active	\N	\N	\N	2026-05-31 19:55:56.167302	\N	user	\N	2026-05-31 19:55:56.167302	1150000.00	\N	1998-11-12
5	Hanni (Updated)	Hanni@mail.com	$2b$10$Mr1MeaCuSoNWjk6CDVDWrOiBdcnkoGGDbhFhsHJYpxtkwnFkkey92	active	\N	\N	\N	2026-05-06 19:10:38.640113	\N	user	08123456789	2026-05-17 18:02:51.888238	71850000.00	\N	2004-08-11
10	Ayudya Nandira Afifah	ayudya@mail.com	$2b$10$9NWDQ2tYSTtWG1rKM2ZWVuWqVs6oy5jWUt1W13C.deX5g68fxbc0q	active	\N	\N	\N	2026-06-07 21:37:30.144136	\N	user	\N	2026-06-07 21:37:30.144136	633000000.00	\N	\N
3	Minji	Minji@mail.com	$2b$10$ngYQJtpDizc97aJY/KujuO74XnooNvG9ptvOFD2gqydGp0nWFDgw2	active	\N	\N	\N	2026-05-06 19:01:43.359491	\N	user	\N	2026-05-17 18:02:23.070105	301000000.00	\N	2004-05-07
\.


--
-- Name: ab_testing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_testing_id_seq', 2, true);


--
-- Name: admin_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_logs_id_seq', 4, true);


--
-- Name: feature_interactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feature_interactions_id_seq', 69, true);


--
-- Name: features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.features_id_seq', 9, true);


--
-- Name: homepage_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.homepage_configs_id_seq', 1, true);


--
-- Name: model_monitoring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.model_monitoring_id_seq', 4, true);


--
-- Name: recommendation_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recommendation_events_id_seq', 24, true);


--
-- Name: recommendations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recommendations_id_seq', 35, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 5, true);


--
-- Name: user_consents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_consents_id_seq', 3, true);


--
-- Name: user_segments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_segments_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- Name: ab_testing ab_testing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_testing
    ADD CONSTRAINT ab_testing_pkey PRIMARY KEY (id);


--
-- Name: admin_logs admin_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_logs
    ADD CONSTRAINT admin_logs_pkey PRIMARY KEY (id);


--
-- Name: feature_interactions feature_interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature_interactions
    ADD CONSTRAINT feature_interactions_pkey PRIMARY KEY (id);


--
-- Name: features features_feature_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_feature_name_key UNIQUE (feature_name);


--
-- Name: features features_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_pkey PRIMARY KEY (id);


--
-- Name: homepage_configs homepage_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_configs
    ADD CONSTRAINT homepage_configs_pkey PRIMARY KEY (id);


--
-- Name: model_monitoring model_monitoring_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_monitoring
    ADD CONSTRAINT model_monitoring_pkey PRIMARY KEY (id);


--
-- Name: recommendation_events recommendation_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendation_events
    ADD CONSTRAINT recommendation_events_pkey PRIMARY KEY (id);


--
-- Name: recommendations recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: user_consents user_consents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consents
    ADD CONSTRAINT user_consents_pkey PRIMARY KEY (id);


--
-- Name: user_segments user_segments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_segments
    ADD CONSTRAINT user_segments_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_feature_interactions_feature_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_feature_interactions_feature_id ON public.feature_interactions USING btree (feature_id);


--
-- Name: idx_feature_interactions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_feature_interactions_user_id ON public.feature_interactions USING btree (user_id);


--
-- Name: idx_interactions_user_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_interactions_user_time ON public.feature_interactions USING btree (user_id, interaction_time DESC);


--
-- Name: idx_recommendations_user_generated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recommendations_user_generated ON public.recommendations USING btree (user_id, generated_at DESC);


--
-- Name: idx_recommendations_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recommendations_user_id ON public.recommendations USING btree (user_id);


--
-- Name: idx_transactions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transactions_user_id ON public.transactions USING btree (user_id);


--
-- Name: idx_user_segments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_segments_user_id ON public.user_segments USING btree (user_id);


--
-- Name: ab_testing ab_testing_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_testing
    ADD CONSTRAINT ab_testing_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: admin_logs admin_logs_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_logs
    ADD CONSTRAINT admin_logs_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.users(id);


--
-- Name: feature_interactions feature_interactions_feature_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature_interactions
    ADD CONSTRAINT feature_interactions_feature_id_fkey FOREIGN KEY (feature_id) REFERENCES public.features(id) ON DELETE CASCADE;


--
-- Name: feature_interactions feature_interactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature_interactions
    ADD CONSTRAINT feature_interactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: transactions fk_receiver; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_receiver FOREIGN KEY (receiver_id) REFERENCES public.users(id);


--
-- Name: recommendation_events recommendation_events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendation_events
    ADD CONSTRAINT recommendation_events_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: recommendations recommendations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_consents user_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consents
    ADD CONSTRAINT user_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_segments user_segments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_segments
    ADD CONSTRAINT user_segments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict KlTysNTjQWjKgPqGF8h9Txt17EXPcipxs9jQnqYMrziAHGtgR1pLTgo32bXE6Yf

