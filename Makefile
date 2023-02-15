NAME=ex00

FILES=$(shell docker-compose up)

$(NAME): $(FILES)
	$(CC) $(FLAGS) $(OBJ) -o $(NAME)

all: $(NAME)

re: all

.PHONY: make all clean fclean re
