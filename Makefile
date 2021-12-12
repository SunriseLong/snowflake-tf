IMAGE := terraform-dev-image:1.0
.PHONY: build
build:
	@echo "Building image..."
	@docker build -t ${IMAGE} -f Dockerfile .
	@docker run -it -v ${PWD}:/app -v ~/.ssh/:/root/.ssh -w /app ${IMAGE} /bin/bash
