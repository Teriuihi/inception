NAME = inception

all: fclean host reload

host:
	@ ./setup_host.sh
	
stop:
	@ docker compose -f docker-compose.yml down

clean: stop
	@ rm -rf /tmp/inception

fclean: clean
	@ docker system prune -f

reload: 
	@ docker compose -f docker-compose.yml up --force-recreate --build

.PHONY: host stop clean fclean reload all
