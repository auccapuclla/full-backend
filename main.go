package main

import (
	"BackendUdemy/api"
	db "BackendUdemy/db/sqlc"
	"BackendUdemy/util"
	"database/sql"
	_ "github.com/lib/pq"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		panic(err)
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		panic(err)
	}
	store := db.NewStore(conn)
	server := api.NewServer(store)
	err = server.Start(config.ServerAddress)
	if err != nil {
		panic(err)
	}

}
