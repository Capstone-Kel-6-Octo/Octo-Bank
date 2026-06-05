--
-- PostgreSQL database dump
--

\restrict DlIM9LMQadUbJZp2ALUScDdjO6ZdNrbAIJOp8OlPDocdOhyCtnAaD1LkB6zMC6x

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-06-05 14:47:34

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
-- TOC entry 236 (class 1259 OID 32899)
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
-- TOC entry 235 (class 1259 OID 32898)
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
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 235
-- Name: ab_testing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ab_testing_id_seq OWNED BY public.ab_testing.id;


--
-- TOC entry 238 (class 1259 OID 32913)
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
-- TOC entry 237 (class 1259 OID 32912)
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
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 237
-- Name: admin_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_logs_id_seq OWNED BY public.admin_logs.id;


--
-- TOC entry 226 (class 1259 OID 32809)
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
-- TOC entry 225 (class 1259 OID 32808)
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
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 225
-- Name: feature_interactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feature_interactions_id_seq OWNED BY public.feature_interactions.id;


--
-- TOC entry 222 (class 1259 OID 32784)
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
-- TOC entry 221 (class 1259 OID 32783)
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
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 221
-- Name: features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.features_id_seq OWNED BY public.features.id;


--
-- TOC entry 232 (class 1259 OID 32860)
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
-- TOC entry 231 (class 1259 OID 32859)
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
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 231
-- Name: homepage_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.homepage_configs_id_seq OWNED BY public.homepage_configs.id;


--
-- TOC entry 240 (class 1259 OID 32929)
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
-- TOC entry 239 (class 1259 OID 32928)
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
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 239
-- Name: model_monitoring_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.model_monitoring_id_seq OWNED BY public.model_monitoring.id;


--
-- TOC entry 230 (class 1259 OID 32844)
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
-- TOC entry 229 (class 1259 OID 32843)
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
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 229
-- Name: recommendations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recommendations_id_seq OWNED BY public.recommendations.id;


--
-- TOC entry 228 (class 1259 OID 32828)
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
-- TOC entry 227 (class 1259 OID 32827)
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
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 227
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- TOC entry 234 (class 1259 OID 32883)
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
-- TOC entry 233 (class 1259 OID 32882)
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
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 233
-- Name: user_consents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_consents_id_seq OWNED BY public.user_consents.id;


--
-- TOC entry 224 (class 1259 OID 32794)
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
-- TOC entry 223 (class 1259 OID 32793)
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
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 223
-- Name: user_segments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_segments_id_seq OWNED BY public.user_segments.id;


--
-- TOC entry 220 (class 1259 OID 32770)
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
    balance numeric(15,2) DEFAULT 1000000
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 32769)
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
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4828 (class 2604 OID 32902)
-- Name: ab_testing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_testing ALTER COLUMN id SET DEFAULT nextval('public.ab_testing_id_seq'::regclass);


--
-- TOC entry 4830 (class 2604 OID 32916)
-- Name: admin_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_logs ALTER COLUMN id SET DEFAULT nextval('public.admin_logs_id_seq'::regclass);


--
-- TOC entry 4815 (class 2604 OID 32812)
-- Name: feature_interactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature_interactions ALTER COLUMN id SET DEFAULT nextval('public.feature_interactions_id_seq'::regclass);


--
-- TOC entry 4811 (class 2604 OID 32787)
-- Name: features id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features ALTER COLUMN id SET DEFAULT nextval('public.features_id_seq'::regclass);


--
-- TOC entry 4821 (class 2604 OID 32863)
-- Name: homepage_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_configs ALTER COLUMN id SET DEFAULT nextval('public.homepage_configs_id_seq'::regclass);


--
-- TOC entry 4832 (class 2604 OID 32932)
-- Name: model_monitoring id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_monitoring ALTER COLUMN id SET DEFAULT nextval('public.model_monitoring_id_seq'::regclass);


--
-- TOC entry 4819 (class 2604 OID 32847)
-- Name: recommendations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations ALTER COLUMN id SET DEFAULT nextval('public.recommendations_id_seq'::regclass);


--
-- TOC entry 4817 (class 2604 OID 32831)
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- TOC entry 4824 (class 2604 OID 32886)
-- Name: user_consents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consents ALTER COLUMN id SET DEFAULT nextval('public.user_consents_id_seq'::regclass);


--
-- TOC entry 4813 (class 2604 OID 32797)
-- Name: user_segments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_segments ALTER COLUMN id SET DEFAULT nextval('public.user_segments_id_seq'::regclass);


