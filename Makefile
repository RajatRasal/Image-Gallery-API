GCP_CONFIG = gcp_config.json

install:
	[[ $(which conda) ]] || echo 'Install Miniconda: https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html'; exit 1;
	conda env create -f environment.yml 

test: $(GCP_CONFIG) server.py
	conda activate cloud_functions; \
	export FLASK_APP=server.py; \
	export GOOGLE_APPLICATION_CREDENTIALS=$(GCP_CONFIG); \
	pytest tests/

run: Dockerfile
	docker build . -t cloud_function_image_gallery:latest
	docker run -p 4000:4000 cloud_function_image_gallery:latest
