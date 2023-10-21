
.PHONY: cli
cli:
	docker run --rm -it -v ${PWD}:/app -w /app -v ~/.terraform.d:/root/terraform.d hub.kateops.com/base/terraform:latest sh