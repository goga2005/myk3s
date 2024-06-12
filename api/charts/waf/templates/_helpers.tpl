{{/*
Expand the name of the chart.
*/}}
{{- define "waf.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "waf.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "waf.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "waf.labels" -}}
helm.sh/chart: {{ include "waf.chart" . }}
{{ include "waf.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "waf.selectorLabels" -}}
app.kubernetes.io/name: {{ include "waf.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "waf.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "waf.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Expand the name environment configmap.
*/}}
{{- define "waf.configmap.environment" -}}
{{- printf "%s-%s" (include "waf.fullname" .) "environment" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name files configmap.
*/}}
{{- define "waf.configmap.files" -}}
{{- printf "%s-%s" (include "waf.fullname" .) "files" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name tls secret.
*/}}
{{- define "waf.secret.tls" -}}
{{- printf "%s-%s" (include "waf.fullname" .) "tls" | trunc 63 | trimSuffix "-" }}
{{- end }}
