GCP_CONFIG = gcp_config.json
APP_NAME = image_gallery
FRONTEND_CONTAINER = image_gallery_api
TEST_CONTAINER = tests

install:
	[[ $$(which conda) ]] || echo 'Install Miniconda: https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html'; exit 1;
	conda env create -f environment.yml 

build: Dockerfile 
	docker build . -t $(APP_NAME)

run:
	docker run -p 4000:4000 --name $(FRONTEND_CONTAINER) -d $(APP_NAME) flask run 

test:
	docker run --name $(TEST_CONTAINER) -d $(APP_NAME) pytest 
	docker attach $(TEST_CONTAINER) 

stop_run:
	docker stop $(FRONTEND_CONTAINER); docker rm $(FRONTEND_CONTAINER)

stop_test:
	docker stop $(TEST_CONTAINER); docker rm $(TEST_CONTAINER)

clean:
	docker rmi $$(docker images -aq)
