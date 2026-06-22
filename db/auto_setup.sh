#!/bin/sh
psql < db/drop.sql && psql < db/schema.sql && psql < db/inserts.sql
