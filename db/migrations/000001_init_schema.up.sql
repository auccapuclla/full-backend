create table "accounts"
(
    "id" bigserial PRIMARY KEY,
    "owner" varchar NOT NULL,
    "balance" bigint NOT NULL,
    "currency" varchar NOT NULL,
    "create_at" timestamptz NOT NULL DEFAULT (now())
);

create table "entries"
(
    "id" bigserial primary key,
    "account_id" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "create_at" timestamptz NOT NULL DEFAULT (now())
);

create table "transfers"
(
    "id" bigserial primary key,
    "from_account_id" bigint NOT NULL,
    "to_account_id" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "create_at" timestamptz NOT NULL DEFAULT (now())
);

alter table "entries" add foreign key ("account_id") references "accounts" ("id");

alter table "transfers" add foreign key ("from_account_id") references "accounts" ("id");

alter table "transfers" add foreign key ("to_account_id") references "accounts" ("id");

create index ON "accounts" ("owner");

create index ON "entries" ("account_id");
create index ON "transfers" ("from_account_id");
create index ON "transfers" ("to_account_id");

create index ON "transfers" ("from_account_id","to_account_id");

COMMENT ON COLUMN "entries"."amount" IS 'can be negative or positive';
COMMENT ON COLUMN "transfers"."amount" IS 'must be positive';

