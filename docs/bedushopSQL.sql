-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public."Orders"
(
    id integer NOT NULL,
    user_id integer NOT NULL,
    order_status character varying(26) NOT NULL,
    order_date date NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."Categories"
(
    id integer,
    category character varying(25),
    imagecategory_url0 character varying(255),
    CONSTRAINT "id " PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."Users"
(
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    username character varying(50),
    email character varying(50) NOT NULL,
    gender character varying(50),
    street character varying(50),
    city character varying(50),
    zip_code integer,
    state character varying(50),
    country character varying(50),
    password character varying(255) NOT NULL,
    user_type boolean NOT NULL,
    credit_card_type character varying(50),
    credit_card character varying(16),
    phone character varying(12),
    phone2 character varying(20),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."Reviews"
(
    id integer NOT NULL,
    review text,
    rating double precision NOT NULL DEFAULT 5,
    user_id integer NOT NULL,
    product_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Products"
(
    id integer NOT NULL,
    title text NOT NULL,
    price double precision NOT NULL,
    description text NOT NULL,
    "category.id" integer NOT NULL,
    "category.name" character varying(20) NOT NULL,
    "category.image_url" character varying(255),
    image_url0 character varying(255),
    image_url1 character varying(255),
    image_url2 character varying(255),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public."order-details"
(
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    order_price double precision NOT NULL,
    quantity integer NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public."Reviews"
    ADD CONSTRAINT user_id FOREIGN KEY (user_id)
    REFERENCES public."Users" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Reviews"
    ADD CONSTRAINT product_id FOREIGN KEY (product_id)
    REFERENCES public."Products" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Products"
    ADD CONSTRAINT category_id FOREIGN KEY ("category.id")
    REFERENCES public."Categories" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_category_id
    ON public."Products"("category.id");


ALTER TABLE IF EXISTS public."order-details"
    ADD CONSTRAINT order_id FOREIGN KEY (order_id)
    REFERENCES public."Orders" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_order_id
    ON public."order-details"(order_id);


ALTER TABLE IF EXISTS public."order-details"
    ADD CONSTRAINT product_id FOREIGN KEY (product_id)
    REFERENCES public."Products" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_product_id
    ON public."order-details"(product_id);

END;