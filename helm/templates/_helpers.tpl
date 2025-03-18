{{/* Define a template for HTTP health probes */}}
{{- define "app.httpProbes" -}}
livenessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 30
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3
readinessProbe:
  httpGet:
    path: /
    port: 80
  initialDelaySeconds: 5
  periodSeconds: 5
  timeoutSeconds: 3
  successThreshold: 1
  failureThreshold: 3
{{- end -}}

{{/* Define a template for TCP health probes (Redis) */}}
{{- define "redis.tcpProbes" -}}
livenessProbe:
  tcpSocket:
    port: 6379
  initialDelaySeconds: 30
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3
readinessProbe:
  tcpSocket:
    port: 6379
  initialDelaySeconds: 5
  periodSeconds: 5
  timeoutSeconds: 3
  successThreshold: 1
  failureThreshold: 3
{{- end -}}

{{/* Define a template for worker exec probe */}}
{{- define "worker.execProbe" -}}
livenessProbe:
  exec:
    command:
    - /bin/sh
    - -c
    - ps aux | grep worker || exit 1
  initialDelaySeconds: 30
  periodSeconds: 20
  timeoutSeconds: 5
  failureThreshold: 3
{{- end -}}

{{/* Define a template for PostgreSQL health probes */}}
{{- define "db.postgresProbes" -}}
livenessProbe:
  exec:
    command:
    - /bin/sh
    - -c
    - pg_isready -U $POSTGRES_USER -d postgres
  initialDelaySeconds: 60
  periodSeconds: 20
  timeoutSeconds: 5
  failureThreshold: 6
readinessProbe:
  exec:
    command:
    - /bin/sh
    - -c
    - pg_isready -U $POSTGRES_USER -d postgres
  initialDelaySeconds: 20
  periodSeconds: 10
  timeoutSeconds: 3
  successThreshold: 1
  failureThreshold: 3
{{- end -}}