--
-- TOC entry 4805 (class 2604 OID 32773)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5040 (class 0 OID 32899)
-- Dependencies: 236
-- Data for Name: ab_testing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ab_testing (id, user_id, group_type, assigned_at) FROM stdin;
1	1	A/B_Test_Grup_B_Personalisasi	2026-05-30 18:25:38.190038
2	1	A/B_Test_Grup_B_Personalisasi	2026-05-30 18:28:51.581896
\.


--
-- TOC entry 5042 (class 0 OID 32913)
-- Dependencies: 238
-- Data for Name: admin_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_logs (id, admin_id, action, description, created_at) FROM stdin;
1	1	UPDATE_HOMEPAGE	Updated homepage for REGULER users	2026-05-20 12:27:06.38572
2	1	CHANGE_CONSENT	Modified consent settings	2026-05-20 12:27:06.38572
3	1	UPDATE_SEGMENT	Updated user segmentation	2026-05-20 12:27:06.38572
\.


--
-- TOC entry 5030 (class 0 OID 32809)
-- Dependencies: 226
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
\.


--
-- TOC entry 5026 (class 0 OID 32784)
-- Dependencies: 222
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
-- TOC entry 5036 (class 0 OID 32860)
-- Dependencies: 232
-- Data for Name: homepage_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.homepage_configs (id, persona_label, config, is_active, created_at) FROM stdin;
1	PENGUSAHA	{"widgets": ["header", "cashflow_widget", "feature_grid"]}	t	2026-05-17 22:12:01.013116
\.


--
-- TOC entry 5044 (class 0 OID 32929)
-- Dependencies: 240
-- Data for Name: model_monitoring; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model_monitoring (id, model_name, version, accuracy, status, last_run) FROM stdin;
\.


--
-- TOC entry 5034 (class 0 OID 32844)
-- Dependencies: 230
-- Data for Name: recommendations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recommendations (id, user_id, config, generated_at, expired_at, ml_version) FROM stdin;
22	8	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 8, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "transfer"}, {"info": "Baru saja diakses", "menu": "investasi"}, {"info": "Rekomendasi untukmu", "menu": "top_up"}, {"info": "Rekomendasi untukmu", "menu": "pembayaran"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "transfer", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "transfer"}, {"menu": "investasi", "rank": 2, "score": 0.7, "reason": "Baru saja diakses", "feature_id": "investasi"}, {"menu": "top_up", "rank": 3, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "top_up"}, {"menu": "pembayaran", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "pembayaran"}]}	2026-06-05 14:08:10.2558	2026-06-05 14:16:15.363393	v1
23	8	{"cluster": 1, "persona": "REGULER", "success": true, "user_id": 8, "dynamic_nav": [{"info": "Sering digunakan dan baru saja diakses", "menu": "investasi"}, {"info": "Baru saja diakses", "menu": "payroll"}, {"info": "Baru saja diakses", "menu": "transfer"}, {"info": "Rekomendasi untukmu", "menu": "top_up"}], "explanation": {"beta": 0.4, "alpha": 0.6, "method": "KMeans clustering + Frequency Recency Ranking", "summary": "Homepage dipersonalisasi berdasarkan frekuensi penggunaan fitur dan waktu akses terakhir."}, "ab_test_group": "A/B_Test_Grup_B_Personalisasi", "recommendations": [{"menu": "investasi", "rank": 1, "score": 1, "reason": "Sering digunakan dan baru saja diakses", "feature_id": "investasi"}, {"menu": "payroll", "rank": 2, "score": 0.76, "reason": "Baru saja diakses", "feature_id": "payroll"}, {"menu": "transfer", "rank": 3, "score": 0.64, "reason": "Baru saja diakses", "feature_id": "transfer"}, {"menu": "top_up", "rank": 4, "score": 0, "reason": "Rekomendasi untukmu", "feature_id": "top_up"}]}	2026-06-05 14:16:15.39752	2026-06-06 14:16:15.39752	v1
\.


--
-- TOC entry 5032 (class 0 OID 32828)
-- Dependencies: 228
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, user_id, transaction_type, transaction_category, amount, status, transaction_time, receiver_id) FROM stdin;
1	5	TRANSFER	BUSINESS	500000	SUCCESS	2026-05-17 18:54:37.333271	\N
2	5	transfer	transfer	100000	success	2026-05-31 21:53:48.660581	8
3	5	transfer	transfer	50000	success	2026-06-03 21:53:13.327193	8
\.


