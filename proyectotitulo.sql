drop table if exists public.categorias
drop table if exists public.actividades
drop table if exists public.entrenamientos
drop table if exists public.actividades_entrenamientos
drop table if exists public.razas
drop table if exists public.sugerencias
drop table if exists public.temas
drop table if exists public.usuarios
drop table if exists public.perros
drop table if exists public.entrenamientos_perros
drop table if exists public.actividades_perros
drop table if exists public.actividades_recientes
drop table if exists public.administradores

CREATE TABLE public.categorias
(
    id_categoria serial NOT NULL,
    nombre character varying NOT NULL,
    descripcion character varying NOT NULL,
    PRIMARY KEY (id_categoria)
);

ALTER TABLE IF EXISTS public.categorias
    OWNER to postgres;

CREATE TABLE public.actividades
(
    id_actividad serial NOT NULL,
    id_categoria serial NOT NULL,
    nombre character varying NOT NULL,
    descripcion character varying NOT NULL,
    fecha_creacion date NOT NULL,
    calificacion integer NOT NULL,
    progreso integer NOT NULL,
    contador integer NOT NULL,
    PRIMARY KEY (id_actividad),
    FOREIGN KEY (id_categoria)
        REFERENCES public.categorias (id_categoria) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.actividades
    OWNER to postgres;
	
CREATE TABLE public.entrenamientos
(
    id_entrenamiento serial NOT NULL,
    nombre character varying NOT NULL,
    descripcion character varying NOT NULL,
    PRIMARY KEY (id_entrenamiento)
);

ALTER TABLE IF EXISTS public.entrenamientos
    OWNER to postgres;

CREATE TABLE public.actividades_entrenamientos
(
    id_entrenamiento serial NOT NULL,
    id_actividad serial NOT NULL,
    PRIMARY KEY (id_entrenamiento, id_actividad),
    FOREIGN KEY (id_entrenamiento)
        REFERENCES public.entrenamientos (id_entrenamiento) MATCH SIMPLE,
	FOREIGN KEY (id_actividad)
        REFERENCES public.actividades (id_actividad) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.actividades_entrenamientos
    OWNER to postgres;
	
CREATE TABLE public.razas
(
    id_raza serial NOT NULL,
    nombre character varying NOT NULL,
    PRIMARY KEY (id_raza)
);

ALTER TABLE IF EXISTS public.razas
    OWNER to postgres;
	
CREATE TABLE public.sugerencias
(
    id_sugerencia serial NOT NULL,
    id_raza serial NOT NULL,
    nombre character varying NOT NULL,
    descripcion character varying NOT NULL,
    PRIMARY KEY (id_sugerencia),
    FOREIGN KEY (id_raza)
        REFERENCES public.razas (id_raza) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.sugerencias
    OWNER to postgres;
	
CREATE TABLE public.temas
(
    id_tema serial NOT NULL,
    tema character varying NOT NULL,
    PRIMARY KEY (id_tema)
);

ALTER TABLE IF EXISTS public.temas
    OWNER to postgres;
	
CREATE TABLE public.usuarios
(
    id_usuario serial NOT NULL,
    id_tema serial NOT NULL,
    nombre character varying NOT NULL,
    apellido character varying NOT NULL,
    email character varying NOT NULL,
    contrasena character varying NOT NULL,
    fecha_creacion date NOT NULL,
    fecha_nacimiento date NOT NULL,
	sin_perro boolean NOT NULL,
	
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_tema)
        REFERENCES public.temas (id_tema) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.usuarios
    OWNER to postgres;

ALTER TABLE IF EXISTS public.entrenamientos
    ADD COLUMN id_usuario serial NOT NULL;
ALTER TABLE IF EXISTS public.entrenamientos
    ADD FOREIGN KEY (id_usuario)
    REFERENCES public.usuarios (id_usuario) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
CREATE TABLE public.perros
(
    id_perro serial NOT NULL,
    id_usuario serial NOT NULL,
    id_raza serial NOT NULL,
    nombre character varying NOT NULL,
    fecha_nacimiento date NOT NULL,
    genero character varying NOT NULL,
    PRIMARY KEY (id_perro),
    FOREIGN KEY (id_usuario)
        REFERENCES public.usuarios (id_usuario) MATCH SIMPLE,
    FOREIGN KEY (id_raza)
		REFERENCES public.razas (id_raza) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.perros
    OWNER to postgres;
	
CREATE TABLE public.entrenamientos_perros
(
    id_entrenamiento serial NOT NULL,
    id_perro serial NOT NULL,
    PRIMARY KEY (id_entrenamiento, id_perro),
    FOREIGN KEY (id_entrenamiento)
        REFERENCES public.entrenamientos (id_entrenamiento) MATCH SIMPLE,
	FOREIGN KEY (id_perro)
        REFERENCES public.perros (id_perro) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.entrenamientos_perros
    OWNER to postgres;

CREATE TABLE public.actividades_recientes
(
    id_perro serial NOT NULL,
    id_actividad serial NOT NULL,
    fecha_reciente date NOT NULL,
    PRIMARY KEY (id_perro, id_actividad),
    FOREIGN KEY (id_perro)
        REFERENCES public.perros (id_perro) MATCH SIMPLE,
    FOREIGN KEY (id_actividad)
        REFERENCES public.actividades (id_actividad) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.actividades_recientes
    OWNER to postgres;
	
CREATE TABLE public.actividades_perros
(
    id_perro serial NOT NULL,
    id_actividad serial NOT NULL,
    PRIMARY KEY (id_perro, id_actividad),
    FOREIGN KEY (id_perro)
        REFERENCES public.perros (id_perro) MATCH SIMPLE,
    FOREIGN KEY (id_actividad)
        REFERENCES public.actividades (id_actividad) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.actividades_perros
    OWNER to postgres;
	
CREATE TABLE public.administradores
(
    id_administrador serial NOT NULL,
    nombre character varying NOT NULL,
    apellido character varying NOT NULL,
    email character varying NOT NULL,
    contrasena character varying NOT NULL,
    PRIMARY KEY (id_administrador)
);

ALTER TABLE IF EXISTS public.administradores
    OWNER to postgres;
	
	CREATE TABLE public.pasos
(
    id_paso serial NOT NULL,
    id_actividad serial NOT NULL,
    titulo character varying NOT NULL,
    nombre character varying NOT NULL,
    descripcion character varying NOT NULL,
    PRIMARY KEY (id_paso),
    FOREIGN KEY (id_actividad)
        REFERENCES public.actividades (id_actividad) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE IF EXISTS public.pasos
    OWNER to postgres;
	
ALTER TABLE IF EXISTS public.actividades_perros
    ADD COLUMN contador integer;
	
ALTER TABLE public.actividades_recientes
    ALTER COLUMN fecha_reciente TYPE timestamp without time zone ;
	
ALTER TABLE IF EXISTS public.actividades
    ADD COLUMN imagen character varying;
	
ALTER TABLE IF EXISTS public.pasos
    ADD COLUMN imagen character varying;
