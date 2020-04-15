GCP_CONFIG = gcp_config.json
API_CONTAINER = image_gallery_api

install:
	[[ $$(which conda) ]] || echo 'Install Miniconda: https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html'; exit 1;
	conda env create -f environment.yml 

run: Dockerfile
	docker build . -t $(API_CONTAINER):latest
	docker run -d -p 4000:4000 $(API_CONTAINER):latest

stop:
	docker stop $$(docker container list -a | grep $(API_CONTAINER) | awk '{ print $$1 }')
	docker rm $$(docker ps -a -q)

clean:
	docker rmi $$(docker images -aq)