--
-- TOC entry 5038 (class 0 OID 32883)
-- Dependencies: 234
-- Data for Name: user_consents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consents (id, user_id, consent_given, consent_type, created_at, updated_at) FROM stdin;
1	5	t	PERSONALIZATION	2026-05-18 01:03:07.73996	2026-06-03 07:08:39.821847
2	8	t	PERSONALIZATION	2026-06-03 22:09:12.54879	2026-06-03 22:09:12.54879
\.


--
-- TOC entry 5028 (class 0 OID 32794)
-- Dependencies: 224
-- Data for Name: user_segments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_segments (id, user_id, persona_label, cluster_label, confidence, source, assigned_at, expired_at) FROM stdin;
2	\N	\N	\N	\N	\N	2026-05-17 20:04:24.8148	\N
1	1	PRIORITAS	TRANSFER_HEAVY	0.91	ml_engine	2026-05-17 21:57:50.673169	2026-07-01 00:00:00
3	1	PRIORITAS	TRANSFER_HEAVY	0.91	MANUAL	2026-05-17 21:57:50.673169	2026-07-01 00:00:00
4	1	REGULER	1	\N	ML_SERVICE	2026-05-30 18:13:38.68325	\N
5	1	REGULER	1	\N	ML_SERVICE	2026-05-30 18:25:37.964444	\N
6	1	REGULER	1	\N	ML_SERVICE	2026-05-30 18:28:51.393951	\N
\.


--
-- TOC entry 5024 (class 0 OID 32770)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, account_status, job_type, account_type, balance_band, created_at, update_at, role, phone, updated_at, balance) FROM stdin;
3	Minji	Minji@mail.com	$2b$10$ngYQJtpDizc97aJY/KujuO74XnooNvG9ptvOFD2gqydGp0nWFDgw2	active	\N	\N	\N	2026-05-06 19:01:43.359491	\N	user	\N	2026-05-17 18:02:23.070105	1000000.00
6	Haerin	haerin@admin.com	$2b$10$cCOzJwxjSS7Jo.bQcEZvi.ycCtGJwoxJfUO0Y7FzriiiZlZjdphqu	active	\N	\N	\N	2026-05-19 18:00:16.112884	\N	user	\N	2026-05-19 18:00:16.112884	1000000.00
1	Didi	didi@mail.com	123456	active	\N	\N	\N	2026-04-27 18:08:28.932259	\N	admin	\N	2026-05-17 18:02:23.070105	1000000.00
7	admin	admin@bank.com	$2b$10$WeN9MQ9WHNlAoET8/dWx9O5r0R8j3VzyUv83i4v8306hZ3fh5uOB6	active	\N	\N	\N	2026-05-19 18:02:48.304468	\N	admin	\N	2026-05-19 18:02:48.304468	1000000.00
5	Hanni (Updated)	Hanni@mail.com	$2b$10$Mr1MeaCuSoNWjk6CDVDWrOiBdcnkoGGDbhFhsHJYpxtkwnFkkey92	active	\N	\N	\N	2026-05-06 19:10:38.640113	\N	user	08123456789	2026-05-17 18:02:51.888238	4850000.00
8	Minji Kim	minji@mail.com	$2b$10$/Icx07BH5.R8LmyLk.XieOcw0X8YHJaUF/OieX4k83CscCi/4gocK	active	\N	\N	\N	2026-05-31 19:55:56.167302	\N	user	\N	2026-05-31 19:55:56.167302	1150000.00
\.


--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 235
-- Name: ab_testing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ab_testing_id_seq', 2, true);


--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 237
-- Name: admin_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_logs_id_seq', 3, true);


--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 225
-- Name: feature_interactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feature_interactions_id_seq', 10, true);


--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 221
-- Name: features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.features_id_seq', 9, true);


--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 231
-- Name: homepage_configs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.homepage_configs_id_seq', 1, true);


--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 239
-- Name: model_monitoring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.model_monitoring_id_seq', 1, false);


--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 229
-- Name: recommendations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recommendations_id_seq', 23, true);


--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 227
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 3, true);


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 233
-- Name: user_consents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_consents_id_seq', 2, true);


--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 223
-- Name: user_segments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_segments_id_seq', 6, true);


--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 8, true);


--
-- TOC entry 4862 (class 2606 OID 32906)
-- Name: ab_testing ab_testing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_testing
    ADD CONSTRAINT ab_testing_pkey PRIMARY KEY (id);


