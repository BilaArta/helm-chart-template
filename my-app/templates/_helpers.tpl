{{/*
Expand the name of the chart.
*/}}
{{- define "my-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "my-app.fullname" -}}
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
{{- define "my-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "my-app.labels" -}}
helm.sh/chart: {{ include "my-app.chart" . }}
{{ include "my-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "my-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "my-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "my-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "my-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the mount volume config
*/}}
{{- define "my-app.configVolume" -}}
- name: {{ include "my-app.name" . }}-config-volume
  mountPath: "C:\\inetpub\\wwwroot\\config"
  subPath: "..data"
{{- end }}

{{/*
Create the mount volume settings app
*/}}
{{- define "my-app.settingVolume" -}}
- name: {{ include "my-app.name" . }}-settings-volume
  mountPath: "C:\\inetpub\\wwwroot\\config\\settings.config"
  subPath: "..data\\{{ include "my-app.name" . }}-settings.config"
{{- end }}

{{/*
Create the mount volume hosts
*/}}
{{- define "my-app.hostsVolume" -}}
- name: "hosts-configmap"
  mountPath: "C:\\Windows\\System32\\drivers\\etc\\hosts"
  subPath: "hosts"
{{- end }}

{{/*
Create the mount log app
*/}}
{{- define "my-app.logVolume" -}}
- name:  "aither-log-volume" 
  mountPath: "C:\\log"
{{- end }}

{{/*
Create the mount log app
*/}}
{{- define "my-app.setCommand" -}}
Name:  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
Name Override:  {{- default "" .Values.nameOverride | trunc 63 | trimSuffix "-" }}
Image Repository:  {{- default "" .Values.image.repository | trunc 63 | trimSuffix "-" }}
Namespace:  {{- default "" .Values.namespace | trunc 63 | trimSuffix "-" }}
Ingress ClassName:  {{- default "" .Values.ingress.className | trunc 63 | trimSuffix "-" }}
{{- end }}