import os
from fastapi import FastAPI
from fastapi.responses import JSONResponse, Response
from prometheus_client import Counter, CONTENT_TYPE_LATEST, generate_latest

app = FastAPI(title="Platform API")
requests = Counter("platform_health_requests_total", "Consultas de saude")

@app.get("/health")
def health():
    requests.inc()
    return {"status": "ok"}

@app.get("/ready")
def ready():
    # Simulacao para o laboratorio; nao verifica dependencias reais.
    if os.getenv("APP_READY", "true").lower() != "true":
        return JSONResponse(status_code=503, content={"status": "not ready"})
    return {"status": "ready"}

@app.get("/version")
def version():
    return {"version": os.getenv("APP_VERSION", "1.0.0")}

@app.get("/metrics")
def metrics():
    return Response(content=generate_latest(), media_type=CONTENT_TYPE_LATEST)
