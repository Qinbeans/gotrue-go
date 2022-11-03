BLUE=\033[0;34m
GREEN=\033[0;32m
NC=\033[0m

up:
	@echo "${BLUE}Starting containers${NC}"
	@docker compose -f docker-compose.yaml up -d 1>/dev/null 2>/dev/null && echo "${GREEN}Started${NC}"

down:
	@echo "${BLUE}Removing containers${NC}"
	@docker compose -f docker-compose.yaml down 2>/dev/null && echo "${GREEN}Removed${NC}"

test: up
	-go test -count=1 ./...
	@make down

test_ci:
	docker compose -f docker-compose.yaml up -d --build
	-go test ./...
	docker compose -f docker-compose.yaml down