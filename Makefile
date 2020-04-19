GCP_CONFIG = gcp_config.json
GCP_PROJECT = $$(GCP_PROJECT)
APP_NAME = image_gallery
FRONTEND_CONTAINER = image_gallery_api
TEST_CONTAINER = tests

install:
	@echo
	@echo "Install Docker! I'd rather you did this yourself: https://docs.docker.com/get-docker/"
	@echo
	@echo "Install GCP CLI and setup a project! https://cloud.google.com/sdk/docs/quickstarts"
	@echo

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

setup_bucket: 
	@echo create bucket, if not already exists, and (re)upload all images to it
	@echo each file should be uploaded with a name and date

kill_bucket:
	@echo delete bucket

setup_cloud_function:
	@echo deploy cloud function

test_cloud_function:
	@echo using artillery to test

kill_cloud_function:
	@echo delete cloud function

setup_gcp: setup_bucket setup_cloud_function

kill_gcp: kill_bucket kill_cloud_function
