# Use the official OPA Docker image as the base image
FROM openpolicyagent/opa:latest


# Set the working directory inside the container
WORKDIR /app


# Expose the OPA API port
EXPOSE 8181


# Command to run OPA with the policies
CMD ["run", "--server", "--addr=:8181", "/app"]