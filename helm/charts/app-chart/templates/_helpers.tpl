{{/*
Expand the name of the chart.
*/}}
{{- define "01-conects-gong.name" -}}
{{- default .Release.Name }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "01-conects-gong.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s" .Release.Name  }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "01-conects-gong.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "01-conects-gong.labels" -}}
tags.datadoghq.com/env: prod
tags.datadoghq.com/service: {{ .Release.Name }}
admission.datadoghq.com/java-lib.version: v1.34.0
helm.sh/chart: {{ include "01-conects-gong.chart" . }}
admission.datadoghq.com/enabled: 'true'
{{ include "01-conects-gong.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "01-conects-gong.selectorLabels" -}}
app.kubernetes.io/name: {{ include "01-conects-gong.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "01-conects-gong.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "01-conects-gong.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "imageAddress" -}}
{{ $token := (split "-" .Release.Name) }}
{{- if contains "conects" .Release.Name }}
{{- printf "01_%s_%s" $token._0 $token._1 }}
{{- else }}
{{- printf "%s_%s" $token._0 $token._1 }}
{{- end }}
{{- end }}
{{- define "extentionVer" -}}
{{- if eq .Release.Namespace "mconects" }}
{{- default "20220829"}}
{{- else }}
{{- default "20190902"}}
{{- end }}
{{- end }}