{{/*
Return the name of the chart
*/}}
{{- define "hello-world.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Return a full name including the release name
*/}}
{{- define "hello-world.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "hello-world.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}