--
-- TOC entry 4864 (class 2606 OID 32922)
-- Name: admin_logs admin_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_logs
    ADD CONSTRAINT admin_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4846 (class 2606 OID 32816)
-- Name: feature_interactions feature_interactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature_interactions
    ADD CONSTRAINT feature_interactions_pkey PRIMARY KEY (id);


--
-- TOC entry 4839 (class 2606 OID 32792)
-- Name: features features_feature_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_feature_name_key UNIQUE (feature_name);


--
-- TOC entry 4841 (class 2606 OID 32790)
-- Name: features features_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.features
    ADD CONSTRAINT features_pkey PRIMARY KEY (id);


--
-- TOC entry 4858 (class 2606 OID 32870)
-- Name: homepage_configs homepage_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepage_configs
    ADD CONSTRAINT homepage_configs_pkey PRIMARY KEY (id);


--
-- TOC entry 4866 (class 2606 OID 32935)
-- Name: model_monitoring model_monitoring_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_monitoring
    ADD CONSTRAINT model_monitoring_pkey PRIMARY KEY (id);


--
-- TOC entry 4856 (class 2606 OID 32853)
-- Name: recommendations recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);


--
-- TOC entry 4852 (class 2606 OID 32837)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 4860 (class 2606 OID 32892)
-- Name: user_consents user_consents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consents
    ADD CONSTRAINT user_consents_pkey PRIMARY KEY (id);


--
-- TOC entry 4844 (class 2606 OID 32802)
-- Name: user_segments user_segments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_segments
    ADD CONSTRAINT user_segments_pkey PRIMARY KEY (id);


--
-- TOC entry 4835 (class 2606 OID 32782)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4837 (class 2606 OID 32780)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4847 (class 1259 OID 32873)
-- Name: idx_feature_interactions_feature_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_feature_interactions_feature_id ON public.feature_interactions USING btree (feature_id);


--
-- TOC entry 4848 (class 1259 OID 32872)
-- Name: idx_feature_interactions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_feature_interactions_user_id ON public.feature_interactions USING btree (user_id);


--
-- TOC entry 4849 (class 1259 OID 41135)
-- Name: idx_interactions_user_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_interactions_user_time ON public.feature_interactions USING btree (user_id, interaction_time DESC);


--
-- TOC entry 4853 (class 1259 OID 41134)
-- Name: idx_recommendations_user_generated; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recommendations_user_generated ON public.recommendations USING btree (user_id, generated_at DESC);


--
-- TOC entry 4854 (class 1259 OID 32875)
-- Name: idx_recommendations_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_recommendations_user_id ON public.recommendations USING btree (user_id);


--
-- TOC entry 4850 (class 1259 OID 32874)
-- Name: idx_transactions_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_transactions_user_id ON public.transactions USING btree (user_id);


--
-- TOC entry 4842 (class 1259 OID 32871)
-- Name: idx_user_segments_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_segments_user_id ON public.user_segments USING btree (user_id);


--
-- TOC entry 4874 (class 2606 OID 32907)
-- Name: ab_testing ab_testing_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ab_testing
    ADD CONSTRAINT ab_testing_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4875 (class 2606 OID 32923)
-- Name: admin_logs admin_logs_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_logs
    ADD CONSTRAINT admin_logs_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.users(id);


--
-- TOC entry 4868 (class 2606 OID 32822)
-- Name: feature_interactions feature_interactions_feature_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature_interactions
    ADD CONSTRAINT feature_interactions_feature_id_fkey FOREIGN KEY (feature_id) REFERENCES public.features(id) ON DELETE CASCADE;


--
-- TOC entry 4869 (class 2606 OID 32817)
-- Name: feature_interactions feature_interactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feature_interactions
    ADD CONSTRAINT feature_interactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4870 (class 2606 OID 41129)
-- Name: transactions fk_receiver; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_receiver FOREIGN KEY (receiver_id) REFERENCES public.users(id);


--
-- TOC entry 4872 (class 2606 OID 32854)
-- Name: recommendations recommendations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4871 (class 2606 OID 32838)
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4873 (class 2606 OID 32893)
-- Name: user_consents user_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consents
    ADD CONSTRAINT user_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4867 (class 2606 OID 32803)
-- Name: user_segments user_segments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_segments
    ADD CONSTRAINT user_segments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2026-06-05 14:47:35

--
-- PostgreSQL database dump complete
--

\unrestrict DlIM9LMQadUbJZp2ALUScDdjO6ZdNrbAIJOp8OlPDocdOhyCtnAaD1LkB6zMC6x

