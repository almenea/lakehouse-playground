# 🏗️ Lakehouse Playground

A local development environment for an **Open Data Lakehouse** using Docker Compose.

## Components 
| Component | Role | Image |
|---|---|---|
| **SeaweedFS** | S3-compatible distributed storage | `chrislusf/seaweedfs` |
| **Apache Polaris** | Iceberg REST catalog | `apache/polaris` |
| **Trino** | SQL query engine | `trinodb/trino` |
| **Jupyter** | Interactive notebooks | `jupyter/scipy-notebook` |

**Data Pattern:** Medallion Architecture — `bronze` → `silver` → `gold` S3 buckets.

---

## Quick Start

### 1. Start the stack

```bash
docker compose up -d
docker compose ps   # wait until all services are healthy
```

### 2. Open the setup notebook

Open **[http://localhost:8888](http://localhost:8888)** and use token: **`lakehouse`**

Navigate to `work/setup.ipynb` and run all cells. The notebook will:
- ✅ Create `bronze`, `silver`, `gold` S3 buckets
- ✅ Obtain a Polaris API token & register the catalog
- ✅ Create Medallion namespaces
- ✅ Connect to Trino and run your first Iceberg queries

### 3. Explore advanced patterns

| Notebook | Pattern |
|---|---|
| `setup.ipynb` | Lakehouse setup & Medallion ETL |
| `cdc_snapshotting.ipynb` | CDC Log Compaction — MERGE INTO with dedup |
| `advanced_views_and_streaming.ipynb` | Incremental Aggregations & CDC via `table_changes` |
| `advanced_trino_iceberg_features.ipynb` | Object Store Layout, ANALYZE, `add_files`, Metadata Caching |

---

## Service URLs

| Service | URL | Credentials |
|---|---|---|
| **Jupyter Lab** | [http://localhost:8888](http://localhost:8888) | Token: `lakehouse` |
| **Trino Web UI** | [http://localhost:8443](http://localhost:8443) | No auth |
| **Polaris REST API** | [http://localhost:8181](http://localhost:8181) | `root` / `polaris-secret` |
| **Polaris Management** | [http://localhost:8182](http://localhost:8182) | — |
| **SeaweedFS Master** | [http://localhost:9333](http://localhost:9333) | — |
| **SeaweedFS S3 API** | [http://localhost:8333](http://localhost:8333) | See `.env` |

---

## Project Structure

```
lakehouse-playground/
├── docker-compose.yaml     # All services (4 containers)
├── .env                    # Shared credentials
├── requirements.txt        # Python dependencies
├── README.md
├── notebooks/
│   ├── setup.ipynb              # Interactive setup & hello world
│   ├── cdc_snapshotting.ipynb   # CDC log compaction pattern
│   ├── advanced_views_and_streaming.ipynb # Incremental Aggregations & table_changes
│   └── advanced_trino_iceberg_features.ipynb # Object Store Layout, ANALYZE, add_files, Metadata Cache
├── seaweedfs/
│   └── s3.json             # S3 identity config
└── trino/
    └── etc/
        ├── config.properties
        ├── jvm.config
        ├── node.properties
        ├── log.properties
        └── catalog/
            └── iceberg.properties
```

---

## Useful Commands

```bash
# Stop everything
docker compose down

# Stop and remove volumes (clean slate)
docker compose down -v

# View logs for a specific service
docker compose logs -f polaris

# Restart a single service
docker compose restart trino

# Trino CLI
docker exec -it trino trino
```

---

## License

This project is provided as a development playground. Use at your own risk.
