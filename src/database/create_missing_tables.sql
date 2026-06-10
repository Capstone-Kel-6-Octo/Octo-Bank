-- Skrip SQL untuk memperbaiki tabel yang kurang dan melengkapi data fitur di PostgreSQL
-- Silakan jalankan skrip ini pada pgAdmin atau psql terminal database Anda.

-- 1. Buat Tabel user_consents (Consent Hukum Privasi AI)
CREATE TABLE IF NOT EXISTS public.user_consents (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    consent_given BOOLEAN DEFAULT TRUE,
    consent_type VARCHAR(50) DEFAULT 'data_sharing',
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Buat Tabel admin_logs (Audit Trails Log Admin)
CREATE TABLE IF NOT EXISTS public.admin_logs (
    id SERIAL PRIMARY KEY,
    admin_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    action VARCHAR(50) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Buat Tabel model_monitoring (Monitoring Model AI/ML)
CREATE TABLE IF NOT EXISTS public.model_monitoring (
    id SERIAL PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    version VARCHAR(50) NOT NULL,
    accuracy NUMERIC(5,2),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    last_run TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. Masukkan Fitur-Fitur Statis Favorit ke Tabel features
-- Mencegah error Foreign Key pada tabel feature_interactions saat mengeklik menu statis di Flutter
INSERT INTO public.features (id, feature_name) VALUES
    (95, 'adjust_favorite'),
    (96, 'kode_promo'),
    (97, 'jadwal_saya'),
    (98, 'kartu_elektronik'),
    (99, 'transaksi_tanpa_kartu')
ON CONFLICT (id) DO NOTHING;

-- 5. Tambah Kolom balance, role, phone, dan updated_at ke Tabel users (Untuk sinkronisasi data & beranda)
ALTER TABLE public.users ADD COLUMN IF NOT EXISTS balance NUMERIC DEFAULT 1500000;
ALTER TABLE public.users ADD COLUMN IF NOT EXISTS role VARCHAR(20) DEFAULT 'user';
ALTER TABLE public.users ADD COLUMN IF NOT EXISTS phone VARCHAR(20);
ALTER TABLE public.users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP;

-- 6. Tambah Kolom receiver_id ke Tabel transactions (Untuk relasi transaksi transfer)
ALTER TABLE public.transactions ADD COLUMN IF NOT EXISTS receiver_id INTEGER REFERENCES public.users(id);
