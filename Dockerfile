FROM python:3.12-slim-bookworm

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Install uv (for running FastAPI)
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure uv is in PATH
ENV PATH="/root/.local/bin:$PATH"

# Set working directory
WORKDIR /app

# Copy application files
COPY true_app.py /app/
COPY requirements.txt /app/

# Install dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Run the app
CMD ["uv", "run", "true_app.py"]
