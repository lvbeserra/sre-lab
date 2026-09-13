from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}

def test_ready(monkeypatch):
    monkeypatch.setenv("APP_READY", "true")
    assert client.get("/ready").status_code == 200

def test_not_ready(monkeypatch):
    monkeypatch.setenv("APP_READY", "false")
    assert client.get("/ready").status_code == 503
    assert client.get("/health").status_code == 200

def test_version(monkeypatch):
    monkeypatch.setenv("APP_VERSION", "2.0.0")
    assert client.get("/version").json() == {"version": "2.0.0"}

def test_metrics():
    client.get("/health")
    response = client.get("/metrics")
    assert response.status_code == 200
    assert "platform_health_requests_total" in response.text
