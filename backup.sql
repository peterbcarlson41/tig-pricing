--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6
-- Dumped by pg_dump version 15.3

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

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA pgsodium;


ALTER SCHEMA pgsodium OWNER TO supabase_admin;

--
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: postgres
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  partition_name text;
BEGIN
  partition_name := 'messages_' || to_char(NOW(), 'YYYY_MM_DD');

  IF NOT EXISTS (
    SELECT 1
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = 'realtime'
    AND c.relname = partition_name
  ) THEN
    EXECUTE format(
      'CREATE TABLE realtime.%I PARTITION OF realtime.messages FOR VALUES FROM (%L) TO (%L)',
      partition_name,
      NOW(),
      (NOW() + interval '1 day')::timestamp
    );
  END IF;

  INSERT INTO realtime.messages (payload, event, topic, private, extension)
  VALUES (payload, event, topic, private, 'broadcast');
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: secrets_encrypt_secret_secret(); Type: FUNCTION; Schema: vault; Owner: supabase_admin
--

CREATE FUNCTION vault.secrets_encrypt_secret_secret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;


ALTER FUNCTION vault.secrets_encrypt_secret_secret() OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: pair_data_recent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pair_data_recent (
    id bigint NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    chain_id text,
    dex_id text,
    url text,
    pair_address text,
    price_native text,
    price_usd text,
    fdv numeric,
    market_cap numeric,
    pair_created_at bigint,
    volume_m5 numeric,
    volume_h1 numeric,
    volume_h6 numeric,
    volume_h24 numeric,
    price_change_m5 numeric,
    price_change_h1 numeric,
    price_change_h6 numeric,
    price_change_h24 numeric,
    txns_m5_buys integer,
    txns_m5_sells integer,
    txns_h1_buys integer,
    txns_h1_sells integer,
    txns_h6_buys integer,
    txns_h6_sells integer,
    txns_h24_buys integer,
    txns_h24_sells integer,
    liquidity_usd numeric,
    liquidity_base numeric,
    liquidity_quote numeric
);


ALTER TABLE public.pair_data_recent OWNER TO postgres;

--
-- Name: pair_data_recent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pair_data_recent ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.pair_data_recent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: price_volume_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_volume_history (
    id bigint NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    price_usd text,
    volume_h24 numeric
);


ALTER TABLE public.price_volume_history OWNER TO postgres;

--
-- Name: price_volume_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.price_volume_history ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.price_volume_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: token_price_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_price_history (
    id bigint NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    price numeric(20,10) NOT NULL
);


ALTER TABLE public.token_price_history OWNER TO postgres;

--
-- Name: token_price_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.token_price_history ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.token_price_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: decrypted_secrets; Type: VIEW; Schema: vault; Owner: supabase_admin
--

CREATE VIEW vault.decrypted_secrets AS
 SELECT secrets.id,
    secrets.name,
    secrets.description,
    secrets.secret,
        CASE
            WHEN (secrets.secret IS NULL) THEN NULL::text
            ELSE
            CASE
                WHEN (secrets.key_id IS NULL) THEN NULL::text
                ELSE convert_from(pgsodium.crypto_aead_det_decrypt(decode(secrets.secret, 'base64'::text), convert_to(((((secrets.id)::text || secrets.description) || (secrets.created_at)::text) || (secrets.updated_at)::text), 'utf8'::name), secrets.key_id, secrets.nonce), 'utf8'::name)
            END
        END AS decrypted_secret,
    secrets.key_id,
    secrets.nonce,
    secrets.created_at,
    secrets.updated_at
   FROM vault.secrets;


ALTER TABLE vault.decrypted_secrets OWNER TO supabase_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--

COPY pgsodium.key (id, status, created, expires, key_type, key_id, key_context, name, associated_data, raw_key, raw_key_nonce, parent_key, comment, user_data) FROM stdin;
\.


--
-- Data for Name: pair_data_recent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pair_data_recent (id, "timestamp", chain_id, dex_id, url, pair_address, price_native, price_usd, fdv, market_cap, pair_created_at, volume_m5, volume_h1, volume_h6, volume_h24, price_change_m5, price_change_h1, price_change_h6, price_change_h24, txns_m5_buys, txns_m5_sells, txns_h1_buys, txns_h1_sells, txns_h6_buys, txns_h6_sells, txns_h24_buys, txns_h24_sells, liquidity_usd, liquidity_base, liquidity_quote) FROM stdin;
2	2024-12-07 17:14:32.77094+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1454	3.14	111668430	44198051	1723532457000	214.33	214.33	56152.32	202156.7	0.01	0.01	0.71	1.21	1	0	1	0	16	7	49	31	2713382.89	550072	983155
3	2024-12-07 17:19:33.80108+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1459	3.14	111684410	44204376	1723532457000	0	583.33	56521.32	202364.75	0	0.02	0.72	1.22	0	0	2	0	17	7	49	31	2713634.15	549956	983524
4	2024-12-07 17:24:34.599261+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1486	3.14	111782185	44243075	1723532457000	2257.26	2840.59	58778.58	204616.32	0.09	0.11	0.81	1.49	1	0	3	0	18	7	50	30	2715170.38	549245	985782
5	2024-12-07 17:29:35.893659+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1486	3.14	111782185	44243075	1723532457000	0	2840.59	58778.58	204616.32	0	0.11	0.81	1.49	0	0	3	0	18	7	50	30	2715170.38	549245	985782
6	2024-12-07 17:34:36.705454+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111777737	44241314	1723532457000	101.63	2942.23	58880.22	204717.96	0	0.11	0.81	1.49	0	1	3	1	18	8	50	31	2715102.59	549278	985680
7	2024-12-07 17:39:37.597686+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111777737	44241314	1723532457000	0	2942.23	58880.22	200106.88	0	0.11	0.81	1.49	0	0	3	1	18	8	50	30	2715102.59	549278	985680
8	2024-12-07 17:44:38.643898+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111777737	44241314	1723532457000	0	2942.23	58849.29	200106.88	0	0.11	0.81	1.49	0	0	3	1	18	7	50	30	2715102.59	549278	985680
9	2024-12-07 17:49:39.557865+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111779680	44242084	1723532457000	3.81	2987.1	58894.16	200151.74	0	0.11	0.81	1.49	1	0	7	1	22	7	54	30	2715133.11	549264	985725
10	2024-12-07 17:54:40.266884+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	22.07	3009.17	58916.23	200173.82	0	0.11	0.81	1.49	0	1	7	2	22	8	54	31	2715118.39	549271	985703
11	2024-12-07 17:59:41.017753+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	3009.17	58440.78	197796.95	0	0.11	0.79	1.59	0	0	7	2	20	8	53	30	2715118.39	549271	985703
12	2024-12-07 18:04:41.681408+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	3009.17	58440.78	197796.95	0	0.11	0.79	1.59	0	0	7	2	20	8	53	30	2715118.39	549271	985703
13	2024-12-07 18:09:42.436425+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	3009.17	58440.78	195981.78	0	0.11	0.79	1.72	0	0	7	2	20	8	53	28	2715118.39	549271	985703
14	2024-12-07 18:15:14.696087+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	2425.83	58430.81	194349.99	0	0.08	0.79	1.71	0	0	5	2	19	8	52	27	2715118.39	549271	985703
15	2024-12-07 18:20:15.602932+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	2425.83	58430.81	194194.01	0	0.08	0.79	1.71	0	0	5	2	19	8	51	27	2715118.39	549271	985703
16	2024-12-07 18:25:16.252518+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	168.57	58430.81	194194.01	0	0	0.79	1.71	0	0	4	2	19	8	51	27	2715118.39	549271	985703
17	2024-12-07 18:30:17.753455+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	168.57	58430.81	194194.01	0	0	0.79	1.71	0	0	4	2	19	8	51	27	2715118.39	549271	985703
18	2024-12-07 18:35:18.89015+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	66.93	58430.81	194194.01	0	0	0.79	1.71	0	0	4	1	19	8	51	27	2715118.39	549271	985703
19	2024-12-07 18:40:19.598146+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	66.93	58430.81	193086.87	0	0	0.79	1.47	0	0	4	1	19	8	49	27	2715118.39	549271	985703
20	2024-12-07 18:45:20.160512+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	25.88	58430.81	193086.87	0	0	0.79	1.47	0	0	1	1	19	8	49	27	2715118.39	549271	985703
21	2024-12-07 18:50:20.969273+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	0	58430.81	193086.87	0	0	0.79	1.47	0	0	0	0	19	8	49	27	2715118.39	549271	985703
22	2024-12-07 18:55:21.64099+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	0	58430.81	193086.87	0	0	0.79	1.47	0	0	0	0	19	8	49	27	2715118.39	549271	985703
23	2024-12-07 19:00:22.289591+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	0	54879.38	188002.95	0	0	0.93	1.46	0	0	0	0	19	7	47	27	2715118.39	549271	985703
24	2024-12-07 19:05:22.904317+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	0	54879.38	188002.95	0	0	0.93	1.46	0	0	0	0	19	7	47	27	2715118.39	549271	985703
25	2024-12-07 19:10:26.850659+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	0	54879.38	188002.95	0	0	0.93	1.46	0	0	0	0	19	7	47	27	2715118.39	549271	985703
26	2024-12-07 19:15:27.49043+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1485	3.14	111778714	44241701	1723532457000	0	0	54879.38	188002.95	0	0	0.93	1.46	0	0	0	0	19	7	47	27	2715118.39	549271	985703
27	2024-12-07 19:20:28.249623+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1601	3.16	112189873	44404437	1723532457000	9481.49	9481.49	60253.57	197484.45	0.37	0.37	1.14	1.83	3	0	3	0	20	7	50	27	2721503.98	546289	995152
28	2024-12-07 19:25:28.890402+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1601	3.16	112189873	44404437	1723532457000	0	9481.49	60253.57	197484.45	0	0.37	1.14	1.83	0	0	3	0	20	7	50	27	2721503.98	546289	995152
29	2024-12-07 19:30:29.602973+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1618	3.16	112250364	44428379	1723532457000	1864	11910.83	47260.16	192689.81	0.07	0.42	1.57	2.1	2	0	6	1	20	4	48	25	2722458.77	545854	996551
30	2024-12-07 19:35:30.151019+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1618	3.16	112250364	44428379	1723532457000	0	2429.33	47260.16	192689.81	0	0.05	1.57	2.1	0	0	3	1	20	4	48	25	2722458.77	545854	996551
31	2024-12-07 19:40:30.938065+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1618	3.16	112251337	44428764	1723532457000	22.41	2451.74	47282.57	192712.22	0	0.05	1.57	2.1	1	0	4	1	21	4	49	25	2722473.95	545847	996573
32	2024-12-07 19:45:31.612852+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1619	3.16	112252422	44429193	1723532457000	24.99	1961.41	47307.57	192719.58	0	0.08	1.57	2.11	1	0	5	0	22	4	50	24	2722490.89	545839	996598
213	2024-12-07 22:07:00.031111+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264379	44433926	1723532457000	0	11.67	17264.87	124308.7	0	0	0.62	0.43	0	0	1	1	19	4	49	20	2722677.71	545753	996874
216	2024-12-07 22:35:40.237341+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112436295	44501970	1723532457000	0	3969.67	19224.26	112390.99	0	0.15	0.7	1.2	0	0	2	1	19	4	47	19	2725357.1	544515	1000832
219	2024-12-07 22:54:34.14071+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112435745	44501752	1723532457000	0	3970.53	19236.81	112403.53	0	0.15	0.7	1.2	0	0	1	1	19	5	47	20	2725348.79	544519	1000819
222	2024-12-07 23:18:45.346346+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112435745	112435745	1723532457000	0	3970.54	18653.48	112359.73	0	0.15	0.67	1.07	0	0	2	1	18	5	47	20	2725348.79	544519	1000819
225	2024-12-07 23:40:21.490236+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1671	3.16	112437787	44502561	1723532457000	0	59.54	16341.58	101172.04	0	0	0.59	0.75	0	0	2	1	18	4	45	20	2725380.58	544504	1000866
228	2024-12-07 23:58:09.663461+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1671	3.16	112437787	44502561	1723532457000	0	47	16274.64	100882.04	0	0	0.59	0.75	0	0	2	0	14	3	44	20	2725380.58	544504	1000866
231	2024-12-08 01:28:21.441003+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112436394	44502009	1723532457000	0	30	6369.25	100952.99	0	0	0.24	0.75	0	0	1	0	12	4	45	21	2725360.13	544514	1000835
234	2024-12-08 03:12:12.983062+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1340	3.13	111262421	44037354	1723532457000	0	1939.91	32109.27	128719.4	0	-0.08	-0.89	-0.3	0	0	0	1	6	11	45	27	2707494.84	553114	974023
236	2024-12-08 03:43:58.847804+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1264	3.12	110991983	43930315	1723532457000	0	5036.93	35194.62	131736.58	0	-0.32	-1.13	-0.42	0	0	0	2	5	11	44	28	2703336.41	555114	967825
238	2024-12-08 03:59:48.607846+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09201	3.092	109771158	43447116	1723532457000	0	31168.99	63266.6	159808.56	0	-1.34	-2.22	-1.52	0	0	0	9	5	19	44	36	2684374.31	564234	939753
240	2024-12-08 04:20:00.325317+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09201	3.092	109771158	43447116	1723532457000	0	31168.99	63266.6	159808.56	0	-1.34	-2.22	-1.52	0	0	0	9	5	19	44	36	2684374.31	564234	939753
242	2024-12-08 04:40:17.961396+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09094	3.090	109733191	43432089	1723532457000	0	28947.41	60184.04	160683.99	0	-1.13	-2.4	-1.55	0	0	0	9	4	20	44	37	2683779.6	564520	938877
244	2024-12-08 04:53:23.330734+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09094	3.090	109733191	43432089	1723532457000	0	7164.6	60171.49	160683.99	0	-0.28	-2.4	-1.55	0	0	0	3	4	19	44	37	2683779.6	564520	938877
246	2024-12-08 05:07:20.484197+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09094	3.090	109733191	43432089	1723532457000	0	875.43	60171.48	157411.22	0	-0.03	-2.4	-1.5	0	0	0	1	3	19	44	35	2683779.6	564520	938877
248	2024-12-08 05:27:53.82606+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09094	3.090	109733191	43432089	1723532457000	0	0	60171.48	157411.22	0	0	-2.4	-1.5	0	0	0	0	3	19	44	35	2683779.6	564520	938877
249	2024-12-08 05:36:23.13089+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09123	3.091	109743544	43436187	1723532457000	241.13	241.13	60365.63	157652.35	0.01	0.01	-2.4	-1.49	1	0	1	0	3	19	45	35	2683946.62	564443	939119
250	2024-12-08 05:43:06.522858+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09123	3.091	109743586	43436203	1723532457000	0.99	242.12	60366.62	157653.34	0	0.01	-2.4	-1.49	1	0	2	0	4	19	46	35	2683947.3	564443	939120
251	2024-12-08 05:49:04.779509+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09123	3.091	109743586	43436203	1723532457000	0	242.12	60366.62	157653.34	0	0.01	-2.4	-1.49	0	0	2	0	4	19	46	35	2683947.3	564443	939120
252	2024-12-08 05:54:46.764965+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09123	3.091	109743586	43436203	1723532457000	0	242.12	60366.62	157653.34	0	0.01	-2.4	-1.49	0	0	2	0	4	19	46	35	2683947.3	564443	939120
214	2024-12-07 22:16:26.688212+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264379	44433926	1723532457000	0	11.67	15266.27	123997.59	0	0	0.54	0.43	0	0	1	1	18	4	48	20	2722677.71	545753	996874
217	2024-12-07 22:42:42.992741+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112436295	44501970	1723532457000	0	3958	19224.26	112390.99	0	0.15	0.7	1.2	0	0	2	0	19	4	47	19	2725357.1	544515	1000832
220	2024-12-07 23:00:31.24867+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112435745	44501752	1723532457000	0	3970.53	19236.81	112403.53	0	0.15	0.7	1.2	0	0	1	1	19	5	47	20	2725348.79	544519	1000819
223	2024-12-07 23:27:07.515004+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112435745	44501752	1723532457000	0	12.55	16396.22	101125.05	0	0	0.58	0.75	0	0	1	1	17	5	44	20	2725348.79	544519	1000819
226	2024-12-07 23:46:12.376062+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1671	3.16	112437787	44502561	1723532457000	0	59.54	16296.71	100882.04	0	0	0.59	0.75	0	0	2	1	14	4	44	20	2725380.58	544504	1000866
229	2024-12-08 00:30:43.759723+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112436394	44502009	1723532457000	30	91.44	16366.08	100952.99	0	0	0.59	0.75	1	0	1	2	15	5	45	21	2725360.13	544514	1000835
232	2024-12-08 02:12:49.690082+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1364	3.13	111347135	44070883	1723532457000	0	26048.69	30503.95	126818.07	0	-0.97	-0.8	-0.22	0	0	1	6	10	10	46	26	2708794.36	552489	975963
235	2024-12-08 03:28:50.086705+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1264	3.12	110991983	43930315	1723532457000	3097.01	5036.93	35206.29	131816.42	-0.24	-0.32	-1.13	-0.55	0	1	0	2	6	12	45	28	2703336.41	555114	967825
237	2024-12-08 03:53:51.324509+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1005	3.10	110074491	43567174	1723532457000	7008.25	24180.07	56277.67	152819.63	-0.28	-1.07	-1.95	-1.25	0	1	0	6	5	16	44	33	2689114.92	561954	946742
239	2024-12-08 04:09:14.027747+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09201	3.092	109771158	43447116	1723532457000	0	31168.99	63266.6	159808.56	0	-1.34	-2.22	-1.52	0	0	0	9	5	19	44	36	2684374.31	564234	939753
241	2024-12-08 04:31:29.496972+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09094	3.090	109733191	43432089	1723532457000	0	28947.41	60184.04	160683.99	0	-1.13	-2.4	-1.55	0	0	0	9	4	20	44	37	2683779.6	564520	938877
243	2024-12-08 04:47:20.269017+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09094	3.090	109733191	43432089	1723532457000	0	14872.61	60184.04	160683.99	0	-0.59	-2.4	-1.55	0	0	0	5	4	20	44	37	2683779.6	564520	938877
245	2024-12-08 04:58:59.847417+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09094	3.090	109733191	43432089	1723532457000	0	875.43	60171.49	157581.56	0	-0.03	-2.4	-1.55	0	0	0	1	4	19	44	36	2683779.6	564520	938877
247	2024-12-08 05:17:07.809895+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09094	3.090	109733191	43432089	1723532457000	0	875.43	60171.48	157411.22	0	-0.03	-2.4	-1.5	0	0	0	1	3	19	44	35	2683779.6	564520	938877
199	2024-12-07 19:50:32.31188+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1619	3.16	112252422	44429193	1723532457000	0	1961.41	45241.82	192719.58	0	0.08	1.49	2.11	0	0	5	0	21	4	50	24	2722490.89	545839	996598
200	2024-12-07 20:39:01.422865+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1621	3.16	112261050	44432608	1723532457000	198.72	2160.13	45440.55	192918.31	0.01	0.08	1.49	2.12	1	0	6	0	22	4	51	24	2722625.53	545777	996797
201	2024-12-07 20:44:02.10651+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264890	44434128	1723532457000	88.45	2198.58	45529	193006.76	0	0.09	1.5	2.12	1	0	6	0	23	4	52	24	2722685.45	545749	996885
202	2024-12-07 20:49:02.748992+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264890	44434128	1723532457000	0	2198.58	45529	193006.76	0	0.09	1.5	2.12	0	0	6	0	23	4	52	24	2722685.45	545749	996885
203	2024-12-07 20:54:03.393927+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264890	44434128	1723532457000	0	2198.58	45529	192729.89	0	0.09	1.5	1.12	0	0	6	0	23	4	52	23	2722685.45	545749	996885
204	2024-12-07 21:09:44.460011+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264890	44434128	1723532457000	0	2198.58	43451.92	167487.14	0	0.09	1.41	1.61	0	0	6	0	21	4	51	23	2722685.45	545749	996885
205	2024-12-07 21:11:12.929084+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264890	44434128	1723532457000	0	2198.58	43451.92	167487.14	0	0.09	1.41	1.61	0	0	6	0	21	4	51	23	2722685.45	545749	996885
206	2024-12-07 21:21:23.451094+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264890	44434128	1723532457000	0	312.17	20251.83	155133.3	0	0.01	0.5	1.22	0	0	3	0	19	4	51	22	2722685.45	545749	996885
207	2024-12-07 21:28:43.813427+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264890	44434128	1723532457000	0	287.17	20251.83	155133.3	0	0.01	0.5	1.22	0	0	2	0	19	4	51	22	2722685.45	545749	996885
208	2024-12-07 21:35:05.0503+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264890	44434128	1723532457000	0	88.45	20221.47	155133.3	0	0	0.5	1.22	0	0	1	0	18	4	51	22	2722685.45	545749	996885
209	2024-12-07 21:41:12.922318+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264379	44433926	1723532457000	11.66	100.11	20233.14	124935.94	0	0	0.5	0.44	0	1	1	1	18	5	49	23	2722677.7	545753	996874
210	2024-12-07 21:47:10.679752+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264379	44433926	1723532457000	0.01	11.67	20233.15	124655.37	0	0	0.5	0.44	1	0	1	1	19	5	50	22	2722677.71	545753	996874
211	2024-12-07 21:53:21.79067+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264379	44433926	1723532457000	0	11.67	20233.15	124513.28	0	0	0.5	0.45	0	0	1	1	19	5	50	21	2722677.71	545753	996874
212	2024-12-07 21:59:01.111768+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1622	3.16	112264379	44433926	1723532457000	0	11.67	17264.87	124308.7	0	0	0.62	0.43	0	0	1	1	19	4	49	20	2722677.71	545753	996874
124	2024-12-04 16:00:00+00	\N	\N	\N	\N	3.0491	3.0490685736	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
125	2024-12-04 17:00:00+00	\N	\N	\N	\N	3.0483	3.0482656245	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
126	2024-12-04 18:00:00+00	\N	\N	\N	\N	2.7895	2.7895497519	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
33	2024-11-30 21:00:00+00	\N	\N	\N	\N	3.1498	3.1497756566	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
34	2024-11-30 22:00:00+00	\N	\N	\N	\N	3.1292	3.1292444172	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
35	2024-11-30 23:00:00+00	\N	\N	\N	\N	3.0513	3.0513226413	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
36	2024-12-01 00:00:00+00	\N	\N	\N	\N	3.0537	3.0536738412	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
37	2024-12-01 01:00:00+00	\N	\N	\N	\N	3.072	3.0720427587	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
38	2024-12-01 02:00:00+00	\N	\N	\N	\N	3.101	3.1010359415	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
39	2024-12-01 03:00:00+00	\N	\N	\N	\N	3.1188	3.1188085076	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
40	2024-12-01 04:00:00+00	\N	\N	\N	\N	3.1179	3.1179082488	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
41	2024-12-01 05:00:00+00	\N	\N	\N	\N	3.2927	3.2926638493	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
42	2024-12-01 06:00:00+00	\N	\N	\N	\N	3.3359	3.3359390714	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
43	2024-12-01 07:00:00+00	\N	\N	\N	\N	3.4022	3.4022210796	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
44	2024-12-01 08:00:00+00	\N	\N	\N	\N	3.4021	3.4021328232	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
45	2024-12-01 09:00:00+00	\N	\N	\N	\N	3.5013	3.5012861342	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
46	2024-12-01 10:00:00+00	\N	\N	\N	\N	3.8015	3.8015069273	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
47	2024-12-01 11:00:00+00	\N	\N	\N	\N	3.5695	3.5695224763	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
48	2024-12-01 12:00:00+00	\N	\N	\N	\N	3.5131	3.5130715435	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
49	2024-12-01 13:00:00+00	\N	\N	\N	\N	3.5118	3.5118246439	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
50	2024-12-01 14:00:00+00	\N	\N	\N	\N	3.6034	3.6034193457	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
51	2024-12-01 15:00:00+00	\N	\N	\N	\N	3.6236	3.6235834983	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
52	2024-12-01 16:00:00+00	\N	\N	\N	\N	3.6306	3.6305663794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
53	2024-12-01 17:00:00+00	\N	\N	\N	\N	3.6379	3.6378968047	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
54	2024-12-01 18:00:00+00	\N	\N	\N	\N	3.5056	3.5055862786	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
55	2024-12-01 19:00:00+00	\N	\N	\N	\N	3.5195	3.5194608906	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
56	2024-12-01 20:00:00+00	\N	\N	\N	\N	3.5259	3.5259395952	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
57	2024-12-01 21:00:00+00	\N	\N	\N	\N	3.5573	3.5572942008	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
58	2024-12-01 22:00:00+00	\N	\N	\N	\N	3.5705	3.5704919943	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
59	2024-12-01 23:00:00+00	\N	\N	\N	\N	3.5739	3.5739342484	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
60	2024-12-02 00:00:00+00	\N	\N	\N	\N	3.6677	3.6677351526	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
61	2024-12-02 01:00:00+00	\N	\N	\N	\N	3.7244	3.7244021848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
62	2024-12-02 02:00:00+00	\N	\N	\N	\N	4.1528	4.1528354986	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
63	2024-12-02 03:00:00+00	\N	\N	\N	\N	4.2625	4.2624510258	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
64	2024-12-02 04:00:00+00	\N	\N	\N	\N	4.0112	4.011210939	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
65	2024-12-02 05:00:00+00	\N	\N	\N	\N	4.0318	4.0317636671	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
66	2024-12-02 06:00:00+00	\N	\N	\N	\N	4.0039	4.0038577948	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
67	2024-12-02 07:00:00+00	\N	\N	\N	\N	3.9906	3.9905789558	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
68	2024-12-02 08:00:00+00	\N	\N	\N	\N	3.9411	3.9410943003	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
69	2024-12-02 09:00:00+00	\N	\N	\N	\N	3.9842	3.9842230634	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
70	2024-12-02 10:00:00+00	\N	\N	\N	\N	3.951	3.9509836396	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
71	2024-12-02 11:00:00+00	\N	\N	\N	\N	3.9714	3.9713709565	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
72	2024-12-02 12:00:00+00	\N	\N	\N	\N	3.9716	3.971613082	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
73	2024-12-02 13:00:00+00	\N	\N	\N	\N	3.9888	3.9888095596	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
74	2024-12-02 14:00:00+00	\N	\N	\N	\N	3.9598	3.9597979151	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
75	2024-12-02 15:00:00+00	\N	\N	\N	\N	3.9593	3.9592832619	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
76	2024-12-02 16:00:00+00	\N	\N	\N	\N	3.9534	3.9533564322	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
77	2024-12-02 17:00:00+00	\N	\N	\N	\N	3.9468	3.9468004346	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
78	2024-12-02 18:00:00+00	\N	\N	\N	\N	3.4732	3.4732421496	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
79	2024-12-02 19:00:00+00	\N	\N	\N	\N	3.4705	3.4705124379	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
80	2024-12-02 20:00:00+00	\N	\N	\N	\N	3.1628	3.1627751441	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
81	2024-12-02 21:00:00+00	\N	\N	\N	\N	3.1581	3.158120854	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
82	2024-12-02 22:00:00+00	\N	\N	\N	\N	3.1523	3.1523227382	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
83	2024-12-02 23:00:00+00	\N	\N	\N	\N	3.3607	3.3607322387	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
84	2024-12-03 00:00:00+00	\N	\N	\N	\N	3.5073	3.5072673608	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
85	2024-12-03 01:00:00+00	\N	\N	\N	\N	3.6244	3.624371238	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
86	2024-12-03 02:00:00+00	\N	\N	\N	\N	3.6344	3.6343825263	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
87	2024-12-03 03:00:00+00	\N	\N	\N	\N	3.6353	3.635320136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
88	2024-12-03 04:00:00+00	\N	\N	\N	\N	3.6516	3.6516202179	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
89	2024-12-03 05:00:00+00	\N	\N	\N	\N	3.7157	3.7156652176	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
90	2024-12-03 06:00:00+00	\N	\N	\N	\N	3.8269	3.8268962706	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
91	2024-12-03 07:00:00+00	\N	\N	\N	\N	3.789	3.789028736	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
92	2024-12-03 08:00:00+00	\N	\N	\N	\N	3.787	3.786996114	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
93	2024-12-03 09:00:00+00	\N	\N	\N	\N	3.7418	3.7417876158	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
94	2024-12-03 10:00:00+00	\N	\N	\N	\N	3.8066	3.8065742995	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
95	2024-12-03 11:00:00+00	\N	\N	\N	\N	3.8098	3.8097694998	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
96	2024-12-03 12:00:00+00	\N	\N	\N	\N	3.7925	3.7924627329	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
97	2024-12-03 13:00:00+00	\N	\N	\N	\N	3.7967	3.7967196695	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
98	2024-12-03 14:00:00+00	\N	\N	\N	\N	3.7967	3.7967196695	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
99	2024-12-03 15:00:00+00	\N	\N	\N	\N	3.7724	3.7724208855	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
100	2024-12-03 16:00:00+00	\N	\N	\N	\N	3.6238	3.6238369177	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
101	2024-12-03 17:00:00+00	\N	\N	\N	\N	3.6105	3.6104691942	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
102	2024-12-03 18:00:00+00	\N	\N	\N	\N	3.536	3.5360225068	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
103	2024-12-03 19:00:00+00	\N	\N	\N	\N	3.4263	3.4263105877	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
104	2024-12-03 20:00:00+00	\N	\N	\N	\N	3.4302	3.4301714309	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
105	2024-12-03 21:00:00+00	\N	\N	\N	\N	3.3782	3.3781753463	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
106	2024-12-03 22:00:00+00	\N	\N	\N	\N	3.416	3.4159709558	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
107	2024-12-03 23:00:00+00	\N	\N	\N	\N	3.4181	3.4181321178	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
108	2024-12-04 00:00:00+00	\N	\N	\N	\N	2.9751	2.9751357594	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
109	2024-12-04 01:00:00+00	\N	\N	\N	\N	2.7923	2.7923196965	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
110	2024-12-04 02:00:00+00	\N	\N	\N	\N	3.0847	3.0847126057	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
111	2024-12-04 03:00:00+00	\N	\N	\N	\N	3.0763	3.0763266303	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
112	2024-12-04 04:00:00+00	\N	\N	\N	\N	3.0896	3.0896317681	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
113	2024-12-04 05:00:00+00	\N	\N	\N	\N	3.0898	3.0898166239	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
114	2024-12-04 06:00:00+00	\N	\N	\N	\N	3.1167	3.1166723518	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
115	2024-12-04 07:00:00+00	\N	\N	\N	\N	3.117	3.117043932	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
116	2024-12-04 08:00:00+00	\N	\N	\N	\N	3.1178	3.1177719625	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
117	2024-12-04 09:00:00+00	\N	\N	\N	\N	3.1114	3.1114214407	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
118	2024-12-04 10:00:00+00	\N	\N	\N	\N	3.1154	3.1153787899	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
119	2024-12-04 11:00:00+00	\N	\N	\N	\N	3.1148	3.1147926667	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
120	2024-12-04 12:00:00+00	\N	\N	\N	\N	3.1197	3.1197170073	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
121	2024-12-04 13:00:00+00	\N	\N	\N	\N	3.1318	3.131824842	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
122	2024-12-04 14:00:00+00	\N	\N	\N	\N	3.1316	3.1316103924	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
123	2024-12-04 15:00:00+00	\N	\N	\N	\N	3.1176	3.1176379136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
127	2024-12-04 19:00:00+00	\N	\N	\N	\N	2.7433	2.7432710782	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
128	2024-12-04 20:00:00+00	\N	\N	\N	\N	2.7636	2.7635806239	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
129	2024-12-04 21:00:00+00	\N	\N	\N	\N	2.7286	2.7286311015	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
130	2024-12-04 22:00:00+00	\N	\N	\N	\N	2.7774	2.777372214	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
131	2024-12-04 23:00:00+00	\N	\N	\N	\N	2.8206	2.8205954993	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
132	2024-12-05 00:00:00+00	\N	\N	\N	\N	2.8265	2.8265219551	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
133	2024-12-05 01:00:00+00	\N	\N	\N	\N	2.6633	2.6632547484	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
134	2024-12-05 02:00:00+00	\N	\N	\N	\N	2.6518	2.6517655872	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
135	2024-12-05 03:00:00+00	\N	\N	\N	\N	2.661	2.6609917221	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
136	2024-12-05 04:00:00+00	\N	\N	\N	\N	2.6482	2.6481890373	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
137	2024-12-05 05:00:00+00	\N	\N	\N	\N	2.6493	2.6493155451	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
138	2024-12-05 06:00:00+00	\N	\N	\N	\N	2.6236	2.6235886771	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
139	2024-12-05 07:00:00+00	\N	\N	\N	\N	2.6378	2.6377722314	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
140	2024-12-05 08:00:00+00	\N	\N	\N	\N	2.7088	2.7087756992	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
141	2024-12-05 09:00:00+00	\N	\N	\N	\N	2.7364	2.7363735389	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
142	2024-12-05 10:00:00+00	\N	\N	\N	\N	2.7334	2.7334235421	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
143	2024-12-05 11:00:00+00	\N	\N	\N	\N	2.4637	2.4636556072	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
144	2024-12-05 12:00:00+00	\N	\N	\N	\N	2.4393	2.4392782645	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
145	2024-12-05 13:00:00+00	\N	\N	\N	\N	2.4922	2.4922259211	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
146	2024-12-05 14:00:00+00	\N	\N	\N	\N	2.5098	2.5097999116	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
147	2024-12-05 15:00:00+00	\N	\N	\N	\N	2.5071	2.507072067	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
148	2024-12-05 16:00:00+00	\N	\N	\N	\N	2.5165	2.5165308194	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
149	2024-12-05 17:00:00+00	\N	\N	\N	\N	2.4964	2.4963992862	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
150	2024-12-05 18:00:00+00	\N	\N	\N	\N	2.5108	2.5108326757	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
151	2024-12-05 19:00:00+00	\N	\N	\N	\N	2.6351	2.6351216258	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
152	2024-12-05 20:00:00+00	\N	\N	\N	\N	2.6312	2.6311852643	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
153	2024-12-05 21:00:00+00	\N	\N	\N	\N	2.5752	2.5751644691	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
154	2024-12-05 23:00:00+00	\N	\N	\N	\N	2.5763	2.5763192532	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
155	2024-12-06 00:00:00+00	\N	\N	\N	\N	2.5749	2.5749273869	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
156	2024-12-06 01:00:00+00	\N	\N	\N	\N	2.5776	2.5775816861	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
157	2024-12-06 02:00:00+00	\N	\N	\N	\N	2.5804	2.5804430737	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
158	2024-12-06 03:00:00+00	\N	\N	\N	\N	2.5842	2.5841526309	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
159	2024-12-06 04:00:00+00	\N	\N	\N	\N	2.5987	2.5986880495	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
160	2024-12-06 05:00:00+00	\N	\N	\N	\N	2.6288	2.6288312434	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
161	2024-12-06 06:00:00+00	\N	\N	\N	\N	2.6554	2.6554440301	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
162	2024-12-06 07:00:00+00	\N	\N	\N	\N	2.6837	2.6837111488	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
163	2024-12-06 08:00:00+00	\N	\N	\N	\N	2.7372	2.7372472321	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
164	2024-12-06 09:00:00+00	\N	\N	\N	\N	2.7317	2.731683817	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
165	2024-12-06 10:00:00+00	\N	\N	\N	\N	2.8709	2.8709349266	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
166	2024-12-06 11:00:00+00	\N	\N	\N	\N	3.0533	3.0532824029	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
167	2024-12-06 12:00:00+00	\N	\N	\N	\N	3.0527	3.0527347748	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
168	2024-12-06 13:00:00+00	\N	\N	\N	\N	3.0702	3.0702044409	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
169	2024-12-06 14:00:00+00	\N	\N	\N	\N	3.096	3.0959849966	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
170	2024-12-06 15:00:00+00	\N	\N	\N	\N	3.0963	3.0962957324	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
171	2024-12-06 16:00:00+00	\N	\N	\N	\N	3.1027	3.102662772	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
172	2024-12-06 17:00:00+00	\N	\N	\N	\N	3.0995	3.0994584347	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
173	2024-12-06 18:00:00+00	\N	\N	\N	\N	3.103	3.1030335467	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
174	2024-12-06 19:00:00+00	\N	\N	\N	\N	3.0959	3.0958558444	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
175	2024-12-06 20:00:00+00	\N	\N	\N	\N	3.0966	3.0966196653	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
176	2024-12-06 21:00:00+00	\N	\N	\N	\N	3.1483	3.1482697515	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
177	2024-12-06 22:00:00+00	\N	\N	\N	\N	3.1296	3.1295558147	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
178	2024-12-06 23:00:00+00	\N	\N	\N	\N	3.1436	3.1436466561	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
179	2024-12-07 00:00:00+00	\N	\N	\N	\N	3.1436	3.1436214039	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
180	2024-12-07 02:00:00+00	\N	\N	\N	\N	3.1434	3.1433952496	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
181	2024-12-07 03:00:00+00	\N	\N	\N	\N	3.1435	3.1435396583	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
182	2024-12-07 04:00:00+00	\N	\N	\N	\N	3.1397	3.1397195458	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
183	2024-12-07 05:00:00+00	\N	\N	\N	\N	3.1381	3.1381362598	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
184	2024-12-07 06:00:00+00	\N	\N	\N	\N	3.1189	3.1188643333	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
185	2024-12-07 07:00:00+00	\N	\N	\N	\N	3.119	3.1189602685	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
186	2024-12-07 08:00:00+00	\N	\N	\N	\N	3.1201	3.1200997032	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
187	2024-12-07 09:00:00+00	\N	\N	\N	\N	3.122	3.1220276093	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
188	2024-12-07 10:00:00+00	\N	\N	\N	\N	3.1234	3.1233607761	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
189	2024-12-07 11:00:00+00	\N	\N	\N	\N	3.1239	3.1239007306	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
190	2024-12-07 12:00:00+00	\N	\N	\N	\N	3.1196	3.1195537656	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
191	2024-12-07 13:00:00+00	\N	\N	\N	\N	3.113	3.1129921796	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
192	2024-12-07 14:00:00+00	\N	\N	\N	\N	3.1157	3.1157117848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
193	2024-12-07 15:00:00+00	\N	\N	\N	\N	3.1428	3.1427560079	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
194	2024-12-07 16:00:00+00	\N	\N	\N	\N	3.1452	3.1451932466	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
195	2024-12-07 17:00:00+00	\N	\N	\N	\N	3.1486	3.1485611464	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
196	2024-12-07 18:00:00+00	\N	\N	\N	\N	3.1537	3.1536863167	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
197	2024-12-07 19:00:00+00	\N	\N	\N	\N	3.1596	3.1595673348	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
198	2024-12-07 20:00:00+00	\N	\N	\N	\N	3.1618	3.1618464669	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
215	2024-12-07 22:27:03.730911+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112436295	44501970	1723532457000	3957.99	3969.67	19224.26	127939.44	0.15	0.15	0.7	0.58	1	0	2	1	19	4	48	20	2725357.1	544515	1000832
218	2024-12-07 22:48:44.448292+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112436295	44501970	1723532457000	0	3957.99	19224.26	112390.99	0	0.15	0.7	1.2	0	0	1	0	19	4	47	19	2725357.1	544515	1000832
221	2024-12-07 23:09:36.879819+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112435745	44501752	1723532457000	0	3970.54	19236.82	112403.54	0	0.15	0.7	1.2	0	0	2	1	20	5	48	20	2725348.79	544519	1000819
224	2024-12-07 23:33:43.77941+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1671	3.16	112437787	44502561	1723532457000	46.99	59.54	16341.58	101172.04	0	0	0.59	0.75	1	0	2	1	18	4	45	20	2725380.58	544504	1000866
227	2024-12-07 23:52:11.257113+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1671	3.16	112437787	44502561	1723532457000	0	47	16274.64	100882.04	0	0	0.59	0.75	0	0	2	0	14	3	44	20	2725380.58	544504	1000866
230	2024-12-08 00:54:08.033346+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1670	3.16	112436394	44502009	1723532457000	0	91.44	16366.08	100952.99	0	0	0.59	0.75	0	0	1	2	15	5	45	21	2725360.13	544514	1000835
233	2024-12-08 02:47:45.296202+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1340	3.13	111262421	44037354	1723532457000	1939.91	8744.47	32109.27	128757.99	-0.08	-0.3	-0.89	-0.3	0	1	1	4	6	11	46	27	2707494.84	553114	974023
253	2024-12-08 06:00:47.113492+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09123	3.091	109743638	43436224	1723532457000	1.19	243.32	60335.05	156538.49	0	0.01	-2.39	-1.51	1	0	3	0	5	18	47	34	2683948.13	564442	939121
254	2024-12-08 06:09:47.642318+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09123	3.091	109743638	43436224	1723532457000	0	243.32	60306.36	156143.01	0	0.01	-2.39	-1.49	0	0	3	0	5	17	46	34	2683948.13	564442	939121
255	2024-12-08 06:21:14.292076+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09120	3.091	109742310	43435698	1723532457000	0	273.92	60336.97	156173.61	0	0.01	-2.39	-1.49	0	0	3	1	5	18	46	35	2683927.34	564452	939090
256	2024-12-08 06:34:26.900703+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09120	3.091	109742310	43435698	1723532457000	0	32.78	60306.97	155583.31	0	0	-2.4	-0.89	0	0	2	1	4	18	46	34	2683927.34	564452	939090
257	2024-12-08 06:43:54.925124+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09120	3.091	109742310	43435698	1723532457000	0	31.79	60306.97	140097.91	0	0	-2.4	-0.89	0	0	1	1	4	18	46	33	2683927.34	564452	939090
258	2024-12-08 06:51:05.094549+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09120	3.091	109742310	43435698	1723532457000	0	31.79	60306.97	140097.91	0	0	-2.4	-0.89	0	0	1	1	4	18	46	33	2683927.34	564452	939090
259	2024-12-08 06:57:11.201223+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09120	3.091	109742310	43435698	1723532457000	0	31.79	60306.97	140097.91	0	0	-2.4	-0.89	0	0	1	1	4	18	46	33	2683927.34	564452	939090
260	2024-12-08 07:04:31.030631+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09120	3.091	109742311	43435698	1723532457000	0	30.61	60306.98	140097.91	0	0	-2.4	-0.89	1	0	1	1	5	18	47	33	2683927.34	564452	939090
261	2024-12-08 07:13:28.455178+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09120	3.091	109742311	43435698	1723532457000	0	0	60306.98	140097.91	0	0	-2.4	-0.89	0	0	1	0	5	18	47	33	2683927.34	564452	939090
262	2024-12-08 07:23:58.452395+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09120	3.091	109742311	43435698	1723532457000	0	0	60306.98	140018.93	0	0	-2.4	-0.91	0	0	1	0	5	18	46	33	2683927.34	564452	939090
263	2024-12-08 07:30:57.262436+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09120	3.091	109742311	43435698	1723532457000	0	0	60306.98	140018.93	0	0	-2.4	-0.91	0	0	1	0	5	18	46	33	2683927.34	564452	939090
264	2024-12-08 07:37:09.433118+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09012	3.090	109704022	43420544	1723532457000	882.99	883	61189.97	140901.92	-0.03	-0.03	-2.43	-0.94	0	1	1	1	5	19	46	34	2683327.33	564741	938207
265	2024-12-08 07:43:05.226551+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09012	3.090	109704022	43420544	1723532457000	0	883	60872.71	140901.92	0	-0.03	-2.42	-0.94	0	0	1	1	5	18	46	34	2683327.33	564741	938207
266	2024-12-08 07:48:58.313651+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09012	3.090	109704022	43420544	1723532457000	0	883	41945.83	140901.92	0	-0.03	-1.69	-0.94	0	0	1	1	5	16	46	34	2683327.33	564741	938207
267	2024-12-08 07:54:54.939312+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09012	3.090	109704022	43420544	1723532457000	0	883	37592.88	140901.92	0	-0.03	-1.53	-0.94	0	0	1	1	5	15	46	34	2683327.33	564741	938207
268	2024-12-08 08:01:00.359629+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09012	3.090	109704022	43420544	1723532457000	0	883	35729.6	140901.92	0	-0.03	-1.45	-0.94	0	0	1	1	5	13	46	34	2683327.33	564741	938207
269	2024-12-08 08:10:00.037453+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09012	3.090	109704022	43420544	1723532457000	0	882.99	35141.27	140901.92	0	-0.03	-1.48	-0.94	0	0	0	1	4	13	46	34	2683327.33	564741	938207
270	2024-12-08 08:21:14.701601+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09012	3.090	109704022	43420544	1723532457000	0	882.99	35141.27	140901.92	0	-0.03	-1.48	-0.94	0	0	0	1	4	13	46	34	2683327.33	564741	938207
271	2024-12-08 08:32:24.64764+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09012	3.090	109704022	43420544	1723532457000	0	882.99	35141.27	140399.75	0	-0.03	-1.48	-0.96	0	0	0	1	4	13	45	34	2683327.33	564741	938207
272	2024-12-08 08:40:53.90266+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09005	3.090	109701705	43419627	1723532457000	0	53.43	35194.71	140453.19	0	0	-1.48	-0.96	0	0	0	1	4	14	45	35	2683291.02	564758	938154
273	2024-12-08 08:48:17.414745+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09005	3.090	109701705	43419627	1723532457000	0	53.43	33254.79	140017.34	0	0	-1.4	-1.02	0	0	0	1	4	13	44	35	2683291.02	564758	938154
274	2024-12-08 08:54:10.551217+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09005	3.090	109701705	43419627	1723532457000	0	53.43	33254.79	140017.34	0	0	-1.4	-1.02	0	0	0	1	4	13	44	35	2683291.02	564758	938154
275	2024-12-08 08:59:54.728141+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09005	3.090	109701705	43419627	1723532457000	0	53.43	33254.79	140017.34	0	0	-1.4	-1.02	0	0	0	1	4	13	44	35	2683291.02	564758	938154
276	2024-12-08 09:08:08.891947+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09005	3.090	109701705	43419627	1723532457000	0	53.43	33254.79	140017.34	0	0	-1.4	-1.02	0	0	0	1	4	13	44	35	2683291.02	564758	938154
277	2024-12-08 09:18:09.349444+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09274	3.092	109797207	43457426	1723532457000	2204.77	2277.81	35479.18	142241.72	0.09	0.08	-1.32	-0.94	1	0	2	1	6	13	46	35	2684831.55	564046	940378
278	2024-12-08 09:27:21.366097+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09274	3.092	109797207	43457426	1723532457000	0	2277.81	35479.18	142241.72	0	0.08	-1.32	-0.94	0	0	2	1	6	13	46	35	2684831.55	564046	940378
279	2024-12-08 09:34:03.915943+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09274	3.092	109797207	43457426	1723532457000	0	2277.81	32382.16	142241.72	0	0.08	-1.08	-0.94	0	0	2	1	6	12	46	35	2684831.55	564046	940378
280	2024-12-08 09:40:41.142682+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09274	3.092	109797207	43457426	1723532457000	0	2224.38	32382.16	142241.72	0	0.09	-1.08	-0.94	0	0	2	0	6	12	46	35	2684831.55	564046	940378
281	2024-12-08 09:46:39.596739+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09274	3.092	109797207	43457426	1723532457000	0	2224.38	18307.36	140691.72	0	0.09	-0.53	-1	0	0	2	0	6	8	45	35	2684831.55	564046	940378
282	2024-12-08 09:52:38.029021+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09274	3.092	109797207	43457426	1723532457000	0	2224.38	11299.11	140691.72	0	0.09	-0.25	-1	0	0	2	0	6	7	45	35	2684831.55	564046	940378
283	2024-12-08 09:58:30.345701+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09274	3.092	109797207	43457426	1723532457000	0	2224.38	4310.18	140691.72	0	0.09	0.02	-1	0	0	2	0	6	4	45	35	2684831.55	564046	940378
284	2024-12-08 10:06:52.298605+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09263	3.092	109793101	43455801	1723532457000	0	2319.04	4404.84	139262.24	0	0.08	0.02	-0.98	0	0	2	1	6	5	44	36	2684767.26	564077	940284
285	2024-12-08 10:16:52.377097+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09263	3.092	109793101	43455801	1723532457000	0	94.66	4404.84	139262.24	0	0	0.02	-0.98	0	0	0	1	6	5	44	36	2684767.26	564077	940284
286	2024-12-08 10:28:09.843103+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09263	3.092	109793101	43455801	1723532457000	0	94.66	3529.4	139262.24	0	0	0.05	-0.98	0	0	0	1	6	4	44	36	2684767.26	564077	940284
287	2024-12-08 10:37:27.624088+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09263	3.092	109793101	43455801	1723532457000	0	94.66	3529.4	139262.24	0	0	0.05	-0.98	0	0	0	1	6	4	44	36	2684767.26	564077	940284
288	2024-12-08 10:44:14.054337+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09276	3.092	109797739	43457637	1723532457000	108.01	202.67	3637.42	139370.26	0	0	0.06	-0.98	1	0	1	1	7	4	45	36	2684842.04	564042	940392
289	2024-12-08 10:50:00.975711+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09276	3.092	109797739	43457637	1723532457000	0	202.67	3637.42	138983.72	0	0	0.06	-0.98	0	0	1	1	7	4	45	35	2684842.04	564042	940392
290	2024-12-08 10:56:02.455978+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09276	3.092	109797739	43457637	1723532457000	0	202.67	3637.42	138983.72	0	0	0.06	-0.98	0	0	1	1	7	4	45	35	2684842.04	564042	940392
291	2024-12-08 11:02:34.84835+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09276	3.092	109797739	43457637	1723532457000	0	108.01	3637.42	138983.72	0	0	0.06	-0.98	0	0	1	0	7	4	45	35	2684842.04	564042	940392
292	2024-12-08 11:11:33.236061+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09276	3.092	109797739	43457637	1723532457000	0	108.01	3637.42	138983.72	0	0	0.06	-0.98	0	0	1	0	7	4	45	35	2684842.04	564042	940392
293	2024-12-08 11:19:38.40312+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09276	3.092	109797739	43457637	1723532457000	0	108.01	3637.42	138983.72	0	0	0.06	-0.98	0	0	1	0	7	4	45	35	2684842.04	564042	940392
294	2024-12-08 11:26:16.752313+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09285	3.092	109801201	43459007	1723532457000	0	188.62	3718.03	139064.32	0	0.01	0.06	-0.98	0	0	3	0	9	4	47	35	2684897.85	564017	940472
295	2024-12-08 11:32:25.080965+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09576	3.095	109904294	43499811	1723532457000	2400.07	2588.69	6118.1	141464.4	0.09	0.1	0.16	-0.88	2	0	5	0	11	4	49	35	2686558.59	563249	942872
296	2024-12-08 11:38:41.333388+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09576	3.095	109904294	43499811	1723532457000	0	2588.69	5876.96	141464.4	0	0.1	0.15	-0.88	0	0	5	0	10	4	49	35	2686558.59	563249	942872
297	2024-12-08 11:44:22.435845+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09576	3.095	109904294	43499811	1723532457000	0	2480.68	5875.97	141433.47	0	0.1	0.15	-0.9	0	0	4	0	9	4	49	34	2686558.59	563249	942872
298	2024-12-08 11:50:20.888786+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09576	3.095	109904294	43499811	1723532457000	0	2480.68	5875.97	141433.47	0	0.1	0.15	-0.9	0	0	4	0	9	4	49	34	2686558.59	563249	942872
299	2024-12-08 11:56:01.855487+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09389	3.093	109837821	43473501	1723532457000	1531.93	4012.61	7407.91	142536.73	-0.06	0.04	0.09	-0.96	0	1	4	1	9	5	48	35	2685518.96	563749	941340
300	2024-12-08 12:04:17.235801+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09389	3.093	109837821	43473501	1723532457000	0	4012.61	7406.72	142489.96	0	0.04	0.09	-0.96	0	0	4	1	8	5	47	35	2685518.96	563749	941340
301	2024-12-08 12:14:34.608428+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09389	3.093	109837821	43473501	1723532457000	0	4012.61	7376.12	142479.99	0	0.04	0.09	-0.82	0	0	4	1	8	4	46	35	2685518.96	563749	941340
302	2024-12-08 12:28:39.238281+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09688	3.096	109944304	43515647	1723532457000	2478.56	6410.57	9854.68	144958.56	0.1	0.13	0.18	-0.73	2	0	4	1	10	4	48	35	2687233.47	562956	943819
303	2024-12-08 12:47:21.226404+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09686	3.096	109943453	43515310	1723532457000	0	4030.12	9874.31	144978.18	0	0.04	0.18	-0.73	0	0	2	2	10	5	48	36	2687220.16	562962	943799
304	2024-12-08 13:00:49.876758+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09686	3.096	109943453	43515310	1723532457000	0	2498.18	9874.31	141426.75	0	0.1	0.18	-0.88	0	0	2	1	10	5	48	35	2687220.16	562962	943799
305	2024-12-08 13:12:37.605559+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09687	3.096	109943795	43515445	1723532457000	0	2506.15	9882.26	141434.72	0	0.1	0.18	-0.88	0	0	3	1	10	5	49	35	2687225.67	562960	943807
306	2024-12-08 13:24:39.820654+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09687	3.096	109943795	43515445	1723532457000	0	207.96	9882.26	137327.41	0	0.01	0.18	-1	0	0	2	1	10	5	47	35	2687225.67	562960	943807
307	2024-12-08 13:33:56.793126+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09687	3.096	109943795	43515445	1723532457000	0	27.58	8999.27	134366.96	0	0	0.22	-0.86	0	0	1	1	10	4	46	35	2687225.67	562960	943807
308	2024-12-08 13:40:56.688422+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09687	3.096	109943795	43515445	1723532457000	0	7.96	8999.27	134366.96	0	0	0.22	-0.86	0	0	1	0	10	4	46	35	2687225.67	562960	943807
309	2024-12-08 13:46:50.993663+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09687	3.096	109943795	43515445	1723532457000	0	7.96	8999.27	126945.32	0	0	0.22	-0.65	0	0	1	0	10	4	46	33	2687225.67	562960	943807
310	2024-12-08 13:52:52.922332+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09687	3.096	109943795	43515445	1723532457000	0	7.96	8999.27	122009.56	0	0	0.22	-0.52	0	0	1	0	10	4	46	31	2687225.67	562960	943807
311	2024-12-08 13:58:39.29008+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09687	3.096	109943795	43515445	1723532457000	0	7.96	8999.27	122009.56	0	0	0.22	-0.52	0	0	1	0	10	4	46	31	2687225.67	562960	943807
312	2024-12-08 14:06:21.001324+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09689	3.096	109944390	43515681	1723532457000	0	13.84	9013.11	121918.51	0	0	0.22	-0.6	0	0	1	0	11	4	45	31	2687235.24	562955	943821
313	2024-12-08 14:15:32.700488+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09737	3.097	109961491	43522449	1723532457000	397.94	411.78	9411.05	122316.45	0.02	0.02	0.23	-0.59	1	0	2	0	12	4	46	31	2687510.36	562828	944219
314	2024-12-08 14:25:44.528738+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09737	3.097	109961491	43522449	1723532457000	0	411.78	9411.05	122316.45	0	0.02	0.23	-0.59	0	0	2	0	12	4	46	31	2687510.36	562828	944219
315	2024-12-08 14:33:58.292001+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09743	3.097	109963630	43523296	1723532457000	49.78	461.57	9460.84	120300.49	0	0.02	0.24	-0.59	1	0	3	0	13	4	46	31	2687544.78	562812	944269
316	2024-12-08 14:40:50.509406+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09743	3.097	109963630	43523296	1723532457000	0	461.57	9407.41	120300.49	0	0.02	0.24	-0.59	0	0	3	0	13	3	46	31	2687544.78	562812	944269
317	2024-12-08 14:46:35.601601+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09741	3.097	109963098	43523085	1723532457000	12.26	473.83	9419.67	120312.76	0	0.02	0.24	-0.59	0	1	3	1	13	4	46	32	2687536.47	562816	944256
318	2024-12-08 14:52:47.682339+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09741	3.097	109963098	43523085	1723532457000	0	473.83	9419.67	120312.76	0	0.02	0.24	-0.59	0	0	3	1	13	4	46	32	2687536.47	562816	944256
319	2024-12-08 14:58:24.600543+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09741	3.097	109963098	43523085	1723532457000	0	473.83	9419.67	120232.78	0	0.02	0.24	-0.66	0	0	3	1	13	4	45	32	2687536.47	562816	944256
320	2024-12-08 15:06:07.744422+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09741	3.097	109963098	43523085	1723532457000	0	459.99	9419.67	118235.67	0	0.02	0.24	-1.48	0	0	2	1	13	4	44	32	2687536.47	562816	944256
321	2024-12-08 15:15:43.807714+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08620	3.086	109564841	43365456	1723532457000	0	9244.71	18582.73	106217.06	0	-0.36	-0.13	-1.91	0	0	1	2	12	5	43	33	2681298.71	565816	935074
322	2024-12-08 15:27:07.384312+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08248	3.082	109432811	43313199	1723532457000	396.05	12292.62	19425.86	107266.15	-0.02	-0.48	-0.33	-2.03	0	2	1	8	11	11	42	39	2679223.38	566814	932026
323	2024-12-08 15:34:43.472239+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08248	3.082	109432811	43313199	1723532457000	0	12242.83	19425.86	107235.8	0	-0.48	-0.33	-1.92	0	0	0	8	11	11	41	39	2679223.38	566814	932026
324	2024-12-08 15:42:03.117645+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08249	3.082	109433324	43313402	1723532457000	11.95	12254.78	19437.81	107247.75	0	-0.48	-0.33	-1.92	1	0	1	8	12	11	42	39	2679231.68	566811	932038
325	2024-12-08 15:47:58.050443+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08249	3.082	109433324	43313402	1723532457000	0	12242.52	19437.81	107247.75	0	-0.48	-0.33	-1.92	0	0	1	7	12	11	42	39	2679231.68	566811	932038
326	2024-12-08 15:54:00.699748+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08249	3.082	109433324	43313402	1723532457000	0	12242.52	19437.81	107247.75	0	-0.48	-0.33	-1.92	0	0	1	7	12	11	42	39	2679231.68	566811	932038
327	2024-12-08 15:59:56.669019+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08266	3.082	109439450	43315827	1723532457000	142.9	12385.42	19580.72	104422.38	0.01	-0.48	-0.33	-1.99	1	0	2	7	13	11	43	38	2679330.92	566765	932181
328	2024-12-08 16:08:24.426453+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08266	3.082	109439450	43315827	1723532457000	0	3202.76	19486.05	104422.38	0	-0.11	-0.32	-1.99	0	0	2	6	13	10	43	38	2679330.92	566765	932181
329	2024-12-08 16:18:57.394429+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08448	3.084	109503842	43341313	1723532457000	1501.67	4704.44	20987.73	103925.45	0.06	-0.06	-0.26	-1.94	1	0	3	6	14	10	43	38	2680373.48	566283	933682
330	2024-12-08 16:30:39.561426+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08448	3.084	109503842	43341313	1723532457000	0	1656.53	20987.73	103925.45	0	0.06	-0.26	-1.94	0	0	3	0	14	10	43	38	2680373.48	566283	933682
331	2024-12-08 16:40:00.410566+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08448	3.084	109503842	43341313	1723532457000	0	1656.53	20987.73	103925.45	0	0.06	-0.26	-1.94	0	0	3	0	14	10	43	38	2680373.48	566283	933682
332	2024-12-08 16:47:21.691598+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08424	3.084	109495435	43337986	1723532457000	194.07	1838.65	21073.79	104119.52	-0.01	0.06	-0.28	-1.95	0	1	2	1	13	11	43	39	2680241.34	566346	933488
333	2024-12-08 16:53:10.851135+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08424	3.084	109495435	43337986	1723532457000	0	1838.66	21073.79	104119.53	0	0.06	-0.28	-1.95	0	0	3	1	14	11	44	39	2680241.34	566346	933488
334	2024-12-08 16:58:58.9901+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08485	3.084	109516911	43346486	1723532457000	0	2196.51	21574.55	104620.29	0	0.07	-0.26	-1.93	0	0	3	1	15	11	45	39	2680588.9	566185	933989
335	2024-12-08 17:06:50.163495+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08479	3.084	109514794	43345648	1723532457000	0	2245.38	21623.42	104669.15	0	0.07	-0.26	-1.93	0	0	3	2	15	12	45	40	2680555.63	566201	933940
336	2024-12-08 17:15:51.42889+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08479	3.084	109514794	43345648	1723532457000	0	743.7	21623.42	104085.82	0	0.01	-0.26	-2.03	0	0	2	2	15	12	43	40	2680555.63	566201	933940
337	2024-12-08 17:25:27.509165+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08479	3.084	109514794	43345648	1723532457000	0	743.7	21542.81	101828.56	0	0.01	-0.26	-2.02	0	0	2	2	13	12	42	40	2680555.63	566201	933940
338	2024-12-08 17:32:51.165321+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08479	3.084	109514794	43345648	1723532457000	0	743.7	19142.74	101726.92	0	0.01	-0.35	-2.03	0	0	2	2	11	12	42	39	2680555.63	566201	933940
339	2024-12-08 17:39:36.127229+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08471	3.084	109512073	43344571	1723532457000	62.81	806.52	19205.55	101789.74	0	0.01	-0.36	-2.03	0	1	2	3	11	13	42	40	2680512.87	566222	933877
340	2024-12-08 17:45:12.724142+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08471	3.084	109512073	43344571	1723532457000	0	612.44	19205.55	101748.68	0	0.02	-0.36	-2.03	0	0	2	2	11	13	39	40	2680512.87	566222	933877
341	2024-12-08 17:51:12.553278+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08471	3.084	109512073	43344571	1723532457000	0	612.44	19205.55	101722.8	0	0.02	-0.36	-2.06	0	0	1	2	11	13	38	39	2680512.87	566222	933877
342	2024-12-08 17:57:11.044632+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08471	3.084	109512073	43344571	1723532457000	0	111.68	17673.62	101722.8	0	0	-0.3	-2.06	0	0	0	2	11	12	38	39	2680512.87	566222	933877
343	2024-12-08 18:05:48.947774+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08519	3.085	109528975	43351261	1723532457000	0	456.91	18067.71	102116.89	0	0.01	-0.28	-2.05	0	0	1	1	12	12	39	39	2680786.36	566096	934272
344	2024-12-08 18:15:57.927295+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08519	3.085	109528975	43351261	1723532457000	0	456.91	18067.71	102116.89	0	0.01	-0.28	-2.05	0	0	1	1	12	12	39	39	2680786.36	566096	934272
345	2024-12-08 18:28:59.686212+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08396	3.083	109485321	43333982	1723532457000	1007.73	1464.64	16596.88	103124.62	-0.04	-0.03	-0.42	-2.09	0	1	1	2	10	13	39	40	2680100.23	566426	933264
346	2024-12-08 18:39:18.230589+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1006	3.10	110078784	43568874	1723532457000	13820.63	15222.46	30417.51	116945.26	0.54	0.52	0.12	-1.56	1	0	2	1	11	13	40	40	2689670.1	562001	947084
347	2024-12-08 18:46:49.871957+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09478	3.094	109869678	43486110	1723532457000	8706.17	23928.64	39104.07	125651.44	-0.19	0.33	-0.07	-1.74	1	1	3	2	12	13	41	41	2686443.01	563578	942287
348	2024-12-08 18:52:30.663905+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09478	3.094	109869678	43486110	1723532457000	0	23928.64	39104.07	125651.44	0	0.33	-0.07	-1.74	0	0	3	2	12	13	41	41	2686443.01	563578	942287
349	2024-12-08 18:58:29.911914+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09478	3.094	109869678	43486110	1723532457000	0	23928.64	39104.07	125651.44	0	0.33	-0.07	-1.74	0	0	3	2	12	13	41	41	2686443.01	563578	942287
350	2024-12-08 19:06:07.3884+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1170	3.11	110658288	43798240	1723532457000	0	41860.84	57422.4	143977.74	0	1.03	0.65	-1.04	0	0	3	2	12	13	42	41	2699080.27	557736	960614
351	2024-12-08 19:14:48.439552+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1160	3.11	110624676	43784936	1723532457000	771.98	42632.82	58194.39	144749.72	-0.03	1	0.62	-1.07	0	1	3	3	12	14	42	42	2698559.91	557986	959842
352	2024-12-08 19:21:55.658764+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1161	3.11	110626441	43785635	1723532457000	0	42673.77	58235.34	135309.18	0	1	0.62	-1.37	0	0	4	3	13	14	40	42	2698588.06	557973	959883
353	2024-12-08 19:27:48.301945+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1161	3.11	110626441	43785635	1723532457000	0	41666.04	58235.34	134793.84	0	1.04	0.62	-1.38	0	0	4	2	13	14	40	41	2698588.06	557973	959883
354	2024-12-08 19:34:08.881921+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1161	3.11	110626441	43785635	1723532457000	0	41666.04	58235.34	134793.84	0	1.04	0.62	-1.38	0	0	4	2	13	14	40	41	2698588.06	557973	959883
355	2024-12-08 19:39:54.628886+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1161	3.11	110626441	43785635	1723532457000	0	27845.4	58235.34	134793.84	0	0.5	0.62	-1.38	0	0	3	2	13	14	40	41	2698588.06	557973	959883
356	2024-12-08 19:45:39.916953+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1161	3.11	110626441	43785635	1723532457000	0	19139.23	58235.34	134743.84	0	0.69	0.62	-1.41	0	0	2	1	13	14	39	41	2698588.06	557973	959883
357	2024-12-08 19:51:42.624476+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1161	3.11	110626441	43785635	1723532457000	0	19139.23	58235.34	134743.84	0	0.69	0.62	-1.41	0	0	2	1	13	14	39	41	2698588.06	557973	959883
358	2024-12-08 19:57:37.659449+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1161	3.11	110626441	43785635	1723532457000	0	19139.23	58235.34	134743.84	0	0.69	0.62	-1.41	0	0	2	1	13	14	39	41	2698588.06	557973	959883
359	2024-12-08 20:05:49.665039+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1168	3.11	110652240	43795846	1723532457000	598.53	1411.46	58820.03	135342.37	0.02	-0.01	0.64	-1.39	1	0	2	1	13	14	40	41	2698999.45	557783	960481
360	2024-12-08 20:15:29.626979+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1168	3.11	110652240	43796219	1723532457000	0	639.48	58422.08	133478.37	0	0.02	0.63	-1.42	0	0	2	0	12	14	38	41	2698999.45	557783	960481
361	2024-12-08 20:26:56.138795+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1168	3.11	110652240	43796219	1723532457000	0	598.53	58422.08	133430.96	0	0.02	0.63	-1.43	0	0	1	0	12	14	36	41	2698999.45	557783	960481
362	2024-12-08 20:33:32.211729+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1168	3.11	110652240	43796219	1723532457000	0	598.53	58372.3	133430.96	0	0.02	0.63	-1.43	0	0	1	0	11	14	36	41	2698999.45	557783	960481
363	2024-12-08 20:41:06.312926+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1168	3.11	110652240	43796219	1723532457000	0	598.53	58372.3	133232.24	0	0.02	0.63	-1.44	0	0	1	0	11	14	35	41	2698999.45	557783	960481
364	2024-12-08 20:46:56.19805+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1168	3.11	110652240	43796219	1723532457000	0	598.53	58360.03	133143.79	0	0.02	0.63	-1.44	0	0	1	0	11	13	34	41	2698999.45	557783	960481
365	2024-12-08 20:52:35.613808+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1168	3.11	110652240	43795846	1723532457000	0	598.53	58360.03	133143.79	0	0.02	0.63	-1.44	0	0	1	0	11	13	34	41	2698999.45	557783	960481
366	2024-12-08 20:58:31.440149+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1168	3.11	110652240	43796219	1723532457000	0	598.53	58360.03	133143.79	0	0.02	0.63	-1.44	0	0	1	0	11	13	34	41	2698999.45	557783	960481
367	2024-12-08 21:06:22.464425+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1168	3.11	110652240	43796219	1723532457000	0	0	58360.03	133143.79	0	0	0.63	-1.44	0	0	0	0	11	13	34	41	2698999.45	557783	960481
368	2024-12-08 21:15:36.133939+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1176	3.11	110682302	43808118	1723532457000	697.35	697.35	49874.72	133841.14	0.03	0.03	1.02	-1.41	1	0	1	0	12	12	35	41	2699478.65	557562	961178
369	2024-12-08 21:24:28.068947+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1176	3.11	110682302	43808118	1723532457000	0	697.35	46826.82	133841.14	0	0.03	1.14	-1.41	0	0	1	0	12	6	35	41	2699478.65	557562	961178
370	2024-12-08 21:30:33.998317+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1176	3.11	110682302	43808118	1723532457000	0	697.35	46826.82	133841.14	0	0.03	1.14	-1.41	0	0	1	0	12	6	35	41	2699478.65	557562	961178
371	2024-12-08 21:36:48.660837+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1176	3.11	110682302	43808118	1723532457000	0	697.35	46826.82	133841.14	0	0.03	1.14	-1.41	0	0	1	0	12	6	35	41	2699478.65	557562	961178
372	2024-12-08 21:42:32.107965+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1176	3.11	110682302	43808118	1723532457000	0	697.35	46814.86	133829.48	0	0.03	1.14	-1.41	0	0	1	0	11	6	35	40	2699478.65	557562	961178
373	2024-12-08 21:48:31.187224+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1176	3.11	110682302	43808118	1723532457000	0	697.35	46814.86	133829.46	0	0.03	1.14	-1.56	0	0	1	0	11	6	34	40	2699478.65	557562	961178
374	2024-12-08 21:54:30.319026+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1176	3.11	110682302	43807744	1723532457000	0	697.35	46814.86	133829.46	0	0.03	1.14	-1.56	0	0	1	0	11	6	34	40	2699478.65	557562	961178
375	2024-12-08 22:00:24.111019+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1176	3.11	110682710	43807906	1723532457000	9.45	706.8	46681.41	133838.92	0	0.03	1.14	-1.56	1	0	2	0	11	6	35	40	2699485.14	557559	961188
376	2024-12-08 22:08:35.333654+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1176	3.11	110682710	43808279	1723532457000	0	706.8	46681.41	133838.92	0	0.03	1.14	-1.56	0	0	2	0	11	6	35	40	2699485.14	557559	961188
377	2024-12-08 22:18:22.780029+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1031	3.10	110167045	43604179	1723532457000	0	11864.8	57035.09	145694.27	0	-0.47	0.61	-2.02	0	0	1	1	10	7	35	41	2691478.34	561409	949333
378	2024-12-08 22:28:59.081092+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1049	3.10	110230810	43629417	1723532457000	0	13347.1	58517.39	143218.57	0	-0.41	0.66	-1.96	0	0	2	1	11	7	35	41	2692501.09	560936	950815
379	2024-12-08 22:37:15.643729+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	101.09	14084.59	59254.87	143956.06	0	-0.39	0.68	-1.94	0	1	3	2	12	8	36	42	2692871.63	560766	951350
380	2024-12-08 22:43:42.076351+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	14084.59	59060.8	143956.06	0	-0.39	0.69	-1.94	0	0	3	2	12	7	36	42	2692871.63	560766	951350
381	2024-12-08 22:49:25.069842+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	14084.59	59060.79	143943.52	0	-0.39	0.69	-1.94	0	0	3	2	11	7	36	41	2692871.63	560766	951350
382	2024-12-08 22:55:20.797724+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	14084.59	58560.03	143943.52	0	-0.39	0.67	-1.94	0	0	3	2	10	7	36	41	2692871.63	560766	951350
383	2024-12-08 23:01:50.927285+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	14075.13	58511.17	143943.52	0	-0.39	0.67	-1.94	0	0	2	2	10	6	36	41	2692871.63	560766	951350
384	2024-12-08 23:10:21.814526+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	14075.13	58511.17	143943.51	0	-0.39	0.67	-1.94	0	0	2	2	10	6	35	41	2692871.63	560766	951350
385	2024-12-08 23:20:35.438377+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	2219.78	58511.17	143943.51	0	0.08	0.67	-1.94	0	0	2	1	10	6	35	41	2692871.63	560766	951350
386	2024-12-08 23:28:34.203929+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	737.48	58511.17	143943.51	0	0.02	0.67	-1.94	0	0	1	1	10	6	35	41	2692871.63	560766	951350
387	2024-12-08 23:35:08.196881+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	0	58511.17	143896.51	0	0	0.67	-1.94	0	0	0	0	10	6	34	41	2692871.63	560766	951350
388	2024-12-08 23:41:17.514952+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	0	58448.35	143896.51	0	0	0.68	-1.94	0	0	0	0	10	5	34	41	2692871.63	560766	951350
389	2024-12-08 23:47:00.870679+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	0	58448.35	143896.51	0	0	0.68	-1.94	0	0	0	0	10	5	34	41	2692871.63	560766	951350
390	2024-12-08 23:52:58.179669+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	0	58448.35	143896.51	0	0	0.68	-1.94	0	0	0	0	10	5	34	41	2692871.63	560766	951350
391	2024-12-08 23:59:00.617792+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1056	3.10	110253797	43638515	1723532457000	0	0	58448.35	143863.75	0	0	0.68	-1.94	0	0	0	0	10	5	34	40	2692871.63	560766	951350
392	2024-12-09 00:34:33.930903+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1058	3.10	110261024	43641375	1723532457000	99.43	601.67	57648.19	144406.73	0	0.01	0.71	-1.92	1	0	2	1	11	5	35	40	2692991.81	560713	951520
393	2024-12-09 00:59:35.08004+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09583	3.095	109906913	43501218	1723532457000	0	8468.34	43274.52	152559.88	0	-0.33	0.03	-2.24	0	0	1	2	9	5	35	41	2687468.08	563369	943367
394	2024-12-09 01:36:06.656949+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09583	3.095	109906913	43501218	1723532457000	0	8153.14	24135.29	152559.88	0	-0.32	-0.65	-2.24	0	0	0	1	7	4	35	41	2687468.08	563369	943367
395	2024-12-09 02:16:04.14017+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09584	3.095	109907342	43501388	1723532457000	0	9.99	23546.75	126521.18	0	0	-0.67	-1.22	0	0	1	0	7	4	35	35	2687474.99	563366	943377
396	2024-12-09 02:47:44.071249+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09477	3.094	109869178	43486283	1723532457000	0	889.46	24426.22	125460.73	0	-0.03	-0.71	-1.01	0	0	1	1	7	5	35	35	2686878.09	563653	942498
397	2024-12-09 03:11:45.503739+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08719	3.087	109600063	43379767	1723532457000	0	7085.29	30632.05	131666.56	0	-0.28	-0.95	-1.25	0	0	0	4	7	8	35	38	2682660.4	565681	936292
398	2024-12-09 03:29:00.403659+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08719	3.087	109600063	43379767	1723532457000	0	6205.82	29934.69	128569.54	0	-0.24	-0.98	-0.87	0	0	0	3	6	8	35	37	2682660.4	565681	936292
399	2024-12-09 03:44:13.485571+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08570	3.085	109547100	43358804	1723532457000	1222.23	7428.05	31156.93	119931.23	-0.05	-0.29	-1.03	-0.89	0	1	0	4	6	9	35	37	2681828.54	566081	935070
400	2024-12-09 03:54:16.885045+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08570	3.085	109547100	43358804	1723532457000	0	1246.68	31156.93	108008.96	0	-0.05	-1.03	-0.38	0	0	0	2	6	9	35	32	2681828.54	566081	935070
401	2024-12-09 04:00:03.602289+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08570	3.085	109547100	43358804	1723532457000	0	1246.68	31147.47	101719.79	0	-0.05	-1.03	-0.17	0	0	0	2	5	9	35	30	2681828.54	566081	935070
402	2024-12-09 04:10:05.506537+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08532	3.085	109533866	43353566	1723532457000	0	1527.69	31452.94	102025.26	0	-0.06	-1.04	-0.18	0	0	0	2	5	10	35	31	2681620.57	566181	934764
403	2024-12-09 04:21:28.269221+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08532	3.085	109533866	43353566	1723532457000	0	1527.69	18115.29	102025.26	0	-0.06	-0.63	-0.18	0	0	0	2	4	9	35	31	2681620.57	566181	934764
404	2024-12-09 04:33:29.400337+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08439	3.084	109500696	43340437	1723532457000	765.65	2293.35	18244.56	101915.48	0	-0.09	-0.69	-0.22	0	1	0	3	3	10	35	31	2681099.2	566432	933998
405	2024-12-09 04:42:41.166725+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08439	3.084	109500696	43340437	1723532457000	0	1071.12	18143.46	101915.48	0	-0.04	-0.68	-0.22	0	0	0	2	3	9	35	31	2681099.2	566432	933998
406	2024-12-09 04:50:10.986426+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08430	3.084	109497389	43339128	1723532457000	0	1147.46	18219.8	101991.82	0	-0.05	-0.69	-0.22	0	0	0	3	3	10	35	32	2681047.2	566457	933922
407	2024-12-09 04:56:01.312885+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08430	3.084	109497389	43339128	1723532457000	0	1147.46	18219.8	101991.82	0	-0.05	-0.69	-0.22	0	0	0	3	3	10	35	32	2681047.2	566457	933922
408	2024-12-09 05:03:26.225521+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08430	3.084	109497389	43339128	1723532457000	0	841.99	18219.8	101991.82	0	-0.03	-0.69	-0.22	0	0	0	2	3	10	35	32	2681047.2	566457	933922
409	2024-12-09 05:12:53.726223+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08430	3.084	109497389	43339128	1723532457000	0	841.99	18219.8	101991.82	0	-0.03	-0.69	-0.22	0	0	0	2	3	10	35	32	2681047.2	566457	933922
410	2024-12-09 05:24:02.432689+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08430	3.084	109497389	43339128	1723532457000	0	841.99	18219.8	101991.82	0	-0.03	-0.69	-0.22	0	0	0	2	3	10	35	32	2681047.2	566457	933922
411	2024-12-09 05:33:58.194379+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08470	3.084	109511720	43344801	1723532457000	0	410.49	18553.96	102084.84	0	0.01	-0.67	-0.21	0	0	1	1	4	10	35	32	2681279.18	566349	934256
412	2024-12-09 05:41:54.217231+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08470	3.084	109511720	43344801	1723532457000	0	410.49	18553.96	102083.85	0	0.01	-0.67	-0.21	0	0	1	1	4	10	34	32	2681279.18	566349	934256
413	2024-12-09 05:47:50.463031+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08470	3.084	109511720	43344801	1723532457000	0	334.15	18553.96	102083.85	0	0.01	-0.67	-0.21	0	0	1	0	4	10	34	32	2681279.18	566349	934256
414	2024-12-09 05:53:44.64594+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08470	3.084	109511720	43344801	1723532457000	0	334.15	18553.96	102083.85	0	0.01	-0.67	-0.21	0	0	1	0	4	10	34	32	2681279.18	566349	934256
415	2024-12-09 05:59:40.785902+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08470	3.084	109511720	43344801	1723532457000	0	334.15	18267.49	102082.66	0	0.01	-0.68	-0.21	0	0	1	0	3	10	33	32	2681279.18	566349	934256
416	2024-12-09 06:11:12.761757+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08470	3.084	109511720	43344801	1723532457000	0	334.15	18267.49	102082.66	0	0.01	-0.68	-0.21	0	0	1	0	3	10	33	32	2681279.18	566349	934256
417	2024-12-09 06:23:23.773902+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08470	3.084	109511720	43344801	1723532457000	0	334.15	18051.72	102052.05	0	0.01	-0.68	-0.21	0	0	1	0	3	9	33	31	2681279.18	566349	934256
418	2024-12-09 06:37:44.701927+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08470	3.084	109511720	43344801	1723532457000	0	0	17952.29	102052.05	0	0	-0.68	-0.21	0	0	0	0	2	9	33	31	2681279.18	566349	934256
419	2024-12-09 06:48:16.526055+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08470	3.084	109511720	43344801	1723532457000	0	0	9799.14	102052.05	0	0	-0.36	-0.21	0	0	0	0	2	8	33	31	2681279.18	566349	934256
420	2024-12-09 06:55:14.893631+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08470	3.084	109511720	43344801	1723532457000	0	0	9799.14	102052.05	0	0	-0.36	-0.21	0	0	0	0	2	8	33	31	2681279.18	566349	934256
421	2024-12-09 07:01:41.505845+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08505	3.085	109524119	43349708	1723532457000	0	289.1	10088.25	102341.16	0	0.01	-0.35	-0.2	0	0	1	0	3	8	34	31	2681479.86	566257	934545
422	2024-12-09 07:10:41.720984+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08333	3.083	109463237	43325611	1723532457000	0	1694.6	11493.75	103746.65	0	-0.04	-0.4	-0.22	0	0	1	1	3	9	33	32	2680522.58	566717	933140
423	2024-12-09 07:21:44.14921+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08305	3.083	109453154	43321620	1723532457000	232.8	1927.4	11726.55	103979.46	-0.01	-0.05	-0.41	-0.23	0	1	1	2	3	10	33	33	2680363.97	566793	932907
424	2024-12-09 07:30:48.971083+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08310	3.083	109454876	43322301	1723532457000	40.14	1967.55	11766.7	104019.6	0	-0.05	-0.41	-0.23	1	0	2	2	4	10	34	33	2680391.85	566780	932947
425	2024-12-09 07:37:55.961751+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08310	3.083	109454876	43322301	1723532457000	0	1967.55	11766.7	103136.61	0	-0.05	-0.41	-0.23	0	0	2	2	4	10	34	32	2680391.85	566780	932947
426	2024-12-09 07:43:50.241694+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08310	3.083	109454876	43322301	1723532457000	0	1967.55	11766.7	103136.61	0	-0.05	-0.41	-0.23	0	0	2	2	4	10	34	32	2680391.85	566780	932947
427	2024-12-09 07:49:53.201855+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08310	3.083	109454876	43322301	1723532457000	0	1967.55	11766.7	103136.61	0	-0.05	-0.41	-0.23	0	0	2	2	4	10	34	32	2680391.85	566780	932947
428	2024-12-09 07:55:48.46341+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08198	3.081	109415097	43306557	1723532457000	918.56	2597.02	12675.27	104055.18	-0.04	-0.1	-0.45	-0.26	0	2	1	4	3	12	34	34	2679765.89	567081	932029
429	2024-12-09 08:03:30.970308+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08198	3.081	109415097	43306557	1723532457000	0	2597.02	12675.27	104055.18	0	-0.1	-0.45	-0.26	0	0	1	4	3	12	34	34	2679765.89	567081	932029
430	2024-12-09 08:13:34.137814+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1033	3.10	110172866	43606483	1723532457000	17035.84	18837.62	30321.38	121701.28	0.67	0.65	0.24	0.43	3	0	5	3	7	12	38	34	2691986.16	561433	949675
431	2024-12-09 08:26:23.184793+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1054	3.10	110247843	43636158	1723532457000	0	20307.52	31184.76	123444.14	0	0.72	0.34	0.5	0	0	7	2	10	11	41	34	2693188.71	560877	951418
432	2024-12-09 08:38:36.960893+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1050	3.10	110235447	43631252	1723532457000	0	20592.74	31469.98	123675.92	0	0.71	0.33	0.49	0	0	7	3	10	12	41	34	2692995.73	560970	951132
433	2024-12-09 08:48:11.166414+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1038	3.10	110190196	43613342	1723532457000	0	21634.08	32511.32	124717.26	0	0.67	0.29	0.44	0	0	7	4	10	13	41	35	2692291.02	561308	950091
434	2024-12-09 08:55:17.765369+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1039	3.10	110196302	43615759	1723532457000	141.94	20857.46	26471.89	124859.2	0.01	0.71	0.54	0.45	1	0	8	2	11	11	42	35	2692388.97	561263	950233
435	2024-12-09 09:01:58.155729+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1042	3.10	110204961	43619186	1723532457000	0	21058.73	26673.16	125060.48	0	0.72	0.55	0.46	0	0	9	2	12	11	43	35	2692527.86	561199	950434
436	2024-12-09 09:11:01.135031+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1042	3.10	110204961	43619186	1723532457000	0	4210.58	26648.71	125040.87	0	0.06	0.55	0.37	0	0	6	2	12	10	42	35	2692527.86	561199	950434
437	2024-12-09 09:22:24.859047+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1042	3.10	110207277	43620103	1723532457000	0	1723.63	26702.57	122889.95	0	-0.04	0.55	0.38	0	0	3	2	13	10	42	35	2692565.02	561182	950488
438	2024-12-09 09:32:44.460791+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1042	3.10	110207277	43620103	1723532457000	0	1438.41	26702.57	122889.95	0	-0.03	0.55	0.38	0	0	3	1	13	10	42	35	2692565.02	561182	950488
439	2024-12-09 09:40:47.477758+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1024	3.10	110140534	43593686	1723532457000	0	1933.23	28238.73	124426.11	0	-0.05	0.49	0.32	0	0	3	1	13	11	42	36	2691525.04	561682	948952
440	2024-12-09 09:46:59.488669+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1024	3.10	110140534	43593686	1723532457000	0	1933.23	27016.5	124426.11	0	-0.05	0.54	0.32	0	0	3	1	13	10	42	36	2691525.04	561682	948952
441	2024-12-09 09:53:00.17466+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1024	3.10	110140534	43593686	1723532457000	0	1933.23	27016.5	124426.11	0	-0.05	0.54	0.32	0	0	3	1	13	10	42	36	2691525.04	561682	948952
442	2024-12-09 09:59:03.759675+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1024	3.10	110140534	43593686	1723532457000	0	1590.01	27016.5	124426.11	0	-0.06	0.54	0.32	0	0	1	1	13	10	42	36	2691525.04	561682	948952
443	2024-12-09 10:08:49.398847+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1014	3.10	110107182	43580485	1723532457000	767.73	2357.74	27478.76	125099.18	-0.03	-0.09	0.52	0.28	0	1	1	2	13	10	42	36	2691005.01	561932	948184
444	2024-12-09 10:19:49.048531+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1014	3.10	110107182	43580485	1723532457000	0	2303.89	27478.76	125099.18	0	-0.09	0.52	0.28	0	0	0	2	13	10	42	36	2691005.01	561932	948184
445	2024-12-09 10:32:30.62084+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1014	3.10	110107182	43580485	1723532457000	0	2303.89	26713.1	125099.18	0	-0.09	0.55	0.28	0	0	0	2	13	9	42	36	2691005.01	561932	948184
446	2024-12-09 10:42:25.420674+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1014	3.10	110107182	43580485	1723532457000	0	767.73	26636.76	124991.16	0	-0.03	0.56	0.28	0	0	0	1	13	8	41	36	2691005.01	561932	948184
447	2024-12-09 10:50:06.770569+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09193	3.091	109768289	43446351	1723532457000	143.17	8575.45	34444.49	132798.89	-0.01	-0.34	0.25	-0.03	0	1	0	3	13	10	41	38	2685707.59	564479	940376
448	2024-12-09 10:55:58.406684+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09193	3.091	109768289	43446351	1723532457000	0	8575.45	34444.49	132798.89	0	-0.34	0.25	-0.03	0	0	0	3	13	10	41	38	2685707.59	564479	940376
449	2024-12-09 11:02:56.799626+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09193	3.091	109768289	43446351	1723532457000	0	8575.45	34444.49	132798.89	0	-0.34	0.25	-0.03	0	0	0	3	13	10	41	38	2685707.59	564479	940376
450	2024-12-09 11:11:32.023848+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09193	3.091	109768289	43446351	1723532457000	0	7807.72	34444.49	132798.89	0	-0.31	0.25	-0.03	0	0	0	2	13	10	41	38	2685707.59	564479	940376
451	2024-12-09 11:21:36.416475+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09193	3.091	109768289	43446351	1723532457000	0	7807.72	34444.49	132718.28	0	-0.31	0.25	-0.12	0	0	0	2	13	10	39	38	2685707.59	564479	940376
452	2024-12-09 11:28:59.113412+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09193	3.091	109768289	43446351	1723532457000	0	7807.72	34110.33	130318.21	0	-0.31	0.23	-0.06	0	0	0	2	12	10	37	38	2685707.59	564479	940376
453	2024-12-09 11:35:26.973057+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09199	3.091	109770592	43447262	1723532457000	0	7861.76	34164.37	130372.25	0	-0.31	0.24	-0.06	0	0	1	3	13	11	38	39	2685744.74	564461	940430
454	2024-12-09 11:41:27.779185+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09199	3.091	109770592	43447262	1723532457000	0	7861.76	34164.37	130372.25	0	-0.31	0.24	-0.06	0	0	1	3	13	11	38	39	2685744.74	564461	940430
455	2024-12-09 11:47:30.28946+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09199	3.091	109770592	43447262	1723532457000	0	54.04	34164.37	130372.25	0	0	0.24	-0.06	0	0	1	1	13	11	38	39	2685744.74	564461	940430
456	2024-12-09 11:53:26.612506+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09199	3.091	109770592	43447262	1723532457000	0	54.04	34164.37	128840.31	0	0	0.24	-0.15	0	0	1	1	13	11	38	38	2685744.74	564461	940430
457	2024-12-09 11:59:13.995297+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09735	3.097	109960826	43522557	1723532457000	4428.5	4482.55	38592.88	133268.82	0.17	0.18	0.41	0.02	2	0	3	1	15	11	40	38	2688771.06	564398	940629
458	2024-12-09 12:13:18.012695+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09735	3.097	109960826	43522557	1723532457000	0	4482.55	38592.88	133268.82	0	0.18	0.41	0.02	0	0	3	1	15	11	40	38	2688809.89	563045	944859
459	2024-12-09 12:27:20.948894+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09734	3.097	109960338	43522364	1723532457000	0	4493.8	38604.14	130801.51	0	0.17	0.41	0.02	0	0	3	2	15	12	38	39	2688802.26	563048	944847
460	2024-12-09 12:46:22.651877+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08704	3.087	109594802	43377685	1723532457000	0	12867.43	47031.81	139209.56	0	-0.16	0.08	-0.32	0	0	2	3	15	14	38	40	2683075.89	565801	936420
461	2024-12-09 13:02:16.756764+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.08885	3.088	109659007	43403097	1723532457000	0	9935.17	48238.95	140705.81	0	-0.27	0.12	-0.26	0	0	1	3	15	14	39	40	2684113.67	565322	937916
462	2024-12-09 13:17:12.227165+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.07419	3.074	109138727	43197170	1723532457000	9146.91	22326.97	59225.26	153089.65	-0.36	-0.75	-0.3	-0.73	0	3	2	7	16	17	39	44	2675925.11	569261	925902
463	2024-12-09 13:31:11.695004+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.07426	3.074	109141082	43198102	1723532457000	0	13952.22	59007.3	153144.65	0	-0.41	-0.29	-0.73	0	0	3	5	16	16	40	44	2675963.42	569243	925957
464	2024-12-09 13:41:34.249755+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.06462	3.064	108798759	43062610	1723532457000	246.11	22354.5	67418.75	161556.09	0.01	-0.73	-0.6	-1.04	1	0	4	5	17	17	41	45	2670546.87	571851	918037
465	2024-12-09 13:48:23.82635+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.06464	3.064	108799394	43062861	1723532457000	0	22369.35	67433.6	161570.95	0	-0.73	-0.6	-1.04	0	0	5	5	18	17	42	45	2670557.25	571846	918052
466	2024-12-09 13:54:03.463989+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.06464	3.064	108799394	43062861	1723532457000	0	20873.1	66515.04	161570.95	0	-0.78	-0.56	-1.04	0	0	4	5	18	15	42	45	2670557.25	571846	918052
467	2024-12-09 13:59:58.849041+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.05359	3.053	108407436	42907724	1723532457000	9085.57	29958.67	75600.61	170656.52	-0.36	-1.14	-0.92	-1.4	0	1	4	6	18	16	42	46	2664318.95	574846	908967
468	2024-12-09 14:08:23.561524+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.05359	3.053	108407436	42907724	1723532457000	0	26713.78	73597.98	170642.68	0	-1.03	-1	-1.41	0	0	3	5	16	16	41	46	2664318.95	574846	908967
469	2024-12-09 14:18:38.802578+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04155	3.041	107979998	42738544	1723532457000	0	27600.75	66245.53	180278.62	0	-1.06	-2.06	-1.8	0	0	4	4	12	18	41	48	2657479.36	578137	899041
470	2024-12-09 14:30:17.448709+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9895	2.98	106133837	42007832	1723532457000	0	36502.02	74916.59	189234.89	0	-2.76	-3.72	-3.48	0	0	3	5	12	18	41	49	2627427.29	581137	890084
471	2024-12-09 14:39:52.678669+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9895	2.98	106133837	42007832	1723532457000	0	28090.58	74916.59	189185.1	0	-2.45	-3.72	-3.48	0	0	2	4	12	18	40	49	2627427.29	581137	890084
472	2024-12-09 14:47:06.445157+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9886	2.98	106102232	41995323	1723532457000	78.29	28384.74	74184.26	189481.85	0.02	-2.48	-3.71	-3.16	1	0	2	5	13	18	41	49	2626913.03	581189	889932
473	2024-12-09 14:53:12.599689+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9377	2.93	104294612	41279866	1723532457000	8800.4	37185.14	82984.67	198282.25	-1.7	-4.14	-5.35	-4.81	0	1	2	6	13	19	41	50	2597333.65	584189	881131
474	2024-12-09 14:58:59.341439+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9377	2.93	104294612	41279866	1723532457000	0	28099.57	82641.45	198282.25	0	-3.79	-5.36	-4.81	0	0	2	5	11	19	41	50	2597333.65	584189	881131
475	2024-12-09 15:07:58.055141+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9393	2.93	104349692	41301667	1723532457000	272	28371.57	82913.45	189371.59	0.05	-3.74	-5.31	-4.75	2	0	4	5	13	19	43	49	2598175.58	584080	881386
476	2024-12-09 15:18:20.468819+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9460	2.94	104590623	41397027	1723532457000	386.4	19526.62	84048.52	190560.52	0.07	-3.14	-5.1	-4.53	4	0	15	3	24	19	55	49	2602149.96	583680	882575
477	2024-12-09 15:29:32.646737+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9378	2.93	104298396	41281364	1723532457000	288.2	13797.72	87275.9	190739.99	0.06	-1.73	-5.36	-4.69	4	0	26	5	35	22	66	46	2597375.94	584173	881156
478	2024-12-09 15:38:11.524579+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9424	2.94	104462346	41346255	1723532457000	322.2	14607.12	86549.14	191549.39	0.06	-1.57	-5.16	-4.54	4	0	35	5	44	21	75	46	2600081.19	583901	881965
479	2024-12-09 15:45:26.499392+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9457	2.94	104578327	41392161	1723532457000	222.1	14948.61	87121.34	192109.64	0.04	-1.42	-5.05	-4.44	2	0	40	4	49	21	79	46	2601994.17	583709	882537
480	2024-12-09 15:51:20.65125+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9480	2.94	104659164	41424156	1723532457000	398.62	6468.53	87519.96	192508.27	0.08	0.35	-4.98	-4.37	1	0	40	3	50	21	80	46	2603327.1	583575	882936
481	2024-12-09 15:57:28.597192+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9480	2.94	104659164	41424156	1723532457000	0	6468.53	87519.96	192365.36	0	0.35	-4.98	-4.42	0	0	40	3	50	21	79	46	2603327.1	583575	882936
482	2024-12-09 16:06:21.76497+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9525	2.95	104820278	41487925	1723532457000	957.27	7408.7	87839.71	193452.84	0.13	0.48	-4.8	-4.28	3	1	43	4	54	21	83	47	2605985.79	583309	883732
483	2024-12-09 16:16:46.131099+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9563	2.95	104954514	41541056	1723532457000	280.4	6756.17	88500.81	192612.26	0.05	0.35	-4.68	-4.15	3	0	37	4	61	21	89	47	2608197.55	583087	884393
484	2024-12-09 16:30:11.306989+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9616	2.96	105144431	41616225	1723532457000	251.9	4330.7	89435.41	193546.86	0.05	0.79	-4.51	-3.97	2	0	33	1	70	21	98	47	2611325.31	582774	885327
485	2024-12-09 16:42:21.690804+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9662	2.96	105305575	41680006	1723532457000	310.4	3874.15	90227.76	194339.21	0.06	0.7	-4.36	-3.83	3	0	30	1	79	21	107	47	2613977.89	582510	886120
486	2024-12-09 16:51:50.894214+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9933	2.99	106269771	42061635	1723532457000	54.16	8204.54	87149.05	198874.15	0.01	1.54	-3.19	-2.96	1	1	32	2	82	20	109	47	2629824.37	580939	890848
487	2024-12-09 16:58:10.983797+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9933	2.99	106269771	42061635	1723532457000	0	8204.54	87149.05	198373.39	0	1.54	-3.19	-2.96	0	0	32	2	82	20	108	47	2629824.37	580939	890848
488	2024-12-09 17:06:10.712762+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9933	2.99	106269771	42061635	1723532457000	0	6990.56	87149.05	198324.52	0	1.36	-3.19	-2.96	0	0	27	1	82	20	108	46	2629824.37	580939	890848
489	2024-12-09 17:15:35.19587+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.0001272	3.00012	106509086	42156357	1723532457000	0	7626.22	88319.31	199494.78	0	1.48	-2.97	-2.74	0	0	23	1	84	20	110	46	2633750.87	580552	892018
490	2024-12-09 17:26:22.119925+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.01690	3.016	107104880	42392172	1723532457000	2907.75	9851.27	91227.06	202402.54	0.56	1.91	-2.43	-2.2	1	0	17	1	85	20	111	46	2643514.87	579595	894926
491	2024-12-09 17:35:09.126847+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.009957	3.0099	106858063	42294482	1723532457000	1191.56	10425.69	92364.58	203594.1	-0.23	1.56	-2.65	-2.42	0	4	10	5	84	23	111	50	2639495.99	579995	893734
492	2024-12-09 17:42:37.155566+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9865	2.98	106026623	41965397	1723532457000	0	17760.86	100256.36	211423.06	0	0.66	-3.41	-3.2	0	0	6	6	85	24	112	50	2625976.08	581357	889730
493	2024-12-09 17:48:48.232771+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9879	2.98	106077914	41985698	1723532457000	251.21	13466.73	100507.57	211674.27	0.05	-0.17	-3.36	-3.15	2	0	7	6	87	24	114	50	2626818.45	581274	889981
494	2024-12-09 17:54:28.607993+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.001275	3.0012	106549832	42172484	1723532457000	2308.51	15721.07	102816.09	213982.78	0.44	0.26	-2.93	-2.72	1	0	7	5	88	24	115	50	2634563.28	580511	892290
495	2024-12-09 18:00:23.282943+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.001275	3.0012	106549832	42172484	1723532457000	0	15721.07	98387.58	213982.78	0	0.26	-3.1	-2.72	0	0	7	5	86	24	115	50	2634563.28	580511	892290
496	2024-12-09 18:10:24.243113+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.001275	3.0012	106549832	42172484	1723532457000	0	14550.81	98387.58	213588.69	0	0.04	-3.1	-2.68	0	0	5	5	86	24	114	50	2634563.28	580511	892290
497	2024-12-09 18:22:17.168814+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.01746	3.017	107124458	42399921	1723532457000	2804.04	14447.11	101180.37	216392.73	0.54	0.02	-2.58	-2.16	1	0	5	5	87	23	115	50	2643979.96	579588	895094
498	2024-12-09 18:36:25.12309+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.01746	3.017	107124458	42399921	1723532457000	0	13255.54	92761.87	201564.36	0	0.25	-2.25	-2.42	0	0	5	1	87	22	114	49	2643979.96	579588	895094
499	2024-12-09 18:46:29.141314+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.0002971	3.00029	106515117	42158744	1723532457000	2804.05	8056.51	95696.65	195802.14	-0.54	0.41	-2.81	-3.74	0	1	2	2	87	23	113	50	2634053.29	580576	892150
500	2024-12-09 18:53:34.987296+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.0002971	3.00029	106515117	42158744	1723532457000	0	5748	94200.4	195802.14	0	-0.03	-2.87	-3.74	0	0	1	2	86	23	113	50	2634053.29	580576	892150
501	2024-12-09 18:59:20.978408+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.0002971	3.00029	106515117	42158744	1723532457000	0	5748	94200.4	195802.14	0	-0.03	-2.87	-3.74	0	0	1	2	86	23	113	50	2634053.29	580576	892150
502	2024-12-09 19:07:16.495756+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.0002971	3.00029	106515117	42158744	1723532457000	0	5748	90955.51	177475.84	0	-0.03	-2.76	-3.71	0	0	1	2	85	22	112	50	2634053.29	580576	892150
503	2024-12-09 19:16:31.388963+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.0002729	3.00027	106514258	42158403	1723532457000	4.15	5752.15	81812.76	176667.07	0	-0.03	-2.4	-3.74	0	1	1	3	85	20	111	50	2634039.28	580578	892145
504	2024-12-09 19:24:17.390047+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.0002729	3.00027	106514258	42158403	1723532457000	0	2948.11	81757.76	176667.07	0	-0.57	-2.41	-3.74	0	0	0	3	84	20	111	50	2634039.28	580578	892145
505	2024-12-09 19:29:55.888542+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.0002729	3.00027	106514258	42158403	1723532457000	0	2948.11	81757.76	176667.07	0	-0.57	-2.41	-3.74	0	0	0	3	84	20	111	50	2634039.28	580578	892145
506	2024-12-09 19:36:27.651986+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.0003794	3.00037	106518040	42159900	1723532457000	0	2966.59	73610.9	176685.55	0	-0.57	-2.09	-3.74	0	0	1	3	85	19	112	50	2634101.31	580572	892164
507	2024-12-09 19:42:26.521368+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.0003794	3.00037	106518040	42159900	1723532457000	0	2826.69	73349.94	176685.55	0	-0.54	-2.1	-3.74	0	0	1	2	83	19	112	50	2634101.31	580572	892164
508	2024-12-09 19:48:28.360783+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.0003794	3.00037	106518040	42159900	1723532457000	0	22.64	73349.94	176685.55	0	0	-2.1	-3.74	0	0	1	1	83	19	112	50	2634101.31	580572	892164
509	2024-12-09 19:54:22.849924+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.003362	3.0033	106623942	42201817	1723532457000	0	540.06	73867.37	177202.97	0	0.1	-2	-3.64	0	0	2	1	84	19	113	50	2635838.1	580401	892681
510	2024-12-09 20:00:03.492029+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.003362	3.0033	106623942	42201817	1723532457000	0	540.06	64781.79	177202.97	0	0.1	-1.65	-3.64	0	0	2	1	84	18	113	50	2635838.1	580401	892681
511	2024-12-09 20:08:55.974667+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9977	2.99	106423952	42122660	1723532457000	0	1507.63	65749.36	177572.01	0	-0.09	-1.83	-3.85	0	0	2	2	84	19	112	51	2632577.39	580727	891714
512	2024-12-09 20:19:37.029825+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9977	2.99	106423952	42122660	1723532457000	0	1503.47	55715.48	177572.01	0	-0.08	-1.44	-3.85	0	0	2	1	83	17	112	51	2632577.39	580727	891714
513	2024-12-09 20:30:25.691028+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9350	2.93	104199491	41242217	1723532457000	11451.26	12954.74	58210.47	189023.28	0	-2.17	-1.82	-5.86	4	2	6	3	87	18	116	53	2596190.85	584414	880893
514	2024-12-09 20:38:51.705099+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9308	2.93	104049416	41182818	1723532457000	1696.43	15114.79	60389.01	191201.81	-0.24	-2.32	-1.96	-5.99	3	1	13	4	95	19	124	54	2593741.74	584669	880166
515	2024-12-09 20:45:52.716915+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9352	2.93	104205763	41244700	1723532457000	397.8	15887.59	60852.8	191974.61	0.08	-2.17	-1.79	-5.85	4	0	21	4	102	18	132	54	2596323.75	584408	880939
516	2024-12-09 20:51:42.630819+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9373	2.93	104280311	41274206	1723532457000	276	16028.04	52710.26	192632.48	0.05	-2.2	-0.01	-5.78	4	0	26	5	108	18	138	55	2597557.38	584285	881308
517	2024-12-09 20:57:39.026669+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9241	2.92	103812627	41089097	1723532457000	3370.68	19547.52	56229.75	196151.97	-0.48	-2.64	-0.46	-6.21	5	1	32	6	114	19	144	56	2589889.34	585116	878905
518	2024-12-09 21:05:19.422029+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9281	2.92	103952119	41144307	1723532457000	407.3	19270.26	56920.05	196842.27	0.08	-2.32	-0.33	-6.08	4	0	39	5	121	19	151	56	2592195.83	584842	879715
519	2024-12-09 21:14:36.88109+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9336	2.93	104148216	41221923	1723532457000	258.3	20239.89	56646.15	197114.55	0.05	-2.14	-0.38	-5.9	2	0	47	5	117	19	158	56	2595433.81	584558	880558
520	2024-12-09 21:24:55.193252+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9281	2.92	103953967	41145039	1723532457000	179.65	23562.92	56743.71	200437.58	0	-2.32	-0.29	-6.08	1	1	53	7	113	18	164	58	2592269.41	584847	879746
521	2024-12-09 21:32:18.596408+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9310	2.93	104056883	41185773	1723532457000	243.4	12332.45	56664.01	200946.58	0.05	-0.19	-0.3	-5.99	2	0	51	5	111	18	169	58	2593969.69	584675	880255
522	2024-12-09 21:39:23.366109+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9340	2.93	104164168	41228236	1723532457000	382.43	10843.75	56526.74	201476.92	0.07	0.09	-0.33	-5.89	5	0	50	4	110	18	175	58	2595740.91	584518	880717
523	2024-12-09 21:45:07.592983+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9362	2.93	104242390	41259197	1723532457000	386.5	10586.15	56568.64	201863.42	0.08	0.04	-0.32	-5.82	4	0	48	4	111	18	179	58	2597033.15	584365	881172
524	2024-12-09 21:50:58.179334+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9385	2.93	104322946	41291081	1723532457000	287.88	10326.16	56567.9	202261.3	0.06	0.04	-0.32	-5.75	3	0	46	3	114	18	183	58	2598362.96	584231	881570
525	2024-12-09 21:56:34.844649+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9416	2.94	104432656	41334504	1723532457000	318.55	7625.21	57386.43	203070.38	0.01	0.6	-0.22	-5.21	2	1	45	3	119	19	187	59	2600176.32	584049	882113
526	2024-12-09 22:03:40.522467+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9449	2.94	104551499	41381542	1723532457000	329	7661.61	57555.55	203656.78	0.06	0.6	-0.13	-5.1	3	0	44	3	122	18	192	59	2602136.99	583852	882699
527	2024-12-09 22:12:59.920996+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9384	2.93	104320921	41290279	1723532457000	1691.53	8584.71	58323.79	193707.16	-0.26	0.19	-0.57	-5.36	2	1	41	4	120	19	197	59	2598362.88	584240	881576
528	2024-12-09 22:24:10.039341+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9385	2.93	104322150	41290766	1723532457000	1052.25	6540.44	59175.05	193699.02	-0.08	0.34	-0.69	-5.38	3	1	41	3	121	20	204	60	2598397.92	584241	881590
529	2024-12-09 22:34:16.807757+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9421	2.94	104449298	41341091	1723532457000	344.9	6579.34	59058.69	193690.33	0.07	0.35	-0.71	-5.26	3	0	42	3	119	20	209	60	2600496.27	584029	882218
530	2024-12-09 22:42:16.405812+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9297	2.92	104012164	41168073	1723532457000	3099.67	9453.88	61717.97	196931.81	-0.47	-0.16	-1.25	-5.67	3	1	41	4	118	21	214	60	2593334.21	584767	880086
531	2024-12-09 22:48:22.679929+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9314	2.93	104071660	41191622	1723532457000	180.7	9201.58	57466.82	197226.01	0.04	-0.21	-2.06	-5.62	2	0	39	4	120	21	217	60	2594317.06	584667	880380
532	2024-12-09 22:54:04.134128+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9321	2.93	104095406	41201021	1723532457000	0	8579.22	57530.05	197343.41	0	-0.33	-2.05	-5.6	0	0	34	4	120	20	218	60	2594709.29	584628	880497
533	2024-12-09 23:00:06.944883+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9321	2.93	104095406	41201021	1723532457000	0	7972.76	57530.05	197343.41	0	-0.4	-2.05	-5.6	0	0	30	3	120	20	218	60	2594709.29	584628	880497
534	2024-12-09 23:08:30.219874+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9321	2.93	104095406	41201021	1723532457000	0	7449.66	57359.79	197343.41	0	-0.5	-2.08	-5.6	0	0	24	3	119	20	218	60	2594709.29	584628	880497
535	2024-12-09 23:18:34.640442+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9325	2.93	104108380	41206155	1723532457000	420.95	5976.78	56902.45	197886.07	-0.01	-0.29	-2.25	-5.58	2	1	21	4	121	22	221	62	2594928.38	584607	880564
536	2024-12-09 23:27:53.54549+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9348	2.93	104191681	41239126	1723532457000	192.1	5053.43	54406.4	198297.77	0.04	-0.18	-2.72	-5.51	2	0	20	3	125	22	226	62	2596305.36	584425	881104
537	2024-12-09 23:35:02.517678+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9376	2.93	104292571	41279058	1723532457000	190.5	5126.78	53759.99	198842.92	0.04	-0.17	-2.4	-5.42	2	0	21	4	130	19	231	63	2597970.26	584300	881474
538	2024-12-09 23:42:02.650727+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9404	2.94	104391482	41318207	1723532457000	331	2286.01	46356.61	199331.32	0.06	0.34	-1.54	-5.33	3	0	21	3	134	18	236	63	2599602.83	584136	881962
539	2024-12-09 23:47:58.185528+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9424	2.94	104459982	41345320	1723532457000	189.1	2443.41	46443.5	199669.42	0.04	0.37	-1.53	-5.27	2	0	22	3	135	18	239	63	2600733.18	584022	882301
540	2024-12-09 23:53:55.717961+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9559	2.95	104941347	41535844	1723532457000	212.2	4698.81	46507.79	202042.22	0.04	0.81	-1.51	-4.83	2	0	26	3	139	18	244	63	2608671.22	583193	884768
541	2024-12-09 23:59:56.607396+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9580	2.95	105013907	41564564	1723532457000	200.1	5056.01	46864.99	202112.96	0.04	0.88	-1.44	-4.76	2	0	30	3	143	18	247	63	2609865.75	583106	885031
542	2024-12-10 00:33:45.739743+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9670	2.96	105336094	41692085	1723532457000	173.3	6244.43	46748.88	204485.69	0.03	1	-1.67	-4.16	2	0	39	2	164	20	268	64	2615182.15	582578	886621
543	2024-12-10 00:58:18.804791+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9548	2.95	104901571	41520101	1723532457000	353.9	9377.38	50494.37	203021.99	0.07	-0.11	-1.51	-4.55	3	0	43	3	185	19	289	64	2608113.12	583358	884378
544	2024-12-10 01:35:09.025728+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9699	2.96	105439168	41732882	1723532457000	130.4	9345.65	53263.54	205813.8	0	0.07	-1.01	-4.07	1	1	41	2	206	19	311	65	2616968.81	582424	887172
545	2024-12-10 02:14:47.317371+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9699	2.96	105437086	41732058	1723532457000	0	7077.45	57661.7	211686.96	0	0.2	-0.93	-4.03	0	0	40	2	234	19	339	66	2616993.86	582438	887192
546	2024-12-10 02:46:04.612493+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9715	2.97	105496221	41755464	1723532457000	0	2183.44	43437.43	211097.92	0	0.42	1.22	-3.75	0	0	20	0	214	16	340	65	2617966.85	582341	887482
547	2024-12-10 03:10:08.360471+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9715	2.97	105496221	41755464	1723532457000	0	290.43	37970.53	204892.1	0	0.06	1.35	-3.7	0	0	1	0	190	14	340	62	2617966.85	582341	887482
548	2024-12-10 03:27:17.350742+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9715	2.97	105496221	41755464	1723532457000	0	0	34123.61	204892.1	0	0	1.43	-3.7	0	0	0	0	179	12	340	62	2617966.85	582341	887482
549	2024-12-10 03:41:59.017538+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9625	2.96	105176169	41628787	1723532457000	1200.24	4309	37573.27	209201.1	0.23	-0.3	0.95	-3.99	5	0	7	1	177	13	347	63	2612757.97	582876	885939
550	2024-12-10 03:52:41.140642+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9696	2.96	105426941	41728043	1723532457000	452.5	5541.6	37519.61	209211.46	0.09	-0.07	0.94	-3.75	4	0	18	1	177	13	358	62	2616886.1	582464	887171
551	2024-12-10 03:58:36.153021+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105443125	41734449	1723532457000	0	5621.1	37110.66	209290.96	0	-0.05	0.92	-3.73	0	0	19	1	175	12	359	62	2617152.43	582438	887251
552	2024-12-10 04:09:14.844353+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105443125	41734449	1723532457000	0	5621.1	36469.56	208985.5	0	-0.05	0.79	-3.71	0	0	19	1	168	12	359	61	2617152.43	582438	887251
553	2024-12-10 04:20:14.110281+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105443125	41734449	1723532457000	0	5621.1	34388.42	208985.5	0	-0.05	0.98	-3.71	0	0	19	1	161	11	359	61	2617152.43	582438	887251
554	2024-12-10 04:32:15.953954+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105444262	41734899	1723532457000	222.7	7693.28	34946.35	210292.02	0.04	-0.05	0.97	-3.7	3	0	31	2	166	11	371	61	2617191.91	582440	887267
555	2024-12-10 04:41:21.721146+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9698	2.96	105435193	41731309	1723532457000	0	3299.59	31434.28	210336.13	0	0.22	1.35	-3.71	0	0	23	2	159	11	371	62	2617043.56	582455	887223
556	2024-12-10 04:48:49.85562+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9699	2.96	105437228	41732114	1723532457000	9.99	2521.48	31146.18	210269.79	0	0.07	1.29	-3.72	1	0	17	2	157	11	372	61	2617077.05	582451	887233
557	2024-12-10 04:54:35.809569+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9699	2.96	105437228	41732114	1723532457000	0	2126.28	31146.18	210269.79	0	-0.01	1.29	-3.72	0	0	13	2	157	11	372	61	2617077.05	582451	887233
558	2024-12-10 05:00:17.959118+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9690	2.96	105405749	41719655	1723532457000	318.06	2444.35	31464.25	210587.85	-0.03	-0.04	1.26	-3.75	1	1	14	3	158	12	373	62	2616563.77	582504	887080
559	2024-12-10 05:08:51.73736+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9702	2.97	105448297	41736495	1723532457000	0	2771.54	31782.73	210915.05	0	0	1.3	-3.71	0	0	17	4	161	12	376	63	2617265.13	582434	887290
560	2024-12-10 05:19:12.054216+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9706	2.97	105462646	41742175	1723532457000	0	2842.02	31261.46	210985.53	0	0.02	1.29	-3.7	0	0	18	4	158	11	377	63	2617501.24	582411	887360
561	2024-12-10 05:30:23.048204+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9706	2.97	105462646	41742175	1723532457000	0	827.43	30552.9	210651.37	0	0.03	1.16	-3.71	0	0	7	3	151	10	376	63	2617501.24	582411	887360
562	2024-12-10 05:39:00.018198+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9706	2.97	105462646	41742175	1723532457000	0	725.73	29994.9	210651.37	0	0.03	1.05	-3.71	0	0	6	2	145	10	376	63	2617501.24	582411	887360
563	2024-12-10 05:45:23.163358+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9706	2.97	105462646	41742175	1723532457000	0	715.73	29618.1	210651.37	0	0.02	0.98	-3.71	0	0	5	2	142	10	376	63	2617501.24	582411	887360
564	2024-12-10 05:51:20.378737+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9706	2.97	105462646	105462646	1723532457000	0	715.73	27163.1	210651.37	0	0.02	0.5	-3.71	0	0	5	2	136	10	376	63	2617501.24	582411	887360
565	2024-12-10 05:57:14.104265+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9706	2.97	105462646	105462646	1723532457000	0	715.73	26890.5	210651.37	0	0.02	0.44	-3.71	0	0	5	2	133	10	376	63	2617501.24	582411	887360
566	2024-12-10 06:06:56.322649+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9706	2.97	105462646	41742175	1723532457000	0	70.47	25692.07	210651.37	0	0.01	0.43	-3.71	0	0	1	0	126	8	376	63	2617501.24	582411	887360
567	2024-12-10 06:17:55.097643+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9706	2.97	105462646	105462646	1723532457000	0	0	25080.27	210651.37	0	0	0.31	-3.71	0	0	0	0	119	8	376	63	2617501.24	582411	887360
568	2024-12-10 06:32:05.135234+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9706	2.97	105462646	41742175	1723532457000	0	0	24241.07	210651.37	0	0	0.14	-3.71	0	0	0	0	111	8	376	63	2617501.24	582411	887360
569	2024-12-10 06:43:42.403921+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9640	2.96	105227044	41648923	1723532457000	1793.76	1793.76	20755.37	212445.13	-0.22	-0.22	0.61	-3.92	3	1	3	1	104	8	379	64	2613652.92	582802	886218
570	2024-12-10 06:51:53.624275+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9504	2.95	104746481	41458716	1723532457000	249.4	5312.21	23159.73	215963.58	0.05	-0.68	-0.07	-4.36	3	0	10	2	103	9	386	65	2605793.94	583604	883881
571	2024-12-10 06:57:51.506825+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9461	2.94	104593924	41398334	1723532457000	430.9	7492.18	24920.71	217854.45	0.08	-0.82	-0.29	-4.45	4	0	17	3	106	10	392	66	2603307.49	583861	883144
572	2024-12-10 07:06:40.701222+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9522	2.95	104809960	41483841	1723532457000	552.2	8557.08	24963.99	217513.85	0.11	-0.62	-0.28	-4.24	5	0	26	3	109	10	401	65	2606869.34	583526	884143
573	2024-12-10 07:16:41.614229+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9600	2.96	105087789	41593806	1723532457000	900.98	9924.97	25755.98	218881.73	0.17	-0.36	-0.13	-3.99	6	0	37	3	115	10	412	65	2611447.56	583070	885504
574	2024-12-10 07:27:45.780919+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8835	2.88	102371247	40518597	1723532457000	368.4	25524.87	40291.99	234208.69	0.07	-2.93	-2.91	-6.44	4	0	48	4	116	11	422	65	2566821.32	587814	871814
575	2024-12-10 07:35:34.314188+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8821	2.88	102319574	40498145	1723532457000	125.4	26181.7	40818.42	234865.52	0.02	-2.98	-2.96	-6.49	2	0	51	5	118	11	425	66	2565967.73	587745	872016
576	2024-12-10 07:42:23.042964+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8832	2.88	102358424	40513522	1723532457000	193.7	24708.34	37591.73	235059.22	0.01	-2.73	-2.47	-6.45	2	0	51	4	115	10	427	66	2566612.81	587678	872210
577	2024-12-10 07:48:18.302243+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8843	2.88	102397863	40529132	1723532457000	124	21354.89	36931.88	235255.82	0.02	-2.22	-2.58	-6.42	1	0	46	3	109	10	429	66	2567267.59	587611	872407
578	2024-12-10 07:54:19.101259+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8855	2.88	102441223	40546294	1723532457000	85.9	19493.32	36501.88	234553.35	0.02	-2.02	-2.66	-6.4	1	0	42	2	105	10	431	64	2567987.39	587536	872623
579	2024-12-10 08:00:04.86135+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8868	2.88	102489067	40565231	1723532457000	238.4	19157.72	36283.28	234791.75	0.05	-2.08	-2.7	-6.35	2	0	39	2	102	10	433	64	2568781.53	587455	872861
580	2024-12-10 08:10:51.066393+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8905	2.89	102619252	40616758	1723532457000	236.8	18650.92	36428.46	218592	0.05	-2.18	-2.67	-6.86	2	0	34	2	103	10	436	64	2570941.81	587233	873510
581	2024-12-10 08:22:30.818099+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9039	2.90	103095856	40805398	1723532457000	1782.58	4888.71	38798.75	218421.48	0.35	0.78	-2.22	-6.48	4	0	30	1	112	10	441	64	2578843.61	586423	875880
582	2024-12-10 08:34:55.836078+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9102	2.91	103319634	40893970	1723532457000	190.13	5252.2	39897.04	219524.97	0.04	0.98	-2.06	-6.24	3	0	33	1	121	11	451	64	2582552.74	586045	876992
583	2024-12-10 08:44:47.825989+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9170	2.91	103561092	40989539	1723532457000	230.7	6183.35	41094.49	219681.09	0.04	1.16	-1.83	-6.02	3	0	38	1	129	11	459	63	2586549.23	585638	878190
584	2024-12-10 08:52:48.713874+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9150	2.91	103488727	40960896	1723532457000	1336.85	7351	42602.24	221188.84	-0.1	1.02	-1.9	-6.09	3	1	40	2	134	12	464	64	2585370.52	585763	877840
585	2024-12-10 08:58:32.618709+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9175	2.91	103576057	40995462	1723532457000	321.4	7545.5	43035.14	221278.52	0.06	1.06	-1.82	-6.02	3	0	42	2	138	12	466	64	2586815.59	585616	878273
586	2024-12-10 09:08:02.504558+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9202	2.92	103674890	41034580	1723532457000	235.1	7516.8	43524.84	221768.22	0.05	1.05	-1.73	-5.93	2	0	42	2	143	12	471	64	2588450.56	585450	878763
587	2024-12-10 09:18:31.803347+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9243	2.92	103817865	41091169	1723532457000	231.3	7436.1	44232.84	222422.37	0.05	1.04	-1.59	-5.74	2	0	42	2	150	12	477	64	2590814.93	585210	879471
588	2024-12-10 09:29:39.590183+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9285	2.92	103967002	41150198	1723532457000	221.1	5398.23	44970.84	223160.37	0.04	0.69	-1.45	-5.61	3	0	40	1	157	12	484	64	2593280.19	584960	880209
589	2024-12-10 09:37:52.190769+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9294	2.92	103999608	41163103	1723532457000	188.3	4974.35	42467.09	222366.81	0.04	0.49	-0.92	-5.55	2	0	37	2	159	12	489	64	2593824.86	584907	880373
590	2024-12-10 09:44:51.082627+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9318	2.93	104083452	41196289	1723532457000	164.6	5033.55	41324.44	222781.41	0.03	0.5	-1.13	-5.47	2	0	37	2	155	12	493	64	2595211.64	584719	880928
591	2024-12-10 09:50:45.94558+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9347	2.93	104188739	41237962	1723532457000	306.1	4188.8	41202.64	223301.81	0.06	0.7	-1.16	-5.38	3	0	38	1	154	12	498	64	2596949.41	584591	881308
592	2024-12-10 09:56:37.483092+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9362	2.93	104242375	41259191	1723532457000	203.6	3989.2	41292.34	223566.81	0.04	0.67	-1.14	-5.33	2	0	37	1	155	12	501	64	2597835.19	584502	881573
593	2024-12-10 10:04:35.991171+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9393	2.93	104351935	41302555	1723532457000	246.4	4048.1	41833.44	224107.91	0.05	0.68	-1.03	-5.23	3	0	38	1	161	12	507	64	2599644.13	584319	882114
594	2024-12-10 10:14:16.256435+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9428	2.94	104474846	41351203	1723532457000	244.5	4059.7	42440.14	223946.88	0.05	0.68	-0.92	-4.83	2	0	37	1	166	12	512	63	2601672.84	584115	882721
595	2024-12-10 10:26:19.63486+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9467	2.94	104613443	41406060	1723532457000	279.9	3891.4	41468.83	224630.58	0.05	0.64	-0.71	-4.7	3	0	38	1	167	11	520	63	2603959.61	583885	883405
596	2024-12-10 10:37:47.93768+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9512	2.95	104775023	41470013	1723532457000	305.4	3828	41804.05	225427.08	0.06	0.75	-0.63	-4.55	3	0	38	0	169	10	527	63	2606624.43	583618	884201
597	2024-12-10 10:46:39.652924+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9543	2.95	104883888	41513102	1723532457000	216.5	3683.8	42330.35	218155.65	0.04	0.72	-0.52	-4.45	3	0	37	0	174	10	533	61	2608419.17	583438	884737
598	2024-12-10 10:52:41.471321+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9565	2.95	104963354	41544555	1723532457000	318.9	3759.2	42721.65	218546.95	0.06	0.73	-0.45	-4.38	3	0	38	0	178	10	537	61	2609728.91	583307	885129
599	2024-12-10 10:58:26.493232+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9580	2.95	105016782	41565702	1723532457000	263	3630.1	42984.65	218809.95	0.05	0.71	-0.4	-4.33	3	0	37	0	181	10	540	61	2610609.32	583219	885392
600	2024-12-10 11:06:32.287408+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9625	2.96	105173738	41627825	1723532457000	320	3882.02	43052.62	219523.18	0.07	0.77	-0.26	-4.19	3	0	38	0	183	8	546	61	2613194.94	582961	886164
601	2024-12-10 11:15:50.603891+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9657	2.96	105290073	41673870	1723532457000	312.6	3825.92	43554.14	220095.18	0.06	0.75	-0.16	-4.08	3	0	38	0	188	8	552	61	2615110.65	582770	886736
602	2024-12-10 11:24:36.559514+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9673	2.96	105346616	41696250	1723532457000	66.3	3550.22	43832.04	220373.08	0.01	0.7	-0.11	-4.03	1	0	36	0	192	8	556	61	2616042.37	582649	887097
603	2024-12-10 11:30:55.933006+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9698	2.96	105435337	41731366	1723532457000	213.1	3495.02	44267.94	220754.94	0.04	0.69	-0.03	-3.96	2	0	36	0	196	8	559	60	2617501.87	582532	887450
604	2024-12-10 11:37:19.906411+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9698	2.96	105435337	41731366	1723532457000	0	3189.62	44267.94	220754.94	0	0.63	-0.03	-3.96	0	0	33	0	196	8	559	60	2617501.87	582532	887450
605	2024-12-10 11:43:01.340283+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9698	2.96	105435337	41731366	1723532457000	0	2789.12	44267.94	220754.94	0	0.55	-0.03	-3.96	0	0	29	0	196	8	559	60	2617501.87	582532	887450
606	2024-12-10 11:49:03.107211+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9698	2.96	105435337	41731366	1723532457000	0	2462.82	44267.94	220754.94	0	0.49	-0.03	-3.96	0	0	25	0	196	8	559	60	2617501.87	582532	887450
607	2024-12-10 11:55:04.273852+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9698	2.96	105435337	41731366	1723532457000	0	2081.12	44267.94	220754.94	0	0.41	-0.03	-3.96	0	0	21	0	196	8	559	60	2617501.87	582532	887450
608	2024-12-10 12:01:55.098923+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9698	2.96	105435337	41731366	1723532457000	0	1605.8	44267.94	216326.43	0	0.32	-0.03	-4.12	0	0	17	0	196	8	557	60	2617501.87	582532	887450
609	2024-12-10 12:13:39.438655+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9631	2.96	105198040	41637443	1723532457000	1080.21	4031.55	47506.3	219564.78	-0.04	-0.07	-0.25	-4.33	4	1	18	3	205	11	566	63	2613639.43	582928	886306
610	2024-12-10 12:27:33.956843+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9703	2.97	105450263	41737273	1723532457000	212.6	4477.95	48745.9	220793.12	0.04	0.01	-0.01	-3.78	2	0	21	3	217	11	578	62	2617791.81	582515	887545
611	2024-12-10 12:46:35.086791+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9714	2.97	105490827	41753329	1723532457000	0	4677.17	43951.41	212564.68	0	0.05	0.77	-3.8	0	0	22	3	212	9	579	60	2618459.35	582448	887744
612	2024-12-10 13:02:23.831795+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9722	2.97	105520902	41765232	1723532457000	0	4824.85	40944.21	211216.11	0	0.08	0.76	-3.66	0	0	24	3	198	8	580	60	2618954.22	582399	887892
613	2024-12-10 13:17:00.021876+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8261	2.82	100331972	39711451	1723532457000	26956.9	28149.1	65982.23	225781.21	-4.92	-4.7	-4.55	-8.07	3	1	14	1	185	9	582	57	2533459.91	591303	862358
614	2024-12-10 13:30:58.912918+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8347	2.83	100636563	39832008	1723532457000	416.9	28836.4	51525.99	227258.81	0.08	-4.56	-1.62	-7.49	4	0	20	1	188	7	595	57	2538546.11	590767	863890
615	2024-12-10 13:41:21.10333+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8311	2.83	100510696	39782190	1723532457000	1920.13	31169.71	53739.43	221379.89	-0.25	-4.72	-1.81	-7.62	4	2	29	3	194	9	604	58	2536476.68	590994	863273
616	2024-12-10 13:48:11.593982+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8357	2.83	100674567	39847051	1723532457000	478.3	31993.81	54366.93	222189.14	0.09	-4.57	-1.68	-7.13	5	0	37	3	200	9	611	58	2539211.63	590727	864037
617	2024-12-10 13:53:49.007788+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8369	2.83	100715412	39863217	1723532457000	205.3	32061.29	54356.13	222394.44	0.04	-4.55	-1.68	-7.1	2	0	38	3	200	9	613	58	2539893.84	590634	864303
618	2024-12-10 13:59:48.810317+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8378	2.83	100747110	39875763	1723532457000	159.3	32210.73	54277.03	213468.17	0.03	-4.52	-1.7	-7.07	2	0	39	3	200	9	615	57	2540422.77	590579	864462
619	2024-12-10 14:08:12.267342+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8409	2.84	100857745	39919552	1723532457000	356.3	32766.53	54314.43	214023.97	0.07	-4.42	-1.69	-6.97	3	0	44	3	200	9	620	57	2542267.78	590409	864948
620	2024-12-10 14:18:18.803936+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8402	2.84	100833620	39910004	1723532457000	933.48	6851.19	54898.39	205362.75	-0.09	0.43	-1.87	-4.99	2	3	44	6	199	13	625	59	2541881.07	590430	864904
621	2024-12-10 14:29:55.828367+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8446	2.84	100990800	39972216	1723532457000	174.3	6438.89	52777.41	197195.67	0.03	0.35	-2.22	-4.8	2	0	41	6	197	12	633	58	2544502.42	590155	865693
622	2024-12-10 14:39:46.796586+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8492	2.84	101152968	40036402	1723532457000	326.2	4719.95	52434.13	198009.27	0.06	0.64	-2.28	-4.65	3	0	38	4	196	12	640	58	2547205.69	589872	866507
623	2024-12-10 14:47:16.365249+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8516	2.85	101238725	40070344	1723532457000	349.28	4385.83	52462.51	198130.24	0.07	0.57	-2.28	-2.93	4	0	36	4	196	12	644	57	2548634.7	589723	866937
624	2024-12-10 14:53:06.545736+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8534	2.85	101300535	40094809	1723532457000	221	4430.33	51323.96	189639.63	0.04	0.58	-2.14	-2.9	3	0	37	4	196	11	648	56	2549664.45	589615	867247
625	2024-12-10 14:59:47.592623+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8579	2.85	101462801	40159034	1723532457000	640.04	5083.88	51755.2	190452.48	0.13	0.71	-2.05	-2.74	3	0	40	4	197	11	653	56	2552366.87	589333	868060
626	2024-12-10 15:07:57.766393+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8602	2.86	101542923	40190746	1723532457000	131.59	4946.27	51631.3	190396.07	0.02	0.68	-2.08	-2.74	2	1	40	5	197	12	654	57	2553700.95	589194	868461
627	2024-12-10 15:18:27.164454+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8645	2.86	101695217	40251024	1723532457000	252.8	4238.21	51651.3	189979.84	0.05	0.84	-2.07	-2.82	2	0	40	1	197	12	649	57	2556235.52	588931	869223
628	2024-12-10 15:29:49.387114+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7132	2.71	96324168	38125160	1723532457000	27751	31733.82	79257.3	215090.47	-5.38	-4.64	-7.37	-7.69	2	2	39	3	197	14	645	56	2466692.18	598700	842273
629	2024-12-10 15:38:35.646245+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7390	2.73	97240000	38487647	1723532457000	5053.54	37380.62	84715.1	220555.17	1.02	-3.87	-6.55	-6.98	3	0	40	4	198	14	643	57	2481978.23	597007	846751
630	2024-12-10 15:46:02.095268+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7412	2.74	97319294	38519031	1723532457000	167.1	37356.14	84741.7	220616.07	0.03	-3.87	-6.54	-7.01	2	0	39	4	198	14	644	57	2483316.84	596810	847298
631	2024-12-10 15:52:00.718809+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7432	2.74	97391107	38547455	1723532457000	152	37413.44	84741.3	220584.55	0.03	-3.86	-6.54	-6.97	2	0	39	4	198	14	647	57	2484527.62	596677	847665
632	2024-12-10 15:57:44.868816+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7281	2.72	96854691	38335142	1723532457000	194.3	40114.52	87863.12	224098.47	0.04	-4.54	-7.12	-7.48	2	0	38	6	198	16	651	59	2475539.91	597682	844951
633	2024-12-10 16:06:38.409824+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7316	2.73	96979263	38384447	1723532457000	285.5	40334.56	88040.06	223522.72	0.06	-4.49	-7.08	-7.51	3	0	40	5	200	16	653	58	2477643.09	597451	845590
634	2024-12-10 16:17:46.157865+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7333	2.73	97038734	38407986	1723532457000	731.31	40819.07	88563.77	224178.54	-0.04	-4.58	-7.16	-7.57	3	1	40	6	200	17	653	59	2478656.34	597342	845899
635	2024-12-10 16:30:48.593324+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7378	2.73	97197268	38470734	1723532457000	338.9	13158.77	88425.17	223971.04	0.07	0.87	-7.18	-7.59	3	0	39	4	199	17	651	59	2481331.28	597048	846710
636	2024-12-10 16:42:53.080766+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7419	2.74	97344997	38529205	1723532457000	279.9	7399.46	88474.77	223945.09	0.06	0.04	-7.16	-8.39	3	0	39	3	200	17	651	59	2483822.7	596775	847466
637	2024-12-10 16:52:04.88866+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7413	2.74	97320423	38519479	1723532457000	859.63	7564.79	89054.91	220452.81	-0.07	-0.01	-7.28	-8.45	2	1	38	3	199	18	654	59	2483420.74	596823	847346
638	2024-12-10 16:58:28.30039+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6031	2.60	92416627	36578553	1723532457000	27532.18	32197.56	116265.36	248171.49	-5.07	-4.6	-12.04	-13.06	2	2	38	4	198	20	658	61	2400613.64	606335	822217
639	2024-12-10 17:06:27.014644+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5949	2.59	92123368	36462481	1723532457000	145.1	34236	118394.03	250768.16	0.03	-5.01	-12.41	-13.34	2	0	37	5	199	21	663	62	2395628.77	606929	820698
640	2024-12-10 17:15:50.649963+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5980	2.59	92234210	36506352	1723532457000	170.6	33649.79	118404.33	250180.2	0.04	-4.94	-12.4	-13.88	2	0	38	4	200	21	668	62	2397529.17	606707	821280
641	2024-12-10 17:26:46.641141+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6014	2.60	92354282	36553877	1723532457000	267.8	33597.79	118432.73	247902.85	0.06	-4.94	-12.39	-13.76	3	0	38	4	200	21	674	62	2399587.06	606467	821911
642	2024-12-10 17:35:36.057548+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6042	2.60	92454167	36593411	1723532457000	121.5	33499.29	118845.03	247235.38	0.03	-4.96	-12.31	-13.8	2	0	38	4	205	21	680	58	2401298.34	606268	822435
643	2024-12-10 17:43:05.142647+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6064	2.60	92531371	36623969	1723532457000	216.8	33564.29	119249.93	239748.51	0.04	-4.94	-12.24	-12.76	2	0	38	4	209	21	683	57	2402620.66	606114	822840
644	2024-12-10 17:49:04.288351+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6072	2.60	92561050	36635716	1723532457000	452.28	33893.07	119924.32	240171.68	-0.01	-4.98	-12.21	-13.13	2	1	38	5	213	22	685	58	2403134.12	606056	822998
645	2024-12-10 17:55:10.035856+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6092	2.60	92634101	36664629	1723532457000	197	19829.56	120307.22	238246.07	0.04	-2.23	-12.14	-13.53	2	0	38	3	217	22	688	58	2404384.86	605911	823381
646	2024-12-10 18:01:43.430616+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6114	2.61	92709948	36694650	1723532457000	214.2	3741.48	120704.62	238643.47	0.04	0.67	-12.07	-13.46	3	0	39	1	222	22	693	58	2405683.18	605760	823778
647	2024-12-10 18:11:17.383185+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6135	2.61	92784662	36724222	1723532457000	132.6	3575.98	118707.98	239034.77	0.03	0.63	-11.87	-13.39	2	0	37	1	220	20	698	58	2406961.77	605612	824170
648	2024-12-10 18:23:15.020564+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6177	2.61	92934275	36783439	1723532457000	255.8	3745.68	117613.66	237013.82	0.05	0.67	-11.83	-13.22	3	0	38	1	216	19	705	58	2409521.19	605315	824953
649	2024-12-10 18:37:03.352914+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5855	2.58	91790857	36330873	1723532457000	7170.68	10780.06	125262.95	244875.71	-1.37	-0.74	-12.95	-14.29	3	1	38	2	223	20	714	59	2390067.62	607621	819033
650	2024-12-10 18:47:03.028504+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5891	2.58	91918419	36381362	1723532457000	415.6	10429.38	125676.53	242544.55	0.09	-0.69	-12.87	-13.7	4	0	37	1	228	20	720	57	2392257.09	607367	819698
651	2024-12-10 18:53:53.13252+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5917	2.59	92009884	36417564	1723532457000	303.9	10522.58	126014.81	243020.65	0.06	-0.67	-12.8	-13.62	3	0	38	1	232	20	725	57	2393826.41	607185	820174
652	2024-12-10 18:59:34.052662+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5932	2.59	92065856	36439718	1723532457000	234.1	10493.08	126299.05	243314.75	0.05	-0.68	-12.75	-13.56	2	0	37	1	234	20	728	57	2394786.56	607072	820468
653	2024-12-10 19:07:23.499842+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5954	2.59	92142060	36469879	1723532457000	214.7	10561.08	126699.55	243715.25	0.04	-0.67	-12.68	-13.49	3	0	38	1	239	20	733	57	2396093.49	606920	820869
654	2024-12-10 19:16:46.974345+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6086	2.60	92610577	36655319	1723532457000	2003.8	12359.88	102078.65	246169.8	0.41	-0.3	-7.72	-13.06	3	0	38	1	242	19	740	56	2404121.47	605984	823327
655	2024-12-10 19:24:37.558769+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6107	2.61	92686002	36685172	1723532457000	227.02	12373.21	101696.57	246571.52	0.02	-0.32	-7.8	-12.99	2	1	38	2	239	20	744	57	2405412.79	605834	823723
656	2024-12-10 19:30:39.566589+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6128	2.61	92760611	36714702	1723532457000	159.1	12343.61	101461.27	246962.32	0.03	-0.3	-7.83	-12.92	2	0	38	2	237	20	748	57	2406689.74	605686	824113
657	2024-12-10 19:37:06.305593+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6160	2.61	92872140	36758846	1723532457000	326.4	5618.62	101189.02	247527.74	0.07	1.18	-7.81	-12.9	3	0	39	1	235	19	752	57	2408598.02	605465	824697
658	2024-12-10 19:42:45.918659+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6173	2.61	92920524	36777996	1723532457000	154	5541.62	99420.04	247780.94	0.03	1.15	-7.61	-12.85	2	0	39	1	232	18	755	57	2409425.66	605369	824950
659	2024-12-10 19:48:48.484139+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6220	2.62	93087356	36844028	1723532457000	682.64	5959.37	99814.29	248653.49	0.14	1.24	-7.54	-12.7	3	0	39	1	232	18	760	57	2412278.41	605039	825823
660	2024-12-10 19:54:49.465052+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6242	2.62	93164116	36874410	1723532457000	264.4	6056.67	100010.19	248537.26	0.05	1.25	-7.5	-12.46	3	0	40	1	234	18	763	57	2413590.45	604888	826224
661	2024-12-10 20:00:55.436465+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6268	2.62	93258023	93258023	1723532457000	366.4	6067.37	100223.19	249027.86	0.08	1.26	-7.46	-12.37	3	0	39	1	235	18	767	57	2415195.14	604703	826715
662	2024-12-10 20:09:42.137115+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6293	2.62	93347362	36946938	1723532457000	231.5	6050.97	100167.89	248526.79	0.05	1.25	-7.46	-10.39	2	0	39	1	235	18	772	56	2416722.25	604492	827276
663	2024-12-10 20:20:28.716849+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6314	2.63	93419469	36975478	1723532457000	233.8	4697.83	99806.32	249688.49	0.05	0.81	-7.4	-10.32	2	0	39	1	236	15	780	57	2417960.67	604387	827562
664	2024-12-10 20:30:40.843753+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6356	2.63	93571053	37035476	1723532457000	366.51	4762.85	99825.34	238811.34	0.08	0.82	-7.39	-10.25	3	0	39	1	235	15	781	55	2420548.56	604090	828352
665	2024-12-10 20:38:42.090673+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6395	2.63	93707058	37089306	1723532457000	252.3	4946.15	99938.04	237429.6	0.05	0.86	-7.36	-9.99	2	0	41	1	237	15	780	54	2422869.37	603824	829061
666	2024-12-10 20:45:24.488653+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6421	2.64	93801373	37126636	1723532457000	269	5049.45	100003.56	237132.7	0.08	0.91	-7.32	-10	3	0	42	1	237	15	778	54	2424478.19	603640	829552
667	2024-12-10 20:51:03.503115+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6478	2.64	94002948	37206420	1723532457000	924.15	5224.11	100680.97	237524.04	0.19	0.94	-7.19	-9.88	4	0	43	1	239	15	778	53	2427915	603247	830602
668	2024-12-10 20:57:01.301461+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7976	2.79	99322263	39311808	1723532457000	27328.63	32111.05	127235.26	261369.89	5.67	6.55	-2.09	-4.34	7	0	46	2	241	16	779	53	2517821.39	593320	857894
669	2024-12-10 21:04:15.536796+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8046	2.80	99569605	39409706	1723532457000	694.34	32905.57	128050.79	261930.61	0.14	6.72	-1.93	-4.23	4	0	48	2	243	15	779	53	2521966.06	592878	859145
670	2024-12-10 21:13:26.644976+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8066	2.80	99640672	39437834	1723532457000	269.1	32994.12	128279.63	261785.41	0.05	6.66	-1.95	-4.33	3	0	48	3	244	16	778	54	2523159.74	592752	859506
671	2024-12-10 21:24:01.292167+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8113	2.81	99805674	39503142	1723532457000	216.2	32671.02	128308.13	259100.39	0.04	6.75	-1.94	-4.02	2	0	48	2	244	16	777	52	2525922.36	592458	860339
672	2024-12-10 21:31:40.462212+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8145	2.81	99920931	39548761	1723532457000	314.33	32528.34	100858.56	259241.22	0.06	6.72	3.69	-4	4	0	48	2	246	14	780	52	2527851.28	592253	860921
673	2024-12-10 21:38:29.357321+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8164	2.81	99988701	39575584	1723532457000	226.6	32388.74	94919.46	259052.79	0.04	6.69	2.81	-4.02	3	0	47	2	244	13	778	52	2528985.17	592133	861263
674	2024-12-10 21:44:09.19016+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8184	2.81	100059946	39603783	1723532457000	244.3	32479.04	94978.16	259025.59	0.05	6.67	2.82	-4.03	2	0	47	2	244	13	777	52	2530176.92	592007	861622
675	2024-12-10 21:50:08.218607+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8210	2.82	100151809	39640143	1723532457000	343.2	31892.93	95074.16	259090.8	0.07	6.54	2.83	-4.01	3	0	45	2	244	13	777	52	2531713.22	591844	862085
676	2024-12-10 21:55:54.455205+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8237	2.82	100246077	39677454	1723532457000	347.4	5002.6	92153.63	258747.27	0.07	0.93	3.53	-4.03	3	0	42	1	245	11	776	51	2533289.29	591678	862560
677	2024-12-10 22:02:40.857493+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8673	2.86	101796506	40291114	1723532457000	7499.33	11532.11	99362.44	265941.4	1.49	2.24	5.01	-2.65	3	0	41	1	245	11	777	51	2559147.62	588971	870340
678	2024-12-10 22:11:26.841747+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8699	2.86	101886441	40326711	1723532457000	200	11394.56	99244.74	264485.17	0.04	2.28	4.98	-2.36	2	0	41	0	245	11	777	50	2560643.96	588816	870790
679	2024-12-10 22:22:08.709073+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8747	2.87	102057879	40394566	1723532457000	251.6	11307.36	98943.72	263979.81	0.05	2.26	5.11	-2.17	3	0	42	0	247	10	779	49	2563495.21	588520	871646
680	2024-12-10 22:32:34.072785+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8985	2.89	102901517	40728478	1723532457000	3791.78	14813.71	102389.4	267443	0.75	2.96	5.82	-1.51	3	0	42	0	248	10	780	49	2577505.35	587079	875850
681	2024-12-10 22:40:31.873236+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9015	2.90	103009605	40771260	1723532457000	245.8	14866.51	102476.4	264637.72	0.05	2.97	5.83	-0.99	2	0	42	0	248	10	780	48	2579297.88	586895	876387
682	2024-12-10 22:46:28.625376+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9042	2.90	103106557	40809634	1723532457000	227.1	14905.71	102644.7	264825.22	0.04	2.98	5.87	-0.95	2	0	42	0	248	10	781	48	2580905.24	586731	876869
683	2024-12-10 22:52:27.092593+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9148	2.91	103482213	40958318	1723532457000	1673.88	16423.1	103537.95	266572.11	0.33	3.28	6.31	-0.59	5	0	46	0	252	9	787	48	2587128.97	586097	878733
684	2024-12-10 22:58:23.92336+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9193	2.91	103642614	41021805	1723532457000	547.9	16686.8	76589.37	267367.11	0.11	3.33	12.12	-0.43	3	0	46	0	253	7	792	48	2589784.38	585827	879528
685	2024-12-10 23:06:36.631027+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9241	2.92	103811828	41088780	1723532457000	275.5	9775.98	74829.11	268205.12	0.05	1.93	12.66	-0.27	3	0	47	0	254	6	799	48	2592584.37	585543	880366
686	2024-12-10 23:16:23.558324+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9275	2.92	103931283	41136061	1723532457000	278.29	9691.66	74920.89	268363.84	0.05	1.91	12.67	-0.17	3	0	47	0	255	6	804	46	2594560.17	585343	880957
687	2024-12-10 23:25:46.850501+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9419	2.94	104443815	104443815	1723532457000	236.3	11567.9	76878.13	270374.58	0.05	2.28	13.09	0.22	2	0	47	0	256	6	805	46	2603030.79	584458	883582
688	2024-12-10 23:32:32.083526+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9494	2.94	104711281	41444784	1723532457000	334.7	8959.32	77794.73	271201.63	0.06	1.76	13.29	0.4	3	0	48	0	258	6	807	45	2607444.89	584045	884809
689	2024-12-10 23:39:14.603748+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9578	2.95	105007717	41562114	1723532457000	1261.81	9882.13	78845.65	272241.25	0.24	1.94	13.51	0.59	3	0	48	0	258	6	807	45	2612335.24	583521	886372
690	2024-12-10 23:44:55.414545+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9537	2.95	104864126	41505280	1723532457000	224.1	10751.9	79857.82	273215.92	0.04	1.7	13.28	0.39	3	0	48	1	259	7	808	46	2609987.04	583796	885572
691	2024-12-10 23:50:47.937915+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9503	2.95	104741401	41456706	1723532457000	1323.3	10341.72	80673.74	272290.62	-0.14	1.22	13.12	-0.19	3	1	45	2	259	7	807	47	2607983.22	584002	884978
692	2024-12-10 23:56:53.237852+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9518	2.95	104796782	41478626	1723532457000	207.2	9819.62	80566.44	272215.32	0.04	1.11	13.09	-0.21	2	0	43	2	258	7	806	47	2608896.9	583911	885251
693	2024-12-11 00:18:23.174335+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9590	2.95	105049988	41578845	1723532457000	299.1	7615.69	80799.04	271770.48	0.06	0.66	13.1	-0.1	3	0	40	3	259	8	806	46	2613073.67	583493	886498
694	2024-12-11 00:37:21.389414+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9648	2.96	105256933	41660754	1723532457000	136.1	5461.77	73630.96	271344.88	0.03	0.24	14.65	-0.17	2	0	37	3	258	7	804	46	2616484.16	583153	887516
695	2024-12-11 01:03:24.250014+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105444537	41735007	1723532457000	50.9	2643.3	72922.16	265202.72	0.01	0.51	14.46	0.33	1	0	29	0	250	7	793	45	2619574.18	582846	888438
696	2024-12-11 01:40:39.837469+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105444537	41735007	1723532457000	0	708.3	68803.33	260037.84	0	0.14	13.49	0.51	0	0	7	0	227	6	772	43	2619574.18	582846	888438
697	2024-12-11 02:16:31.575801+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105444537	41735007	1723532457000	0	0	65501.39	257383.57	0	0	12.91	-0.05	0	0	0	0	201	5	746	43	2619574.18	582846	888438
698	2024-12-11 02:46:53.178595+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105445547	41735407	1723532457000	0	4.95	63265.68	257098.1	0	0	12.36	0.52	0	0	1	0	180	5	746	43	2619590.8	582844	888443
699	2024-12-11 03:08:55.604862+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105445547	41735407	1723532457000	0	4.95	33421.32	257098.1	0	0	5.88	0.52	0	0	1	0	160	3	746	43	2619590.8	582844	888443
700	2024-12-11 03:25:07.585273+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105445547	41735407	1723532457000	0	4.95	32245.42	257098.1	0	0	5.64	0.52	0	0	1	0	149	3	746	43	2619590.8	582844	888443
701	2024-12-11 03:39:30.010923+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105445547	41735407	1723532457000	0	0	31280.18	253760.94	0	0	5.43	0.42	0	0	0	0	138	3	742	42	2619590.8	582844	888443
702	2024-12-11 03:50:04.073633+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105445547	41735407	1723532457000	0	0	30445.18	251769.3	0	0	5.26	0.04	0	0	0	0	131	3	730	42	2619590.8	582844	888443
703	2024-12-11 03:56:50.585538+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105445547	41735407	1723532457000	0	0	29904.88	251477	0	0	5.15	0.2	0	0	0	0	126	3	727	42	2619590.8	582844	888443
704	2024-12-11 04:05:12.891941+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9701	2.97	105445547	41735407	1723532457000	0	0	22135.05	251477	0	0	3.55	0.2	0	0	0	0	120	3	727	42	2619590.8	582844	888443
705	2024-12-11 04:15:32.052505+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.005581	3.0055	106702715	42232995	1723532457000	0	6156.74	27649.4	257633.75	0	1.19	4.65	1.4	0	0	1	0	114	3	728	42	2640255.63	580804	894600
706	2024-12-11 04:28:09.914808+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.005581	3.0055	106702715	42232995	1723532457000	0	6156.74	26756.6	255719.76	0	1.19	4.47	1.2	0	0	1	0	104	3	718	41	2640255.63	580804	894600
707	2024-12-11 04:38:54.717055+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.005581	3.0055	106702715	42232995	1723532457000	0	6156.74	22427.51	255517.45	0	1.19	3.59	1.2	0	0	1	0	96	3	716	40	2640255.63	580804	894600
708	2024-12-11 04:47:04.716961+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.008466	3.0084	106805125	42273529	1723532457000	499.93	6656.68	22255.35	256007.39	0.1	1.29	3.55	1.34	1	0	2	0	91	3	716	40	2641935.83	580639	895100
709	2024-12-11 04:53:21.940807+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.008466	3.0084	106805125	42273529	1723532457000	0	6656.68	20334.36	256007.39	0	1.29	3.16	1.34	0	0	2	0	84	3	716	40	2641935.83	580639	895100
710	2024-12-11 04:59:10.96538+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.007239	3.0072	106761594	42256299	1723532457000	2184.05	8840.73	21867.72	257873.38	-0.04	1.25	2.99	1.26	1	1	3	1	81	4	716	40	2641235.12	580313	896092
711	2024-12-11 05:08:03.550906+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.02845	3.028	107514634	42554353	1723532457000	3669.5	12510.24	24672.12	261215.69	0.71	1.96	3.54	1.95	1	0	4	1	74	4	714	39	2653587.48	579510	898569
712	2024-12-11 05:18:06.714068+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.02845	3.028	107514634	42554353	1723532457000	0	6353.49	22070.69	261145.21	0	0.76	3.02	2.24	0	0	3	1	66	4	713	39	2653587.48	579510	898569
713	2024-12-11 05:29:16.086525+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.02845	3.028	107514634	42554353	1723532457000	0	6353.49	20642.99	261145.21	0	0.76	2.73	2.24	0	0	3	1	58	4	713	39	2653587.48	579510	898569
714	2024-12-11 05:38:09.54808+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.02845	3.028	107514634	42554353	1723532457000	0	6353.49	18898.87	261145.21	0	0.76	2.39	2.24	0	0	3	1	51	4	713	39	2653587.48	579510	898569
715	2024-12-11 05:44:45.814502+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.02845	3.028	107514634	42554353	1723532457000	0	5853.56	17547.4	261145.21	0	0.66	2.53	2.24	0	0	2	1	47	3	713	39	2653587.48	579510	898569
716	2024-12-11 05:50:42.658604+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.02845	3.028	107514634	42554353	1723532457000	0	5853.56	16093.3	261145.21	0	0.66	2.65	2.24	0	0	2	1	43	2	713	39	2653587.48	579510	898569
717	2024-12-11 05:56:39.824092+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.02845	3.028	107514634	42554353	1723532457000	0	5853.56	15682.3	261145.21	0	0.66	2.57	2.24	0	0	2	1	39	2	713	39	2653587.48	579510	898569
718	2024-12-11 06:05:18.61153+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.02845	3.028	107514634	42554353	1723532457000	0	0	15054.7	261145.21	0	0	2.46	2.24	0	0	0	0	33	1	713	39	2653587.48	579510	898569
719	2024-12-11 06:15:49.481373+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04454	3.044	108085973	42780489	1723532457000	4796.17	4796.17	19316.67	265941.38	0.53	0.53	2.9	2.78	1	0	1	0	28	1	714	39	2662953.41	577947	903365
720	2024-12-11 06:29:14.758707+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04454	3.044	108085973	42780489	1723532457000	0	4796.17	18636.17	265941.38	0	0.53	2.77	2.78	0	0	1	0	20	1	714	39	2662953.41	577947	903365
721	2024-12-11 06:41:50.602863+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04454	3.044	108085973	42780489	1723532457000	0	4796.17	17781.47	264274.32	0	0.53	2.6	2.72	0	0	1	0	11	1	712	38	2662953.41	577947	903365
722	2024-12-11 06:50:47.16939+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04454	3.044	108085973	42780489	1723532457000	0	4796.17	17362.27	260532.97	0	0.53	2.52	3.46	0	0	1	0	7	1	703	37	2662953.41	577947	903365
723	2024-12-11 06:56:24.588223+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04454	3.044	108085973	42780489	1723532457000	0	4796.17	17362.27	258520.8	0	0.53	2.52	3.34	0	0	1	0	7	1	698	36	2662953.41	577947	903365
724	2024-12-11 07:03:54.083676+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04454	3.044	108085973	42780489	1723532457000	0	4796.17	17311.37	257600.4	0	0.53	2.51	3.14	0	0	1	0	6	1	690	36	2662953.41	577947	903365
725	2024-12-11 07:13:06.830075+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04911	3.049	108248183	42844692	1723532457000	3805.66	3805.66	21117.03	260553.86	0.15	0.15	2.66	3.06	1	0	1	0	7	1	682	36	2665629.35	576711	907171
726	2024-12-11 07:24:31.613578+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04911	3.049	108248183	42844692	1723532457000	0	3805.66	21117.03	244489.17	0	0.15	2.66	5.77	0	0	1	0	7	1	670	35	2665629.35	576711	907171
727	2024-12-11 07:32:14.677849+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04911	3.049	108248183	42844692	1723532457000	0	3805.66	21117.03	243620.44	0	0.15	2.66	5.79	0	0	1	0	7	1	665	34	2665629.35	576711	907171
728	2024-12-11 07:39:08.593755+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04911	3.049	108248183	42844692	1723532457000	0	3805.66	21117.03	243429.44	0	0.15	2.66	5.75	0	0	1	0	7	1	663	34	2665629.35	576711	907171
729	2024-12-11 07:45:04.296593+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04911	3.049	108248183	42844692	1723532457000	0	3805.66	21117.03	243299.04	0	0.15	2.66	5.71	0	0	1	0	7	1	661	34	2665629.35	576711	907171
730	2024-12-11 07:50:53.590475+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04911	3.049	108248183	42844692	1723532457000	0	3805.66	21117.03	243044.84	0	0.15	2.66	5.67	0	0	1	0	7	1	659	34	2665629.35	576711	907171
731	2024-12-11 07:56:52.222381+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04911	3.049	108248183	42844692	1723532457000	0	3805.66	21117.03	242860.54	0	0.15	2.66	5.62	0	0	1	0	7	1	657	34	2665629.35	576711	907171
732	2024-12-11 08:05:54.25847+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04911	3.049	108248183	42844692	1723532457000	0	3805.66	21117.03	242308.94	0	0.15	2.66	5.51	0	0	1	0	7	1	652	34	2665629.35	576711	907171
733	2024-12-11 08:16:21.88817+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.04911	3.049	108248183	42844692	1723532457000	0	0	21117.03	241484.44	0	0	2.66	5.35	0	0	0	0	7	1	645	34	2665629.35	576711	907171
734	2024-12-11 08:29:40.039337+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9912	2.99	106194952	42032022	1723532457000	15089.67	15089.67	36201.75	253592.95	-1.9	-1.9	0.71	2.8	1	1	1	1	7	2	635	34	2632242.94	581678	892281
735	2024-12-11 08:41:15.98889+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9912	2.99	106194952	42032022	1723532457000	0	15089.67	36201.75	252350.26	0	-1.9	0.71	2.56	0	0	1	1	7	2	626	34	2632242.94	581678	892281
736	2024-12-11 08:50:07.725305+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9901	2.99	106153743	42015711	1723532457000	199.69	15289.37	36401.45	251039.91	-0.04	-1.93	0.67	2.58	0	1	1	2	7	3	620	34	2631569.73	581745	892081
737	2024-12-11 08:56:33.764598+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9365	2.93	104250267	41262314	1723532457000	10770.05	26567.45	47679.53	261853.39	-1.89	-3.69	-1.13	0.65	4	1	6	3	12	4	621	35	2600406.52	584953	882690
738	2024-12-11 09:04:08.390191+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9393	2.93	104351126	41302234	1723532457000	533.65	27309.51	48421.59	262113.25	0.06	-3.6	-1.04	0.65	4	1	13	4	19	5	623	36	2602076.76	584740	883324
739	2024-12-11 09:13:37.781357+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9448	2.94	104546881	41379714	1723532457000	371.3	28275.61	49387.69	262484.25	0.07	-3.42	-0.85	0.73	4	0	23	4	29	5	627	36	2605309.78	584415	884290
740	2024-12-11 09:25:21.364272+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8867	2.88	102482394	40562589	1723532457000	325.5	40391.25	61503.33	273747.89	0.06	-5.33	-2.81	-1.42	4	0	34	5	40	6	631	37	2571345.48	587929	874168
741	2024-12-11 09:34:02.261188+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8939	2.89	102739641	40664408	1723532457000	336.6	26582.48	62784.23	274282.19	0.07	-3.25	-2.57	-1.21	4	0	43	4	50	6	635	36	2575616.89	587490	875448
742	2024-12-11 09:41:37.003829+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8947	2.89	102769747	40676324	1723532457000	0	26732.28	62934.03	274000.39	0	-3.23	-2.54	-1.26	0	0	45	4	52	6	633	36	2576116.57	587439	875598
743	2024-12-11 09:47:33.590358+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8955	2.89	102797244	40687207	1723532457000	0	26869.08	63070.83	273774.99	0	-3.2	-2.51	-1.31	0	0	46	4	53	6	630	36	2576572.91	587392	875735
744	2024-12-11 09:53:28.998888+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8960	2.89	102813005	40693445	1723532457000	0	15857	63149.23	273537.49	0	-1.3	-2.5	-1.36	0	0	45	2	54	6	628	36	2576834.45	587365	875813
745	2024-12-11 09:59:25.219267+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8898	2.88	102594982	40607152	1723532457000	1355.83	16617.13	64505.06	274501.22	-0.21	-1.63	-2.7	-1.64	1	1	40	3	55	7	625	37	2573239.84	587741	874741
746	2024-12-11 10:08:34.751653+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8991	2.89	102925646	40738029	1723532457000	1343.76	17133.93	66150.33	275431.69	0.26	-1.48	-2.39	-1.46	3	0	36	2	61	7	624	37	2578727.93	587178	876386
747	2024-12-11 10:19:11.719121+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9027	2.90	103052938	40788411	1723532457000	143.8	5680.34	60626.23	275528.84	0.03	0.64	-3.42	-1.44	2	0	33	1	67	7	625	37	2580839.22	586962	877019
748	2024-12-11 10:31:34.763877+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9071	2.90	103208213	40849869	1723532457000	265	4948.44	61397.43	275416.24	0.05	0.49	-3.27	-1.46	3	0	28	1	75	7	625	37	2583414.79	586658	877910
749	2024-12-11 10:41:37.454884+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9103	2.91	103322831	40895235	1723532457000	214.2	5052.24	61966.33	275359.94	0.04	0.51	-3.17	-1.46	2	0	29	1	81	7	625	37	2585314.38	586464	878481
750	2024-12-11 10:48:56.725775+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9138	2.91	103446949	40944361	1723532457000	279.9	5589.54	62082.1	275568.64	0.05	0.62	-3.14	-1.43	2	0	33	1	85	7	625	37	2587369.44	586296	878974
751	2024-12-11 10:54:38.502845+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9045	2.90	103115689	40813248	1723532457000	256.4	7996.45	64489.01	277593.85	0.05	0.29	-3.45	-1.81	2	0	37	2	89	8	625	38	2581920.43	586863	877351
752	2024-12-11 11:00:35.971631+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9066	2.90	103189308	40842386	1723532457000	296.2	6921.72	62670.55	277484.12	0.06	0.56	-3.35	-1.85	3	0	39	1	92	7	625	38	2583140.91	586738	877716
753	2024-12-11 11:08:51.907721+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9096	2.90	103295754	40884518	1723532457000	241.4	5684.1	59529.45	277493.42	0.05	0.32	-3.92	-1.83	2	0	37	1	96	7	625	38	2584905.18	586558	878245
754	2024-12-11 11:18:20.453479+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9133	2.91	103429595	40937492	1723532457000	310.3	5920.7	60193.45	277718.92	0.06	0.37	-3.8	-1.79	3	0	38	1	102	7	626	38	2587122.72	586332	878909
755	2024-12-11 11:26:17.715191+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9165	2.91	103542778	40982290	1723532457000	281	5975.68	60754.62	277844.99	0.05	0.38	-3.69	-1.77	3	0	39	1	108	7	627	38	2588997.33	586142	879470
756	2024-12-11 11:32:29.917539+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9189	2.91	103625489	41015027	1723532457000	337	6000.78	61164.52	278041.79	0.07	0.38	-3.62	-1.7	3	0	39	1	112	7	629	38	2590366.85	586003	879880
757	2024-12-11 11:38:51.876453+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9210	2.92	103703299	41045824	1723532457000	259.13	5977.81	61590.66	278467.93	0.04	0.37	-3.54	-1.63	2	1	38	2	116	8	633	39	2591655.33	585872	880265
758	2024-12-11 11:44:45.721761+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9230	2.92	103772521	41073222	1723532457000	273.8	5984.81	61933.46	278810.73	0.05	0.37	-3.48	-1.56	3	0	39	2	120	8	637	39	2592801.01	585756	880608
759	2024-12-11 11:50:46.099411+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9252	2.92	103850334	41104021	1723532457000	319.2	3939.61	62318.66	279195.93	0.06	0.76	-3.41	-1.49	3	0	39	1	124	8	641	39	2594088.58	585626	880993
760	2024-12-11 11:56:45.256649+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9269	2.92	103910591	41127871	1723532457000	231.5	3796.71	62616.86	279494.13	0.05	0.73	-3.35	-1.43	2	0	38	1	127	8	644	39	2595085.48	585525	881292
761	2024-12-11 12:06:49.81165+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9303	2.93	104032826	41176251	1723532457000	314.25	3908.67	63320.72	278258.65	0.04	0.74	-3.24	-1.13	3	1	39	2	134	9	648	38	2597108.19	585321	881897
762	2024-12-11 12:18:22.564868+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9345	2.93	104181833	41235228	1723532457000	351.2	3863.85	59261.14	277216.62	0.07	0.73	-3.61	-1.08	3	0	40	2	141	9	645	37	2599571.73	585072	882633
763	2024-12-11 12:33:59.354312+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9393	2.93	104350997	41302184	1723532457000	300.5	3561.38	60096.74	277292.22	0.06	0.67	-3.46	-1.08	3	0	38	2	151	9	648	37	2602367.29	584790	883469
764	2024-12-11 12:53:17.944053+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9348	2.93	104193122	41239697	1723532457000	247.8	5936.41	63525.6	280384.05	0.05	0.32	-3.6	-1.26	3	0	40	2	164	10	659	38	2599800.65	585060	882710
765	2024-12-11 13:07:07.73754+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9399	2.93	104371248	41310199	1723532457000	298.4	5871.36	64405.4	281253.99	0.06	0.32	-3.44	-1.18	3	0	39	1	173	10	667	38	2602744.2	584764	883590
766	2024-12-11 13:19:26.730473+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9444	2.94	104530756	41373332	1723532457000	341.2	5818.06	61386.93	254660.58	0.07	0.31	-3.43	4.07	3	0	38	1	180	10	668	37	2605377.77	584534	884272
767	2024-12-11 13:33:23.085189+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9481	2.94	104663061	41425699	1723532457000	189.1	3654.6	62039.43	253950.28	0.04	0.71	-3.31	3.92	2	0	38	0	188	10	663	37	2607563.22	584280	885030
768	2024-12-11 13:42:25.596646+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9447	2.94	104542787	41378094	1723532457000	1488.22	4976.02	63837.96	253253.68	0.03	0.49	-3.42	3.94	3	1	39	1	194	11	660	36	2605601.51	584483	884449
769	2024-12-11 13:48:59.257821+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9469	2.94	104619590	41408493	1723532457000	249.7	4684.12	64216.76	253024.88	0.05	0.45	-3.35	3.9	2	0	37	1	198	11	658	36	1807282.79	314205	881348
770	2024-12-11 13:54:56.913045+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9488	2.94	104688691	41435843	1723532457000	225.7	4611.02	64557.46	253160.28	0.04	0.43	-3.29	3.93	2	0	37	1	202	11	660	36	1807897.67	314091	881688
771	2024-12-11 14:01:02.626688+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9508	2.95	104759703	41463950	1723532457000	283.3	4606.12	64907.46	253232.68	0.05	0.43	-3.22	3.94	3	0	37	1	206	11	661	36	1808529.32	313973	882038
772	2024-12-11 14:09:33.045517+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9519	2.95	104799406	41479664	1723532457000	856.11	5318.04	66088.28	253891.69	-0.02	0.38	-3.19	3.87	3	1	38	2	212	12	662	37	1808892.27	313910	882239
773	2024-12-11 14:19:54.082309+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09798	3.097	109983234	43531426	1723532457000	0	29854.24	91320.68	277600.83	0	5.2	1.6	8.99	0	0	35	2	216	12	659	33	1854370.46	305649	907471
774	2024-12-11 14:31:23.410676+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.09798	3.097	109983234	43531426	1723532457000	0	29281.24	76231	276829.14	0	5.08	3.57	8.83	0	0	28	2	215	11	651	33	1854370.46	305649	907471
775	2024-12-11 14:40:16.669292+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.3140	3.31	117654054	46567541	1723532457000	487.03	63826.28	112521.57	312523.5	0.09	12.55	10.79	16.29	1	1	25	2	217	12	648	34	1919277.56	294434	943504
776	2024-12-11 14:47:24.792765+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.3137	3.31	117643616	46563410	1723532457000	0	63510.78	112637.87	312121.02	0	12.45	10.78	16.17	0	0	21	3	218	13	643	35	1919191.34	294424	943539
777	2024-12-11 14:53:25.805141+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.3135	3.31	117635076	46560029	1723532457000	49.28	63219.36	101596.67	311848.41	-0.01	12.37	12.92	16.09	1	1	18	4	217	12	640	36	1919121.01	294436	943499
778	2024-12-11 14:59:10.722741+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.3135	3.31	117635076	46560029	1723532457000	0	62935.96	101000.97	311136.46	0	12.3	12.79	15.92	0	0	15	4	211	12	636	36	1919121.01	294436	943499
779	2024-12-11 15:07:46.479898+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.3172	3.31	117767270	46612352	1723532457000	614.9	62451.55	100618.62	311241.57	0.11	12.41	12.76	15.93	1	0	10	3	203	11	631	35	1920223.18	294252	944114
780	2024-12-11 15:18:03.559441+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.3172	3.31	117767270	46612352	1723532457000	0	37071.05	88475.07	310571.17	0	7.08	15.02	15.77	0	0	5	3	193	10	625	35	1920223.18	294252	944114
781	2024-12-11 15:29:26.520166+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.3633	3.36	119402789	47259691	1723532457000	0	44650.32	94635.45	289871.64	0	8.56	16.3	23.94	0	0	6	3	182	10	619	33	1933802.97	292006	951693
782	2024-12-11 15:38:01.34091+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.3398	3.33	118569667	46929941	1723532457000	0	12661.8	97964.8	287318.39	0	0.87	15.37	21.91	0	0	5	3	176	11	612	33	1926979.91	293284	947455
783	2024-12-11 15:45:18.547363+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2941	3.29	116948194	46288161	1723532457000	8795.87	21277.94	107046.73	296131.62	-1.29	-0.59	13.77	20.13	1	2	4	5	176	14	609	36	1913627.22	295432	940421
784	2024-12-11 15:50:59.416096+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.3126	3.31	117602909	46547298	1723532457000	3050.93	24323.88	110019.27	298815.45	0.56	-0.04	14.39	20.85	2	0	5	5	177	14	607	36	1919097.61	294517	943472
785	2024-12-11 15:57:02.394004+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.3126	3.31	117602909	46547298	1723532457000	0	24279.59	109877.77	295301.53	0	-0.03	14.35	21.4	0	0	5	4	176	14	603	34	1919097.61	294517	943472
786	2024-12-11 16:05:18.926595+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.3126	3.31	117602909	46547298	1723532457000	0	24279.59	108361.94	294738.7	0	-0.03	14.56	21.27	0	0	5	4	173	13	597	34	1919097.61	294517	943472
787	2024-12-11 16:15:31.433563+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2329	3.23	114775220	45428097	1723532457000	19850.43	43515.12	126379.75	313449.12	-2.4	-2.54	11.41	18.3	1	2	5	6	166	15	592	35	1895678.45	298573	930400
788	2024-12-11 16:28:34.89465+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2135	3.21	114085331	114085331	1723532457000	3222.02	39157.87	128772.87	315744.14	-0.6	-4.45	10.56	17.38	0	1	4	7	157	16	583	36	1889899.12	299583	927178
789	2024-12-11 16:41:02.707198+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2135	3.21	114085331	45155039	1723532457000	0	34919.26	127995.37	314988.14	0	-3.71	10.39	17.2	0	0	4	5	149	16	575	36	1889899.12	299583	927178
790	2024-12-11 16:50:34.896105+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2142	3.21	114109356	45164547	1723532457000	0	23185.95	125465.17	313928.61	0	-2.97	10.72	17.22	0	0	3	3	145	15	571	35	1890102.98	299548	927292
791	2024-12-11 16:57:08.074279+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2142	3.21	114109356	45164547	1723532457000	0	23185.95	125024.07	286209.93	0	-2.97	10.62	23.44	0	0	3	3	141	15	567	33	1890102.98	299548	927292
792	2024-12-11 17:04:28.416167+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2164	3.21	114189493	45196266	1723532457000	378.51	23564.46	124934.68	284067.36	0.07	-2.9	10.6	23.95	1	0	4	3	137	15	564	32	1890782.8	299431	927670
793	2024-12-11 17:13:32.165931+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2164	3.21	114189493	45196266	1723532457000	0	3714.03	124255.98	283409.46	0	-0.51	10.45	23.79	0	0	3	1	131	15	556	32	1890782.8	299431	927670
794	2024-12-11 17:24:05.551844+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2183	3.21	114257651	45223243	1723532457000	321.83	4035.86	123908.23	283220.39	0.06	-0.45	10.37	23.72	1	0	4	1	125	15	551	32	1891360.79	299332	927992
795	2024-12-11 17:33:09.867034+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2183	3.21	114257651	45223243	1723532457000	0	813.84	123273.13	282647.19	0	0.15	10.24	23.58	0	0	4	0	119	15	545	32	1891360.79	299332	927992
796	2024-12-11 17:40:39.598879+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2183	3.21	114257651	45223243	1723532457000	0	813.84	122791.9	282171.89	0	0.15	10.14	23.45	0	0	4	0	114	14	540	32	1891360.79	299332	927992
797	2024-12-11 17:46:38.092718+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2183	3.21	114257651	45223243	1723532457000	0	700.34	122465.6	281497.51	0	0.13	10.07	23.41	0	0	2	0	110	14	536	31	1891360.79	299332	927992
798	2024-12-11 17:52:40.147801+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2145	3.21	114121432	45169327	1723532457000	0	1337.2	122796.06	281811.47	0	0.01	9.88	23.2	0	0	2	1	107	15	533	32	1890218.31	299532	927355
799	2024-12-11 17:58:50.135656+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2145	3.21	114121432	45169327	1723532457000	0	1337.2	122390.26	281513.97	0	0.01	9.79	23.11	0	0	2	1	103	15	529	32	1890218.31	299532	927355
800	2024-12-11 18:09:58.329784+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2145	3.21	114121432	45169327	1723532457000	0	958.69	121699.51	280962.77	0	-0.06	9.66	22.98	0	0	1	1	95	14	522	32	1890218.31	299532	927355
801	2024-12-11 18:21:34.409673+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2145	3.21	114121432	45169327	1723532457000	0	636.86	120912.81	280179.67	0	-0.12	9.5	22.76	0	0	0	1	87	14	514	32	1890218.31	299532	927355
802	2024-12-11 18:35:47.916705+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2030	3.20	113713557	45007890	1723532457000	0	2546.06	119976.45	274226.99	0	-0.48	9.39	23.87	0	0	0	3	78	15	505	33	1886792.82	300133	925446
803	2024-12-11 18:46:03.320276+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2039	3.20	113745652	45020593	1723532457000	0	2697.94	119225.03	273766.07	0	-0.45	9.23	23.72	0	0	1	3	72	15	500	33	1887065.66	300086	925598
804	2024-12-11 18:53:26.582985+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2033	3.20	113723015	45011634	1723532457000	35.39	2167.12	118892.38	273396.01	-0.01	-0.35	9.12	23.58	0	1	1	5	67	18	495	36	1886875.38	300120	925492
805	2024-12-11 18:59:14.87187+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2022	3.20	113686280	44997094	1723532457000	137.47	2339.24	118769.39	273274.03	-0.03	-0.38	9.02	23.47	0	3	1	9	64	22	492	40	1886566.53	300174	925319
806	2024-12-11 19:07:10.381946+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2002	3.20	113614715	44968768	1723532457000	149.43	2674.61	118654.47	273208.91	-0.03	-0.44	8.86	23.27	0	2	1	14	59	27	487	45	1885964.72	300280	924984
807	2024-12-11 19:16:17.628471+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1992	3.19	113577147	44953899	1723532457000	41.88	2850.72	118276.27	270926.31	-0.01	-0.48	8.7	22.62	0	1	1	18	53	31	480	49	1885648.7	300335	924808
808	2024-12-11 19:23:54.328606+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2048	3.20	113778633	45033647	1723532457000	0	1895.17	118814.52	271374.83	0	0.06	8.81	22.7	0	0	2	16	49	31	476	48	1887361.93	300041	925762
809	2024-12-11 19:29:39.329088+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2048	3.20	113778633	45033647	1723532457000	0	1895.17	118448.22	270951.03	0	0.06	8.73	22.59	0	0	2	16	45	31	472	48	1887361.93	300041	925762
810	2024-12-11 19:36:19.383035+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2048	3.20	113778633	45033647	1723532457000	0	1895.17	118034.22	270503.53	0	0.06	8.64	22.49	0	0	2	16	41	31	468	48	1887361.93	300041	925762
811	2024-12-11 19:42:04.992722+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2048	3.20	113778633	45033647	1723532457000	0	1743.29	116483.8	270250.33	0	0.03	8.82	22.43	0	0	1	16	37	30	465	48	1887361.93	300041	925762
812	2024-12-11 19:48:00.28448+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2049	3.20	113779427	45033962	1723532457000	3.76	1676.4	116170.96	269381.55	0	0.04	8.76	22.19	1	0	2	14	35	30	461	48	1887368.69	300039	925765
813	2024-12-11 19:54:05.507491+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2049	3.20	113779427	45033962	1723532457000	0	1606.36	115830.26	268980.35	0	0.06	8.68	22.1	0	0	2	12	31	30	457	48	1887368.69	300039	925765
814	2024-12-11 19:59:47.876903+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2049	3.20	113779427	45033962	1723532457000	0	1417.62	115480.26	268489.75	0	0.09	8.61	21.99	0	0	2	8	27	30	453	48	1887368.69	300039	925765
815	2024-12-11 20:08:44.185467+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	2499.89	115764.79	269394.1	0	-0.11	8.27	21.51	0	0	2	3	21	30	447	49	1884739.13	300502	924300
816	2024-12-11 20:19:23.56707+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	1469.1	90532.39	268326.9	0	-0.27	3.17	21.43	0	0	1	1	17	30	440	48	1884739.13	300502	924300
817	2024-12-11 20:30:03.496434+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	1469.1	90532.39	267470.59	0	-0.27	3.17	21.22	0	0	1	1	17	30	432	48	1884739.13	300502	924300
818	2024-12-11 20:37:57.182614+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	1469.1	54728.11	266749.09	0	-0.27	-3.47	21.04	0	0	1	1	16	29	425	48	1884739.13	300502	924300
819	2024-12-11 20:44:48.075478+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	1469.1	54125.52	266480.09	0	-0.27	-3.55	20.94	0	0	1	1	14	28	422	48	1884739.13	300502	924300
820	2024-12-11 20:50:44.141477+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	1465.34	54120.52	265394.18	0	-0.27	-3.55	20.69	0	0	0	1	13	28	416	47	1884739.13	300502	924300
821	2024-12-11 20:56:27.187648+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	1465.34	54076.24	237937.74	0	-0.27	-3.54	14.13	0	0	0	1	13	27	408	47	1884739.13	300502	924300
822	2024-12-11 21:03:19.960882+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	1465.34	54076.24	236814.52	0	-0.27	-3.54	13.94	0	0	0	1	13	27	402	47	1884739.13	300502	924300
823	2024-12-11 21:12:21.29279+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	0	53461.34	236117.38	0	0	-3.65	13.84	0	0	0	0	12	27	396	46	1884739.13	300502	924300
824	2024-12-11 21:23:04.612632+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	0	45882.06	235283.98	0	0	-4.97	13.67	0	0	0	0	11	27	389	46	1884739.13	300502	924300
825	2024-12-11 21:31:03.661905+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	0	45882.06	234702.24	0	0	-4.97	13.53	0	0	0	0	11	27	382	46	1884739.13	300502	924300
826	2024-12-11 21:38:02.07218+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	0	41643.45	234360.34	0	0	-4.23	13.45	0	0	0	0	11	25	378	46	1884739.13	300502	924300
827	2024-12-11 21:43:44.265694+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	0	40429.62	233881.14	0	0	-4.32	13.35	0	0	0	0	10	24	374	46	1884739.13	300502	924300
828	2024-12-11 21:49:36.354901+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	0	29796.64	233537.94	0	0	-3.52	13.27	0	0	0	0	8	23	371	46	1884739.13	300502	924300
829	2024-12-11 21:55:24.396909+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	0	29796.64	233062.94	0	0	-3.52	13.16	0	0	0	0	8	23	367	46	1884739.13	300502	924300
830	2024-12-11 22:01:49.767835+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	0	29796.64	225282.41	0	0	-3.52	11.44	0	0	0	0	8	23	361	46	1884739.13	300502	924300
831	2024-12-11 22:10:35.656236+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	0	26407.58	224718.01	0	0	-4.11	11.32	0	0	0	0	7	23	355	46	1884739.13	300502	924300
832	2024-12-11 22:21:07.146655+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1961	3.19	113466780	44910216	1723532457000	0	0	9946.21	223976.61	0	0	-1.14	11.15	0	0	0	0	7	21	347	46	1884739.13	300502	924300
833	2024-12-11 22:32:22.525537+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1966	3.19	113484691	44917305	1723532457000	0	84.85	6809.04	219858.08	0	0.02	-0.53	10.26	0	0	1	0	8	20	340	46	1884891.58	300476	924385
834	2024-12-11 22:40:51.995687+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1913	3.19	113298558	44843633	1723532457000	0	1487.26	8211.45	220618.59	0	-0.15	-0.69	9.93	0	0	2	1	9	21	335	47	1883329.61	300753	923514
835	2024-12-11 22:47:22.290743+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1913	3.19	113298558	44843633	1723532457000	0	1487.26	8097.95	220051.09	0	-0.15	-0.71	9.74	0	0	2	1	7	21	330	47	1883329.61	300753	923514
836	2024-12-11 22:53:20.752513+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1913	3.19	113298558	44843633	1723532457000	0	1487.26	8097.95	218130.1	0	-0.15	-0.71	9.37	0	0	2	1	7	21	323	47	1883329.61	300753	923514
837	2024-12-11 22:58:58.479025+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1913	3.19	113298558	44843633	1723532457000	0	1487.26	8097.95	217479.4	0	-0.15	-0.71	9.28	0	0	2	1	7	21	319	47	1883329.61	300753	923514
838	2024-12-11 23:07:22.044609+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1913	3.19	113298558	44843633	1723532457000	0	1487.26	7719.44	216614.31	0	-0.15	-0.78	9.09	0	0	2	1	6	21	311	47	1883329.61	300753	923514
839	2024-12-11 23:17:07.32979+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1913	3.19	113298558	44843633	1723532457000	0	1487.26	7719.44	214012.87	0	-0.15	-0.78	8.55	0	0	2	1	6	21	303	47	1883329.61	300753	923514
840	2024-12-11 23:26:28.864142+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1925	3.19	113338691	44859518	1723532457000	0	1592.66	7587.86	212963.82	0	-0.13	-0.8	8.31	0	0	2	1	6	21	298	47	1883671.46	300694	923705
841	2024-12-11 23:33:23.480355+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1925	3.19	113338691	44859518	1723532457000	0	1326.76	7587.86	212293.12	0	-0.18	-0.8	8.17	0	0	1	1	6	21	292	47	1883671.46	300694	923705
842	2024-12-11 23:40:19.315783+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1925	3.19	113338691	44859518	1723532457000	0	190.25	7587.86	209903.93	0	0.04	-0.8	8.11	0	0	1	0	6	21	288	46	1883671.46	300694	923705
843	2024-12-11 23:46:02.516809+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1925	3.19	113338691	44859518	1723532457000	0	190.25	7587.86	209549.03	0	0.04	-0.8	8.04	0	0	1	0	6	21	284	46	1883671.46	300694	923705
844	2024-12-11 23:52:01.096021+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1925	3.19	113338691	44859518	1723532457000	0	190.25	6951	208160.03	0	0.04	-0.69	8.18	0	0	1	0	6	20	280	45	1883671.46	300694	923705
845	2024-12-11 23:58:05.534612+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1925	3.19	113338691	44859518	1723532457000	0	190.25	6951	207749.73	0	0.04	-0.69	8.08	0	0	1	0	6	20	276	45	1883671.46	300694	923705
846	2024-12-12 00:28:08.969927+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1919	3.19	113318651	44851586	1723532457000	0	94.04	5135.84	206066.48	0	-0.02	-0.35	7.73	0	0	0	1	6	19	257	45	1883502.66	300723	923611
847	2024-12-12 00:50:05.4495+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1963	3.19	113475178	44913539	1723532457000	0	835.82	5655.09	205534.35	0	0.12	-0.22	7.62	0	0	1	1	6	17	245	45	1884835.47	300493	924352
848	2024-12-12 01:21:23.666351+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1960	3.19	113465162	44909575	1723532457000	0	788.75	4029.42	205530.43	0	0.13	-0.28	7.61	0	0	1	1	5	4	244	46	1884751.17	300508	924305
849	2024-12-12 02:02:34.028714+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1960	3.19	113465964	44909893	1723532457000	0	50.77	4029.47	205534.23	0	-0.01	-0.28	7.61	0	0	1	1	5	4	245	46	1884758	300507	924309
850	2024-12-12 02:37:40.913534+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1960	3.19	113465964	44909893	1723532457000	0	3.8	2564.12	205529.27	0	0	0	6.34	0	0	1	0	5	3	244	46	1884758	300507	924309
851	2024-12-12 03:02:19.066756+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	2017.09	2050.23	4614.35	207579.51	0	0.38	0.38	6.74	2	0	3	0	8	3	247	46	1888441.32	299873	926359
852	2024-12-12 03:22:45.938227+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	2050.23	4614.35	207579.51	0	0.38	0.38	6.74	0	0	3	0	8	3	247	46	1888441.32	299873	926359
853	2024-12-12 03:38:03.901739+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	2050.23	4614.35	207579.51	0	0.38	0.38	6.74	0	0	3	0	8	3	247	46	1888441.32	299873	926359
854	2024-12-12 03:49:12.126154+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	2050.23	4614.35	207579.51	0	0.38	0.38	6.74	0	0	3	0	8	3	247	46	1888441.32	299873	926359
855	2024-12-12 03:56:31.119098+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	2017.09	4614.35	207579.51	0	0.38	0.38	6.74	0	0	2	0	8	3	247	46	1888441.32	299873	926359
856	2024-12-12 04:04:39.99+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	0	4614.35	207579.51	0	0	0.38	6.74	0	0	0	0	8	3	247	46	1888441.32	299873	926359
857	2024-12-12 04:14:35.872285+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	0	4614.35	201422.76	0	0	0.38	6.64	0	0	0	0	8	3	246	46	1888441.32	299873	926359
858	2024-12-12 04:26:58.329632+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	0	4529.5	201422.76	0	0	0.37	6.64	0	0	0	0	7	3	246	46	1888441.32	299873	926359
859	2024-12-12 04:38:14.641497+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	0	3127.08	201422.76	0	0	0.53	6.64	0	0	0	0	6	2	246	46	1888441.32	299873	926359
860	2024-12-12 04:46:42.733164+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	0	3127.08	200922.82	0	0	0.53	6.44	0	0	0	0	6	2	245	46	1888441.32	299873	926359
861	2024-12-12 04:53:31.011248+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	0	3127.08	200922.82	0	0	0.53	6.44	0	0	0	0	6	2	245	46	1888441.32	299873	926359
862	2024-12-12 04:59:14.350527+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	0	3127.08	198738.77	0	0	0.53	5.94	0	0	0	0	6	2	244	45	1888441.32	299873	926359
863	2024-12-12 05:08:25.537849+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	0	3127.08	195069.26	0	0	0.53	5.38	0	0	0	0	6	2	243	45	1888441.32	299873	926359
864	2024-12-12 05:18:24.377111+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	0	3127.08	195069.26	0	0	0.53	5.38	0	0	0	0	6	2	243	45	1888441.32	299873	926359
865	2024-12-12 05:29:37.202933+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	0	2936.83	195069.26	0	0	0.49	5.38	0	0	0	0	5	2	243	45	1888441.32	299873	926359
866	2024-12-12 05:38:22.485455+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.2082	3.20	113899142	45081344	1723532457000	0	0	2936.83	195069.26	0	0	0.49	5.38	0	0	0	0	5	2	243	45	1888441.32	299873	926359
867	2024-12-12 05:45:10.28909+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1458	3.14	111682381	44203949	1723532457000	10428.14	10428.14	13364.97	205497.41	-1.95	-1.95	-1.46	3.33	0	1	0	1	5	3	243	46	1869719.14	303189	915931
868	2024-12-12 05:51:06.795909+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1458	3.14	111682381	44203949	1723532457000	0	10428.14	13364.97	205497.41	0	-1.95	-1.46	3.33	0	0	0	1	5	3	243	46	1869719.14	303189	915931
869	2024-12-12 05:57:03.45248+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1458	3.14	111682381	44203949	1723532457000	0	10428.14	13364.97	205497.41	0	-1.95	-1.46	3.33	0	0	0	1	5	3	243	46	1869719.14	303189	915931
870	2024-12-12 06:06:36.688284+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1458	3.14	111682381	44203949	1723532457000	0	10428.14	13270.93	205497.41	0	-1.95	-1.44	3.33	0	0	0	1	5	2	243	46	1869719.14	303189	915931
871	2024-12-12 06:17:38.858677+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1458	3.14	111682381	44203949	1723532457000	0	10428.14	13270.93	200701.23	0	-1.95	-1.44	3.17	0	0	0	1	5	2	242	46	1869719.14	303189	915931
872	2024-12-12 06:31:32.517696+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1458	3.14	111682381	44203949	1723532457000	0	10428.14	13270.93	200701.23	0	-1.95	-1.44	3.17	0	0	0	1	5	2	242	46	1869719.14	303189	915931
873	2024-12-12 06:43:43.465468+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1467	3.14	111713938	44216440	1723532457000	0	150.68	12679.83	200851.92	0	0.03	-1.55	3.2	0	0	1	0	5	2	243	46	1869990.14	303141	916082
874	2024-12-12 06:52:08.905202+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1467	3.14	111713938	44216440	1723532457000	0	150.68	12679.83	200851.92	0	0.03	-1.55	3.2	0	0	1	0	5	2	243	46	1869990.14	303141	916082
875	2024-12-12 06:58:01.767954+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1467	3.14	111713938	44216440	1723532457000	0	150.68	12679.83	200851.92	0	0.03	-1.55	3.2	0	0	1	0	5	2	243	46	1869990.14	303141	916082
876	2024-12-12 07:06:49.226725+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1467	3.14	111713938	44216440	1723532457000	0	150.68	12679.83	200851.92	0	0.03	-1.55	3.2	0	0	1	0	5	2	243	46	1869990.14	303141	916082
877	2024-12-12 07:16:51.728488+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1467	3.14	111713938	44216440	1723532457000	0	150.68	12632.86	197046.25	0	0.03	-1.54	5.22	0	0	1	0	5	1	242	46	1869990.14	303141	916082
878	2024-12-12 07:27:19.940509+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1467	3.14	111713938	44216440	1723532457000	0	150.68	12632.86	197046.25	0	0.03	-1.54	5.22	0	0	1	0	5	1	242	46	1869990.14	303141	916082
879	2024-12-12 07:34:25.277095+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1467	3.14	111713938	44216440	1723532457000	0	150.68	12632.86	197046.25	0	0.03	-1.54	5.22	0	0	1	0	5	1	242	46	1869990.14	303141	916082
880	2024-12-12 07:41:13.287625+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1467	3.14	111714534	44216676	1723532457000	10.2	10.2	12643.06	197056.46	0	0	-1.54	5.22	2	1	2	1	7	2	244	47	1869995.33	303141	916085
881	2024-12-12 07:47:08.351323+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1467	3.14	111714534	44216676	1723532457000	0	10.2	12639.26	197056.46	0	0	-1.54	5.22	0	0	2	1	6	2	244	47	1869995.33	303141	916085
882	2024-12-12 07:52:47.80975+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1467	3.14	111714534	44216676	1723532457000	0	10.2	12639.26	197056.46	0	0	-1.54	5.22	0	0	2	1	6	2	244	47	1869995.33	303141	916085
883	2024-12-12 07:58:29.091961+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1457	3.14	111678385	44202368	1723532457000	170.88	181.08	12810.14	197227.34	-0.03	-0.03	-1.58	5.18	0	1	2	2	6	3	244	48	1869688.35	303195	915914
884	2024-12-12 08:09:36.325046+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1457	3.14	111678385	44202368	1723532457000	0	181.08	12810.14	197227.34	0	-0.03	-1.58	5.18	0	0	2	2	6	3	244	48	1869688.35	303195	915914
885	2024-12-12 08:21:00.268979+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1457	3.14	111678385	44202368	1723532457000	0	181.08	12810.14	197227.34	0	-0.03	-1.58	5.18	0	0	2	2	6	3	244	48	1869688.35	303195	915914
886	2024-12-12 08:33:51.885311+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1457	3.14	111678385	44202368	1723532457000	0	181.08	12810.14	182137.67	0	-0.03	-1.58	5.2	0	0	2	2	6	3	243	47	1869688.35	303195	915914
887	2024-12-12 08:43:32.462213+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1457	3.14	111678385	44202368	1723532457000	0	170.88	12810.14	182137.67	0	-0.03	-1.58	5.2	0	0	0	1	6	3	243	47	1869688.35	303195	915914
888	2024-12-12 08:51:29.553145+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1457	3.14	111678385	44202368	1723532457000	0	170.88	12777.01	181937.97	0	-0.03	-1.58	5.1	0	0	0	1	5	3	243	46	1869688.35	303195	915914
889	2024-12-12 08:57:14.364691+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1476	3.14	111745341	44228869	1723532457000	0	319.68	13096.69	170914.37	0	0.06	-1.52	7.17	0	0	1	0	6	3	238	45	1870263.29	303095	916234
890	2024-12-12 09:05:21.671728+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1480	3.14	111761675	44235334	1723532457000	77.97	397.66	11157.57	170165.09	0.01	0.07	-1.88	7.05	2	0	3	0	6	3	232	44	1870403.51	303070	916312
891	2024-12-12 09:15:08.416222+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1295	3.12	111105092	43975458	1723532457000	0	3505.09	14265	172258.82	0	-0.51	-2.45	6.21	0	0	3	3	6	6	222	47	1864820.53	304070	913204
892	2024-12-12 09:27:11.152766+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1309	3.13	111152658	43994285	1723532457000	227.7	3732.79	14492.7	160162.38	0.04	-0.47	-2.41	8.29	1	0	4	3	7	6	211	46	1865230.16	303998	913432
893	2024-12-12 09:35:27.066363+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1309	3.13	111152658	43994285	1723532457000	0	3732.79	14492.7	159138.18	0	-0.47	-2.41	8.13	0	0	4	3	7	6	202	46	1865230.16	303998	913432
894	2024-12-12 09:42:47.117688+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1309	3.13	111152658	43994285	1723532457000	0	3732.79	14492.7	159001.38	0	-0.47	-2.41	8.11	0	0	4	3	7	6	201	46	1865230.16	303998	913432
895	2024-12-12 09:48:49.694616+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1309	3.13	111152658	43994285	1723532457000	0	3732.79	14492.7	158922.98	0	-0.47	-2.41	8.08	0	0	4	3	7	6	200	46	1865230.16	303998	913432
896	2024-12-12 09:54:33.044077+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1309	3.13	111152658	43994285	1723532457000	0	3413.1	14492.7	158922.98	0	-0.53	-2.41	8.08	0	0	3	3	7	6	200	46	1865230.16	303998	913432
897	2024-12-12 10:00:28.009315+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1309	3.13	111152658	43994285	1723532457000	0	3413.09	14492.7	157482.64	0	-0.53	-2.41	8.29	0	0	2	3	7	6	198	45	1865230.16	303998	913432
898	2024-12-12 10:09:16.53301+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1291	3.12	111088583	43968924	1723532457000	303.67	531.37	14796.38	156020.3	-0.06	-0.01	-2.47	7.86	0	1	1	1	7	7	191	46	1864684.46	304096	913128
899	2024-12-12 10:19:53.793782+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1289	3.12	111084009	43967113	1723532457000	0	553.05	14818.06	155391.39	0	-0.02	-2.47	7.73	0	0	1	2	7	8	184	47	1864645.5	304103	913106
900	2024-12-12 10:32:20.050469+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1290	3.12	111086080	43967933	1723532457000	0	335.27	14827.98	154733.5	0	-0.06	-2.47	7.6	0	0	1	2	8	8	178	47	1864663.34	304100	913116
901	2024-12-12 10:41:55.701772+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1290	3.12	111086080	43967933	1723532457000	0	335.27	14827.98	154020.3	0	-0.06	-2.47	7.44	0	0	1	2	8	8	171	47	1864663.34	304100	913116
902	2024-12-12 10:49:09.919955+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1290	3.12	111086080	43967933	1723532457000	0	335.27	14827.98	151583.8	0	-0.06	-2.47	7.78	0	0	1	2	8	8	167	46	1864663.34	304100	913116
903	2024-12-12 10:54:56.930684+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1290	3.12	111086080	43967933	1723532457000	0	335.27	14827.98	151192.4	0	-0.06	-2.47	7.69	0	0	1	2	8	8	163	46	1864663.34	304100	913116
904	2024-12-12 11:01:04.974042+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1290	3.12	111086080	43967933	1723532457000	0	335.27	14827.98	150797.3	0	-0.06	-2.47	7.62	0	0	1	2	8	8	159	46	1864663.34	304100	913116
905	2024-12-12 11:09:26.032468+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1290	3.12	111086080	43967933	1723532457000	0	9.91	14827.98	150229.8	0	0	-2.47	7.5	0	0	1	0	8	8	154	46	1864663.34	304100	913116
906	2024-12-12 11:19:09.70827+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1290	3.12	111086080	43967933	1723532457000	0	9.91	14827.98	149554.52	0	0	-2.47	7.34	0	0	1	0	8	8	147	46	1864663.34	304100	913116
907	2024-12-12 11:26:48.489817+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1290	3.12	111086080	43967933	1723532457000	0	0	14827.98	149069.72	0	0	-2.47	7.24	0	0	0	0	8	8	142	46	1864663.34	304100	913116
908	2024-12-12 11:33:23.581149+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1882	3.18	113185984	44799076	1723532457000	10007.27	10007.27	24835.26	158573	1.89	1.89	-0.63	9.19	3	0	3	0	11	8	140	46	1882657.67	300963	923124
909	2024-12-12 11:39:43.070051+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1783	3.17	112837609	44661189	1723532457000	0	11644.48	26472.47	159882.07	0	1.58	-0.93	8.77	0	0	3	1	11	9	137	46	1879718.31	301483	921486
910	2024-12-12 11:45:41.407928+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1786	3.17	112847965	44665288	1723532457000	49.19	11693.68	16093.52	159591.47	0.01	1.59	1.04	8.71	1	0	4	1	12	8	134	46	1879806.75	301468	921536
911	2024-12-12 11:51:39.45909+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1786	3.17	112848382	44665453	1723532457000	0	11695.66	16095.5	159207.55	0	1.59	1.04	8.63	0	0	5	1	13	8	131	46	1879810.31	301467	921538
912	2024-12-12 11:57:16.280688+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1786	3.17	112848382	44665453	1723532457000	0	11695.66	16095.5	158857.65	0	1.59	1.04	8.56	0	0	5	1	13	8	128	46	1879810.31	301467	921538
913	2024-12-12 12:08:15.681477+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1786	3.17	112848382	44665453	1723532457000	0	11695.66	16095.5	158208	0	1.59	1.04	8.44	0	0	5	1	13	8	120	45	1879810.31	301467	921538
914	2024-12-12 12:20:16.485995+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1786	3.17	112848382	44665453	1723532457000	0	11695.66	16095.5	157422.2	0	1.59	1.04	8.27	0	0	5	1	13	8	112	45	1879810.31	301467	921538
915	2024-12-12 12:36:34.931593+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1786	3.17	112848382	44665453	1723532457000	0	51.17	15944.82	154478.74	0	0.01	1.02	8.54	0	0	2	0	12	8	102	44	1879810.31	301467	921538
916	2024-12-12 12:54:58.302507+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1786	3.17	112848382	44665453	1723532457000	0	0	15944.82	153044.64	0	0	1.02	8.24	0	0	0	0	12	8	89	44	1879810.31	301467	921538
917	2024-12-12 13:08:16.364456+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9889	2.98	106113904	41999943	1723532457000	32923.14	32923.14	48867.96	185233.38	-5.97	-5.97	-5.01	1.64	1	5	1	5	13	13	82	49	1821971.67	312004	889392
918	2024-12-12 13:20:42.61807+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9027	2.90	103053646	40788691	1723532457000	387.7	50039.67	65984.5	201564.31	0.08	-8.68	-7.75	-1.44	5	0	13	7	25	15	86	51	1795029.72	317149	874408
919	2024-12-12 13:33:58.841396+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9055	2.90	103150562	40827051	1723532457000	291.6	53601.56	69546.38	204329.5	0.06	-8.59	-7.67	-1.5	3	0	25	8	37	16	89	52	1795933.17	316954	875015
920	2024-12-12 13:42:53.619554+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9113	2.91	103358733	40909445	1723532457000	366	54634.86	70569.48	203725.78	0.07	-8.41	-7.48	-1.16	4	0	35	8	45	15	94	51	1797800.54	316621	875991
921	2024-12-12 13:49:10.25558+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9153	2.91	103499739	40965255	1723532457000	564.11	55334.18	71268.8	204052.69	0.11	-8.28	-7.35	-1.09	3	0	40	8	50	15	95	51	1799064.62	316384	876690
922	2024-12-12 13:55:08.371109+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9153	2.91	103499739	40965255	1723532457000	0	55334.18	71268.8	203701.09	0	-8.28	-7.35	-1.17	0	0	40	8	50	15	91	51	1799064.62	316384	876690
923	2024-12-12 14:01:36.67745+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9027	2.90	103051118	40787691	1723532457000	2404.13	57738.31	73502.04	205685.72	-0.43	-8.68	-7.73	-1.67	1	2	41	10	51	16	88	53	1795086.03	317149	874487
924	2024-12-12 14:10:21.175873+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9013	2.90	103002726	40768537	1723532457000	1075.13	9941.47	74860.08	205999.14	-0.12	0.11	-7.77	-1.74	3	1	43	4	56	17	88	53	1794667.32	317234	874255
925	2024-12-12 14:20:49.374366+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9061	2.90	103172531	40835746	1723532457000	317.1	8915.25	75703.62	181610.29	0.06	-0.08	-7.62	-12.23	3	0	40	4	65	17	93	53	1796191.22	316988	874977
926	2024-12-12 14:32:02.099911+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9106	2.91	103334002	40899656	1723532457000	340	7139.82	76505.12	146608.25	0.07	0.18	-7.47	-12.09	3	0	37	3	72	17	99	53	1797641.38	316674	875900
927	2024-12-12 14:40:40.277976+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9129	2.91	103412718	40930812	1723532457000	206.45	6725.74	77052.74	146552.54	0.04	0.07	-7.4	-12.1	3	0	34	4	78	18	103	52	1798348.86	316541	876291
928	2024-12-12 14:47:24.975183+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8582	2.85	101472662	40162937	1723532457000	10356.68	16382.31	87480.23	156980.02	-1.89	-1.96	-9.14	-13.75	3	1	32	5	82	19	107	53	1781064.9	319893	866724
929	2024-12-12 14:53:11.433144+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8627	2.86	101632899	40226359	1723532457000	691.9	17184.31	87962.54	157732.74	0.14	-1.8	-9.05	-13.7	5	0	38	5	87	19	112	52	1782516.14	319616	867526
930	2024-12-12 14:58:58.699367+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8646	2.86	101698328	40252256	1723532457000	240.2	15207.88	88289.84	158060.04	0.05	-1.29	-8.99	-13.64	3	0	42	3	91	19	116	52	1783108.37	319503	867853
931	2024-12-12 15:07:47.602439+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8709	2.87	101923561	40341403	1723532457000	849.89	14925.64	86230.33	158571.03	0.17	-1.04	-8.26	-14.64	3	0	43	2	95	16	121	52	1785145.42	319114	868979
932	2024-12-12 15:18:13.533228+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8748	2.87	102062660	40396458	1723532457000	299.8	14992.89	86925.03	159265.73	0.06	-1.02	-8.14	-14.52	3	0	42	2	102	16	128	52	1786402.22	318875	869674
933	2024-12-12 15:29:37.16119+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8882	2.88	102538007	40584601	1723532457000	856.6	16558.56	89067.79	154056.92	0.17	-0.72	-7.75	-13.52	4	0	45	2	111	16	137	52	1790690.04	318060	872044
934	2024-12-12 15:38:04.885628+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8909	2.89	102632771	40622109	1723532457000	218.71	16271.15	89539.71	150290.23	0.04	-0.74	-7.67	-13.32	3	0	44	1	117	16	143	50	1791543.54	317898	872516
935	2024-12-12 15:45:10.223416+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8957	2.89	102803138	40689540	1723532457000	217.7	6640.13	90387.57	142342.21	0.04	1.31	-7.51	-12.58	3	0	45	0	123	16	148	48	1793076.88	317608	873364
936	2024-12-12 15:50:50.280115+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8393	2.83	100801770	39897397	1723532457000	7361.07	13729.6	97824.44	146728.15	-1.96	-0.73	-9.31	-14.81	3	1	46	1	127	17	150	49	1775180.46	321099	863462
937	2024-12-12 15:56:53.771829+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7701	2.77	98344290	38924726	1723532457000	17461.98	36145.08	120929.82	169833.53	-1.35	-3.28	-11.52	-16.89	3	1	44	3	131	19	154	51	1753034.17	325548	851219
938	2024-12-12 16:05:13.99404+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7892	2.78	99023330	39193490	1723532457000	3683.56	38990.76	124926.99	173830.7	0.63	-2.83	-10.91	-16.32	6	1	47	4	140	20	163	52	1759115.49	324276	854620
939	2024-12-12 16:15:17.41715+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7925	2.79	99140157	39239730	1723532457000	265.78	38984.64	125193.61	154572.25	0.05	-2.83	-10.75	-13.1	4	0	48	4	147	18	169	50	1760188.18	324066	855212
940	2024-12-12 16:28:23.68149+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8246	2.82	100280974	39691266	1723532457000	5260.96	42213.64	130946.16	157112.69	1.05	-2.2	-9.73	-12.11	3	0	45	4	155	18	178	49	1770626.73	322035	860975
941	2024-12-12 16:40:43.361034+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8323	2.83	100553262	100553262	1723532457000	188.5	42430.08	132316.68	158483.21	0.04	-2.16	-9.48	-11.87	2	0	44	4	164	18	187	49	1773108.52	321555	862345
942	2024-12-12 16:50:12.359015+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8353	2.83	100658221	39840581	1723532457000	221.8	35355.31	132844.48	158897.5	0.04	-0.14	-9.39	-11.85	3	0	44	3	170	18	191	49	1774064.19	321371	862873
943	2024-12-12 16:57:29.480393+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8380	2.83	100754498	39878687	1723532457000	229.2	12522.43	133328.38	159381.4	0.05	2.41	-9.3	-11.77	2	0	43	1	175	18	196	49	1774940.33	321202	863357
944	2024-12-12 17:05:05.691824+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8635	2.86	101660329	40237221	1723532457000	873.03	13278.26	137869.98	163544.5	0.17	2.66	-8.49	-11.03	4	0	44	0	183	18	203	49	1783161.27	319625	867898
945	2024-12-12 17:14:10.046676+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8669	2.86	101781905	40285341	1723532457000	275.3	13288.48	138472.18	164146.7	0.05	2.66	-8.38	-10.92	2	0	42	0	188	18	208	49	1784261.57	319415	868506
946	2024-12-12 17:24:52.412219+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8715	2.87	101946048	40350309	1723532457000	219.9	8467.32	139292.48	164645.17	0.04	1.68	-8.23	-10.67	2	0	41	0	195	18	214	49	1785745.94	319132	869327
947	2024-12-12 17:33:41.164934+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8738	2.87	102025676	40381826	1723532457000	141.4	7742.1	129682.91	165042.87	0.03	1.54	-9.86	-10.6	2	0	40	0	197	18	219	49	1786465.56	318995	869724
948	2024-12-12 17:41:15.189905+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8763	2.87	102114911	40417145	1723532457000	177.6	7605.3	128397.8	165394.97	0.03	1.53	-9.5	-10.52	2	0	39	0	201	17	223	49	1787271.64	318841	870170
949	2024-12-12 17:47:09.284762+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1119	3.11	110480401	43728211	1723532457000	40693.39	48189.19	169280.51	205692	8.14	9.77	-2.1	-2.84	2	0	39	0	203	17	227	48	1861184.79	305296	911104
950	2024-12-12 17:52:59.751494+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1119	3.11	110480608	110480608	1723532457000	0.99	47877.99	169281.51	205693	0	9.7	-2.1	-2.84	1	0	36	0	204	17	228	48	1861186.59	305296	911105
951	2024-12-12 17:58:51.557973+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1119	3.11	110480608	43728293	1723532457000	0	46033.12	169281.51	205693	0	9.3	-2.1	-2.84	0	0	32	0	204	17	228	48	1861186.59	305296	911105
952	2024-12-12 18:10:08.437772+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1068	3.10	110299341	43656547	1723532457000	0	43642.22	170143.44	206554.93	0	8.43	-2.26	-3	0	0	23	1	204	18	228	49	1859635.76	305576	910243
953	2024-12-12 18:21:54.17893+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1068	3.10	110299341	43656547	1723532457000	0	42665.02	170143.44	204648.9	0	8.22	-2.26	-3	0	0	15	1	204	18	228	48	1859635.76	305576	910243
954	2024-12-12 18:36:02.057056+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1068	3.10	110299341	43656547	1723532457000	0	41974.42	170143.44	204645.73	0	8.05	-2.26	-3.03	0	0	7	1	204	18	228	47	1859635.76	305576	910243
955	2024-12-12 18:46:01.785398+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1068	3.10	110299341	43656547	1723532457000	0	862.93	170143.44	204458.53	0	-0.16	-2.26	-3.02	0	0	1	1	204	18	227	46	1859635.76	305576	910243
956	2024-12-12 18:53:18.455179+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1068	3.10	110299341	43656547	1723532457000	0	861.93	170143.44	204387.81	0	-0.16	-2.26	-3	0	0	0	1	204	18	227	44	1859635.76	305576	910243
957	2024-12-12 18:59:01.284209+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1068	3.10	110299341	43656547	1723532457000	0	861.93	170143.44	204215.69	0	-0.16	-2.26	-2.97	0	0	0	1	204	18	227	40	1859635.76	305576	910243
958	2024-12-12 19:06:51.995275+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1068	3.10	110299341	43656547	1723532457000	0	0	137220.3	203830.83	0	0	3.94	-2.9	0	0	0	0	203	13	227	34	1859635.76	305576	910243
959	2024-12-12 19:16:05.694159+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1068	3.10	110299341	43656547	1723532457000	0	0	120369.07	203704.21	0	0	7.09	-3.06	0	0	0	0	195	11	227	31	1859635.76	305576	910243
960	2024-12-12 19:23:40.677186+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1070	3.10	110306081	43659215	1723532457000	32.38	32.38	118902.59	202782.94	0.01	0.01	6.78	-3.05	1	0	1	0	187	11	227	31	1859694.1	305566	910275
961	2024-12-12 19:29:39.919698+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1070	3.10	110306081	43659215	1723532457000	0	32.38	116792.96	202782.94	0	0.01	6.98	-3.05	0	0	1	0	182	10	227	31	1859694.1	305566	910275
962	2024-12-12 19:36:20.314599+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1070	3.10	110306081	43659215	1723532457000	0	32.38	116038.56	202782.94	0	0.01	6.83	-3.05	0	0	1	0	175	10	227	31	1859694.1	305566	910275
963	2024-12-12 19:42:11.830842+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1070	3.10	110306081	110306081	1723532457000	0	32.38	115540.96	202782.94	0	0.01	6.72	-3.05	0	0	1	0	170	10	227	31	1859694.1	305566	910275
964	2024-12-12 19:48:09.816405+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1070	3.10	110306081	43659215	1723532457000	0	32.38	114841.65	202779.18	0	0.01	6.58	-2.79	0	0	1	0	165	10	226	31	1859694.1	305566	910275
965	2024-12-12 19:53:53.55121+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1070	3.10	110306081	43659215	1723532457000	0	32.38	114841.65	202779.18	0	0.01	6.58	-2.79	0	0	1	0	165	10	226	31	1859694.1	305566	910275
966	2024-12-12 19:59:33.506545+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1070	3.10	110306081	43659215	1723532457000	0	32.38	112537.92	202779.18	0	0.01	7.06	-2.79	0	0	1	0	165	8	226	31	1859694.1	305566	910275
967	2024-12-12 20:08:44.295479+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1070	3.10	110306081	43659215	1723532457000	0	32.38	111079.48	201313.83	0	0.01	7.09	-2.8	0	0	1	0	159	7	226	30	1859694.1	305566	910275
968	2024-12-12 20:19:31.746342+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.1052	3.10	110241444	43633632	1723532457000	0	339.89	110543.45	201621.34	0	-0.05	6.85	-2.86	0	0	1	1	150	8	226	31	1859140.78	305666	909968
969	2024-12-12 20:30:02.609263+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9988	2.99	106463002	42138122	1723532457000	0	18433.9	128016.74	219747.74	0	-3.48	3.06	-6.19	0	0	0	3	144	10	226	33	1826475.19	311666	891841
970	2024-12-12 20:38:09.508771+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.005841	3.0058	106711922	42236645	1723532457000	0	19650	128588.22	220963.84	0	-3.26	3.2	-5.97	0	0	1	3	139	9	227	33	1828671.21	311265	893058
971	2024-12-12 20:45:01.135716+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.005841	3.0058	106711922	42236645	1723532457000	0	19650	118109.33	220963.84	0	-3.26	5.16	-5.97	0	0	1	3	134	8	227	33	1828671.21	311265	893058
972	2024-12-12 20:50:37.268264+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.004541	3.0045	106665766	42218376	1723532457000	223.13	19873.13	117985.07	221186.97	-0.04	-3.3	5.05	-6.01	0	1	1	4	131	9	227	34	1828268.73	311340	892834
973	2024-12-12 20:56:41.667596+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.004541	3.0045	106665766	42218376	1723532457000	0	19873.13	117295.16	221186.97	0	-3.3	4.9	-6.01	0	0	1	4	125	9	227	34	1828268.73	311340	892834
974	2024-12-12 21:03:51.785812+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.004541	3.0045	106665766	42218376	1723532457000	0	19873.13	116869.86	221186.97	0	-3.3	4.82	-6.01	0	0	1	4	120	9	227	34	1828268.73	311340	892834
975	2024-12-12 21:12:55.747026+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.003962	3.0039	106645214	42210242	1723532457000	99.37	19664.99	115781.74	221286.34	-0.02	-3.26	4.55	-6.03	0	1	1	4	114	10	227	35	1828089.49	311373	892735
976	2024-12-12 21:23:39.311173+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.003962	3.0039	106645214	42210242	1723532457000	0	1538.6	113968.09	221286.34	0	0.17	4.18	-6.03	0	0	1	2	105	10	227	35	1828089.49	311373	892735
977	2024-12-12 21:31:40.395313+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.003962	3.0039	106645214	42210242	1723532457000	0	322.5	112934.58	221286.34	0	-0.06	3.97	-6.03	0	0	0	2	99	10	227	35	1828089.49	311373	892735
978	2024-12-12 21:38:39.861613+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.003962	3.0039	106645214	42210242	1723532457000	0	322.5	112009.41	221286.34	0	-0.06	3.78	-6.03	0	0	0	2	92	10	227	35	1828089.49	311373	892735
979	2024-12-12 21:44:30.241551+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.003962	3.0039	106645214	42210242	1723532457000	0	322.5	111791.71	221286.34	0	-0.06	3.74	-6.03	0	0	0	2	89	10	227	35	1828089.49	311373	892735
980	2024-12-12 21:50:30.743143+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.003962	3.0039	106645214	42210242	1723532457000	0	99.37	98764.24	221286.34	0	-0.02	6.99	-6.03	0	0	0	1	85	8	227	35	1828089.49	311373	892735
981	2024-12-12 21:56:28.49318+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.003962	3.0039	106645214	42210242	1723532457000	0	99.37	81150.15	221286.34	0	-0.02	8.42	-6.03	0	0	0	1	80	7	227	35	1828089.49	311373	892735
982	2024-12-12 22:03:42.563281+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	3.003962	3.0039	106645214	42210242	1723532457000	0	99.37	77394.58	221286.34	0	-0.02	7.73	-6.03	0	0	0	1	73	6	227	35	1828089.49	311373	892735
983	2024-12-12 22:12:51.77148+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8836	2.88	102375474	40520276	1723532457000	22459.47	22459.47	99249.17	243745.81	-4	-4	3.29	-9.79	1	1	1	1	67	7	228	36	1790441.26	318533	871887
984	2024-12-12 22:23:55.073745+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8889	2.88	102561477	40593896	1723532457000	243	23386.27	94545.41	244672.61	0.05	-3.83	2.33	-9.63	3	0	11	1	69	7	238	36	1792118.59	318216	872813
985	2024-12-12 22:33:59.287409+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8931	2.89	102710941	40653054	1723532457000	614.19	24683.17	94579.09	245618.76	0.01	-3.69	2.22	-9.34	4	1	21	2	72	8	246	37	1793470.76	317962	873560
986	2024-12-12 22:41:59.429059+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8969	2.89	102847440	40707080	1723532457000	749.99	25938.56	95266.79	245737.64	0.03	-3.56	2.24	-9.26	4	1	29	3	74	9	254	37	1794705.42	317731	874242
987	2024-12-12 22:48:01.893868+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9038	2.90	103090857	40803425	1723532457000	451.5	27148.49	96205.52	246947.57	0.09	-3.33	2.43	-9.04	4	0	36	3	78	9	261	37	1796894.64	317318	875452
988	2024-12-12 22:53:59.107908+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9057	2.90	103158103	40830041	1723532457000	147.3	27482.49	96227.32	247281.57	0.03	-3.27	2.43	-8.98	1	0	39	3	77	9	264	37	1797498.93	317204	875786
989	2024-12-12 22:59:58.429752+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9057	2.90	103158103	40830041	1723532457000	0	27482.49	92329.54	247281.57	0	-3.27	1.65	-8.98	0	0	39	3	71	9	264	37	1797498.93	317204	875786
990	2024-12-12 23:08:28.720852+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9097	2.90	103300264	40886308	1723532457000	243.54	28188.22	91893.94	247987.3	0.05	-3.14	1.56	-8.86	3	0	45	3	71	9	270	37	1798775.7	316963	876492
991	2024-12-12 23:18:36.830896+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9135	2.91	103433844	40939179	1723532457000	212.1	5802.73	91808.02	248745.08	0.02	0.9	1.52	-8.74	2	1	45	3	72	10	278	38	1799975.01	316722	877202
992	2024-12-12 23:27:50.507249+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9165	2.91	103541707	40981872	1723532457000	253.6	5526.93	91776.02	249089.63	0.05	0.84	1.51	-8.63	2	0	42	3	71	10	282	38	1800942.9	316557	877690
993	2024-12-12 23:35:05.511708+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9165	2.91	103541707	40981872	1723532457000	0	4523.93	91522.82	249089.63	0	0.75	1.45	-8.63	0	0	35	2	68	10	282	38	1800942.9	316557	877690
994	2024-12-12 23:41:47.179885+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9169	2.91	103557565	40988148	1723532457000	78.6	3538.13	91120.62	249168.23	0.02	0.67	1.36	-8.61	1	0	29	1	64	10	283	38	1801085.08	316530	877769
995	2024-12-12 23:47:41.726626+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9181	2.91	103597833	41004086	1723532457000	199.56	2522.87	50626.79	249367.8	0.04	0.47	-6.23	-8.58	1	0	23	1	63	10	284	38	1801446.06	316462	877968
996	2024-12-12 23:53:42.854454+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8742	2.87	102040558	40387702	1723532457000	9523.75	14074.52	62423.85	261165.84	-1.86	-1.08	-7.64	-9.95	0	1	22	3	63	12	285	40	1787624.6	319144	870320
997	2024-12-12 23:59:28.764158+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.8742	2.87	102040558	40387716	1723532457000	0	14074.52	61561.91	261165.84	0	-1.08	-7.49	-9.95	0	0	22	3	63	11	285	40	1787624.6	319144	870320
998	2024-12-13 00:33:36.058669+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9015	2.90	103009398	40771169	1723532457000	490.23	17066.11	66551.81	266061.7	0.1	-0.51	-6.61	-9.22	1	0	6	3	66	12	288	40	1796361.37	317490	875147
999	2024-12-13 00:58:02.498291+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9168	2.91	103552462	40986129	1723532457000	77.9	8262.42	69824.33	268592.44	0.02	1.48	-6.12	-8.74	1	0	8	2	71	13	292	41	1801243.75	316574	877845
1000	2024-12-13 01:34:17.635146+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9182	2.91	103600922	41005309	1723532457000	0	3512.67	70032.11	268785.63	0	0.57	-6.08	-8.69	0	0	6	1	71	13	293	40	1801678.21	316492	878085
1001	2024-12-13 02:13:51.963837+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9352	2.93	104207206	41245277	1723532457000	3000	3000	72724.6	271781.82	0.59	0.59	-5.47	-8.17	1	0	1	0	72	12	293	40	1807104.5	315477	881085
1002	2024-12-13 02:45:16.989061+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9366	2.93	104256235	41264682	1723532457000	0	3242.22	53624.33	272024.05	0	0.63	-2.3	-8.12	0	0	3	0	73	10	295	40	1807542.55	315396	881328
1003	2024-12-13 03:09:21.202222+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9366	2.93	104256235	41264682	1723532457000	0	3242.22	53401.19	269973.81	0	0.63	-2.26	-6.65	0	0	3	0	73	9	292	40	1807542.55	315396	881328
1004	2024-12-13 03:26:26.968621+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272752	1723532457000	0	143.66	53402.53	270074.52	0	0.03	-2.22	-6.63	0	0	2	0	74	8	293	40	1807724.68	315362	881428
1005	2024-12-13 03:40:56.168889+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272752	1723532457000	0	100.7	53402.53	270074.52	0	0.02	-2.22	-6.63	0	0	1	0	74	8	293	40	1807724.68	315362	881428
1006	2024-12-13 03:51:42.07099+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272752	1723532457000	0	100.7	53402.53	270074.52	0	0.02	-2.22	-6.63	0	0	1	0	74	8	293	40	1807724.68	315362	881428
1007	2024-12-13 03:57:51.940378+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272752	1723532457000	0	100.7	53402.53	270074.52	0	0.02	-2.22	-6.63	0	0	1	0	74	8	293	40	1807724.68	315362	881428
1008	2024-12-13 04:07:34.199048+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272752	1723532457000	0	100.7	53402.53	270074.52	0	0.02	-2.22	-6.63	0	0	1	0	74	8	293	40	1807724.68	315362	881428
1009	2024-12-13 04:18:07.697999+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272752	1723532457000	0	0	30384.76	270074.52	0	0	1.75	-6.63	0	0	0	0	67	7	293	40	1807724.68	315362	881428
1010	2024-12-13 04:30:40.509842+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272752	1723532457000	0	0	29170.86	270074.52	0	0	1.5	-6.63	0	0	0	0	55	7	293	40	1807724.68	315362	881428
1011	2024-12-13 04:40:15.456416+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272752	1723532457000	0	0	27595.46	270074.52	0	0	1.42	-6.63	0	0	0	0	46	5	293	40	1807724.68	315362	881428
1012	2024-12-13 04:47:49.657969+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272737	1723532457000	0	0	26166.43	270074.52	0	0	1.13	-6.63	0	0	0	0	37	5	293	40	1807724.68	315362	881428
1013	2024-12-13 04:53:55.181076+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272752	1723532457000	0	0	25920.03	270074.52	0	0	1.08	-6.63	0	0	0	0	35	5	293	40	1807724.68	315362	881428
1014	2024-12-13 04:59:51.726405+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272737	1723532457000	0	0	25920.03	270074.52	0	0	1.08	-6.63	0	0	0	0	35	5	293	40	1807724.68	315362	881428
1015	2024-12-13 05:08:17.954103+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9372	2.93	104276623	41272752	1723532457000	0	0	25151.7	270074.52	0	0	0.93	-6.63	0	0	0	0	28	5	293	40	1807724.68	315362	881428
1016	2024-12-13 05:18:23.526613+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9380	2.93	104305074	41284013	1723532457000	140.52	140.52	24644.35	270215.04	0.03	0.03	0.83	-6.61	1	0	1	0	22	5	294	40	1807978.8	315314	881569
1017	2024-12-13 05:29:33.718637+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9380	2.93	104305074	41283998	1723532457000	0	140.52	24062.24	270215.04	0	0.03	0.74	-6.61	0	0	1	0	17	4	294	40	1807978.8	315314	881569
1018	2024-12-13 05:38:17.745751+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9380	2.93	104305074	41284013	1723532457000	0	140.52	23983.64	270215.04	0	0.03	0.72	-6.61	0	0	1	0	16	4	294	40	1807978.8	315314	881569
1019	2024-12-13 05:44:57.630973+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9380	2.93	104305074	41283998	1723532457000	0	140.52	23983.64	259786.9	0	0.03	0.72	-6.63	0	0	1	0	16	4	294	39	1807978.8	315314	881569
1020	2024-12-13 05:51:01.299522+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9380	2.93	104305074	41284013	1723532457000	0	140.52	11986.03	259786.9	0	0.03	2.22	-6.63	0	0	1	0	14	2	294	39	1807978.8	315314	881569
1021	2024-12-13 05:56:57.524974+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9378	2.93	104298997	41281608	1723532457000	29.71	170.23	12015.74	259816.61	-0.01	0.02	2.21	-6.64	0	1	1	1	14	3	294	40	1807925.12	315325	881539
1022	2024-12-13 06:06:04.356302+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9378	2.93	104298997	41281593	1723532457000	0	170.23	11934.27	259816.61	0	0.02	2.23	-6.64	0	0	1	1	14	2	294	40	1807925.12	315325	881539
1023	2024-12-13 06:16:49.642278+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9211	2.92	103706675	41047152	1723532457000	2900.22	2929.93	14834.49	262716.84	-0.57	-0.57	1.65	-7.17	0	1	0	2	14	3	294	41	1802685.07	316325	878639
1024	2024-12-13 06:30:41.881029+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9181	2.91	103598434	41004310	1723532457000	0	3460.81	10456.94	263247.72	0	-0.68	0.57	-7.26	0	0	0	3	11	4	294	42	1801725.71	316508	878108
1025	2024-12-13 06:42:50.387698+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9181	2.91	103598434	41004310	1723532457000	0	3460.81	7487.92	263097.03	0	-0.68	0.1	-7.27	0	0	0	3	9	3	293	42	1801725.71	316508	878108
1026	2024-12-13 06:51:15.172774+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9182	2.91	103602371	41005868	1723532457000	19.5	3480.32	7507.43	263116.54	0	-0.67	0.11	-7.26	1	0	1	3	10	3	294	42	1801761	316502	878127
1027	2024-12-13 06:57:00.075206+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9182	2.91	103602371	41005868	1723532457000	0	3450.61	7203.93	263116.54	0	-0.67	0.05	-7.26	0	0	1	2	7	3	294	42	1801761	316502	878127
1028	2024-12-13 07:05:02.939285+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9182	2.91	103602371	41005868	1723532457000	0	3450.61	6963.77	263116.54	0	-0.67	0	-7.26	0	0	1	2	6	3	294	42	1801761	316502	878127
1029	2024-12-13 07:14:22.803526+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9182	2.91	103602371	41005868	1723532457000	0	550.38	6963.77	263116.54	0	-0.1	0	-7.26	0	0	1	1	6	3	294	42	1801761	316502	878127
1030	2024-12-13 07:24:55.305443+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9182	2.91	103602371	41005868	1723532457000	0	19.5	6963.77	263116.54	0	0	0	-7.26	0	0	1	0	6	3	294	42	1801761	316502	878127
1031	2024-12-13 07:32:00.560116+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9194	2.91	103645918	41023104	1723532457000	0	235.27	7179.54	263332.31	0	0.05	0.04	-7.22	0	0	2	0	7	3	295	42	1802151.34	316428	878343
1032	2024-12-13 07:38:26.814133+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9194	2.91	103643749	41022246	1723532457000	0	245.91	7190.18	263342.94	0	0.04	0.04	-7.23	0	0	2	1	7	4	295	43	1802132.12	316432	878333
1033	2024-12-13 07:44:18.910575+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9194	2.91	103643749	41022246	1723532457000	0	245.91	7190.18	263332.74	0	0.04	0.04	-7.19	0	0	2	1	7	4	293	42	1802132.12	316432	878333
1034	2024-12-13 07:50:21.238648+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9194	2.91	103643749	41022246	1723532457000	0	226.4	7190.18	263332.74	0	0.04	0.04	-7.19	0	0	1	1	7	4	293	42	1802132.12	316432	878333
1035	2024-12-13 07:56:32.89069+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9194	2.91	103643749	41022246	1723532457000	0	226.4	7190.18	263161.86	0	0.04	0.04	-7.25	0	0	1	1	7	4	293	41	1802132.12	316432	878333
1036	2024-12-13 08:04:56.422568+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9250	2.92	103843306	41101230	1723532457000	0	1214.6	8178.38	264150.06	0	0.23	0.23	-7.07	0	0	2	1	8	4	294	41	1803919.75	316097	879321
1037	2024-12-13 08:15:12.647075+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9101	2.91	103313476	40891523	1723532457000	0	3814.15	7777.93	266749.61	0	-0.28	-0.86	-7.55	0	0	2	2	7	5	294	42	1799221.81	316997	876721
1038	2024-12-13 08:28:07.361959+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9101	2.91	103313476	40891523	1723532457000	0	3598.39	7578.67	266749.61	0	-0.32	-0.9	-7.55	0	0	1	2	6	5	294	42	1799221.81	316997	876721
1039	2024-12-13 08:39:23.450427+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9101	2.91	103313476	40891523	1723532457000	0	3587.75	7578.67	266749.61	0	-0.32	-0.9	-7.55	0	0	1	1	6	5	294	42	1799221.81	316997	876721
1040	2024-12-13 08:48:03.826674+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9101	2.91	103313476	40891523	1723532457000	0	3587.75	7535.71	266749.61	0	-0.32	-0.9	-7.55	0	0	1	1	5	5	294	42	1799221.81	316997	876721
1041	2024-12-13 08:54:26.657336+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9101	2.91	103313476	40891523	1723532457000	0	3587.75	7535.71	266429.92	0	-0.32	-0.9	-7.55	0	0	1	1	5	5	293	42	1799221.81	316997	876721
1042	2024-12-13 09:00:27.038353+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9101	2.91	103313476	40891523	1723532457000	0	2599.55	7535.71	266429.91	0	-0.51	-0.9	-7.56	0	0	0	1	5	5	292	42	1799221.81	316997	876721
1043	2024-12-13 09:09:08.772873+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9101	2.91	103313476	40891523	1723532457000	0	2599.55	7535.71	263244.52	0	-0.51	-0.9	-7.05	0	0	0	1	5	5	291	39	1799221.81	316997	876721
1044	2024-12-13 09:19:35.052736+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9101	2.91	103313476	40891523	1723532457000	0	0	7435	263244.52	0	0	-0.92	-7.05	0	0	0	0	4	5	291	39	1799221.81	316997	876721
1045	2024-12-13 09:29:34.925971+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.9101	2.91	103313476	40891523	1723532457000	0	0	7435	263016.82	0	0	-0.92	-7	0	0	0	0	4	5	290	39	1799221.81	316997	876721
1046	2024-12-13 09:37:23.092282+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7517	2.75	97689564	38665576	1723532457000	28015.01	28015.01	35450.01	291031.83	-5.44	-5.44	-6.32	-12.06	0	3	0	3	4	8	290	42	1748507.14	326997	848706
1047	2024-12-13 09:43:52.083736+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7517	2.75	97689564	38665576	1723532457000	0	28015.01	35450.01	291031.83	0	-5.44	-6.32	-12.06	0	0	0	3	4	8	290	42	1748507.14	326997	848706
1048	2024-12-13 09:49:50.386255+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7517	2.75	97689564	38665576	1723532457000	0	28015.01	35450.01	291031.83	0	-5.44	-6.32	-12.06	0	0	0	3	4	8	290	42	1748507.14	326997	848706
1049	2024-12-13 09:55:43.08305+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7517	2.75	97690544	38665964	1723532457000	5	28020.01	35455.02	291036.83	0	-5.44	-6.32	-12.06	1	0	1	3	5	8	291	42	1748516.21	326996	848711
1050	2024-12-13 10:02:50.849688+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7493	2.74	97605344	38632242	1723532457000	0	28450.54	35885.55	291467.37	0	-5.53	-6.4	-12.14	0	0	1	4	5	9	291	43	1747735.61	327154	848281
1051	2024-12-13 10:12:06.46605+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7493	2.74	97605344	38632242	1723532457000	0	28450.54	35885.55	291142.01	0	-5.53	-6.4	-12.14	0	0	1	4	5	9	291	41	1747735.61	327154	848281
1052	2024-12-13 10:23:31.333665+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7493	2.74	97605344	38632242	1723532457000	0	28450.54	35885.55	291142.01	0	-5.53	-6.4	-12.14	0	0	1	4	5	9	291	41	1747735.61	327154	848281
1053	2024-12-13 10:35:02.850565+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7501	2.75	97633528	97633528	1723532457000	143.87	14390.92	36029.43	291275.97	0.03	-2.8	-6.37	-12.17	1	0	2	3	6	9	291	41	1747996.75	327102	848425
1054	2024-12-13 10:45:19.749334+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7546	2.75	97794014	38706918	1723532457000	0	2620.6	38070.62	293317.16	0	0.11	-6.22	-12.02	0	0	3	2	7	10	292	42	1749495.24	326810	849250
1055	2024-12-13 10:50:05.305277+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7760	2.77	98553099	39007364	1723532457000	3864.15	6484.76	41934.78	297181.32	0.78	0.88	-5.49	-11.34	1	0	4	2	8	10	293	42	1756506.84	325426	853114
1056	2024-12-13 10:56:01.115799+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7760	2.77	98553099	39007364	1723532457000	0	6479.76	41934.78	297181.32	0	0.88	-5.49	-11.34	0	0	3	2	8	10	293	42	1756506.84	325426	853114
1057	2024-12-13 11:02:44.653804+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7606	2.76	98008979	38792001	1723532457000	2740.66	8789.89	44675.45	299921.99	-0.55	0.41	-6.01	-11.83	0	3	3	4	8	13	293	45	1751539.16	326426	850373
1058	2024-12-13 11:11:14.654946+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6137	2.61	92792921	36727483	1723532457000	1628.37	27326.82	63212.37	318458.91	-0.34	-4.93	-11.01	-16.52	0	1	3	7	8	16	293	48	1703108.03	335826	825333
1059	2024-12-13 11:20:47.763937+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6312	2.63	93412589	36972748	1723532457000	3039.2	30566.03	66311.06	321698.13	0.63	-4.3	-10.44	-15.96	2	0	6	7	10	16	296	48	1709016.12	335232	826944
1060	2024-12-13 11:27:53.81055+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6312	2.63	93412589	36972748	1723532457000	0	30566.03	66311.06	321698.13	0	-4.3	-10.44	-15.96	0	0	6	7	10	16	296	48	1709016.12	335232	826944
1061	2024-12-13 11:34:22.472715+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6312	2.63	93412589	36972748	1723532457000	0	30422.15	66311.06	311690.85	0	-4.32	-10.44	-17.22	0	0	5	7	10	16	293	48	1709016.12	335232	826944
1062	2024-12-13 11:40:18.32834+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6312	2.63	93412589	36972748	1723532457000	0	28380.96	66311.06	310053.64	0	-4.48	-10.44	-17.22	0	0	4	6	10	16	293	47	1709016.12	335232	826944
1063	2024-12-13 11:46:20.943139+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6312	2.63	93412589	36972748	1723532457000	0	28380.96	66311.06	310004.44	0	-4.48	-10.44	-17.22	0	0	4	6	10	16	292	47	1709016.12	335232	826944
1064	2024-12-13 11:52:01.839923+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6722	2.67	94868787	37549111	1723532457000	7570	32086.8	73881.06	317572.46	1.56	-3.74	-9.05	-14.93	1	0	4	6	11	16	292	47	1722784.15	332405	834514
1065	2024-12-13 11:57:57.541258+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6693	2.66	94765665	37508296	1723532457000	528.81	32615.62	74380.17	318101.28	-0.11	-3.84	-9.14	-15.03	0	1	4	7	11	16	292	48	1721823.65	332605	833985
1066	2024-12-13 12:10:08.715432+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6788	2.67	95103125	37641862	1723532457000	1773.74	14766.7	76180.46	319901.57	0.36	2.14	-8.82	-14.72	2	0	6	3	13	17	294	49	1725000.17	331959	835732
1067	2024-12-13 12:22:47.449171+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6899	2.68	95496056	37797385	1723532457000	0	11929.28	74779.53	321931.74	0	2.23	-7.82	-14.37	0	0	6	2	16	15	297	49	1728690.45	331210	837762
1068	2024-12-13 12:39:55.072065+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6981	2.69	95786861	37912486	1723532457000	166.63	13429.1	76279.35	323431.57	0.03	2.54	-7.54	-14.11	1	0	9	2	19	15	300	49	1731416.25	330659	839262
1069	2024-12-13 12:56:34.43852+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6981	2.69	95786861	37912486	1723532457000	0	5330.29	76259.84	323431.57	0	1.08	-7.54	-14.11	0	0	8	1	18	15	300	49	1731416.25	330659	839262
1070	2024-12-13 13:10:04.050923+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6981	2.69	95786861	37912486	1723532457000	0	3529.99	76259.84	274276.69	0	0.72	-7.54	-6.9	0	0	6	0	18	15	297	42	1731416.25	330659	839262
1071	2024-12-13 13:22:37.884844+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6985	2.69	95803753	37919171	1723532457000	77.64	1586.86	76346.89	272301.77	0.02	0.32	-7.53	-7.26	1	0	5	0	20	15	285	42	1731574.44	330627	839349
1072	2024-12-13 13:34:58.009468+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7020	2.70	95928357	37968490	1723532457000	11.77	895.56	76762.38	270288.44	0	0.18	-7.44	-7.08	1	0	6	0	22	14	277	41	1732740.89	330392	839991
1073	2024-12-13 13:43:24.432703+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7020	2.70	95928357	37968490	1723532457000	0	728.93	76762.38	269447.94	0	0.15	-7.44	-7.21	0	0	5	0	22	14	269	41	1732740.89	330392	839991
1074	2024-12-13 13:49:32.708709+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7108	2.71	96237753	38090949	1723532457000	1592.03	2320.97	78354.41	270418.36	0.32	0.47	-7.15	-6.8	3	0	8	0	25	14	268	41	1735633.64	329809	841583
1075	2024-12-13 13:55:12.947897+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7108	2.71	96237753	38090949	1723532457000	0	2320.97	78354.41	270418.36	0	0.47	-7.15	-6.8	0	0	8	0	25	14	268	41	1735633.64	329809	841583
1076	2024-12-13 14:01:42.632463+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5721	2.57	91313583	36141960	1723532457000	26960.57	29301.01	104346.25	294994.27	-5.12	-4.67	-12.07	-11.42	1	1	10	1	26	15	269	40	1689296.18	339473	816135
1077	2024-12-13 14:10:15.604353+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5721	2.57	91313583	36141960	1723532457000	0	29301.01	101746.7	293636.24	0	-4.67	-11.62	-11.37	0	0	10	1	26	14	264	39	1689296.18	339473	816135
1078	2024-12-13 14:20:42.952315+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5721	2.57	91313583	36141960	1723532457000	0	29291.61	101746.7	292792.69	0	-4.67	-11.62	-11.52	0	0	9	1	26	14	255	39	1689296.18	339473	816135
1079	2024-12-13 14:31:37.942536+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5674	2.56	91149255	36076919	1723532457000	1076.09	29847.9	103010.76	293255.24	-0.22	-4.98	-11.77	-11.8	1	1	8	2	28	15	250	40	1687736.81	339808	815287
1080	2024-12-13 14:40:05.333908+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5655	2.56	91080580	36049737	1723532457000	372.71	30258.12	103432.75	293129.62	-0.08	-5.05	-11.84	-11.94	0	1	9	4	30	17	246	41	1687083.6	339948	814932
1081	2024-12-13 14:46:42.772974+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5791	2.57	91562255	36240384	1723532457000	2516.08	32252.65	105948.83	285108.12	0.53	-4.65	-11.37	-9.81	1	0	9	4	31	17	242	40	1691714.51	338980	817448
1082	2024-12-13 14:52:41.512357+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.5791	2.57	91562255	36240384	1723532457000	0	31182.17	105948.83	284329.11	0	-4.86	-11.37	-9.94	0	0	7	4	31	17	236	40	1691714.51	338980	817448
1083	2024-12-13 14:58:28.4872+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6167	2.61	92899742	36769762	1723532457000	0	37365.96	112948.83	291088.91	0	-3.63	-10.08	-8.66	0	0	6	4	32	17	234	40	1704504.96	336312	824448
1084	2024-12-13 15:07:22.846352+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6169	2.61	92904843	36771781	1723532457000	0	11228.82	112975.53	289989.72	0	1.74	-10.07	-8.87	0	0	7	3	33	17	229	40	1704553.55	336302	824475
1085	2024-12-13 15:17:32.870899+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6180	2.61	92944629	36787529	1723532457000	208.17	11436.99	113183.7	289503.19	0.04	1.79	-10.04	-8.94	1	0	8	3	34	17	223	40	1704932.47	336223	824683
1086	2024-12-13 15:28:25.564799+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6202	2.62	93021524	36817964	1723532457000	0	10575.15	113585.91	287534.94	0	2.05	-9.96	-9.3	0	0	7	2	35	17	214	40	1705664.58	336071	825085
1087	2024-12-13 15:36:54.987903+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6202	2.62	93021524	36817964	1723532457000	0	10153.16	85570.9	287063.02	0	2.13	-4.78	-9.44	0	0	5	0	35	14	208	40	1705673.99	336401	824229
1088	2024-12-13 15:43:53.925174+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6155	2.61	92856251	36752549	1723532457000	0	8493.12	86426.95	287071.21	0	1.41	-4.95	-9.69	0	0	4	1	35	15	202	41	1704107.92	336401	824229
1089	2024-12-13 15:49:53.947385+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6155	2.61	92856251	36752549	1723532457000	0	8493.12	86426.95	279634.34	0	1.41	-4.95	-6.85	0	0	4	1	35	15	198	40	1704107.92	336401	824229
1090	2024-12-13 15:55:56.709442+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6155	2.61	92856251	36752549	1723532457000	0	1493.12	86421.94	256528.96	0	-0.05	-4.95	-5.6	0	0	3	1	34	15	194	38	1704107.92	336401	824229
1091	2024-12-13 16:02:57.511061+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6155	2.61	92856251	36752549	1723532457000	0	1466.43	85991.41	252674.09	0	-0.05	-4.87	-6.23	0	0	2	1	34	14	186	37	1704107.92	336401	824229
1092	2024-12-13 16:12:37.918238+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6065	2.60	92537889	36626541	1723532457000	0	3117.57	87642.55	253720.35	0	-0.39	-5.19	-6.66	0	0	2	2	34	15	179	38	1701105.03	337040	822578
1093	2024-12-13 16:24:33.040656+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6073	2.60	92563273	36636588	1723532457000	133.08	2640.27	87775.64	248082.57	0.03	-0.49	-5.17	-7.7	1	0	1	2	35	15	171	38	1701347.33	336990	822711
1094	2024-12-13 16:36:22.828808+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6073	2.60	92563273	36636588	1723532457000	0	1784.22	87631.76	246779.56	0	-0.32	-5.19	-7.93	0	0	1	1	34	15	163	38	1701347.33	336990	822711
1095	2024-12-13 16:46:05.263832+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6073	2.60	92563273	36636588	1723532457000	0	1784.22	85590.57	246220.86	0	-0.32	-5.35	-8.03	0	0	1	1	33	14	157	38	1701347.33	336990	822711
1096	2024-12-13 16:53:18.851009+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6073	2.60	92563273	36636588	1723532457000	0	1784.22	81726.41	245808.56	0	-0.32	-6.08	-8.11	0	0	1	1	32	14	152	38	1701347.33	336990	822711
1097	2024-12-13 16:59:03.534204+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6073	2.60	92563273	36636588	1723532457000	0	1784.22	81726.41	243963.68	0	-0.32	-6.08	-8.78	0	0	1	1	32	14	148	38	1701347.33	336990	822711
1098	2024-12-13 17:07:02.228999+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6075	2.60	92573522	36640665	1723532457000	54	187.08	62131.19	240968.95	0.01	0.04	-0.57	-8.99	1	0	2	0	33	9	142	38	1701445.65	336969	822765
1099	2024-12-13 17:16:33.746308+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6071	2.60	92556047	36633748	1723532457000	195.13	666.1	60582.16	240608.37	0.04	0.02	-0.34	-9.16	1	0	3	1	32	9	136	39	1701284.59	337005	822676
1100	2024-12-13 17:26:53.534096+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6071	2.60	92556047	36633748	1723532457000	0	533.02	57742.63	240017.47	0	-0.01	-0.92	-9.26	0	0	2	1	31	9	130	39	1701284.59	337005	822676
1101	2024-12-13 17:35:18.252415+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6071	2.60	92556047	36633748	1723532457000	0	533.02	57742.63	239576.07	0	-0.01	-0.92	-9.34	0	0	2	1	31	9	125	39	1701284.59	337005	822676
1102	2024-12-13 17:42:20.700269+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6071	2.60	92556047	36633748	1723532457000	0	533.02	57742.63	239157.97	0	-0.01	-0.92	-9.41	0	0	2	1	31	9	121	39	1701284.59	337005	822676
1103	2024-12-13 17:48:02.351663+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6207	2.62	93040168	36825364	1723532457000	2534.81	3067.83	60277.44	200999.39	0.52	0.52	-0.4	-15.79	1	0	3	1	32	9	120	39	1705899	336045	825211
1104	2024-12-13 17:54:03.658574+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6207	2.62	93040168	36825364	1723532457000	0	3067.83	52707.44	200998.39	0	0.52	-1.93	-15.65	0	0	3	1	31	9	119	39	1705899	336045	825211
1105	2024-12-13 17:59:44.271024+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6207	2.62	93040168	36825364	1723532457000	0	3067.83	52178.62	200136.45	0	0.52	-1.82	-15.65	0	0	3	1	31	8	119	38	1705899	336045	825211
1106	2024-12-13 18:09:42.08361+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6819	2.68	95211871	37684925	1723532457000	10744.51	14304.35	61668.84	211426.97	2.22	2.85	0.11	-13.68	1	0	4	1	31	7	121	38	1726438.83	331829	836501
1107	2024-12-13 18:21:15.548996+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6861	2.68	95363796	37745057	1723532457000	0	14610.33	60423.68	212211.98	0	3.03	-0.14	-13.55	0	0	4	0	29	7	122	38	1727866.1	331539	837286
1108	2024-12-13 18:35:00.735974+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6861	2.68	95363402	37744901	1723532457000	0	14612.35	59092.5	212213.99	0	3.03	-0.41	-13.55	0	0	4	1	27	8	122	39	1727862.44	331540	837284
1109	2024-12-13 18:44:41.974543+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6866	2.68	95379310	37751198	1723532457000	39.34	14694.51	59008.03	212296.16	0.01	3.05	-0.43	-13.53	1	0	6	1	28	8	124	39	1728011.43	331524	837327
1110	2024-12-13 18:52:02.266433+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6866	2.68	95379310	37751198	1723532457000	0	12159.7	59008.03	212296.16	0	2.51	-0.43	-13.53	0	0	5	1	28	8	124	39	1728011.82	331510	837367
1111	2024-12-13 18:57:45.796944+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6866	2.68	95379310	37751198	1723532457000	0	12159.7	59008.03	212296.16	0	2.51	-0.43	-13.53	0	0	5	1	28	8	124	39	1728011.82	331510	837367
1112	2024-12-13 19:05:07.172129+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6866	2.68	95379310	37751198	1723532457000	0	11613.7	59008.03	212296.16	0	2.4	-0.43	-13.53	0	0	4	1	28	8	124	39	1728011.82	331510	837367
1113	2024-12-13 19:13:54.144376+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6867	2.68	95383525	37752866	1723532457000	21.76	105.94	59029.8	212317.92	0	0.02	-0.42	-13.53	1	0	3	1	29	8	125	39	1728051.39	331502	837388
1114	2024-12-13 19:21:46.194297+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.6867	2.68	95383525	37752866	1723532457000	0	105.94	58942.75	212285.54	0	0.02	-0.44	-13.48	0	0	3	1	27	8	124	39	1728051.39	331502	837388
1115	2024-12-13 19:27:42.553739+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7003	2.70	95865780	37943743	1723532457000	2487.44	2591.37	61099.21	214772.98	0.51	0.53	0	-13.04	1	0	4	0	27	8	125	39	1732573.2	330588	839876
1116	2024-12-13 19:34:08.225317+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7003	2.70	95865780	37943743	1723532457000	0	2591.37	60788.3	214772.98	0	0.53	-0.07	-13.04	0	0	4	0	25	8	125	39	1732573.2	330588	839876
1117	2024-12-13 19:40:10.356667+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7011	2.70	95893447	37954694	1723532457000	0	2691.07	60930.82	214915.5	0	0.55	-0.04	-13.02	0	0	4	0	26	8	126	39	1732832.24	330535	840018
1118	2024-12-13 19:46:07.496749+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7011	2.70	95893447	37954694	1723532457000	0	2651.72	60930.82	214915.5	0	0.54	-0.04	-13.02	0	0	3	0	26	8	126	39	1732832.24	330535	840018
1119	2024-12-13 19:52:14.415674+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7011	2.70	95893447	37954694	1723532457000	0	2651.72	59338.79	214915.5	0	0.54	-0.36	-13.02	0	0	3	0	23	8	126	39	1732832.24	330535	840018
1120	2024-12-13 19:58:14.380546+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7011	2.70	95893447	37954694	1723532457000	0	2651.72	59319.32	214915.5	0	0.54	-0.36	-13.02	0	0	3	0	22	8	126	39	1732832.24	330535	840018
1121	2024-12-13 20:07:33.121353+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7552	2.75	97815443	38715421	1723532457000	0	12502.24	42209.26	224766.02	0	2.55	7.12	-11.27	0	0	4	0	22	7	127	39	1750728.19	326961	849869
1122	2024-12-13 20:18:06.57716+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7552	2.75	97815443	38715421	1723532457000	0	12480.47	42209.26	224458.5	0	2.55	7.12	-9.18	0	0	3	0	22	7	127	38	1750728.19	326961	849869
1123	2024-12-13 20:28:56.308834+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7552	2.75	97815444	38715421	1723532457000	0	9993.03	40945.21	206332.12	0	2.03	7.31	-8.34	0	0	3	0	21	6	128	36	1750728.2	326961	849869
1124	2024-12-13 20:37:02.396726+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7552	2.75	97815444	38715421	1723532457000	0	9850.52	40523.22	205116.02	0	2	7.39	-8.3	0	0	2	0	19	4	127	36	1750728.2	326961	849869
1125	2024-12-13 20:43:52.330663+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7552	2.75	97815444	38715421	1723532457000	0	9850.52	38007.14	205116.02	0	2	6.83	-8.3	0	0	2	0	18	4	127	36	1750728.2	326961	849869
1126	2024-12-13 20:49:55.036653+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7560	2.75	97842878	38726280	1723532457000	139.9	9990.42	38147.04	205032.78	0.03	2.03	6.86	-8.25	2	0	4	0	20	4	129	35	1750982.24	326910	850009
1127	2024-12-13 20:55:52.885985+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7581	2.75	97920024	38756814	1723532457000	318.4	10383.72	31540.34	205426.08	0.06	2.11	5.4	-8.18	3	0	8	0	23	4	133	35	1751696.41	326769	850402
1128	2024-12-13 21:02:31.721749+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7602	2.76	97991644	38785161	1723532457000	88.1	823.49	31803.93	205716.37	0.03	0.18	5.48	-8.11	1	0	11	0	26	4	137	35	1752359.15	326638	850767
1129	2024-12-13 21:11:06.368944+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7753	2.77	98529101	38997887	1723532457000	296.6	3558.23	34538.67	208351.74	0.06	0.73	6.05	-7.75	2	0	18	0	33	4	144	34	1757324.05	325660	853502
1130	2024-12-13 21:21:28.361761+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7785	2.77	98641603	39042416	1723532457000	221.8	4129.73	34499.78	208923.24	0.04	0.84	6.04	-7.65	3	0	25	0	38	4	151	34	1758361.45	325456	854073
1131	2024-12-13 21:29:30.925821+00	base	uniswap	https://dexscreener.com/base/0x5280d5e63b416277d0f81fae54bb1e0444cabdaa	0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA	2.7810	2.78	98731611	39078041	1723532457000	327.2	4586.72	34956.78	209380.24	0.07	0.94	6.14	-7.56	3	0	29	0	43	4	156	34	1759190.95	325293	854530
\.


--
-- Data for Name: price_volume_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_volume_history (id, "timestamp", price_usd, volume_h24) FROM stdin;
1	2024-12-07 17:14:32.77094+00	3.14	202156.7
2	2024-12-07 17:19:33.80108+00	3.14	202364.75
3	2024-12-07 17:24:34.599261+00	3.14	204616.32
4	2024-12-07 17:29:35.893659+00	3.14	204616.32
5	2024-12-07 17:34:36.705454+00	3.14	204717.96
6	2024-12-07 17:39:37.597686+00	3.14	200106.88
7	2024-12-07 17:44:38.643898+00	3.14	200106.88
8	2024-12-07 17:49:39.557865+00	3.14	200151.74
9	2024-12-07 17:54:40.266884+00	3.14	200173.82
10	2024-12-07 17:59:41.017753+00	3.14	197796.95
11	2024-12-07 18:04:41.681408+00	3.14	197796.95
12	2024-12-07 18:09:42.436425+00	3.14	195981.78
13	2024-12-07 18:15:14.696087+00	3.14	194349.99
14	2024-12-07 18:20:15.602932+00	3.14	194194.01
15	2024-12-07 18:25:16.252518+00	3.14	194194.01
16	2024-12-07 18:30:17.753455+00	3.14	194194.01
17	2024-12-07 18:35:18.89015+00	3.14	194194.01
18	2024-12-07 18:40:19.598146+00	3.14	193086.87
19	2024-12-07 18:45:20.160512+00	3.14	193086.87
20	2024-12-07 18:50:20.969273+00	3.14	193086.87
21	2024-12-07 18:55:21.64099+00	3.14	193086.87
22	2024-12-07 19:00:22.289591+00	3.14	188002.95
23	2024-12-07 19:05:22.904317+00	3.14	188002.95
24	2024-12-07 19:10:26.850659+00	3.14	188002.95
25	2024-12-07 19:15:27.49043+00	3.14	188002.95
26	2024-12-07 19:20:28.249623+00	3.16	197484.45
27	2024-12-07 19:25:28.890402+00	3.16	197484.45
28	2024-12-07 19:30:29.602973+00	3.16	192689.81
29	2024-12-07 19:35:30.151019+00	3.16	192689.81
30	2024-12-07 19:40:30.938065+00	3.16	192712.22
31	2024-12-07 19:45:31.612852+00	3.16	192719.58
32	2024-12-07 19:50:32.31188+00	3.16	192719.58
33	2024-12-07 20:39:01.422865+00	3.16	192918.31
34	2024-12-07 20:44:02.10651+00	3.16	193006.76
35	2024-12-07 20:49:02.748992+00	3.16	193006.76
36	2024-12-07 20:54:03.393927+00	3.16	192729.89
37	2024-12-07 21:09:44.460011+00	3.16	167487.14
38	2024-12-07 21:11:12.929084+00	3.16	167487.14
39	2024-12-07 21:21:23.451094+00	3.16	155133.3
40	2024-12-07 21:28:43.813427+00	3.16	155133.3
41	2024-12-07 21:35:05.0503+00	3.16	155133.3
42	2024-12-07 21:41:12.922318+00	3.16	124935.94
43	2024-12-07 21:47:10.679752+00	3.16	124655.37
44	2024-12-07 21:53:21.79067+00	3.16	124513.28
45	2024-12-07 21:59:01.111768+00	3.16	124308.7
46	2024-12-07 22:07:00.031111+00	3.16	124308.7
47	2024-12-07 22:16:26.688212+00	3.16	123997.59
48	2024-12-07 22:27:03.730911+00	3.16	127939.44
49	2024-12-07 22:35:40.237341+00	3.16	112390.99
50	2024-12-07 22:42:42.992741+00	3.16	112390.99
51	2024-12-07 22:48:44.448292+00	3.16	112390.99
52	2024-12-07 22:54:34.14071+00	3.16	112403.53
53	2024-12-07 23:00:31.24867+00	3.16	112403.53
54	2024-12-07 23:09:36.879819+00	3.16	112403.54
55	2024-12-07 23:18:45.346346+00	3.16	112359.73
56	2024-12-07 23:27:07.515004+00	3.16	101125.05
57	2024-12-07 23:33:43.77941+00	3.16	101172.04
58	2024-12-07 23:40:21.490236+00	3.16	101172.04
59	2024-12-07 23:46:12.376062+00	3.16	100882.04
60	2024-12-07 23:52:11.257113+00	3.16	100882.04
61	2024-12-07 23:58:09.663461+00	3.16	100882.04
62	2024-12-08 00:30:43.759723+00	3.16	100952.99
63	2024-12-08 00:54:08.033346+00	3.16	100952.99
64	2024-12-08 01:28:21.441003+00	3.16	100952.99
65	2024-12-08 02:12:49.690082+00	3.13	126818.07
66	2024-12-08 02:47:45.296202+00	3.13	128757.99
67	2024-12-08 03:12:12.983062+00	3.13	128719.4
68	2024-12-08 03:28:50.086705+00	3.12	131816.42
69	2024-12-08 03:43:58.847804+00	3.12	131736.58
70	2024-12-08 03:53:51.324509+00	3.10	152819.63
71	2024-12-08 03:59:48.607846+00	3.092	159808.56
72	2024-12-08 04:09:14.027747+00	3.092	159808.56
73	2024-12-08 04:20:00.325317+00	3.092	159808.56
74	2024-12-08 04:31:29.496972+00	3.090	160683.99
75	2024-12-08 04:40:17.961396+00	3.090	160683.99
76	2024-12-08 04:47:20.269017+00	3.090	160683.99
77	2024-12-08 04:53:23.330734+00	3.090	160683.99
78	2024-12-08 04:58:59.847417+00	3.090	157581.56
79	2024-12-08 05:07:20.484197+00	3.090	157411.22
80	2024-12-08 05:17:07.809895+00	3.090	157411.22
81	2024-12-08 05:27:53.82606+00	3.090	157411.22
82	2024-12-08 05:36:23.13089+00	3.091	157652.35
83	2024-12-08 05:43:06.522858+00	3.091	157653.34
84	2024-12-08 05:49:04.779509+00	3.091	157653.34
85	2024-12-08 05:54:46.764965+00	3.091	157653.34
86	2024-12-08 06:00:47.113492+00	3.091	156538.49
87	2024-12-08 06:09:47.642318+00	3.091	156143.01
88	2024-12-08 06:21:14.292076+00	3.091	156173.61
89	2024-12-08 06:34:26.900703+00	3.091	155583.31
90	2024-12-08 06:43:54.925124+00	3.091	140097.91
91	2024-12-08 06:51:05.094549+00	3.091	140097.91
92	2024-12-08 06:57:11.201223+00	3.091	140097.91
93	2024-12-08 07:04:31.030631+00	3.091	140097.91
94	2024-12-08 07:13:28.455178+00	3.091	140097.91
95	2024-12-08 07:23:58.452395+00	3.091	140018.93
96	2024-12-08 07:30:57.262436+00	3.091	140018.93
97	2024-12-08 07:37:09.433118+00	3.090	140901.92
98	2024-12-08 07:43:05.226551+00	3.090	140901.92
99	2024-12-08 07:48:58.313651+00	3.090	140901.92
100	2024-12-08 07:54:54.939312+00	3.090	140901.92
101	2024-12-08 08:01:00.359629+00	3.090	140901.92
102	2024-12-08 08:10:00.037453+00	3.090	140901.92
103	2024-12-08 08:21:14.701601+00	3.090	140901.92
104	2024-12-08 08:32:24.64764+00	3.090	140399.75
105	2024-12-08 08:40:53.90266+00	3.090	140453.19
106	2024-12-08 08:48:17.414745+00	3.090	140017.34
107	2024-12-08 08:54:10.551217+00	3.090	140017.34
108	2024-12-08 08:59:54.728141+00	3.090	140017.34
109	2024-12-08 09:08:08.891947+00	3.090	140017.34
110	2024-12-08 09:18:09.349444+00	3.092	142241.72
111	2024-12-08 09:27:21.366097+00	3.092	142241.72
112	2024-12-08 09:34:03.915943+00	3.092	142241.72
113	2024-12-08 09:40:41.142682+00	3.092	142241.72
114	2024-12-08 09:46:39.596739+00	3.092	140691.72
115	2024-12-08 09:52:38.029021+00	3.092	140691.72
116	2024-12-08 09:58:30.345701+00	3.092	140691.72
117	2024-12-08 10:06:52.298605+00	3.092	139262.24
118	2024-12-08 10:16:52.377097+00	3.092	139262.24
119	2024-12-08 10:28:09.843103+00	3.092	139262.24
120	2024-12-08 10:37:27.624088+00	3.092	139262.24
121	2024-12-08 10:44:14.054337+00	3.092	139370.26
122	2024-12-08 10:50:00.975711+00	3.092	138983.72
123	2024-12-08 10:56:02.455978+00	3.092	138983.72
124	2024-12-08 11:02:34.84835+00	3.092	138983.72
125	2024-12-08 11:11:33.236061+00	3.092	138983.72
126	2024-12-08 11:19:38.40312+00	3.092	138983.72
127	2024-12-08 11:26:16.752313+00	3.092	139064.32
128	2024-12-08 11:32:25.080965+00	3.095	141464.4
129	2024-12-08 11:38:41.333388+00	3.095	141464.4
130	2024-12-08 11:44:22.435845+00	3.095	141433.47
131	2024-12-08 11:50:20.888786+00	3.095	141433.47
132	2024-12-08 11:56:01.855487+00	3.093	142536.73
133	2024-12-08 12:04:17.235801+00	3.093	142489.96
134	2024-12-08 12:14:34.608428+00	3.093	142479.99
135	2024-12-08 12:28:39.238281+00	3.096	144958.56
136	2024-12-08 12:47:21.226404+00	3.096	144978.18
137	2024-12-08 13:00:49.876758+00	3.096	141426.75
138	2024-12-08 13:12:37.605559+00	3.096	141434.72
139	2024-12-08 13:24:39.820654+00	3.096	137327.41
140	2024-12-08 13:33:56.793126+00	3.096	134366.96
141	2024-12-08 13:40:56.688422+00	3.096	134366.96
142	2024-12-08 13:46:50.993663+00	3.096	126945.32
143	2024-12-08 13:52:52.922332+00	3.096	122009.56
144	2024-12-08 13:58:39.29008+00	3.096	122009.56
145	2024-12-08 14:06:21.001324+00	3.096	121918.51
146	2024-12-08 14:15:32.700488+00	3.097	122316.45
147	2024-12-08 14:25:44.528738+00	3.097	122316.45
148	2024-12-08 14:33:58.292001+00	3.097	120300.49
149	2024-12-08 14:40:50.509406+00	3.097	120300.49
150	2024-12-08 14:46:35.601601+00	3.097	120312.76
151	2024-12-08 14:52:47.682339+00	3.097	120312.76
152	2024-12-08 14:58:24.600543+00	3.097	120232.78
153	2024-12-08 15:06:07.744422+00	3.097	118235.67
154	2024-12-08 15:15:43.807714+00	3.086	106217.06
155	2024-12-08 15:27:07.384312+00	3.082	107266.15
156	2024-12-08 15:34:43.472239+00	3.082	107235.8
157	2024-12-08 15:42:03.117645+00	3.082	107247.75
158	2024-12-08 15:47:58.050443+00	3.082	107247.75
159	2024-12-08 15:54:00.699748+00	3.082	107247.75
160	2024-12-08 15:59:56.669019+00	3.082	104422.38
161	2024-12-08 16:08:24.426453+00	3.082	104422.38
162	2024-12-08 16:18:57.394429+00	3.084	103925.45
163	2024-12-08 16:30:39.561426+00	3.084	103925.45
164	2024-12-08 16:40:00.410566+00	3.084	103925.45
165	2024-12-08 16:47:21.691598+00	3.084	104119.52
166	2024-12-08 16:53:10.851135+00	3.084	104119.53
167	2024-12-08 16:58:58.9901+00	3.084	104620.29
168	2024-12-08 17:06:50.163495+00	3.084	104669.15
169	2024-12-08 17:15:51.42889+00	3.084	104085.82
170	2024-12-08 17:25:27.509165+00	3.084	101828.56
171	2024-12-08 17:32:51.165321+00	3.084	101726.92
172	2024-12-08 17:39:36.127229+00	3.084	101789.74
173	2024-12-08 17:45:12.724142+00	3.084	101748.68
174	2024-12-08 17:51:12.553278+00	3.084	101722.8
175	2024-12-08 17:57:11.044632+00	3.084	101722.8
176	2024-12-08 18:05:48.947774+00	3.085	102116.89
177	2024-12-08 18:15:57.927295+00	3.085	102116.89
178	2024-12-08 18:28:59.686212+00	3.083	103124.62
179	2024-12-08 18:39:18.230589+00	3.10	116945.26
180	2024-12-08 18:46:49.871957+00	3.094	125651.44
181	2024-12-08 18:52:30.663905+00	3.094	125651.44
182	2024-12-08 18:58:29.911914+00	3.094	125651.44
183	2024-12-08 19:06:07.3884+00	3.11	143977.74
184	2024-12-08 19:14:48.439552+00	3.11	144749.72
185	2024-12-08 19:21:55.658764+00	3.11	135309.18
186	2024-12-08 19:27:48.301945+00	3.11	134793.84
187	2024-12-08 19:34:08.881921+00	3.11	134793.84
188	2024-12-08 19:39:54.628886+00	3.11	134793.84
189	2024-12-08 19:45:39.916953+00	3.11	134743.84
190	2024-12-08 19:51:42.624476+00	3.11	134743.84
191	2024-12-08 19:57:37.659449+00	3.11	134743.84
192	2024-12-08 20:05:49.665039+00	3.11	135342.37
193	2024-12-08 20:15:29.626979+00	3.11	133478.37
194	2024-12-08 20:26:56.138795+00	3.11	133430.96
195	2024-12-08 20:33:32.211729+00	3.11	133430.96
196	2024-12-08 20:41:06.312926+00	3.11	133232.24
197	2024-12-08 20:46:56.19805+00	3.11	133143.79
198	2024-12-08 20:52:35.613808+00	3.11	133143.79
199	2024-12-08 20:58:31.440149+00	3.11	133143.79
200	2024-12-08 21:06:22.464425+00	3.11	133143.79
201	2024-12-08 21:15:36.133939+00	3.11	133841.14
202	2024-12-08 21:24:28.068947+00	3.11	133841.14
203	2024-12-08 21:30:33.998317+00	3.11	133841.14
204	2024-12-08 21:36:48.660837+00	3.11	133841.14
205	2024-12-08 21:42:32.107965+00	3.11	133829.48
206	2024-12-08 21:48:31.187224+00	3.11	133829.46
207	2024-12-08 21:54:30.319026+00	3.11	133829.46
208	2024-12-08 22:00:24.111019+00	3.11	133838.92
209	2024-12-08 22:08:35.333654+00	3.11	133838.92
210	2024-12-08 22:18:22.780029+00	3.10	145694.27
211	2024-12-08 22:28:59.081092+00	3.10	143218.57
212	2024-12-08 22:37:15.643729+00	3.10	143956.06
213	2024-12-08 22:43:42.076351+00	3.10	143956.06
214	2024-12-08 22:49:25.069842+00	3.10	143943.52
215	2024-12-08 22:55:20.797724+00	3.10	143943.52
216	2024-12-08 23:01:50.927285+00	3.10	143943.52
217	2024-12-08 23:10:21.814526+00	3.10	143943.51
218	2024-12-08 23:20:35.438377+00	3.10	143943.51
219	2024-12-08 23:28:34.203929+00	3.10	143943.51
220	2024-12-08 23:35:08.196881+00	3.10	143896.51
221	2024-12-08 23:41:17.514952+00	3.10	143896.51
222	2024-12-08 23:47:00.870679+00	3.10	143896.51
223	2024-12-08 23:52:58.179669+00	3.10	143896.51
224	2024-12-08 23:59:00.617792+00	3.10	143863.75
225	2024-12-09 00:34:33.930903+00	3.10	144406.73
226	2024-12-09 00:59:35.08004+00	3.095	152559.88
227	2024-12-09 01:36:06.656949+00	3.095	152559.88
228	2024-12-09 02:16:04.14017+00	3.095	126521.18
229	2024-12-09 02:47:44.071249+00	3.094	125460.73
230	2024-12-09 03:11:45.503739+00	3.087	131666.56
231	2024-12-09 03:29:00.403659+00	3.087	128569.54
232	2024-12-09 03:44:13.485571+00	3.085	119931.23
233	2024-12-09 03:54:16.885045+00	3.085	108008.96
234	2024-12-09 04:00:03.602289+00	3.085	101719.79
235	2024-12-09 04:10:05.506537+00	3.085	102025.26
236	2024-12-09 04:21:28.269221+00	3.085	102025.26
237	2024-12-09 04:33:29.400337+00	3.084	101915.48
238	2024-12-09 04:42:41.166725+00	3.084	101915.48
239	2024-12-09 04:50:10.986426+00	3.084	101991.82
240	2024-12-09 04:56:01.312885+00	3.084	101991.82
241	2024-12-09 05:03:26.225521+00	3.084	101991.82
242	2024-12-09 05:12:53.726223+00	3.084	101991.82
243	2024-12-09 05:24:02.432689+00	3.084	101991.82
244	2024-12-09 05:33:58.194379+00	3.084	102084.84
245	2024-12-09 05:41:54.217231+00	3.084	102083.85
246	2024-12-09 05:47:50.463031+00	3.084	102083.85
247	2024-12-09 05:53:44.64594+00	3.084	102083.85
248	2024-12-09 05:59:40.785902+00	3.084	102082.66
249	2024-12-09 06:11:12.761757+00	3.084	102082.66
250	2024-12-09 06:23:23.773902+00	3.084	102052.05
251	2024-12-09 06:37:44.701927+00	3.084	102052.05
252	2024-12-09 06:48:16.526055+00	3.084	102052.05
253	2024-12-09 06:55:14.893631+00	3.084	102052.05
254	2024-12-09 07:01:41.505845+00	3.085	102341.16
255	2024-12-09 07:10:41.720984+00	3.083	103746.65
256	2024-12-09 07:21:44.14921+00	3.083	103979.46
257	2024-12-09 07:30:48.971083+00	3.083	104019.6
258	2024-12-09 07:37:55.961751+00	3.083	103136.61
259	2024-12-09 07:43:50.241694+00	3.083	103136.61
260	2024-12-09 07:49:53.201855+00	3.083	103136.61
261	2024-12-09 07:55:48.46341+00	3.081	104055.18
262	2024-12-09 08:03:30.970308+00	3.081	104055.18
263	2024-12-09 08:13:34.137814+00	3.10	121701.28
264	2024-12-09 08:26:23.184793+00	3.10	123444.14
265	2024-12-09 08:38:36.960893+00	3.10	123675.92
266	2024-12-09 08:48:11.166414+00	3.10	124717.26
267	2024-12-09 08:55:17.765369+00	3.10	124859.2
268	2024-12-09 09:01:58.155729+00	3.10	125060.48
269	2024-12-09 09:11:01.135031+00	3.10	125040.87
270	2024-12-09 09:22:24.859047+00	3.10	122889.95
271	2024-12-09 09:32:44.460791+00	3.10	122889.95
272	2024-12-09 09:40:47.477758+00	3.10	124426.11
273	2024-12-09 09:46:59.488669+00	3.10	124426.11
274	2024-12-09 09:53:00.17466+00	3.10	124426.11
275	2024-12-09 09:59:03.759675+00	3.10	124426.11
276	2024-12-09 10:08:49.398847+00	3.10	125099.18
277	2024-12-09 10:19:49.048531+00	3.10	125099.18
278	2024-12-09 10:32:30.62084+00	3.10	125099.18
279	2024-12-09 10:42:25.420674+00	3.10	124991.16
280	2024-12-09 10:50:06.770569+00	3.091	132798.89
281	2024-12-09 10:55:58.406684+00	3.091	132798.89
282	2024-12-09 11:02:56.799626+00	3.091	132798.89
283	2024-12-09 11:11:32.023848+00	3.091	132798.89
284	2024-12-09 11:21:36.416475+00	3.091	132718.28
285	2024-12-09 11:28:59.113412+00	3.091	130318.21
286	2024-12-09 11:35:26.973057+00	3.091	130372.25
287	2024-12-09 11:41:27.779185+00	3.091	130372.25
288	2024-12-09 11:47:30.28946+00	3.091	130372.25
289	2024-12-09 11:53:26.612506+00	3.091	128840.31
290	2024-12-09 11:59:13.995297+00	3.097	133268.82
291	2024-12-09 12:13:18.012695+00	3.097	133268.82
292	2024-12-09 12:27:20.948894+00	3.097	130801.51
293	2024-12-09 12:46:22.651877+00	3.087	139209.56
294	2024-12-09 13:02:16.756764+00	3.088	140705.81
295	2024-12-09 13:17:12.227165+00	3.074	153089.65
296	2024-12-09 13:31:11.695004+00	3.074	153144.65
297	2024-12-09 13:41:34.249755+00	3.064	161556.09
298	2024-12-09 13:48:23.82635+00	3.064	161570.95
299	2024-12-09 13:54:03.463989+00	3.064	161570.95
300	2024-12-09 13:59:58.849041+00	3.053	170656.52
301	2024-12-09 14:08:23.561524+00	3.053	170642.68
302	2024-12-09 14:18:38.802578+00	3.041	180278.62
303	2024-12-09 14:30:17.448709+00	2.98	189234.89
304	2024-12-09 14:39:52.678669+00	2.98	189185.1
305	2024-12-09 14:47:06.445157+00	2.98	189481.85
306	2024-12-09 14:53:12.599689+00	2.93	198282.25
307	2024-12-09 14:58:59.341439+00	2.93	198282.25
308	2024-12-09 15:07:58.055141+00	2.93	189371.59
309	2024-12-09 15:18:20.468819+00	2.94	190560.52
310	2024-12-09 15:29:32.646737+00	2.93	190739.99
311	2024-12-09 15:38:11.524579+00	2.94	191549.39
312	2024-12-09 15:45:26.499392+00	2.94	192109.64
313	2024-12-09 15:51:20.65125+00	2.94	192508.27
314	2024-12-09 15:57:28.597192+00	2.94	192365.36
315	2024-12-09 16:06:21.76497+00	2.95	193452.84
316	2024-12-09 16:16:46.131099+00	2.95	192612.26
317	2024-12-09 16:30:11.306989+00	2.96	193546.86
318	2024-12-09 16:42:21.690804+00	2.96	194339.21
319	2024-12-09 16:51:50.894214+00	2.99	198874.15
320	2024-12-09 16:58:10.983797+00	2.99	198373.39
321	2024-12-09 17:06:10.712762+00	2.99	198324.52
322	2024-12-09 17:15:35.19587+00	3.00012	199494.78
323	2024-12-09 17:26:22.119925+00	3.016	202402.54
324	2024-12-09 17:35:09.126847+00	3.0099	203594.1
325	2024-12-09 17:42:37.155566+00	2.98	211423.06
326	2024-12-09 17:48:48.232771+00	2.98	211674.27
327	2024-12-09 17:54:28.607993+00	3.0012	213982.78
328	2024-12-09 18:00:23.282943+00	3.0012	213982.78
329	2024-12-09 18:10:24.243113+00	3.0012	213588.69
330	2024-12-09 18:22:17.168814+00	3.017	216392.73
331	2024-12-09 18:36:25.12309+00	3.017	201564.36
332	2024-12-09 18:46:29.141314+00	3.00029	195802.14
333	2024-12-09 18:53:34.987296+00	3.00029	195802.14
334	2024-12-09 18:59:20.978408+00	3.00029	195802.14
335	2024-12-09 19:07:16.495756+00	3.00029	177475.84
336	2024-12-09 19:16:31.388963+00	3.00027	176667.07
337	2024-12-09 19:24:17.390047+00	3.00027	176667.07
338	2024-12-09 19:29:55.888542+00	3.00027	176667.07
339	2024-12-09 19:36:27.651986+00	3.00037	176685.55
340	2024-12-09 19:42:26.521368+00	3.00037	176685.55
341	2024-12-09 19:48:28.360783+00	3.00037	176685.55
342	2024-12-09 19:54:22.849924+00	3.0033	177202.97
343	2024-12-09 20:00:03.492029+00	3.0033	177202.97
344	2024-12-09 20:08:55.974667+00	2.99	177572.01
345	2024-12-09 20:19:37.029825+00	2.99	177572.01
346	2024-12-09 20:30:25.691028+00	2.93	189023.28
347	2024-12-09 20:38:51.705099+00	2.93	191201.81
348	2024-12-09 20:45:52.716915+00	2.93	191974.61
349	2024-12-09 20:51:42.630819+00	2.93	192632.48
350	2024-12-09 20:57:39.026669+00	2.92	196151.97
351	2024-12-09 21:05:19.422029+00	2.92	196842.27
352	2024-12-09 21:14:36.88109+00	2.93	197114.55
353	2024-12-09 21:24:55.193252+00	2.92	200437.58
354	2024-12-09 21:32:18.596408+00	2.93	200946.58
355	2024-12-09 21:39:23.366109+00	2.93	201476.92
356	2024-12-09 21:45:07.592983+00	2.93	201863.42
357	2024-12-09 21:50:58.179334+00	2.93	202261.3
358	2024-12-09 21:56:34.844649+00	2.94	203070.38
359	2024-12-09 22:03:40.522467+00	2.94	203656.78
360	2024-12-09 22:12:59.920996+00	2.93	193707.16
361	2024-12-09 22:24:10.039341+00	2.93	193699.02
362	2024-12-09 22:34:16.807757+00	2.94	193690.33
363	2024-12-09 22:42:16.405812+00	2.92	196931.81
364	2024-12-09 22:48:22.679929+00	2.93	197226.01
365	2024-12-09 22:54:04.134128+00	2.93	197343.41
366	2024-12-09 23:00:06.944883+00	2.93	197343.41
367	2024-12-09 23:08:30.219874+00	2.93	197343.41
368	2024-12-09 23:18:34.640442+00	2.93	197886.07
369	2024-12-09 23:27:53.54549+00	2.93	198297.77
370	2024-12-09 23:35:02.517678+00	2.93	198842.92
371	2024-12-09 23:42:02.650727+00	2.94	199331.32
372	2024-12-09 23:47:58.185528+00	2.94	199669.42
373	2024-12-09 23:53:55.717961+00	2.95	202042.22
374	2024-12-09 23:59:56.607396+00	2.95	202112.96
375	2024-12-10 00:33:45.739743+00	2.96	204485.69
376	2024-12-10 00:58:18.804791+00	2.95	203021.99
377	2024-12-10 01:35:09.025728+00	2.96	205813.8
378	2024-12-10 02:14:47.317371+00	2.96	211686.96
379	2024-12-10 02:46:04.612493+00	2.97	211097.92
380	2024-12-10 03:10:08.360471+00	2.97	204892.1
381	2024-12-10 03:27:17.350742+00	2.97	204892.1
382	2024-12-10 03:41:59.017538+00	2.96	209201.1
383	2024-12-10 03:52:41.140642+00	2.96	209211.46
384	2024-12-10 03:58:36.153021+00	2.97	209290.96
385	2024-12-10 04:09:14.844353+00	2.97	208985.5
386	2024-12-10 04:20:14.110281+00	2.97	208985.5
387	2024-12-10 04:32:15.953954+00	2.97	210292.02
388	2024-12-10 04:41:21.721146+00	2.96	210336.13
389	2024-12-10 04:48:49.85562+00	2.96	210269.79
390	2024-12-10 04:54:35.809569+00	2.96	210269.79
391	2024-12-10 05:00:17.959118+00	2.96	210587.85
392	2024-12-10 05:08:51.73736+00	2.97	210915.05
393	2024-12-10 05:19:12.054216+00	2.97	210985.53
394	2024-12-10 05:30:23.048204+00	2.97	210651.37
395	2024-12-10 05:39:00.018198+00	2.97	210651.37
396	2024-12-10 05:45:23.163358+00	2.97	210651.37
397	2024-12-10 05:51:20.378737+00	2.97	210651.37
398	2024-12-10 05:57:14.104265+00	2.97	210651.37
399	2024-12-10 06:06:56.322649+00	2.97	210651.37
400	2024-12-10 06:17:55.097643+00	2.97	210651.37
401	2024-12-10 06:32:05.135234+00	2.97	210651.37
402	2024-12-10 06:43:42.403921+00	2.96	212445.13
403	2024-12-10 06:51:53.624275+00	2.95	215963.58
404	2024-12-10 06:57:51.506825+00	2.94	217854.45
405	2024-12-10 07:06:40.701222+00	2.95	217513.85
406	2024-12-10 07:16:41.614229+00	2.96	218881.73
407	2024-12-10 07:27:45.780919+00	2.88	234208.69
408	2024-12-10 07:35:34.314188+00	2.88	234865.52
409	2024-12-10 07:42:23.042964+00	2.88	235059.22
410	2024-12-10 07:48:18.302243+00	2.88	235255.82
411	2024-12-10 07:54:19.101259+00	2.88	234553.35
412	2024-12-10 08:00:04.86135+00	2.88	234791.75
413	2024-12-10 08:10:51.066393+00	2.89	218592
414	2024-12-10 08:22:30.818099+00	2.90	218421.48
415	2024-12-10 08:34:55.836078+00	2.91	219524.97
416	2024-12-10 08:44:47.825989+00	2.91	219681.09
417	2024-12-10 08:52:48.713874+00	2.91	221188.84
418	2024-12-10 08:58:32.618709+00	2.91	221278.52
419	2024-12-10 09:08:02.504558+00	2.92	221768.22
420	2024-12-10 09:18:31.803347+00	2.92	222422.37
421	2024-12-10 09:29:39.590183+00	2.92	223160.37
422	2024-12-10 09:37:52.190769+00	2.92	222366.81
423	2024-12-10 09:44:51.082627+00	2.93	222781.41
424	2024-12-10 09:50:45.94558+00	2.93	223301.81
425	2024-12-10 09:56:37.483092+00	2.93	223566.81
426	2024-12-10 10:04:35.991171+00	2.93	224107.91
427	2024-12-10 10:14:16.256435+00	2.94	223946.88
428	2024-12-10 10:26:19.63486+00	2.94	224630.58
429	2024-12-10 10:37:47.93768+00	2.95	225427.08
430	2024-12-10 10:46:39.652924+00	2.95	218155.65
431	2024-12-10 10:52:41.471321+00	2.95	218546.95
432	2024-12-10 10:58:26.493232+00	2.95	218809.95
433	2024-12-10 11:06:32.287408+00	2.96	219523.18
434	2024-12-10 11:15:50.603891+00	2.96	220095.18
435	2024-12-10 11:24:36.559514+00	2.96	220373.08
436	2024-12-10 11:30:55.933006+00	2.96	220754.94
437	2024-12-10 11:37:19.906411+00	2.96	220754.94
438	2024-12-10 11:43:01.340283+00	2.96	220754.94
439	2024-12-10 11:49:03.107211+00	2.96	220754.94
440	2024-12-10 11:55:04.273852+00	2.96	220754.94
441	2024-12-10 12:01:55.098923+00	2.96	216326.43
442	2024-12-10 12:13:39.438655+00	2.96	219564.78
443	2024-12-10 12:27:33.956843+00	2.97	220793.12
444	2024-12-10 12:46:35.086791+00	2.97	212564.68
445	2024-12-10 13:02:23.831795+00	2.97	211216.11
446	2024-12-10 13:17:00.021876+00	2.82	225781.21
447	2024-12-10 13:30:58.912918+00	2.83	227258.81
448	2024-12-10 13:41:21.10333+00	2.83	221379.89
449	2024-12-10 13:48:11.593982+00	2.83	222189.14
450	2024-12-10 13:53:49.007788+00	2.83	222394.44
451	2024-12-10 13:59:48.810317+00	2.83	213468.17
452	2024-12-10 14:08:12.267342+00	2.84	214023.97
453	2024-12-10 14:18:18.803936+00	2.84	205362.75
454	2024-12-10 14:29:55.828367+00	2.84	197195.67
455	2024-12-10 14:39:46.796586+00	2.84	198009.27
456	2024-12-10 14:47:16.365249+00	2.85	198130.24
457	2024-12-10 14:53:06.545736+00	2.85	189639.63
458	2024-12-10 14:59:47.592623+00	2.85	190452.48
459	2024-12-10 15:07:57.766393+00	2.86	190396.07
460	2024-12-10 15:18:27.164454+00	2.86	189979.84
461	2024-12-10 15:29:49.387114+00	2.71	215090.47
462	2024-12-10 15:38:35.646245+00	2.73	220555.17
463	2024-12-10 15:46:02.095268+00	2.74	220616.07
464	2024-12-10 15:52:00.718809+00	2.74	220584.55
465	2024-12-10 15:57:44.868816+00	2.72	224098.47
466	2024-12-10 16:06:38.409824+00	2.73	223522.72
467	2024-12-10 16:17:46.157865+00	2.73	224178.54
468	2024-12-10 16:30:48.593324+00	2.73	223971.04
469	2024-12-10 16:42:53.080766+00	2.74	223945.09
470	2024-12-10 16:52:04.88866+00	2.74	220452.81
471	2024-12-10 16:58:28.30039+00	2.60	248171.49
472	2024-12-10 17:06:27.014644+00	2.59	250768.16
473	2024-12-10 17:15:50.649963+00	2.59	250180.2
474	2024-12-10 17:26:46.641141+00	2.60	247902.85
475	2024-12-10 17:35:36.057548+00	2.60	247235.38
476	2024-12-10 17:43:05.142647+00	2.60	239748.51
477	2024-12-10 17:49:04.288351+00	2.60	240171.68
478	2024-12-10 17:55:10.035856+00	2.60	238246.07
479	2024-12-10 18:01:43.430616+00	2.61	238643.47
480	2024-12-10 18:11:17.383185+00	2.61	239034.77
481	2024-12-10 18:23:15.020564+00	2.61	237013.82
482	2024-12-10 18:37:03.352914+00	2.58	244875.71
483	2024-12-10 18:47:03.028504+00	2.58	242544.55
484	2024-12-10 18:53:53.13252+00	2.59	243020.65
485	2024-12-10 18:59:34.052662+00	2.59	243314.75
486	2024-12-10 19:07:23.499842+00	2.59	243715.25
487	2024-12-10 19:16:46.974345+00	2.60	246169.8
488	2024-12-10 19:24:37.558769+00	2.61	246571.52
489	2024-12-10 19:30:39.566589+00	2.61	246962.32
490	2024-12-10 19:37:06.305593+00	2.61	247527.74
491	2024-12-10 19:42:45.918659+00	2.61	247780.94
492	2024-12-10 19:48:48.484139+00	2.62	248653.49
493	2024-12-10 19:54:49.465052+00	2.62	248537.26
494	2024-12-10 20:00:55.436465+00	2.62	249027.86
495	2024-12-10 20:09:42.137115+00	2.62	248526.79
496	2024-12-10 20:20:28.716849+00	2.63	249688.49
497	2024-12-10 20:30:40.843753+00	2.63	238811.34
498	2024-12-10 20:38:42.090673+00	2.63	237429.6
499	2024-12-10 20:45:24.488653+00	2.64	237132.7
500	2024-12-10 20:51:03.503115+00	2.64	237524.04
501	2024-12-10 20:57:01.301461+00	2.79	261369.89
502	2024-12-10 21:04:15.536796+00	2.80	261930.61
503	2024-12-10 21:13:26.644976+00	2.80	261785.41
504	2024-12-10 21:24:01.292167+00	2.81	259100.39
505	2024-12-10 21:31:40.462212+00	2.81	259241.22
506	2024-12-10 21:38:29.357321+00	2.81	259052.79
507	2024-12-10 21:44:09.19016+00	2.81	259025.59
508	2024-12-10 21:50:08.218607+00	2.82	259090.8
509	2024-12-10 21:55:54.455205+00	2.82	258747.27
510	2024-12-10 22:02:40.857493+00	2.86	265941.4
511	2024-12-10 22:11:26.841747+00	2.86	264485.17
512	2024-12-10 22:22:08.709073+00	2.87	263979.81
513	2024-12-10 22:32:34.072785+00	2.89	267443
514	2024-12-10 22:40:31.873236+00	2.90	264637.72
515	2024-12-10 22:46:28.625376+00	2.90	264825.22
516	2024-12-10 22:52:27.092593+00	2.91	266572.11
517	2024-12-10 22:58:23.92336+00	2.91	267367.11
518	2024-12-10 23:06:36.631027+00	2.92	268205.12
519	2024-12-10 23:16:23.558324+00	2.92	268363.84
520	2024-12-10 23:25:46.850501+00	2.94	270374.58
521	2024-12-10 23:32:32.083526+00	2.94	271201.63
522	2024-12-10 23:39:14.603748+00	2.95	272241.25
523	2024-12-10 23:44:55.414545+00	2.95	273215.92
524	2024-12-10 23:50:47.937915+00	2.95	272290.62
525	2024-12-10 23:56:53.237852+00	2.95	272215.32
526	2024-12-11 00:18:23.174335+00	2.95	271770.48
527	2024-12-11 00:37:21.389414+00	2.96	271344.88
528	2024-12-11 01:03:24.250014+00	2.97	265202.72
529	2024-12-11 01:40:39.837469+00	2.97	260037.84
530	2024-12-11 02:16:31.575801+00	2.97	257383.57
531	2024-12-11 02:46:53.178595+00	2.97	257098.1
532	2024-12-11 03:08:55.604862+00	2.97	257098.1
533	2024-12-11 03:25:07.585273+00	2.97	257098.1
534	2024-12-11 03:39:30.010923+00	2.97	253760.94
535	2024-12-11 03:50:04.073633+00	2.97	251769.3
536	2024-12-11 03:56:50.585538+00	2.97	251477
537	2024-12-11 04:05:12.891941+00	2.97	251477
538	2024-12-11 04:15:32.052505+00	3.0055	257633.75
539	2024-12-11 04:28:09.914808+00	3.0055	255719.76
540	2024-12-11 04:38:54.717055+00	3.0055	255517.45
541	2024-12-11 04:47:04.716961+00	3.0084	256007.39
542	2024-12-11 04:53:21.940807+00	3.0084	256007.39
543	2024-12-11 04:59:10.96538+00	3.0072	257873.38
544	2024-12-11 05:08:03.550906+00	3.028	261215.69
545	2024-12-11 05:18:06.714068+00	3.028	261145.21
546	2024-12-11 05:29:16.086525+00	3.028	261145.21
547	2024-12-11 05:38:09.54808+00	3.028	261145.21
548	2024-12-11 05:44:45.814502+00	3.028	261145.21
549	2024-12-11 05:50:42.658604+00	3.028	261145.21
550	2024-12-11 05:56:39.824092+00	3.028	261145.21
551	2024-12-11 06:05:18.61153+00	3.028	261145.21
552	2024-12-11 06:15:49.481373+00	3.044	265941.38
553	2024-12-11 06:29:14.758707+00	3.044	265941.38
554	2024-12-11 06:41:50.602863+00	3.044	264274.32
555	2024-12-11 06:50:47.16939+00	3.044	260532.97
556	2024-12-11 06:56:24.588223+00	3.044	258520.8
557	2024-12-11 07:03:54.083676+00	3.044	257600.4
558	2024-12-11 07:13:06.830075+00	3.049	260553.86
559	2024-12-11 07:24:31.613578+00	3.049	244489.17
560	2024-12-11 07:32:14.677849+00	3.049	243620.44
561	2024-12-11 07:39:08.593755+00	3.049	243429.44
562	2024-12-11 07:45:04.296593+00	3.049	243299.04
563	2024-12-11 07:50:53.590475+00	3.049	243044.84
564	2024-12-11 07:56:52.222381+00	3.049	242860.54
565	2024-12-11 08:05:54.25847+00	3.049	242308.94
566	2024-12-11 08:16:21.88817+00	3.049	241484.44
567	2024-12-11 08:29:40.039337+00	2.99	253592.95
568	2024-12-11 08:41:15.98889+00	2.99	252350.26
569	2024-12-11 08:50:07.725305+00	2.99	251039.91
570	2024-12-11 08:56:33.764598+00	2.93	261853.39
571	2024-12-11 09:04:08.390191+00	2.93	262113.25
572	2024-12-11 09:13:37.781357+00	2.94	262484.25
573	2024-12-11 09:25:21.364272+00	2.88	273747.89
574	2024-12-11 09:34:02.261188+00	2.89	274282.19
575	2024-12-11 09:41:37.003829+00	2.89	274000.39
576	2024-12-11 09:47:33.590358+00	2.89	273774.99
577	2024-12-11 09:53:28.998888+00	2.89	273537.49
578	2024-12-11 09:59:25.219267+00	2.88	274501.22
579	2024-12-11 10:08:34.751653+00	2.89	275431.69
580	2024-12-11 10:19:11.719121+00	2.90	275528.84
581	2024-12-11 10:31:34.763877+00	2.90	275416.24
582	2024-12-11 10:41:37.454884+00	2.91	275359.94
583	2024-12-11 10:48:56.725775+00	2.91	275568.64
584	2024-12-11 10:54:38.502845+00	2.90	277593.85
585	2024-12-11 11:00:35.971631+00	2.90	277484.12
586	2024-12-11 11:08:51.907721+00	2.90	277493.42
587	2024-12-11 11:18:20.453479+00	2.91	277718.92
588	2024-12-11 11:26:17.715191+00	2.91	277844.99
589	2024-12-11 11:32:29.917539+00	2.91	278041.79
590	2024-12-11 11:38:51.876453+00	2.92	278467.93
591	2024-12-11 11:44:45.721761+00	2.92	278810.73
592	2024-12-11 11:50:46.099411+00	2.92	279195.93
593	2024-12-11 11:56:45.256649+00	2.92	279494.13
594	2024-12-11 12:06:49.81165+00	2.93	278258.65
595	2024-12-11 12:18:22.564868+00	2.93	277216.62
596	2024-12-11 12:33:59.354312+00	2.93	277292.22
597	2024-12-11 12:53:17.944053+00	2.93	280384.05
598	2024-12-11 13:07:07.73754+00	2.93	281253.99
599	2024-12-11 13:19:26.730473+00	2.94	254660.58
600	2024-12-11 13:33:23.085189+00	2.94	253950.28
601	2024-12-11 13:42:25.596646+00	2.94	253253.68
602	2024-12-11 13:48:59.257821+00	2.94	253024.88
603	2024-12-11 13:54:56.913045+00	2.94	253160.28
604	2024-12-11 14:01:02.626688+00	2.95	253232.68
605	2024-12-11 14:09:33.045517+00	2.95	253891.69
606	2024-12-11 14:19:54.082309+00	3.097	277600.83
607	2024-12-11 14:31:23.410676+00	3.097	276829.14
608	2024-12-11 14:40:16.669292+00	3.31	312523.5
609	2024-12-11 14:47:24.792765+00	3.31	312121.02
610	2024-12-11 14:53:25.805141+00	3.31	311848.41
611	2024-12-11 14:59:10.722741+00	3.31	311136.46
612	2024-12-11 15:07:46.479898+00	3.31	311241.57
613	2024-12-11 15:18:03.559441+00	3.31	310571.17
614	2024-12-11 15:29:26.520166+00	3.36	289871.64
615	2024-12-11 15:38:01.34091+00	3.33	287318.39
616	2024-12-11 15:45:18.547363+00	3.29	296131.62
617	2024-12-11 15:50:59.416096+00	3.31	298815.45
618	2024-12-11 15:57:02.394004+00	3.31	295301.53
619	2024-12-11 16:05:18.926595+00	3.31	294738.7
620	2024-12-11 16:15:31.433563+00	3.23	313449.12
621	2024-12-11 16:28:34.89465+00	3.21	315744.14
622	2024-12-11 16:41:02.707198+00	3.21	314988.14
623	2024-12-11 16:50:34.896105+00	3.21	313928.61
624	2024-12-11 16:57:08.074279+00	3.21	286209.93
625	2024-12-11 17:04:28.416167+00	3.21	284067.36
626	2024-12-11 17:13:32.165931+00	3.21	283409.46
627	2024-12-11 17:24:05.551844+00	3.21	283220.39
628	2024-12-11 17:33:09.867034+00	3.21	282647.19
629	2024-12-11 17:40:39.598879+00	3.21	282171.89
630	2024-12-11 17:46:38.092718+00	3.21	281497.51
631	2024-12-11 17:52:40.147801+00	3.21	281811.47
632	2024-12-11 17:58:50.135656+00	3.21	281513.97
633	2024-12-11 18:09:58.329784+00	3.21	280962.77
634	2024-12-11 18:21:34.409673+00	3.21	280179.67
635	2024-12-11 18:35:47.916705+00	3.20	274226.99
636	2024-12-11 18:46:03.320276+00	3.20	273766.07
637	2024-12-11 18:53:26.582985+00	3.20	273396.01
638	2024-12-11 18:59:14.87187+00	3.20	273274.03
639	2024-12-11 19:07:10.381946+00	3.20	273208.91
640	2024-12-11 19:16:17.628471+00	3.19	270926.31
641	2024-12-11 19:23:54.328606+00	3.20	271374.83
642	2024-12-11 19:29:39.329088+00	3.20	270951.03
643	2024-12-11 19:36:19.383035+00	3.20	270503.53
644	2024-12-11 19:42:04.992722+00	3.20	270250.33
645	2024-12-11 19:48:00.28448+00	3.20	269381.55
646	2024-12-11 19:54:05.507491+00	3.20	268980.35
647	2024-12-11 19:59:47.876903+00	3.20	268489.75
648	2024-12-11 20:08:44.185467+00	3.19	269394.1
649	2024-12-11 20:19:23.56707+00	3.19	268326.9
650	2024-12-11 20:30:03.496434+00	3.19	267470.59
651	2024-12-11 20:37:57.182614+00	3.19	266749.09
652	2024-12-11 20:44:48.075478+00	3.19	266480.09
653	2024-12-11 20:50:44.141477+00	3.19	265394.18
654	2024-12-11 20:56:27.187648+00	3.19	237937.74
655	2024-12-11 21:03:19.960882+00	3.19	236814.52
656	2024-12-11 21:12:21.29279+00	3.19	236117.38
657	2024-12-11 21:23:04.612632+00	3.19	235283.98
658	2024-12-11 21:31:03.661905+00	3.19	234702.24
659	2024-12-11 21:38:02.07218+00	3.19	234360.34
660	2024-12-11 21:43:44.265694+00	3.19	233881.14
661	2024-12-11 21:49:36.354901+00	3.19	233537.94
662	2024-12-11 21:55:24.396909+00	3.19	233062.94
663	2024-12-11 22:01:49.767835+00	3.19	225282.41
664	2024-12-11 22:10:35.656236+00	3.19	224718.01
665	2024-12-11 22:21:07.146655+00	3.19	223976.61
666	2024-12-11 22:32:22.525537+00	3.19	219858.08
667	2024-12-11 22:40:51.995687+00	3.19	220618.59
668	2024-12-11 22:47:22.290743+00	3.19	220051.09
669	2024-12-11 22:53:20.752513+00	3.19	218130.1
670	2024-12-11 22:58:58.479025+00	3.19	217479.4
671	2024-12-11 23:07:22.044609+00	3.19	216614.31
672	2024-12-11 23:17:07.32979+00	3.19	214012.87
673	2024-12-11 23:26:28.864142+00	3.19	212963.82
674	2024-12-11 23:33:23.480355+00	3.19	212293.12
675	2024-12-11 23:40:19.315783+00	3.19	209903.93
676	2024-12-11 23:46:02.516809+00	3.19	209549.03
677	2024-12-11 23:52:01.096021+00	3.19	208160.03
678	2024-12-11 23:58:05.534612+00	3.19	207749.73
679	2024-12-12 00:28:08.969927+00	3.19	206066.48
680	2024-12-12 00:50:05.4495+00	3.19	205534.35
681	2024-12-12 01:21:23.666351+00	3.19	205530.43
682	2024-12-12 02:02:34.028714+00	3.19	205534.23
683	2024-12-12 02:37:40.913534+00	3.19	205529.27
684	2024-12-12 03:02:19.066756+00	3.20	207579.51
685	2024-12-12 03:22:45.938227+00	3.20	207579.51
686	2024-12-12 03:38:03.901739+00	3.20	207579.51
687	2024-12-12 03:49:12.126154+00	3.20	207579.51
688	2024-12-12 03:56:31.119098+00	3.20	207579.51
689	2024-12-12 04:04:39.99+00	3.20	207579.51
690	2024-12-12 04:14:35.872285+00	3.20	201422.76
691	2024-12-12 04:26:58.329632+00	3.20	201422.76
692	2024-12-12 04:38:14.641497+00	3.20	201422.76
693	2024-12-12 04:46:42.733164+00	3.20	200922.82
694	2024-12-12 04:53:31.011248+00	3.20	200922.82
695	2024-12-12 04:59:14.350527+00	3.20	198738.77
696	2024-12-12 05:08:25.537849+00	3.20	195069.26
697	2024-12-12 05:18:24.377111+00	3.20	195069.26
698	2024-12-12 05:29:37.202933+00	3.20	195069.26
699	2024-12-12 05:38:22.485455+00	3.20	195069.26
700	2024-12-12 05:45:10.28909+00	3.14	205497.41
701	2024-12-12 05:51:06.795909+00	3.14	205497.41
702	2024-12-12 05:57:03.45248+00	3.14	205497.41
703	2024-12-12 06:06:36.688284+00	3.14	205497.41
704	2024-12-12 06:17:38.858677+00	3.14	200701.23
705	2024-12-12 06:31:32.517696+00	3.14	200701.23
706	2024-12-12 06:43:43.465468+00	3.14	200851.92
707	2024-12-12 06:52:08.905202+00	3.14	200851.92
708	2024-12-12 06:58:01.767954+00	3.14	200851.92
709	2024-12-12 07:06:49.226725+00	3.14	200851.92
710	2024-12-12 07:16:51.728488+00	3.14	197046.25
711	2024-12-12 07:27:19.940509+00	3.14	197046.25
712	2024-12-12 07:34:25.277095+00	3.14	197046.25
713	2024-12-12 07:41:13.287625+00	3.14	197056.46
714	2024-12-12 07:47:08.351323+00	3.14	197056.46
715	2024-12-12 07:52:47.80975+00	3.14	197056.46
716	2024-12-12 07:58:29.091961+00	3.14	197227.34
717	2024-12-12 08:09:36.325046+00	3.14	197227.34
718	2024-12-12 08:21:00.268979+00	3.14	197227.34
719	2024-12-12 08:33:51.885311+00	3.14	182137.67
720	2024-12-12 08:43:32.462213+00	3.14	182137.67
721	2024-12-12 08:51:29.553145+00	3.14	181937.97
722	2024-12-12 08:57:14.364691+00	3.14	170914.37
723	2024-12-12 09:05:21.671728+00	3.14	170165.09
724	2024-12-12 09:15:08.416222+00	3.12	172258.82
725	2024-12-12 09:27:11.152766+00	3.13	160162.38
726	2024-12-12 09:35:27.066363+00	3.13	159138.18
727	2024-12-12 09:42:47.117688+00	3.13	159001.38
728	2024-12-12 09:48:49.694616+00	3.13	158922.98
729	2024-12-12 09:54:33.044077+00	3.13	158922.98
730	2024-12-12 10:00:28.009315+00	3.13	157482.64
731	2024-12-12 10:09:16.53301+00	3.12	156020.3
732	2024-12-12 10:19:53.793782+00	3.12	155391.39
733	2024-12-12 10:32:20.050469+00	3.12	154733.5
734	2024-12-12 10:41:55.701772+00	3.12	154020.3
735	2024-12-12 10:49:09.919955+00	3.12	151583.8
736	2024-12-12 10:54:56.930684+00	3.12	151192.4
737	2024-12-12 11:01:04.974042+00	3.12	150797.3
738	2024-12-12 11:09:26.032468+00	3.12	150229.8
739	2024-12-12 11:19:09.70827+00	3.12	149554.52
740	2024-12-12 11:26:48.489817+00	3.12	149069.72
741	2024-12-12 11:33:23.581149+00	3.18	158573
742	2024-12-12 11:39:43.070051+00	3.17	159882.07
743	2024-12-12 11:45:41.407928+00	3.17	159591.47
744	2024-12-12 11:51:39.45909+00	3.17	159207.55
745	2024-12-12 11:57:16.280688+00	3.17	158857.65
746	2024-12-12 12:08:15.681477+00	3.17	158208
747	2024-12-12 12:20:16.485995+00	3.17	157422.2
748	2024-12-12 12:36:34.931593+00	3.17	154478.74
749	2024-12-12 12:54:58.302507+00	3.17	153044.64
750	2024-12-12 13:08:16.364456+00	2.98	185233.38
751	2024-12-12 13:20:42.61807+00	2.90	201564.31
752	2024-12-12 13:33:58.841396+00	2.90	204329.5
753	2024-12-12 13:42:53.619554+00	2.91	203725.78
754	2024-12-12 13:49:10.25558+00	2.91	204052.69
755	2024-12-12 13:55:08.371109+00	2.91	203701.09
756	2024-12-12 14:01:36.67745+00	2.90	205685.72
757	2024-12-12 14:10:21.175873+00	2.90	205999.14
758	2024-12-12 14:20:49.374366+00	2.90	181610.29
759	2024-12-12 14:32:02.099911+00	2.91	146608.25
760	2024-12-12 14:40:40.277976+00	2.91	146552.54
761	2024-12-12 14:47:24.975183+00	2.85	156980.02
762	2024-12-12 14:53:11.433144+00	2.86	157732.74
763	2024-12-12 14:58:58.699367+00	2.86	158060.04
764	2024-12-12 15:07:47.602439+00	2.87	158571.03
765	2024-12-12 15:18:13.533228+00	2.87	159265.73
766	2024-12-12 15:29:37.16119+00	2.88	154056.92
767	2024-12-12 15:38:04.885628+00	2.89	150290.23
768	2024-12-12 15:45:10.223416+00	2.89	142342.21
769	2024-12-12 15:50:50.280115+00	2.83	146728.15
770	2024-12-12 15:56:53.771829+00	2.77	169833.53
771	2024-12-12 16:05:13.99404+00	2.78	173830.7
772	2024-12-12 16:15:17.41715+00	2.79	154572.25
773	2024-12-12 16:28:23.68149+00	2.82	157112.69
774	2024-12-12 16:40:43.361034+00	2.83	158483.21
775	2024-12-12 16:50:12.359015+00	2.83	158897.5
776	2024-12-12 16:57:29.480393+00	2.83	159381.4
777	2024-12-12 17:05:05.691824+00	2.86	163544.5
778	2024-12-12 17:14:10.046676+00	2.86	164146.7
779	2024-12-12 17:24:52.412219+00	2.87	164645.17
780	2024-12-12 17:33:41.164934+00	2.87	165042.87
781	2024-12-12 17:41:15.189905+00	2.87	165394.97
782	2024-12-12 17:47:09.284762+00	3.11	205692
783	2024-12-12 17:52:59.751494+00	3.11	205693
784	2024-12-12 17:58:51.557973+00	3.11	205693
785	2024-12-12 18:10:08.437772+00	3.10	206554.93
786	2024-12-12 18:21:54.17893+00	3.10	204648.9
787	2024-12-12 18:36:02.057056+00	3.10	204645.73
788	2024-12-12 18:46:01.785398+00	3.10	204458.53
789	2024-12-12 18:53:18.455179+00	3.10	204387.81
790	2024-12-12 18:59:01.284209+00	3.10	204215.69
791	2024-12-12 19:06:51.995275+00	3.10	203830.83
792	2024-12-12 19:16:05.694159+00	3.10	203704.21
793	2024-12-12 19:23:40.677186+00	3.10	202782.94
794	2024-12-12 19:29:39.919698+00	3.10	202782.94
795	2024-12-12 19:36:20.314599+00	3.10	202782.94
796	2024-12-12 19:42:11.830842+00	3.10	202782.94
797	2024-12-12 19:48:09.816405+00	3.10	202779.18
798	2024-12-12 19:53:53.55121+00	3.10	202779.18
799	2024-12-12 19:59:33.506545+00	3.10	202779.18
800	2024-12-12 20:08:44.295479+00	3.10	201313.83
801	2024-12-12 20:19:31.746342+00	3.10	201621.34
802	2024-12-12 20:30:02.609263+00	2.99	219747.74
803	2024-12-12 20:38:09.508771+00	3.0058	220963.84
804	2024-12-12 20:45:01.135716+00	3.0058	220963.84
805	2024-12-12 20:50:37.268264+00	3.0045	221186.97
806	2024-12-12 20:56:41.667596+00	3.0045	221186.97
807	2024-12-12 21:03:51.785812+00	3.0045	221186.97
808	2024-12-12 21:12:55.747026+00	3.0039	221286.34
809	2024-12-12 21:23:39.311173+00	3.0039	221286.34
810	2024-12-12 21:31:40.395313+00	3.0039	221286.34
811	2024-12-12 21:38:39.861613+00	3.0039	221286.34
812	2024-12-12 21:44:30.241551+00	3.0039	221286.34
813	2024-12-12 21:50:30.743143+00	3.0039	221286.34
814	2024-12-12 21:56:28.49318+00	3.0039	221286.34
815	2024-12-12 22:03:42.563281+00	3.0039	221286.34
816	2024-12-12 22:12:51.77148+00	2.88	243745.81
817	2024-12-12 22:23:55.073745+00	2.88	244672.61
818	2024-12-12 22:33:59.287409+00	2.89	245618.76
819	2024-12-12 22:41:59.429059+00	2.89	245737.64
820	2024-12-12 22:48:01.893868+00	2.90	246947.57
821	2024-12-12 22:53:59.107908+00	2.90	247281.57
822	2024-12-12 22:59:58.429752+00	2.90	247281.57
823	2024-12-12 23:08:28.720852+00	2.90	247987.3
824	2024-12-12 23:18:36.830896+00	2.91	248745.08
825	2024-12-12 23:27:50.507249+00	2.91	249089.63
826	2024-12-12 23:35:05.511708+00	2.91	249089.63
827	2024-12-12 23:41:47.179885+00	2.91	249168.23
828	2024-12-12 23:47:41.726626+00	2.91	249367.8
829	2024-12-12 23:53:42.854454+00	2.87	261165.84
830	2024-12-12 23:59:28.764158+00	2.87	261165.84
831	2024-12-13 00:33:36.058669+00	2.90	266061.7
832	2024-12-13 00:58:02.498291+00	2.91	268592.44
833	2024-12-13 01:34:17.635146+00	2.91	268785.63
834	2024-12-13 02:13:51.963837+00	2.93	271781.82
835	2024-12-13 02:45:16.989061+00	2.93	272024.05
836	2024-12-13 03:09:21.202222+00	2.93	269973.81
837	2024-12-13 03:26:26.968621+00	2.93	270074.52
838	2024-12-13 03:40:56.168889+00	2.93	270074.52
839	2024-12-13 03:51:42.07099+00	2.93	270074.52
840	2024-12-13 03:57:51.940378+00	2.93	270074.52
841	2024-12-13 04:07:34.199048+00	2.93	270074.52
842	2024-12-13 04:18:07.697999+00	2.93	270074.52
843	2024-12-13 04:30:40.509842+00	2.93	270074.52
844	2024-12-13 04:40:15.456416+00	2.93	270074.52
845	2024-12-13 04:47:49.657969+00	2.93	270074.52
846	2024-12-13 04:53:55.181076+00	2.93	270074.52
847	2024-12-13 04:59:51.726405+00	2.93	270074.52
848	2024-12-13 05:08:17.954103+00	2.93	270074.52
849	2024-12-13 05:18:23.526613+00	2.93	270215.04
850	2024-12-13 05:29:33.718637+00	2.93	270215.04
851	2024-12-13 05:38:17.745751+00	2.93	270215.04
852	2024-12-13 05:44:57.630973+00	2.93	259786.9
853	2024-12-13 05:51:01.299522+00	2.93	259786.9
854	2024-12-13 05:56:57.524974+00	2.93	259816.61
855	2024-12-13 06:06:04.356302+00	2.93	259816.61
856	2024-12-13 06:16:49.642278+00	2.92	262716.84
857	2024-12-13 06:30:41.881029+00	2.91	263247.72
858	2024-12-13 06:42:50.387698+00	2.91	263097.03
859	2024-12-13 06:51:15.172774+00	2.91	263116.54
860	2024-12-13 06:57:00.075206+00	2.91	263116.54
861	2024-12-13 07:05:02.939285+00	2.91	263116.54
862	2024-12-13 07:14:22.803526+00	2.91	263116.54
863	2024-12-13 07:24:55.305443+00	2.91	263116.54
864	2024-12-13 07:32:00.560116+00	2.91	263332.31
865	2024-12-13 07:38:26.814133+00	2.91	263342.94
866	2024-12-13 07:44:18.910575+00	2.91	263332.74
867	2024-12-13 07:50:21.238648+00	2.91	263332.74
868	2024-12-13 07:56:32.89069+00	2.91	263161.86
869	2024-12-13 08:04:56.422568+00	2.92	264150.06
870	2024-12-13 08:15:12.647075+00	2.91	266749.61
871	2024-12-13 08:28:07.361959+00	2.91	266749.61
872	2024-12-13 08:39:23.450427+00	2.91	266749.61
873	2024-12-13 08:48:03.826674+00	2.91	266749.61
874	2024-12-13 08:54:26.657336+00	2.91	266429.92
875	2024-12-13 09:00:27.038353+00	2.91	266429.91
876	2024-12-13 09:09:08.772873+00	2.91	263244.52
877	2024-12-13 09:19:35.052736+00	2.91	263244.52
878	2024-12-13 09:29:34.925971+00	2.91	263016.82
879	2024-12-13 09:37:23.092282+00	2.75	291031.83
880	2024-12-13 09:43:52.083736+00	2.75	291031.83
881	2024-12-13 09:49:50.386255+00	2.75	291031.83
882	2024-12-13 09:55:43.08305+00	2.75	291036.83
883	2024-12-13 10:02:50.849688+00	2.74	291467.37
884	2024-12-13 10:12:06.46605+00	2.74	291142.01
885	2024-12-13 10:23:31.333665+00	2.74	291142.01
886	2024-12-13 10:35:02.850565+00	2.75	291275.97
887	2024-12-13 10:45:19.749334+00	2.75	293317.16
888	2024-12-13 10:50:05.305277+00	2.77	297181.32
889	2024-12-13 10:56:01.115799+00	2.77	297181.32
890	2024-12-13 11:02:44.653804+00	2.76	299921.99
891	2024-12-13 11:11:14.654946+00	2.61	318458.91
892	2024-12-13 11:20:47.763937+00	2.63	321698.13
893	2024-12-13 11:27:53.81055+00	2.63	321698.13
894	2024-12-13 11:34:22.472715+00	2.63	311690.85
895	2024-12-13 11:40:18.32834+00	2.63	310053.64
896	2024-12-13 11:46:20.943139+00	2.63	310004.44
897	2024-12-13 11:52:01.839923+00	2.67	317572.46
898	2024-12-13 11:57:57.541258+00	2.66	318101.28
899	2024-12-13 12:10:08.715432+00	2.67	319901.57
900	2024-12-13 12:22:47.449171+00	2.68	321931.74
901	2024-12-13 12:39:55.072065+00	2.69	323431.57
902	2024-12-13 12:56:34.43852+00	2.69	323431.57
903	2024-12-13 13:10:04.050923+00	2.69	274276.69
904	2024-12-13 13:22:37.884844+00	2.69	272301.77
905	2024-12-13 13:34:58.009468+00	2.70	270288.44
906	2024-12-13 13:43:24.432703+00	2.70	269447.94
907	2024-12-13 13:49:32.708709+00	2.71	270418.36
908	2024-12-13 13:55:12.947897+00	2.71	270418.36
909	2024-12-13 14:01:42.632463+00	2.57	294994.27
910	2024-12-13 14:10:15.604353+00	2.57	293636.24
911	2024-12-13 14:20:42.952315+00	2.57	292792.69
912	2024-12-13 14:31:37.942536+00	2.56	293255.24
913	2024-12-13 14:40:05.333908+00	2.56	293129.62
914	2024-12-13 14:46:42.772974+00	2.57	285108.12
915	2024-12-13 14:52:41.512357+00	2.57	284329.11
916	2024-12-13 14:58:28.4872+00	2.61	291088.91
917	2024-12-13 15:07:22.846352+00	2.61	289989.72
918	2024-12-13 15:17:32.870899+00	2.61	289503.19
919	2024-12-13 15:28:25.564799+00	2.62	287534.94
920	2024-12-13 15:36:54.987903+00	2.62	287063.02
921	2024-12-13 15:43:53.925174+00	2.61	287071.21
922	2024-12-13 15:49:53.947385+00	2.61	279634.34
923	2024-12-13 15:55:56.709442+00	2.61	256528.96
924	2024-12-13 16:02:57.511061+00	2.61	252674.09
925	2024-12-13 16:12:37.918238+00	2.60	253720.35
926	2024-12-13 16:24:33.040656+00	2.60	248082.57
927	2024-12-13 16:36:22.828808+00	2.60	246779.56
928	2024-12-13 16:46:05.263832+00	2.60	246220.86
929	2024-12-13 16:53:18.851009+00	2.60	245808.56
930	2024-12-13 16:59:03.534204+00	2.60	243963.68
931	2024-12-13 17:07:02.228999+00	2.60	240968.95
932	2024-12-13 17:16:33.746308+00	2.60	240608.37
933	2024-12-13 17:26:53.534096+00	2.60	240017.47
934	2024-12-13 17:35:18.252415+00	2.60	239576.07
935	2024-12-13 17:42:20.700269+00	2.60	239157.97
936	2024-12-13 17:48:02.351663+00	2.62	200999.39
937	2024-12-13 17:54:03.658574+00	2.62	200998.39
938	2024-12-13 17:59:44.271024+00	2.62	200136.45
939	2024-12-13 18:09:42.08361+00	2.68	211426.97
940	2024-12-13 18:21:15.548996+00	2.68	212211.98
941	2024-12-13 18:35:00.735974+00	2.68	212213.99
942	2024-12-13 18:44:41.974543+00	2.68	212296.16
943	2024-12-13 18:52:02.266433+00	2.68	212296.16
944	2024-12-13 18:57:45.796944+00	2.68	212296.16
945	2024-12-13 19:05:07.172129+00	2.68	212296.16
946	2024-12-13 19:13:54.144376+00	2.68	212317.92
947	2024-12-13 19:21:46.194297+00	2.68	212285.54
948	2024-12-13 19:27:42.553739+00	2.70	214772.98
949	2024-12-13 19:34:08.225317+00	2.70	214772.98
950	2024-12-13 19:40:10.356667+00	2.70	214915.5
951	2024-12-13 19:46:07.496749+00	2.70	214915.5
952	2024-12-13 19:52:14.415674+00	2.70	214915.5
953	2024-12-13 19:58:14.380546+00	2.70	214915.5
954	2024-12-13 20:07:33.121353+00	2.75	224766.02
955	2024-12-13 20:18:06.57716+00	2.75	224458.5
956	2024-12-13 20:28:56.308834+00	2.75	206332.12
957	2024-12-13 20:37:02.396726+00	2.75	205116.02
958	2024-12-13 20:43:52.330663+00	2.75	205116.02
959	2024-12-13 20:49:55.036653+00	2.75	205032.78
960	2024-12-13 20:55:52.885985+00	2.75	205426.08
961	2024-12-13 21:02:31.721749+00	2.76	205716.37
962	2024-12-13 21:11:06.368944+00	2.77	208351.74
963	2024-12-13 21:21:28.361761+00	2.77	208923.24
964	2024-12-13 21:29:30.925821+00	2.78	209380.24
\.


--
-- Data for Name: token_price_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token_price_history (id, "timestamp", price) FROM stdin;
348	2024-11-30 21:00:00+00	3.1497756566
349	2024-11-30 22:00:00+00	3.1292444172
350	2024-11-30 23:00:00+00	3.0513226413
351	2024-12-01 00:00:00+00	3.0536738412
352	2024-12-01 01:00:00+00	3.0720427587
353	2024-12-01 02:00:00+00	3.1010359415
354	2024-12-01 03:00:00+00	3.1188085076
355	2024-12-01 04:00:00+00	3.1179082488
356	2024-12-01 05:00:00+00	3.2926638493
357	2024-12-01 06:00:00+00	3.3359390714
358	2024-12-01 07:00:00+00	3.4022210796
359	2024-12-01 08:00:00+00	3.4021328232
360	2024-12-01 09:00:00+00	3.5012861342
361	2024-12-01 10:00:00+00	3.8015069273
362	2024-12-01 11:00:00+00	3.5695224763
363	2024-12-01 12:00:00+00	3.5130715435
364	2024-12-01 13:00:00+00	3.5118246439
365	2024-12-01 14:00:00+00	3.6034193457
366	2024-12-01 15:00:00+00	3.6235834983
367	2024-12-01 16:00:00+00	3.6305663794
368	2024-12-01 17:00:00+00	3.6378968047
369	2024-12-01 18:00:00+00	3.5055862786
370	2024-12-01 19:00:00+00	3.5194608906
371	2024-12-01 20:00:00+00	3.5259395952
372	2024-12-01 21:00:00+00	3.5572942008
373	2024-12-01 22:00:00+00	3.5704919943
374	2024-12-01 23:00:00+00	3.5739342484
375	2024-12-02 00:00:00+00	3.6677351526
376	2024-12-02 01:00:00+00	3.7244021848
377	2024-12-02 02:00:00+00	4.1528354986
378	2024-12-02 03:00:00+00	4.2624510258
379	2024-12-02 04:00:00+00	4.0112109390
380	2024-12-02 05:00:00+00	4.0317636671
381	2024-12-02 06:00:00+00	4.0038577948
382	2024-12-02 07:00:00+00	3.9905789558
383	2024-12-02 08:00:00+00	3.9410943003
384	2024-12-02 09:00:00+00	3.9842230634
385	2024-12-02 10:00:00+00	3.9509836396
386	2024-12-02 11:00:00+00	3.9713709565
387	2024-12-02 12:00:00+00	3.9716130820
388	2024-12-02 13:00:00+00	3.9888095596
389	2024-12-02 14:00:00+00	3.9597979151
390	2024-12-02 15:00:00+00	3.9592832619
391	2024-12-02 16:00:00+00	3.9533564322
392	2024-12-02 17:00:00+00	3.9468004346
393	2024-12-02 18:00:00+00	3.4732421496
394	2024-12-02 19:00:00+00	3.4705124379
395	2024-12-02 20:00:00+00	3.1627751441
396	2024-12-02 21:00:00+00	3.1581208540
397	2024-12-02 22:00:00+00	3.1523227382
398	2024-12-02 23:00:00+00	3.3607322387
399	2024-12-03 00:00:00+00	3.5072673608
400	2024-12-03 01:00:00+00	3.6243712380
401	2024-12-03 02:00:00+00	3.6343825263
402	2024-12-03 03:00:00+00	3.6353201360
403	2024-12-03 04:00:00+00	3.6516202179
404	2024-12-03 05:00:00+00	3.7156652176
405	2024-12-03 06:00:00+00	3.8268962706
406	2024-12-03 07:00:00+00	3.7890287360
407	2024-12-03 08:00:00+00	3.7869961140
408	2024-12-03 09:00:00+00	3.7417876158
409	2024-12-03 10:00:00+00	3.8065742995
410	2024-12-03 11:00:00+00	3.8097694998
411	2024-12-03 12:00:00+00	3.7924627329
412	2024-12-03 13:00:00+00	3.7967196695
413	2024-12-03 14:00:00+00	3.7967196695
414	2024-12-03 15:00:00+00	3.7724208855
415	2024-12-03 16:00:00+00	3.6238369177
416	2024-12-03 17:00:00+00	3.6104691942
417	2024-12-03 18:00:00+00	3.5360225068
418	2024-12-03 19:00:00+00	3.4263105877
419	2024-12-03 20:00:00+00	3.4301714309
420	2024-12-03 21:00:00+00	3.3781753463
421	2024-12-03 22:00:00+00	3.4159709558
422	2024-12-03 23:00:00+00	3.4181321178
423	2024-12-04 00:00:00+00	2.9751357594
424	2024-12-04 01:00:00+00	2.7923196965
425	2024-12-04 02:00:00+00	3.0847126057
426	2024-12-04 03:00:00+00	3.0763266303
427	2024-12-04 04:00:00+00	3.0896317681
428	2024-12-04 05:00:00+00	3.0898166239
429	2024-12-04 06:00:00+00	3.1166723518
430	2024-12-04 07:00:00+00	3.1170439320
431	2024-12-04 08:00:00+00	3.1177719625
432	2024-12-04 09:00:00+00	3.1114214407
433	2024-12-04 10:00:00+00	3.1153787899
434	2024-12-04 11:00:00+00	3.1147926667
435	2024-12-04 12:00:00+00	3.1197170073
436	2024-12-04 13:00:00+00	3.1318248420
437	2024-12-04 14:00:00+00	3.1316103924
438	2024-12-04 15:00:00+00	3.1176379136
439	2024-12-04 16:00:00+00	3.0490685736
440	2024-12-04 17:00:00+00	3.0482656245
441	2024-12-04 18:00:00+00	2.7895497519
442	2024-12-04 19:00:00+00	2.7432710782
443	2024-12-04 20:00:00+00	2.7635806239
444	2024-12-04 21:00:00+00	2.7286311015
445	2024-12-04 22:00:00+00	2.7773722140
446	2024-12-04 23:00:00+00	2.8205954993
447	2024-12-05 00:00:00+00	2.8265219551
448	2024-12-05 01:00:00+00	2.6632547484
449	2024-12-05 02:00:00+00	2.6517655872
450	2024-12-05 03:00:00+00	2.6609917221
451	2024-12-05 04:00:00+00	2.6481890373
452	2024-12-05 05:00:00+00	2.6493155451
453	2024-12-05 06:00:00+00	2.6235886771
454	2024-12-05 07:00:00+00	2.6377722314
455	2024-12-05 08:00:00+00	2.7087756992
456	2024-12-05 09:00:00+00	2.7363735389
457	2024-12-05 10:00:00+00	2.7334235421
458	2024-12-05 11:00:00+00	2.4636556072
459	2024-12-05 12:00:00+00	2.4392782645
460	2024-12-05 13:00:00+00	2.4922259211
461	2024-12-05 14:00:00+00	2.5097999116
462	2024-12-05 15:00:00+00	2.5070720670
463	2024-12-05 16:00:00+00	2.5165308194
464	2024-12-05 17:00:00+00	2.4963992862
465	2024-12-05 18:00:00+00	2.5108326757
466	2024-12-05 19:00:00+00	2.6351216258
467	2024-12-05 20:00:00+00	2.6311852643
468	2024-12-05 21:00:00+00	2.5751644691
469	2024-12-05 23:00:00+00	2.5763192532
470	2024-12-06 00:00:00+00	2.5749273869
471	2024-12-06 01:00:00+00	2.5775816861
472	2024-12-06 02:00:00+00	2.5804430737
473	2024-12-06 03:00:00+00	2.5841526309
474	2024-12-06 04:00:00+00	2.5986880495
475	2024-12-06 05:00:00+00	2.6288312434
476	2024-12-06 06:00:00+00	2.6554440301
477	2024-12-06 07:00:00+00	2.6837111488
478	2024-12-06 08:00:00+00	2.7372472321
479	2024-12-06 09:00:00+00	2.7316838170
480	2024-12-06 10:00:00+00	2.8709349266
481	2024-12-06 11:00:00+00	3.0532824029
482	2024-12-06 12:00:00+00	3.0527347748
483	2024-12-06 13:00:00+00	3.0702044409
484	2024-12-06 14:00:00+00	3.0959849966
485	2024-12-06 15:00:00+00	3.0962957324
486	2024-12-06 16:00:00+00	3.1026627720
487	2024-12-06 17:00:00+00	3.0994584347
488	2024-12-06 18:00:00+00	3.1030335467
489	2024-12-06 19:00:00+00	3.0958558444
490	2024-12-06 20:00:00+00	3.0966196653
491	2024-12-06 21:00:00+00	3.1482697515
492	2024-12-06 22:00:00+00	3.1295558147
493	2024-12-06 23:00:00+00	3.1436466561
494	2024-12-07 00:00:00+00	3.1436214039
495	2024-12-07 02:00:00+00	3.1433952496
496	2024-12-07 03:00:00+00	3.1435396583
497	2024-12-07 04:00:00+00	3.1397195458
498	2024-12-07 05:00:00+00	3.1381362598
499	2024-12-07 06:00:00+00	3.1188643333
500	2024-12-07 07:00:00+00	3.1189602685
501	2024-12-07 08:00:00+00	3.1200997032
502	2024-12-07 09:00:00+00	3.1220276093
503	2024-12-07 10:00:00+00	3.1233607761
504	2024-12-07 11:00:00+00	3.1239007306
505	2024-12-07 12:00:00+00	3.1195537656
506	2024-12-07 13:00:00+00	3.1129921796
507	2024-12-07 14:00:00+00	3.1157117848
508	2024-12-07 15:00:00+00	3.1427560079
509	2024-12-07 16:00:00+00	3.1451932466
510	2024-12-07 17:00:00+00	3.1485611464
511	2024-12-07 18:00:00+00	3.1536863167
512	2024-12-07 19:00:00+00	3.1595673348
513	2024-12-07 20:00:00+00	3.1618464669
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2024-12-07 16:23:59
20211116045059	2024-12-07 16:23:59
20211116050929	2024-12-07 16:23:59
20211116051442	2024-12-07 16:23:59
20211116212300	2024-12-07 16:23:59
20211116213355	2024-12-07 16:23:59
20211116213934	2024-12-07 16:23:59
20211116214523	2024-12-07 16:23:59
20211122062447	2024-12-07 16:23:59
20211124070109	2024-12-07 16:23:59
20211202204204	2024-12-07 16:23:59
20211202204605	2024-12-07 16:23:59
20211210212804	2024-12-07 16:24:00
20211228014915	2024-12-07 16:24:00
20220107221237	2024-12-07 16:24:00
20220228202821	2024-12-07 16:24:00
20220312004840	2024-12-07 16:24:00
20220603231003	2024-12-07 16:24:00
20220603232444	2024-12-07 16:24:00
20220615214548	2024-12-07 16:24:00
20220712093339	2024-12-07 16:24:00
20220908172859	2024-12-07 16:24:00
20220916233421	2024-12-07 16:24:00
20230119133233	2024-12-07 16:24:00
20230128025114	2024-12-07 16:24:00
20230128025212	2024-12-07 16:24:00
20230227211149	2024-12-07 16:24:00
20230228184745	2024-12-07 16:24:00
20230308225145	2024-12-07 16:24:00
20230328144023	2024-12-07 16:24:00
20231018144023	2024-12-07 16:24:00
20231204144023	2024-12-07 16:24:00
20231204144024	2024-12-07 16:24:00
20231204144025	2024-12-07 16:24:00
20240108234812	2024-12-07 16:24:00
20240109165339	2024-12-07 16:24:00
20240227174441	2024-12-07 16:24:00
20240311171622	2024-12-07 16:24:00
20240321100241	2024-12-07 16:24:00
20240401105812	2024-12-07 16:24:00
20240418121054	2024-12-07 16:24:00
20240523004032	2024-12-07 16:24:00
20240618124746	2024-12-07 16:24:00
20240801235015	2024-12-07 16:24:01
20240805133720	2024-12-07 16:24:01
20240827160934	2024-12-07 16:24:01
20240919163303	2024-12-07 16:24:01
20240919163305	2024-12-07 16:24:01
20241019105805	2024-12-07 16:24:01
20241030150047	2024-12-07 16:24:01
20241108114728	2024-12-07 16:24:01
20241121104152	2024-12-07 16:24:01
20241130184212	2024-12-07 16:24:01
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2024-12-07 16:23:20.736558
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2024-12-07 16:23:20.81742
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2024-12-07 16:23:20.875481
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2024-12-07 16:23:20.963227
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2024-12-07 16:23:21.04122
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2024-12-07 16:23:21.105206
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2024-12-07 16:23:21.120946
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2024-12-07 16:23:21.184557
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2024-12-07 16:23:21.243531
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2024-12-07 16:23:21.304181
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2024-12-07 16:23:21.320026
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2024-12-07 16:23:21.380926
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2024-12-07 16:23:21.44813
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2024-12-07 16:23:21.516361
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2024-12-07 16:23:21.5757
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2024-12-07 16:23:21.68314
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2024-12-07 16:23:21.749435
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2024-12-07 16:23:21.811785
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2024-12-07 16:23:21.872264
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2024-12-07 16:23:21.949429
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2024-12-07 16:23:22.063771
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2024-12-07 16:23:22.148689
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2024-12-07 16:23:22.233445
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2024-12-07 16:23:22.276078
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2024-12-07 16:23:22.293589
25	custom-metadata	67eb93b7e8d401cafcdc97f9ac779e71a79bfe03	2024-12-07 16:23:22.35379
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('pgsodium.key_key_id_seq', 1, false);


--
-- Name: pair_data_recent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pair_data_recent_id_seq', 1131, true);


--
-- Name: price_volume_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.price_volume_history_id_seq', 964, true);


--
-- Name: token_price_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_price_history_id_seq', 513, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: pair_data_recent pair_data_recent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pair_data_recent
    ADD CONSTRAINT pair_data_recent_pkey PRIMARY KEY (id);


--
-- Name: price_volume_history price_volume_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_volume_history
    ADD CONSTRAINT price_volume_history_pkey PRIMARY KEY (id);


--
-- Name: token_price_history token_price_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_price_history
    ADD CONSTRAINT token_price_history_pkey PRIMARY KEY (id);


--
-- Name: token_price_history token_price_history_timestamp_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_price_history
    ADD CONSTRAINT token_price_history_timestamp_key UNIQUE ("timestamp");


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_token_price_history_timestamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_token_price_history_timestamp ON public.token_price_history USING btree ("timestamp");


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: token_price_history Allow insert access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow insert access" ON public.token_price_history FOR INSERT TO authenticated WITH CHECK (true);


--
-- Name: token_price_history Allow read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow read access for all users" ON public.token_price_history FOR SELECT USING (true);


--
-- Name: token_price_history Allow update access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update access" ON public.token_price_history FOR UPDATE TO authenticated USING (true) WITH CHECK (true);


--
-- Name: token_price_history Anyone can view historical prices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view historical prices" ON public.token_price_history FOR SELECT USING (true);


--
-- Name: pair_data_recent Anyone can view pair_data_recent; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view pair_data_recent" ON public.pair_data_recent FOR SELECT USING (true);


--
-- Name: price_volume_history Anyone can view price_volume_history; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view price_volume_history" ON public.price_volume_history FOR SELECT USING (true);


--
-- Name: token_price_history Service role can insert historical prices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service role can insert historical prices" ON public.token_price_history TO service_role USING (true) WITH CHECK (true);


--
-- Name: pair_data_recent Service role can manage pair_data_recent; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service role can manage pair_data_recent" ON public.pair_data_recent TO service_role USING (true) WITH CHECK (true);


--
-- Name: price_volume_history Service role can manage price_volume_history; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service role can manage price_volume_history" ON public.price_volume_history TO service_role USING (true) WITH CHECK (true);


--
-- Name: pair_data_recent; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.pair_data_recent ENABLE ROW LEVEL SECURITY;

--
-- Name: price_volume_history; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.price_volume_history ENABLE ROW LEVEL SECURITY;

--
-- Name: token_price_history; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.token_price_history ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.try_cast_double(inp text) FROM postgres;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.url_decode(data text) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.url_encode(data bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) FROM postgres;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: postgres
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.schema_migrations TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO postgres;
GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE decrypted_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;


--
-- Name: TABLE masking_rule; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;


--
-- Name: TABLE mask_columns; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;


--
-- Name: TABLE pair_data_recent; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pair_data_recent TO anon;
GRANT ALL ON TABLE public.pair_data_recent TO authenticated;
GRANT ALL ON TABLE public.pair_data_recent TO service_role;


--
-- Name: SEQUENCE pair_data_recent_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.pair_data_recent_id_seq TO anon;
GRANT ALL ON SEQUENCE public.pair_data_recent_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.pair_data_recent_id_seq TO service_role;


--
-- Name: TABLE price_volume_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.price_volume_history TO anon;
GRANT ALL ON TABLE public.price_volume_history TO authenticated;
GRANT ALL ON TABLE public.price_volume_history TO service_role;


--
-- Name: SEQUENCE price_volume_history_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.price_volume_history_id_seq TO anon;
GRANT ALL ON SEQUENCE public.price_volume_history_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.price_volume_history_id_seq TO service_role;


--
-- Name: TABLE token_price_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.token_price_history TO anon;
GRANT ALL ON TABLE public.token_price_history TO authenticated;
GRANT ALL ON TABLE public.token_price_history TO service_role;


--
-- Name: SEQUENCE token_price_history_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.token_price_history_id_seq TO anon;
GRANT ALL ON SEQUENCE public.token_price_history_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.token_price_history_id_seq TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.migrations TO anon;
GRANT ALL ON TABLE storage.migrations TO authenticated;
GRANT ALL ON TABLE storage.migrations TO service_role;
GRANT ALL ON TABLE storage.migrations TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES  TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON TABLES  TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON TABLES  TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

